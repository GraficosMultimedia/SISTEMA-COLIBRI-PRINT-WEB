<?php
declare(strict_types=1);
require_once __DIR__ . '/../config/runtime.php';
require_once __DIR__ . '/../includes/actions.php';
require_auth();

$title = 'Clientes';
$pdo = db();
$error = null;
$success = null;
$action = (string)($_GET['action'] ?? 'list');
$id = (int)($_GET['id'] ?? 0);
$q = trim((string)($_GET['q'] ?? ''));
$returnTo = trim((string)($_GET['return_to'] ?? $_POST['return_to'] ?? ''));
if ($returnTo !== '' && !str_starts_with($returnTo, '/admin/')) $returnTo = '';


$emptyCustomer = [
    'name'=>'', 'email'=>'', 'tax_number'=>'', 'phone'=>'', 'address'=>'',
    'city'=>'', 'zip_code'=>'', 'state'=>'', 'country'=>'MX', 'notes'=>'', 'enabled'=>1
];
$customer = $emptyCustomer;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $postAction = (string)($_POST['form_action'] ?? '');
    if (!csrf_check($_POST['_csrf'] ?? null)) {
        $error = 'La sesión del formulario expiró. Recarga la página e inténtalo nuevamente.';
        $action = $postAction === 'edit' ? 'edit' : 'create';
        $id = (int)($_POST['id'] ?? 0);
    } elseif ($postAction === 'delete') {
        $id = (int)($_POST['id'] ?? 0);
        if ($id <= 0) $error = 'Cliente inválido.';
        else {
            try {
                $stmt = $pdo->prepare('DELETE FROM cp_customers WHERE id=?');
                $stmt->execute([$id]);
                log_activity('delete','customers','Cliente #' . $id . ' eliminado');
                redirect('/admin/clientes.php?deleted=1');
            } catch (Throwable $e) {
                $error = 'No se pudo borrar el cliente: ' . $e->getMessage();
                $action = 'list';
            }
        }
    } elseif ($postAction === 'save') {
        $id = (int)($_POST['id'] ?? 0);
        $customer = [
            'name'=>trim((string)($_POST['name'] ?? '')),
            'email'=>trim((string)($_POST['email'] ?? '')),
            'tax_number'=>trim((string)($_POST['tax_number'] ?? '')),
            'phone'=>trim((string)($_POST['phone'] ?? '')),
            'address'=>trim((string)($_POST['address'] ?? '')),
            'city'=>trim((string)($_POST['city'] ?? '')),
            'zip_code'=>trim((string)($_POST['zip_code'] ?? '')),
            'state'=>trim((string)($_POST['state'] ?? '')),
            'country'=>strtoupper(trim((string)($_POST['country'] ?? 'MX'))),
            'notes'=>trim((string)($_POST['notes'] ?? '')),
            'enabled'=>isset($_POST['enabled']) ? 1 : 0,
        ];
        $action = $id > 0 ? 'edit' : 'create';

        if ($customer['name'] === '') $error = 'El nombre del cliente es obligatorio.';
        elseif ($customer['email'] !== '' && !filter_var($customer['email'], FILTER_VALIDATE_EMAIL)) $error = 'El correo electrónico no es válido.';
        else {
            try {
                if ($id > 0) {
                    $stmt = $pdo->prepare('UPDATE cp_customers SET name=?, email=?, tax_number=?, phone=?, address=?, city=?, zip_code=?, state=?, country=?, notes=?, enabled=?, updated_at=NOW() WHERE id=?');
                    $stmt->execute([$customer['name'],$customer['email'] ?: null,$customer['tax_number'] ?: null,$customer['phone'] ?: null,$customer['address'] ?: null,$customer['city'] ?: null,$customer['zip_code'] ?: null,$customer['state'] ?: null,$customer['country'] ?: 'MX',$customer['notes'] ?: null,$customer['enabled'],$id]);
                    log_activity('update','customers','Cliente #' . $id . ' actualizado');
                    redirect('/admin/clientes.php?saved=updated');
                } else {
                    $stmt = $pdo->prepare('INSERT INTO cp_customers (source_type,name,email,tax_number,phone,address,city,zip_code,state,country,notes,enabled,created_at,updated_at) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,NOW(),NOW())');
                    $stmt->execute(['local',$customer['name'],$customer['email'] ?: null,$customer['tax_number'] ?: null,$customer['phone'] ?: null,$customer['address'] ?: null,$customer['city'] ?: null,$customer['zip_code'] ?: null,$customer['state'] ?: null,$customer['country'] ?: 'MX',$customer['notes'] ?: null,$customer['enabled']]);
                    $newId = (int)$pdo->lastInsertId();
                    log_activity('create','customers','Cliente #' . $newId . ' creado');
                    if ($returnTo !== '') {
                        redirect($returnTo . (str_contains($returnTo, '?') ? '&' : '?') . 'customer_id=' . $newId);
                    }
                    redirect('/admin/clientes.php?saved=created');
                }
            } catch (Throwable $e) {
                $error = 'No se pudo guardar el cliente: ' . $e->getMessage();
            }
        }
    }
}

