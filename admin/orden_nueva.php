<?php
declare(strict_types=1);
require_once __DIR__ . '/../config/runtime.php';
require_once __DIR__ . '/../includes/actions.php';
require_once __DIR__ . '/../includes/cotizaciones.php';
require_once __DIR__ . '/../includes/ordenes.php';
require_auth();

$quoteId = (int)($_GET['quote_id'] ?? $_POST['quote_id'] ?? 0);
$filter = (string)($_GET['filter'] ?? 'available');
$view   = (string)($_GET['view'] ?? 'list');
$search = trim((string)($_GET['q'] ?? ''));
$error = null;
$quote = null;
$users = db()->query('SELECT id,name FROM cp_users ORDER BY name')->fetchAll();
$orderDate = date('Y-m-d');
$dueDate = date('Y-m-d', strtotime('+7 days'));
$responsible = (int)(current_user()['id'] ?? 0);
$notes = '';
$internalNotes = '';
$total = 0.0;

$filters = [
    'available'  => 'Disponibles',
    'approved'   => 'Aprobadas',
    'with_order' => 'Con orden activa',
    'waiting'    => 'En espera',
    'all'        => 'Todas',
];
if (!array_key_exists($filter, $filters)) {
    $filter = 'available';
}
if (!in_array($view, ['list', 'grid'], true)) {
    $view = 'list';
}

$quotes = [];
try {
    $sql = "SELECT
                q.id,
                q.quote_number,
                q.issue_date,
                q.valid_until,
                q.status,
                c.name AS customer_name,
                c.phone AS customer_phone,
                COALESCE(t.total,0) AS total,
                ao.id AS active_order_id,
                ao.order_number AS active_order_number,
                ao.status AS active_order_status
            FROM cp_quotes q
            LEFT JOIN cp_customers c ON c.id=q.customer_id
            LEFT JOIN cp_quote_totals t ON t.quote_id=q.id
            LEFT JOIN (
                SELECT quote_id, MAX(id) AS order_id
                FROM cp_orders
                WHERE status <> 'cancelled'
                GROUP BY quote_id
            ) a ON a.quote_id=q.id
            LEFT JOIN cp_orders ao ON ao.id=a.order_id
            WHERE 1=1";
    $params = [];

    if ($search !== '') {
        $sql .= " AND (q.quote_number LIKE ? OR c.name LIKE ? OR c.phone LIKE ?)";
        $like = '%' . $search . '%';
        $params[] = $like;
        $params[] = $like;
        $params[] = $like;
    }

    switch ($filter) {
        case 'available':
            $sql .= " AND q.status='approved' AND ao.id IS NULL";
            break;
        case 'approved':
            $sql .= " AND q.status='approved'";
            break;
        case 'with_order':
            $sql .= " AND q.status='approved' AND ao.id IS NOT NULL";
            break;
        case 'waiting':
            $sql .= " AND q.status NOT IN ('approved','cancelled')";
            break;
        case 'all':
            break;
    }

    $sql .= ' ORDER BY q.id DESC LIMIT 200';
    $stmt = db()->prepare($sql);
    $stmt->execute($params);
    $quotes = $stmt->fetchAll();
} catch (Throwable $e) {
    $error = 'No se pudieron cargar las cotizaciones. Verifica la conexión y la estructura de la base de datos.';
}

