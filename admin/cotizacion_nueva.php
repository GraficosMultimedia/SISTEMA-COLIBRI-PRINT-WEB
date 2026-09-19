<?php
declare(strict_types=1);
require_once __DIR__ . '/../config/runtime.php';
require_once __DIR__ . '/../includes/actions.php';
require_once __DIR__ . '/../includes/cotizaciones.php';
require_once __DIR__ . '/../includes/company.php';
require_auth();

// Endpoint ligero para búsqueda de clientes desde la cotización.
if (isset($_GET['customer_search'])) {
    header('Content-Type: application/json; charset=utf-8');
    header('Cache-Control: no-store, no-cache, must-revalidate, max-age=0');
    $search = trim((string)($_GET['q'] ?? ''));
    if ($search === '') { echo json_encode([]); exit; }
    $like = '%' . $search . '%';
    $stmt = db()->prepare('SELECT id,name,email,phone,tax_number,city,state FROM cp_customers WHERE enabled=1 AND (name LIKE ? OR email LIKE ? OR phone LIKE ? OR tax_number LIKE ?) ORDER BY name LIMIT 12');
    $stmt->execute([$like,$like,$like,$like]);
    echo json_encode($stmt->fetchAll(), JSON_UNESCAPED_UNICODE);
    exit;
}

$title = 'Nueva cotización';
$error = null;
$id = (int)($_GET['id'] ?? 0);
$editing = $id > 0;
$wasEditing = $editing;
$existing = $editing ? quote_get($id) : null;
if ($editing && !$existing) redirect('/admin/cotizaciones.php');

$customers = [];
$customerFromQuery = (int)($_GET['customer_id'] ?? 0);
if ($customerFromQuery > 0 && !$editing) {
    $stmtCustomer = db()->prepare('SELECT id,name,email,phone,tax_number,city,state FROM cp_customers WHERE id=? AND enabled=1 LIMIT 1');
    $stmtCustomer->execute([$customerFromQuery]);
    $selectedCustomer = $stmtCustomer->fetch() ?: null;
    if ($selectedCustomer) $customers[] = $selectedCustomer;
} else {
    $selectedCustomer = null;
}
$pending = quote_pending_normalize($_SESSION['cp_pending_quote'] ?? null);
$savedSource = $existing ? quote_source_from_saved($existing) : null;
$sourceData = $editing ? $savedSource : $pending;
$source = $sourceData['source'] ?? null;
$sourceResult = $sourceData['result'] ?? [];
$sourceInput = $sourceData['input'] ?? [];
$sourceTitle = $sourceData['title'] ?? quote_source_label($source);

$items = $editing ? quote_items($id) : [];
$totals = $editing ? quote_totals($id) : [];

$customerId = (int)($existing['customer_id'] ?? $customerFromQuery);
if (!$selectedCustomer && $customerId > 0) {
    $stmtCustomer = db()->prepare('SELECT id,name,email,phone,tax_number,city,state FROM cp_customers WHERE id=? LIMIT 1');
    $stmtCustomer->execute([$customerId]);
    $selectedCustomer = $stmtCustomer->fetch() ?: null;
    if ($selectedCustomer) $customers[] = $selectedCustomer;
}
$customerReference = (string)($existing['client_reference'] ?? '');
$paymentTerms = (string)($existing['payment_terms'] ?? '');
$deliveryTime = (string)($existing['delivery_time'] ?? '');
$deliveryPlace = (string)($existing['delivery_place'] ?? '');
$issueDate = (string)($existing['issue_date'] ?? date('Y-m-d'));
$validUntil = (string)($existing['valid_until'] ?? date('Y-m-d', strtotime('+15 days')));
$description = (string)($items[0]['description'] ?? $sourceTitle);
$quantity = (float)($items[0]['quantity'] ?? ($source === 'corte_cnc' ? ($sourceInput['quantity'] ?? 1) : 1));
$unitPrice = (float)($items[0]['unit_price'] ?? ($sourceResult['unit_sale'] ?? $sourceResult['sale'] ?? 0));
$discount = (float)($totals['discount'] ?? 0);
$taxAmountSaved = (float)($totals['tax'] ?? 0);
$taxBaseSaved = max(0, (float)($totals['subtotal'] ?? 0) - $discount);
$taxPct = $taxBaseSaved > 0 ? round(($taxAmountSaved / $taxBaseSaved) * 100, 4) : 0;
$notes = (string)($existing['notes'] ?? '');
$terms = (string)($existing['terms'] ?? 'Cotización sujeta a disponibilidad de materiales y aprobación del cliente.');
$internalNotes = (string)($existing['internal_notes'] ?? '');