if (isset($_GET['deleted'])) $success = 'Cliente eliminado correctamente.';
if (($_GET['saved'] ?? '') === 'created') $success = 'Cliente creado correctamente.';
if (($_GET['saved'] ?? '') === 'updated') $success = 'Cliente actualizado correctamente.';

if (($action === 'edit') && $id > 0 && $_SERVER['REQUEST_METHOD'] !== 'POST') {
    try {
        $stmt = $pdo->prepare('SELECT * FROM cp_customers WHERE id=? LIMIT 1');
        $stmt->execute([$id]);
        $found = $stmt->fetch();
        if (!$found) { $error = 'El cliente solicitado no existe.'; $action = 'list'; }
        else $customer = array_merge($emptyCustomer, $found);
    } catch (Throwable $e) { $error = 'No se pudo cargar el cliente.'; $action = 'list'; }
}

$rows = [];
if ($action === 'list') {
    try {
        if ($q !== '') {
            $stmt = $pdo->prepare('SELECT id,name,email,phone,city,state,enabled,created_at FROM cp_customers WHERE name LIKE ? OR phone LIKE ? OR email LIKE ? OR tax_number LIKE ? ORDER BY id DESC LIMIT 100');
            $like = '%' . $q . '%';
            $stmt->execute([$like,$like,$like,$like]);
            $rows = $stmt->fetchAll();
        } else {
            $rows = $pdo->query('SELECT id,name,email,phone,city,state,enabled,created_at FROM cp_customers ORDER BY id DESC LIMIT 100')->fetchAll();
        }
    } catch (Throwable $e) { $error = 'No se pudieron cargar los clientes: ' . $e->getMessage(); }
}

require __DIR__ . '/../includes/header.php';
?>
<?php if ($action === 'create' || $action === 'edit'): ?>
<div class="toolbar">
  <div class="toolbar-title"><span class="eyebrow">GESTIÓN DE CLIENTES</span><h2><?= $action === 'edit' ? 'Editar cliente' : 'Nuevo cliente' ?></h2><span class="muted">Los clientes de esta sección pertenecen a la nueva base de Colibrí Print.</span></div>
  <div class="toolbar-actions"><?=cancel_button('/admin/clientes.php' . ($q !== '' ? '?q=' . urlencode($q) : ''))?></div>
</div>
<?php if($error): ?><div class="notice danger" style="margin-bottom:14px"><?=e($error)?></div><?php endif; ?>
<div class="card form-card">
  <div class="section-label">Datos principales</div>
  <form method="post" autocomplete="off">
    <input type="hidden" name="_csrf" value="<?=e(csrf_token())?>">
    <input type="hidden" name="form_action" value="save">
    <input type="hidden" name="id" value="<?=e((string)$id)?>"><input type="hidden" name="return_to" value="<?=e($returnTo)?>">
    <div class="form-grid">
      <div class="field full"><label>Nombre / razón social <span class="required">*</span></label><input data-auto-focus type="text" name="name" maxlength="190" value="<?=e((string)$customer['name'])?>" required></div>
      <div class="field"><label>Correo electrónico</label><input type="email" name="email" maxlength="190" value="<?=e((string)$customer['email'])?>"></div>
      <div class="field"><label>Teléfono / WhatsApp</label><input type="text" name="phone" maxlength="80" value="<?=e((string)$customer['phone'])?>"></div>
      <div class="field"><label>RFC</label><input type="text" name="tax_number" maxlength="80" value="<?=e((string)$customer['tax_number'])?>"></div>
      <div class="field"><label>País</label><input type="text" name="country" maxlength="10" value="<?=e((string)$customer['country'])?>"></div>
      <div class="field full"><label>Dirección</label><input type="text" name="address" maxlength="500" value="<?=e((string)$customer['address'])?>"></div>
      <div class="field"><label>Ciudad</label><input type="text" name="city" maxlength="120" value="<?=e((string)$customer['city'])?>"></div>
      <div class="field"><label>Estado</label><input type="text" name="state" maxlength="120" value="<?=e((string)$customer['state'])?>"></div>
      <div class="field"><label>Código postal</label><input type="text" name="zip_code" maxlength="20" value="<?=e((string)$customer['zip_code'])?>"></div>
      <div class="field"><label>Estado del cliente</label><label style="display:flex;align-items:center;gap:8px"><input type="checkbox" name="enabled" value="1" <?=((int)$customer['enabled']===1?'checked':'')?> style="width:auto"> Cliente activo</label></div>
      <div class="field full"><label>Notas internas</label><textarea name="notes" rows="4" style="width:100%;box-sizing:border-box;padding:11px 12px;border-radius:10px;border:1px solid #31577e;background:#09182b;color:#eef7ff;resize:vertical"><?=e((string)$customer['notes'])?></textarea></div>
    </div>
    <div class="form-actions"><?=cancel_button('/admin/clientes.php' . ($q !== '' ? '?q=' . urlencode($q) : ''))?><?=save_button($action === 'edit' ? 'Guardar cambios' : 'Crear cliente')?></div>
  </form>