if ($quoteId > 0) {
    try {
        $quote = quote_get($quoteId);
    } catch (Throwable $e) {
        $quote = null;
        $error = 'No se pudo cargar la cotización seleccionada.';
    }

    if (!$quote) {
        $error = $error ?: 'La cotización seleccionada no existe.';
    } elseif ((string)$quote['status'] !== 'approved') {
        $error = 'La cotización debe estar en estado Aprobada antes de crear la orden de servicio.';
        $quote = null;
    } else {
        try {
            $existing = order_for_quote($quoteId);
        } catch (Throwable $e) {
            $existing = null;
        }
        if ($existing && (string)$existing['status'] !== 'cancelled') {
            redirect('/admin/orden.php?id=' . (int)$existing['id']);
        }
        $total = (float)order_total_from_quote($quoteId);
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $quote && !$error) {
    if (!csrf_check($_POST['_csrf'] ?? null)) {
        $error = 'La sesión del formulario expiró. Recarga la página.';
    } else {
        $orderDate = (string)($_POST['order_date'] ?? date('Y-m-d'));
        $dueDate = (string)($_POST['due_date'] ?? '');
        $responsible = (int)($_POST['responsible_user_id'] ?? 0);
        $notes = trim((string)($_POST['notes'] ?? ''));
        $internalNotes = trim((string)($_POST['internal_notes'] ?? ''));
        $items = quote_items($quoteId);
        $total = (float)order_total_from_quote($quoteId);

        if (!$items) {
            $error = 'La cotización no contiene conceptos.';
        } else {
            try {
                $pdo = db();
                $pdo->beginTransaction();
                $uid = (int)(current_user()['id'] ?? 0);
                $number = order_number_next();
                $st = $pdo->prepare(
                    'INSERT INTO cp_orders(order_number,quote_id,customer_id,status,order_date,due_date,responsible_user_id,total,notes,internal_notes,created_by,updated_by,created_at,updated_at)
                     VALUES(?,?,?,?,?,?,?,?,?,?,?,?,NOW(),NOW())'
                );
                $st->execute([
                    $number,
                    $quoteId,
                    $quote['customer_id'] ?? null,
                    'pending',
                    $orderDate,
                    $dueDate !== '' ? $dueDate : null,
                    $responsible ?: null,
                    $total,
                    $notes,
                    $internalNotes,
                    $uid,
                    $uid,
                ]);
                $orderId = (int)$pdo->lastInsertId();

                $ins = $pdo->prepare(
                    'INSERT INTO cp_order_items(order_id,quote_item_id,description,quantity,unit_price,subtotal,sort_order,created_at,updated_at)
                     VALUES(?,?,?,?,?,?,?,NOW(),NOW())'
                );
                foreach ($items as $i => $item) {
                    $ins->execute([
                        $orderId,
                        $item['id'],
                        $item['description'],
                        $item['quantity'],
                        $item['unit_price'],
                        $item['subtotal'],
                        $i,
                    ]);
                }

                $pdo->prepare(
                    'INSERT INTO cp_order_history(order_id,old_status,new_status,note,changed_by,created_at)
                     VALUES(?,?,?,?,?,NOW())'
                )->execute([
                    $orderId,
                    null,
                    'pending',
                    'Orden creada desde ' . $quote['quote_number'],
                    $uid,
                ]);

                $pdo->commit();
                log_activity('create', 'orders', 'Orden creada ' . $number . ' desde cotización #' . $quoteId);
                redirect('/admin/orden.php?id=' . $orderId . '&created=1');
            } catch (Throwable $e) {
                if (isset($pdo) && $pdo->inTransaction()) {
                    $pdo->rollBack();
                }
                $error = 'No se pudo crear la orden. Verifica que las tablas de Fase 6 estén instaladas.';
            }
        }
    }
}

$title = 'Nueva orden de servicio';
require __DIR__ . '/../includes/header.php';
?>
<link rel="stylesheet" href="/assets/css/ordenes.css?v=20260917-stab1">

<div class="order-toolbar">
  <div>
    <span class="eyebrow">GESTIÓN DE ÓRDENES</span>
    <h2>Nueva orden de servicio</h2>
    <p class="muted">Selecciona una cotización aprobada y disponible para iniciar el servicio.</p>
  </div>
  <div class="order-toolbar-actions">
    <a class="btn btn-secondary" href="/admin/ordenes.php">Ver órdenes</a>
    <a class="btn btn-secondary" href="/admin/orden_nueva.php">Limpiar</a>
  </div>
</div>

<?php if ($error): ?><div class="notice danger"><?=e($error)?></div><?php endif; ?>

<?php if (!$quote): ?>
<section class="card approved-quotes-card">
  <div class="section-heading">
    <div>
      <span class="eyebrow">COTIZACIONES</span>
      <h3>Selecciona el trabajo que vas a convertir en orden</h3>
      <p class="muted">La vista por defecto muestra solo cotizaciones aprobadas sin una orden activa.</p>
    </div>
    <span class="count-pill"><?=count($quotes)?></span>
  </div>

  <form method="get" class="order-selector-tools">
    <div class="selector-search">
      <label for="quoteSearch">Buscar</label>
      <input id="quoteSearch" name="q" value="<?=e($search)?>" placeholder="Folio, cliente o teléfono">
    </div>
    <div>
      <label for="quoteFilter">Mostrar</label>
      <select id="quoteFilter" name="filter" onchange="this.form.submit()">
        <?php foreach ($filters as $key => $label): ?>
          <option value="<?=e($key)?>" <?=$filter === $key ? 'selected' : ''?>><?=e($label)?></option>
        <?php endforeach; ?>
      </select>
    </div>
    <input type="hidden" name="view" value="<?=e($view)?>">
    <div class="filter-actions">
      <button class="btn btn-secondary" type="submit">Buscar</button>
      <a class="btn btn-secondary" href="/admin/orden_nueva.php">Restablecer</a>
    </div>
  </form>

  <div class="selector-summary">
    <div>
      <strong><?=e($filters[$filter])?></strong>
      <span><?=count($quotes)?> resultado(s)</span>
    </div>
    <div class="view-switcher">
      <a class="btn btn-sm <?=$view === 'list' ? 'btn-primary' : 'btn-secondary'?>" href="<?=e('/admin/orden_nueva.php?' . http_build_query(['q' => $search, 'filter' => $filter, 'view' => 'list']))?>">☰ Lista</a>
      <a class="btn btn-sm <?=$view === 'grid' ? 'btn-primary' : 'btn-secondary'?>" href="<?=e('/admin/orden_nueva.php?' . http_build_query(['q' => $search, 'filter' => $filter, 'view' => 'grid']))?>">▦ Tarjetas</a>
    </div>
  </div>

  <?php if (!$quotes): ?>
    <div class="approved-empty">
      <div class="approved-empty-icon">📋</div>
      <strong>No hay cotizaciones para este filtro</strong>
      <p>Prueba otro estado o realiza una búsqueda diferente.</p>
      <a class="btn btn-secondary" href="/admin/cotizaciones.php">Ver cotizaciones</a>
    </div>
  <?php elseif ($view === 'grid'): ?>
    <div class="approved-quote-grid">
      <?php foreach ($quotes as $q): ?>
        <article class="approved-quote-card <?=(!empty($q['active_order_id']) ? 'has-active-order' : '')?>">
          <div class="approved-card-top">
            <div>
              <strong><?=e($q['quote_number'])?></strong>
              <span><?=e($q['customer_name'] ?: 'Sin cliente')?></span>
            </div>
            <span class="quote-status-pill quote-status-<?=e((string)$q['status'])?>"><?=e(quote_status_label((string)$q['status']))?></span>
          </div>
          <div class="approved-card-meta">
            <span>📅 <?=e(date('d/m/Y', strtotime((string)$q['issue_date'])))?></span>
            <?php if (!empty($q['valid_until'])): ?><span>Vigencia: <?=e(date('d/m/Y', strtotime((string)$q['valid_until'])))?></span><?php endif; ?>
          </div>
          <div class="approved-card-total"><?=quote_money((float)$q['total'])?></div>
          <?php if (!empty($q['active_order_id'])): ?>
            <div class="active-order-note">🔗 Orden activa: <b><?=e((string)$q['active_order_number'])?></b></div>
            <a class="btn btn-sm btn-secondary full" href="/admin/orden.php?id=<?=((int)$q['active_order_id'])?>">Ver orden</a>
          <?php elseif ((string)$q['status'] === 'approved'): ?>
            <a class="btn btn-sm btn-primary full" href="/admin/orden_nueva.php?quote_id=<?=((int)$q['id'])?>">Crear orden →</a>
          <?php else: ?>
            <span class="unavailable-note">Esperando aprobación</span>
          <?php endif; ?>
        </article>
      <?php endforeach; ?>
    </div>
  <?php else: ?>
    <div class="approved-quote-list">
      <?php foreach ($quotes as $q): ?>
        <div class="approved-quote-row <?=(!empty($q['active_order_id']) ? 'has-active-order' : '')?>">
          <div class="approved-quote-main">
            <strong><?=e($q['quote_number'])?></strong>
            <span><?=e($q['customer_name'] ?: 'Sin cliente')?></span>
            <?php if (!empty($q['customer_phone'])): ?><small><?=e($q['customer_phone'])?></small><?php endif; ?>
          </div>
          <div class="approved-quote-meta">
            <span>Fecha: <?=e(date('d/m/Y', strtotime((string)$q['issue_date'])))?></span>
            <?php if (!empty($q['valid_until'])): ?><span>Vigencia: <?=e(date('d/m/Y', strtotime((string)$q['valid_until'])))?></span><?php endif; ?>
            <span class="quote-status-pill quote-status-<?=e((string)$q['status'])?>"><?=e(quote_status_label((string)$q['status']))?></span>
          </div>
          <div class="approved-quote-total"><?=quote_money((float)$q['total'])?></div>
          <div class="approved-row-action">
            <?php if (!empty($q['active_order_id'])): ?>
              <span class="active-order-note">🔗 <?=e((string)$q['active_order_number'])?></span>
              <a class="btn btn-sm btn-secondary" href="/admin/orden.php?id=<?=((int)$q['active_order_id'])?>">Ver orden</a>
            <?php elseif ((string)$q['status'] === 'approved'): ?>
              <a class="btn btn-sm btn-primary" href="/admin/orden_nueva.php?quote_id=<?=((int)$q['id'])?>">Crear orden →</a>
            <?php else: ?>
              <span class="unavailable-note">Esperando aprobación</span>
            <?php endif; ?>
          </div>
        </div>
      <?php endforeach; ?>
    </div>
  <?php endif; ?>
</section>
<?php else: ?>
<div class="order-create-grid">
<section class="card">
  <div class="section-heading">
    <div><span class="eyebrow">ORIGEN</span><h3><?=e($quote['quote_number'])?></h3></div>
    <span class="status-badge order-status-<?=e((string)$quote['status'])?>"><?=e(quote_status_label((string)$quote['status']))?></span>
  </div>
  <div class="customer-box"><span>CLIENTE</span><strong><?=e($quote['customer_name'] ?? 'Sin cliente')?></strong><?php if (!empty($quote['customer_phone'])): ?><small><?=e($quote['customer_phone'])?></small><?php endif; ?></div>
  <table class="table"><thead><tr><th>Descripción</th><th>Cant.</th><th>Importe</th></tr></thead><tbody>
  <?php foreach (quote_items($quoteId) as $item): ?><tr><td><?=e($item['description'])?></td><td><?=e((string)$item['quantity'])?></td><td><?=quote_money((float)$item['subtotal'])?></td></tr><?php endforeach; ?>
  </tbody></table>
  <div class="document-total"><div class="grand"><span>Total</span><strong><?=quote_money($total)?></strong></div></div>
</section>
<aside class="card">
  <span class="eyebrow">OPERACIÓN</span><h3>Datos de la orden</h3>
  <form method="post">
    <input type="hidden" name="_csrf" value="<?=e(csrf_token())?>">
    <input type="hidden" name="quote_id" value="<?=((int)$quoteId)?>">
    <div class="field"><label>Fecha de orden</label><input type="date" name="order_date" value="<?=e($orderDate)?>" required></div>
    <div class="field"><label>Fecha compromiso</label><input type="date" name="due_date" value="<?=e($dueDate)?>"></div>
    <div class="field"><label>Responsable</label><select name="responsible_user_id"><option value="0">Sin asignar</option><?php foreach ($users as $u): ?><option value="<?=((int)$u['id'])?>" <?=$responsible === (int)$u['id'] ? 'selected' : ''?>><?=e($u['name'])?></option><?php endforeach; ?></select></div>
    <div class="field"><label>Notas para operación</label><textarea name="notes" rows="5" placeholder="Indicaciones que acompañarán la orden..."><?=e($notes)?></textarea></div>
    <div class="field"><label>Notas internas</label><textarea name="internal_notes" rows="4" placeholder="Información interna..."><?=e($internalNotes)?></textarea></div>
    <div class="form-actions"><a class="btn btn-secondary" href="/admin/orden_nueva.php">← Cambiar cotización</a><button class="btn btn-primary" type="submit">Crear orden</button></div>
  </form>
</aside>
</div>
<?php endif; ?>
<?php require __DIR__ . '/../includes/footer.php'; ?>