$preview = quote_calculate_totals($quantity, $unitPrice, $discount, $taxPct);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!csrf_check($_POST['_csrf'] ?? null)) {
        $error = 'La sesión del formulario expiró. Recarga la página.';
    } else {
        $customerId = (int)($_POST['customer_id'] ?? 0);
        $issueDate = (string)($_POST['issue_date'] ?? date('Y-m-d'));
        $validUntil = (string)($_POST['valid_until'] ?? '');
        $description = trim((string)($_POST['description'] ?? ''));
        $quantity = max(0.001, (float)($_POST['quantity'] ?? 1));
        $unitPrice = max(0, (float)($_POST['unit_price'] ?? 0));
        $discount = max(0, (float)($_POST['discount'] ?? 0));
        $taxPct = max(0, min(100, (float)($_POST['tax_pct'] ?? 0)));
        $notes = trim((string)($_POST['notes'] ?? ''));
        $terms = trim((string)($_POST['terms'] ?? ''));
        $internalNotes = trim((string)($_POST['internal_notes'] ?? ''));
        $customerReference = trim((string)($_POST['client_reference'] ?? ''));
        $paymentTerms = trim((string)($_POST['payment_terms'] ?? ''));
        $deliveryTime = trim((string)($_POST['delivery_time'] ?? ''));
        $deliveryPlace = trim((string)($_POST['delivery_place'] ?? ''));
        $preview = quote_calculate_totals($quantity, $unitPrice, $discount, $taxPct);

        $customerValid = false;
        if ($customerId > 0) {
            $checkCustomer = db()->prepare('SELECT id FROM cp_customers WHERE id=? AND enabled=1 LIMIT 1');
            $checkCustomer->execute([$customerId]);
            $customerValid = (bool)$checkCustomer->fetchColumn();
        }

        if (!$customerValid) {
            $error = 'Selecciona un cliente activo para generar la cotización formal.';
        } elseif ($description === '') {
            $error = 'Captura una descripción del trabajo o producto.';
        } elseif ($unitPrice <= 0) {
            $error = 'El precio unitario debe ser mayor a cero.';
        } else {
            $internalCost = $editing ? (float)($totals['internal_cost'] ?? 0) : (float)($sourceResult['cost'] ?? 0);
            $profit = round($preview['subtotal'] - $preview['discount'] - $internalCost, 2);
            $netSale = max(0, $preview['subtotal'] - $preview['discount']);
            $margin = $netSale > 0 ? round(($profit / $netSale) * 100, 3) : 0;

            try {
                $pdo = db();
                $pdo->beginTransaction();
                $uid = (int)(current_user()['id'] ?? 0);

                if ($editing) {
                    $stmt = $pdo->prepare('UPDATE cp_quotes SET customer_id=?,issue_date=?,valid_until=?,client_reference=?,payment_terms=?,delivery_time=?,delivery_place=?,notes=?,terms=?,internal_notes=?,updated_by=?,updated_at=NOW() WHERE id=?');
                    $stmt->execute([$customerId, $issueDate, $validUntil ?: null, $customerReference ?: null, $paymentTerms ?: null, $deliveryTime ?: null, $deliveryPlace ?: null, $notes, $terms, $internalNotes, $uid, $id]);
                    $pdo->prepare('DELETE FROM cp_quote_items WHERE quote_id=?')->execute([$id]);
                    $pdo->prepare('DELETE FROM cp_quote_totals WHERE quote_id=?')->execute([$id]);
                    if ($sourceResult) $pdo->prepare('DELETE FROM cp_quote_costs WHERE quote_id=?')->execute([$id]);
                } else {
                    $number = next_quote_number();
                    $sourceDataJson = $sourceData ? json_encode($sourceData, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) : null;
                    $stmt = $pdo->prepare('INSERT INTO cp_quotes(quote_number,customer_id,status,issue_date,valid_until,client_reference,payment_terms,delivery_time,delivery_place,notes,terms,internal_notes,source_calculator,source_data,created_by,updated_by,created_at,updated_at) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, ?,NOW(),NOW())');
                    $stmt->execute([$number, $customerId, 'draft', $issueDate, $validUntil ?: null, $customerReference ?: null, $paymentTerms ?: null, $deliveryTime ?: null, $deliveryPlace ?: null, $notes, $terms, $internalNotes, $source, $sourceDataJson, $uid, $uid]);
                    $id = (int)$pdo->lastInsertId();
                    $editing = true;
                }

                $pdo->prepare('INSERT INTO cp_quote_items(quote_id,description,quantity,unit_price,subtotal,calculator_source,sort_order,created_at,updated_at) VALUES(?,?,?,?,?,?,?,NOW(),NOW())')
                    ->execute([$id, $description, $quantity, $unitPrice, $preview['subtotal'], $source, 0]);

                if ($sourceResult) {
                    $ins = $pdo->prepare('INSERT INTO cp_quote_costs(quote_id,concept,amount,details,created_at) VALUES(?,?,?,?,NOW())');
                    foreach (quote_source_cost_rows((string)$source, $sourceResult) as $costRow) {
                        $ins->execute([$id, $costRow[0], round((float)$costRow[1], 2), $sourceTitle]);
                    }
                }

                $pdo->prepare('INSERT INTO cp_quote_totals(quote_id,subtotal,discount,tax,total,internal_cost,profit,margin_pct,created_at,updated_at) VALUES(?,?,?,?,?,?,?,?,NOW(),NOW())')
                    ->execute([$id, $preview['subtotal'], $preview['discount'], $preview['tax'], $preview['total'], $internalCost, $profit, $margin]);

                $pdo->commit();
                unset($_SESSION['cp_pending_quote']);
                log_activity($wasEditing ? 'update' : 'create', 'quotes', ($wasEditing ? 'Cotización actualizada ' : 'Cotización creada ') . '#' . $id);
                redirect('/admin/cotizacion.php?id=' . $id . '&saved=1');
            } catch (Throwable $e) {
                if (isset($pdo) && $pdo->inTransaction()) $pdo->rollBack();
                $error = 'No se pudo guardar la cotización. Verifica que la migración de Fase 5 esté instalada.';
            }
        }
    }
}

