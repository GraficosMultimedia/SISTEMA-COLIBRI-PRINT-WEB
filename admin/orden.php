<?php
declare(strict_types=1);
require_once __DIR__ . '/../config/runtime.php';
require_once __DIR__ . '/../includes/actions.php';
require_once __DIR__ . '/../includes/ordenes.php';
require_once __DIR__ . '/../includes/produccion.php';
require_once __DIR__ . '/../includes/seguimiento.php';
require_once __DIR__ . '/../includes/whatsapp.php';
require_once __DIR__ . '/../includes/finanzas.php';
require_auth();

$id=(int)($_GET['id'] ?? 0);
$order=order_get($id);
if(!$order) redirect('/admin/ordenes.php');
$title='Orden '.$order['order_number'];
$error=null;

if($_SERVER['REQUEST_METHOD']==='POST'){
    if(!csrf_check($_POST['_csrf'] ?? null)){
        $error='La sesión del formulario expiró. Recarga la página.';
    } else {
        $action=(string)($_POST['action'] ?? '');
        try{
            $pdo=db();$uid=(int)(current_user()['id'] ?? 0);
            if($action==='status'){
                $new=(string)($_POST['status'] ?? '');
                if(!array_key_exists($new,order_statuses())) throw new RuntimeException('Estado no válido.');
                $old=(string)$order['status'];
                $historyNote=trim((string)($_POST['history_note'] ?? ''));
                if($new==='delivered'){
                    // Si se marca como entregada desde la ficha de la orden,
                    // también se cierra la etapa de producción.
                    production_set_stage($id,'delivered',$historyNote);
                } elseif($old!==$new){
                    $pdo->beginTransaction();
                    $pdo->prepare('UPDATE cp_orders SET status=?,updated_by=?,updated_at=NOW() WHERE id=?')->execute([$new,$uid,$id]);
                    $pdo->prepare('INSERT INTO cp_order_history(order_id,old_status,new_status,note,changed_by,created_at) VALUES(?,?,?,?,?,NOW())')->execute([$id,$old,$new,$historyNote,$uid]);
                    $pdo->commit();
                }
                redirect('/admin/orden.php?id='.$id.'&updated=1');
            }
            if($action==='details'){
                $due=(string)($_POST['due_date'] ?? '');
                $responsible=(int)($_POST['responsible_user_id'] ?? 0);
                $notes=trim((string)($_POST['notes'] ?? ''));
                $internal=trim((string)($_POST['internal_notes'] ?? ''));
                $pdo->prepare('UPDATE cp_orders SET due_date=?,responsible_user_id=?,notes=?,internal_notes=?,updated_by=?,updated_at=NOW() WHERE id=?')->execute([$due?:null,$responsible?:null,$notes,$internal,$uid,$id]);
                redirect('/admin/orden.php?id='.$id.'&updated=1');
            }
        }catch(Throwable $e){
            if(isset($pdo)&&$pdo->inTransaction())$pdo->rollBack();
            $error=$e->getMessage()==='Estado no válido.'?$e->getMessage():'No se pudo actualizar la orden.';
        }
    }
}

$order=order_get($id);$items=order_items($id);$history=order_history($id);
$financeSummary=finance_tables_ready()?finance_order_summary($id):null;
$trackingUrl=tracking_url_for_order($id);
$users=db()->query('SELECT id,name FROM cp_users ORDER BY name')->fetchAll();