</div>
<?php else: ?>
<div class="toolbar">
  <div class="toolbar-title"><span class="eyebrow">FASE 2 · CLIENTES</span><h2>Clientes</h2><span class="muted">Alta, consulta, edición y eliminación de clientes locales.</span></div>
  <div class="toolbar-actions"><?=action_button('Nuevo cliente','/admin/clientes.php?action=create','btn')?> </div>
</div>
<?php if($error): ?><div class="notice danger" style="margin-bottom:14px"><?=e($error)?></div><?php endif; ?>
<?php if($success): ?><div class="notice" style="margin-bottom:14px"><span class="ok">✓</span> <?=e($success)?></div><?php endif; ?>
<div class="card" style="margin-bottom:14px"><form class="search-form" method="get"><input type="search" name="q" value="<?=e($q)?>" placeholder="Buscar nombre, teléfono, correo o RFC"><button class="btn btn-secondary" type="submit">Buscar</button><?php if($q!==''): ?><?=cancel_button('/admin/clientes.php')?><?php endif; ?></form></div>
<div class="card table-wrap"><table class="table"><thead><tr><th>ID</th><th>Cliente</th><th>Teléfono</th><th>Correo</th><th>Ubicación</th><th>Estado</th><th class="actions-cell">Acciones</th></tr></thead><tbody>
<?php foreach($rows as $r): ?><tr><td><?=e((string)$r['id'])?></td><td><strong><?=e($r['name'])?></strong><div class="muted" style="font-size:12px">Alta: <?=e((string)$r['created_at'])?></div></td><td><?=e($r['phone'] ?: '—')?></td><td><?=e($r['email'] ?: '—')?></td><td><?=e(trim(($r['city']??'').' '.($r['state']??'')) ?: '—')?></td><td class="<?=((int)$r['enabled']===1?'status-active':'status-inactive')?>"><?=((int)$r['enabled']===1?'Activo':'Inactivo')?></td><td class="actions-cell"><div class="actions"><?=edit_button('/admin/clientes.php?action=edit&id='.(int)$r['id'].($q!==''?'&q='.urlencode($q):''))?><form method="post" style="display:inline;margin:0"><input type="hidden" name="_csrf" value="<?=e(csrf_token())?>"><input type="hidden" name="form_action" value="delete"><input type="hidden" name="id" value="<?=e((string)$r['id'])?>"><button type="submit" class="btn btn-sm btn-delete" data-confirm="¿Borrar a <?=e($r['name'])?>? Esta acción no se puede deshacer.">Borrar</button></form></div></td></tr><?php endforeach; ?>
<?php if(!$rows): ?><tr><td colspan="7" class="empty">No se encontraron clientes.<?= $q!=='' ? ' Prueba otra búsqueda o crea un nuevo cliente.' : '' ?><div class="empty-action"><?=action_button('Crear cliente','/admin/clientes.php?action=create','btn btn-sm')?></div></td></tr><?php endif; ?></tbody></table></div>
<?php endif; ?>
<?php require __DIR__ . '/../includes/footer.php'; ?>