require __DIR__ . '/../includes/header.php';
?>
<link rel="stylesheet" href="/assets/css/cotizaciones.css?v=20260917-6">
<div class="quote-toolbar">
    <div>
        <span class="eyebrow">FASE 5 · <?=$editing ? 'EDITAR' : 'NUEVA'?></span>
        <h2><?=$editing ? 'Editar cotización' : 'Nueva cotización'?></h2>
        <p class="muted"><?=$pending ? 'Cálculo interno cargado. Revisa los datos y conviértelo en una cotización formal.' : 'Captura los datos comerciales y revisa el total antes de guardar.'?></p>
    </div>
    <div class="quote-toolbar-actions"><?=cancel_button('/admin/cotizaciones.php')?></div>
</div>

<?php if ($error): ?><div class="notice danger"><?=e($error)?></div><?php endif; ?>

<form method="post" class="quote-form" id="quoteForm">
    <input type="hidden" name="_csrf" value="<?=e(csrf_token())?>">
    <div class="quote-form-grid">
        <div>
            <section class="card">
                <div class="section-heading"><div><span class="eyebrow">CLIENTE</span><h3>Datos de la cotización</h3></div></div>
                <div class="form-grid">
                    <div class="field field-full">
                        <label for="customerSearch">Cliente <span class="required">*</span></label>
                        <div class="customer-picker">
                            <input type="hidden" id="customerId" name="customer_id" value="<?=e((string)$customerId)?>">
                            <input id="customerSearch" type="search" autocomplete="off" placeholder="Buscar por nombre, teléfono, correo o RFC" value="<?=e($selectedCustomer['name'] ?? '')?>">
                            <div id="customerResults" class="customer-results" hidden></div>
                        </div>
                        <div id="selectedCustomer" class="selected-customer" <?=($selectedCustomer ? '' : 'hidden')?>>
                            <?php if ($selectedCustomer): ?>
                              <strong><?=e($selectedCustomer['name'])?></strong><span><?=e(trim(($selectedCustomer['email'] ?? '') . ' · ' . ($selectedCustomer['phone'] ?? ''))) ?></span>
                              <button type="button" class="customer-clear" id="customerClear">Cambiar</button>
                            <?php endif; ?>
                        </div>
                        <div class="customer-actions">
                          <small class="help-text">Los datos del cliente se reutilizan en el documento formal.</small>
                          <a class="btn btn-sm btn-secondary" href="/admin/clientes.php?action=create&return_to=%2Fadmin%2Fcotizacion_nueva.php" target="_blank" rel="noopener">＋ Crear cliente</a>
                        </div>
                    </div>
                    <div class="field"><label for="issueDate">Fecha</label><input id="issueDate" type="date" name="issue_date" value="<?=e($issueDate)?>" required></div>
                    <div class="field"><label for="validUntil">Vigencia hasta</label><input id="validUntil" type="date" name="valid_until" value="<?=e($validUntil)?>"></div>
                    <div class="field"><label for="clientReference">Referencia / proyecto</label><input id="clientReference" name="client_reference" maxlength="190" value="<?=e($customerReference)?>" placeholder="Ej. Viáticos, evento, proyecto o OC"></div>
                </div>
            </section>

            <section class="card">
                <div class="section-heading">
                    <div><span class="eyebrow">CONCEPTO</span><h3>Detalle comercial</h3></div>
                    <?php if ($source): ?><span class="source-pill">🧮 <?=e(quote_source_label((string)$source))?></span><?php endif; ?>
                </div>
                <div class="form-grid">
                    <div class="field field-full"><label for="description">Descripción <span class="required">*</span></label><input id="description" name="description" value="<?=e($description)?>" required></div>
                    <div class="field"><label for="quoteQty">Cantidad</label><input id="quoteQty" type="number" step="0.001" min="0.001" name="quantity" value="<?=e((string)$quantity)?>" required></div>
                    <div class="field"><label for="quotePrice">Precio unitario</label><input id="quotePrice" type="number" step="0.01" min="0" name="unit_price" value="<?=e((string)$unitPrice)?>" required></div>
                    <div class="field"><label for="quoteDiscount">Descuento</label><input id="quoteDiscount" type="number" step="0.01" min="0" name="discount" value="<?=e((string)$discount)?>"></div>
                    <div class="field"><label for="quoteTaxPct">Impuestos (%)</label><input id="quoteTaxPct" type="number" step="0.01" min="0" max="100" name="tax_pct" value="<?=e((string)$taxPct)?>"><small class="help-text">Se aplica sobre el importe después del descuento.</small></div>
                </div>
            </section>

            <section class="card">
                <div class="section-heading"><div><span class="eyebrow">ENTREGA Y PAGO</span><h3>Condiciones comerciales</h3></div></div>
                <div class="form-grid">
                    <div class="field"><label for="paymentTerms">Condiciones de pago</label><input id="paymentTerms" name="payment_terms" maxlength="190" value="<?=e($paymentTerms)?>" placeholder="Ej. 50% anticipo + 50% contra entrega"></div>
                    <div class="field"><label for="deliveryTime">Tiempo de entrega</label><input id="deliveryTime" name="delivery_time" maxlength="190" value="<?=e($deliveryTime)?>" placeholder="Ej. 5 días hábiles"></div>
                    <div class="field full"><label for="deliveryPlace">Lugar de entrega</label><input id="deliveryPlace" name="delivery_place" maxlength="190" value="<?=e($deliveryPlace)?>" placeholder="Ej. Domicilio del cliente / sucursal"></div>
                </div>
                <div class="field" style="margin-top:15px"><label for="notes">Notas</label><textarea id="notes" name="notes" rows="4" placeholder="Información adicional para el cliente..."><?=e($notes)?></textarea></div>
                <div class="field"><label for="terms">Condiciones comerciales</label><textarea id="terms" name="terms" rows="4"><?=e($terms)?></textarea></div>
                <div class="field"><label for="internalNotes">Notas internas</label><textarea id="internalNotes" name="internal_notes" rows="3" placeholder="Información que no se mostrará al cliente..."><?=e($internalNotes)?></textarea></div>
            </section>
        </div>

        <aside class="card quote-live">
            <span class="eyebrow">RESUMEN</span>
            <h3>Vista previa comercial</h3>
            <div class="live-row"><span>Subtotal</span><strong id="liveSubtotal"><?=quote_money($preview['subtotal'])?></strong></div>
            <div class="live-row"><span>Descuento</span><strong id="liveDiscount"><?=quote_money($preview['discount'])?></strong></div>
            <div class="live-row"><span>Impuestos <small id="liveTaxHint"><?=number_format($preview['taxPct'], 2)?>%</small></span><strong id="liveTax"><?=quote_money($preview['tax'])?></strong></div>
            <div class="live-total"><span>Total</span><strong id="liveTotal"><?=quote_money($preview['total'])?></strong></div>
            <?php if ($sourceResult): ?>
                <div class="internal-summary">
                    <span>🔒 Costo interno</span>
                    <strong><?=quote_money((float)($sourceResult['cost'] ?? 0))?></strong>
                    <small>Solo para control interno. Nunca aparece en el documento del cliente.</small>
                </div>
            <?php endif; ?>
            <div class="form-actions form-actions-stack">
                <?=cancel_button('/admin/cotizaciones.php')?>
                <?=save_button($editing ? 'Guardar cambios' : 'Guardar cotización')?>
            </div>
        </aside>
    </div>
</form>
<script src="/assets/js/cotizaciones.js?v=20260917-6" defer></script>
<?php require __DIR__ . '/../includes/footer.php'; ?>