require __DIR__ . '/../includes/header.php';
?>
<link rel="stylesheet" href="/assets/css/ordenes.css?v=20260917-6">
<link rel="stylesheet" href="/assets/css/finanzas.css?v=20260917-1">
<div class="order-toolbar no-print"><div><span class="eyebrow">FASE 6 · ORDEN DE SERVICIO</span><h2><?=e($order['order_number'])?></h2><p class="muted">Origen: <a href="/admin/cotizacion.php?id=<?=((int)$order['quote_id'])?>"><?=e($order['quote_number'])?></a></p></div><div class="order-toolbar-actions"><?php if (!empty($order['customer_phone'])): ?><a class="btn btn-secondary" href="/admin/whatsapp.php?source=order&id=<?=((int)$id)?>&template=order_confirmed">💬 WhatsApp</a><?php endif; ?><a class="btn btn-secondary" href="/admin/pagos.php?order_id=<?=((int)$id)?>">💰 Pagos</a><a class="btn btn-secondary" href="/admin/facturacion.php?order_id=<?=((int)$id)?>">🧾 Facturación</a><a class="btn btn-primary" href="<?=e($trackingUrl)?>" target="_blank" rel="noopener">🔗 Ver seguimiento</a><button class="btn btn-secondary" type="button" onclick="window.print()">Imprimir</button><a class="btn btn-secondary" href="/admin/ordenes.php">Volver</a></div></div>
<?php if($error): ?><div class="notice danger no-print"><?=e($error)?></div><?php endif; ?><?php if(isset($_GET['created'])): ?><div class="notice no-print"><span class="ok">✓</span> Orden creada correctamente.</div><?php endif; ?><?php if(isset($_GET['updated'])): ?><div class="notice no-print"><span class="ok">✓</span> Orden actualizada.</div><?php endif; ?>
<div class="order-view-grid">
<main><article class="card order-document">
<div class="document-head"><div><span class="eyebrow">COLIBRÍ PRINT MÉXICO</span><h3><?=e($order['order_number'])?></h3><p>Fecha: <?=e(date('d/m/Y',strtotime((string)$order['order_date'])))?><?php if($order['due_date']): ?> · Compromiso: <?=e(date('d/m/Y',strtotime((string)$order['due_date'])))?><?php endif; ?></p></div><span class="status-badge order-status-<?=e((string)$order['status'])?>"><?=e(order_status_label((string)$order['status']))?></span></div>
<div class="customer-box"><span>CLIENTE</span><strong><?=e($order['customer_name'] ?? 'Sin cliente')?></strong><?php if($order['customer_tax_number']): ?><small>RFC: <?=e($order['customer_tax_number'])?></small><?php endif; ?><?php if($order['customer_email']): ?><small><?=e($order['customer_email'])?></small><?php endif; ?><?php if($order['customer_phone']): ?><small><?=e($order['customer_phone'])?></small><?php endif; ?><?php if($order['customer_address']): ?><small><?=e($order['customer_address'])?><?= $order['customer_city'] ? ', '.e($order['customer_city']) : '' ?><?= $order['customer_state'] ? ', '.e($order['customer_state']) : '' ?></small><?php endif; ?></div>
<table class="table"><thead><tr><th>Descripción</th><th>Cant.</th><th>Precio</th><th>Importe</th></tr></thead><tbody><?php foreach($items as $item): ?><tr><td><?=e($item['description'])?></td><td><?=e((string)$item['quantity'])?></td><td><?=quote_money((float)$item['unit_price'])?></td><td><?=quote_money((float)$item['subtotal'])?></td></tr><?php endforeach; ?></tbody></table>
<div class="document-total"><div class="grand"><span>Total</span><strong><?=quote_money((float)$order['total'])?></strong></div></div>
<?php if($order['notes']): ?><div class="document-section"><h4>Notas operativas</h4><p><?=nl2br(e($order['notes']))?></p></div><?php endif; ?>
<div class="document-footer">Orden generada desde <?=e($order['quote_number'])?> · <?=e($order['order_number'])?></div>
</article>
<section class="card history-card no-print" id="seguimiento"><div class="section-heading"><div><span class="eyebrow">HISTORIAL</span><h3>Seguimiento de la orden</h3></div></div>
<?php if(!$history): ?><p class="empty">Sin movimientos.</p><?php else: ?><div class="history-list"><?php foreach($history as $h): ?><div class="history-item"><div><strong><?=e(order_status_label((string)$h['new_status']))?></strong><small><?=e(date('d/m/Y H:i',strtotime((string)$h['created_at'])))?> · <?=e($h['user_name'] ?? 'Sistema')?></small></div><p><?=e($h['note'] ?? '')?></p></div><?php endforeach; ?></div><?php endif; ?>
</section></main>
<aside class="no-print">
<div class="card status-card"><span class="eyebrow">ESTADO</span><h3>Actualizar estado</h3><form method="post"><input type="hidden" name="_csrf" value="<?=e(csrf_token())?>"><input type="hidden" name="action" value="status"><select name="status"><?php foreach(order_statuses() as $k=>$label): ?><option value="<?=e($k)?>" <?=$order['status']===$k?'selected':''?>><?=e($label)?></option><?php endforeach; ?></select><textarea name="history_note" rows="3" placeholder="Nota del cambio..."></textarea><button class="btn btn-primary full" type="submit">Guardar estado</button></form></div>
<div class="card finance-order-card"><span class="eyebrow">FINANZAS</span><h3>Resumen de pagos</h3><?php if($financeSummary): ?><div class="finance-mini-grid"><div><span>Total</span><strong>$<?=number_format($financeSummary['order_total'],2,'.',',')?></strong></div><div><span>Pagado</span><strong class="positive">$<?=number_format($financeSummary['paid_total'],2,'.',',')?></strong></div><div><span>Saldo</span><strong class="pending">$<?=number_format($financeSummary['balance'],2,'.',',')?></strong></div></div><div class="actions actions-left"><a class="btn btn-sm btn-secondary" href="/admin/pagos.php?order_id=<?=((int)$id)?>">Ver pagos</a><a class="btn btn-sm btn-secondary" href="/admin/facturacion.php?order_id=<?=((int)$id)?>">Ver facturación</a></div><?php else: ?><p class="help-text">Instala la migración de Fase 10 para habilitar los registros financieros.</p><?php endif; ?></div>
<div class="card internal-card"><span class="eyebrow">OPERACIÓN</span><h3>Datos internos</h3><form method="post"><input type="hidden" name="_csrf" value="<?=e(csrf_token())?>"><input type="hidden" name="action" value="details"><div class="field"><label>Fecha compromiso</label><input type="date" name="due_date" value="<?=e((string)($order['due_date'] ?? ''))?>"></div><div class="field"><label>Responsable</label><select name="responsible_user_id"><option value="0">Sin asignar</option><?php foreach($users as $u): ?><option value="<?=((int)$u['id'])?>" <?=$u['id']==$order['responsible_user_id']?'selected':''?>><?=e($u['name'])?></option><?php endforeach; ?></select></div><div class="field"><label>Notas operativas</label><textarea name="notes" rows="4"><?=e((string)($order['notes'] ?? ''))?></textarea></div><div class="field"><label>Notas internas</label><textarea name="internal_notes" rows="4"><?=e((string)($order['internal_notes'] ?? ''))?></textarea></div><button class="btn btn-secondary full" type="submit">Guardar datos</button></form><small>La orden conserva su vínculo con la cotización original.</small></div>
</aside></div>
<?php require __DIR__ . '/../includes/footer.php'; ?>
