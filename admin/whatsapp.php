<?php
declare(strict_types=1);
require_once __DIR__ . '/../config/runtime.php';
require_once __DIR__ . '/../includes/actions.php';
require_once __DIR__ . '/../includes/whatsapp.php';
require_auth();

$title='Centro de WhatsApp';
$error=null; $success=null;
$sourceType=(string)($_GET['source'] ?? $_POST['source'] ?? 'quote');
$sourceId=(int)($_GET['id'] ?? $_POST['id'] ?? 0);
$templateKey=(string)($_GET['template'] ?? $_POST['template_key'] ?? '');

if($_SERVER['REQUEST_METHOD']==='POST'){
    if(!csrf_check($_POST['_csrf'] ?? null)){
        $error='La sesión del formulario expiró. Recarga la página.';
    } else {
        $action=(string)($_POST['action'] ?? '');
        if($action==='open_whatsapp'){
            try{
                $built=whatsapp_build_message($sourceType,$sourceId,$templateKey);
                $src=$built['source'];
                whatsapp_log_prepared($built['template_key'],$sourceType==='order'?$sourceId:0,$sourceType==='quote'?$sourceId:0,(int)$src['customer_id'],(string)$src['phone'],(string)$built['message']);
                header('Location: '.$built['url'],true,302); exit;
            }catch(Throwable $e){$error=$e->getMessage();}
        } elseif($action==='save_template'){
            $key=(string)($_POST['template_key']??''); $body=trim((string)($_POST['body']??'')); $active=isset($_POST['active'])?1:0;
            $defaults=whatsapp_default_templates();
            if(!isset($defaults[$key])) $error='Plantilla no válida.';
            elseif($body==='') $error='El mensaje no puede quedar vacío.';
            else { try{db()->prepare('INSERT INTO cp_whatsapp_templates(template_key,name,category,body,active,created_at,updated_at) VALUES(?,?,?,?,?,NOW(),NOW()) ON DUPLICATE KEY UPDATE name=VALUES(name),category=VALUES(category),body=VALUES(body),active=VALUES(active),updated_at=NOW()')->execute([$key,$defaults[$key]['name'],$defaults[$key]['category'],$body,$active]); $success='Plantilla guardada correctamente.';}catch(Throwable $e){$error='No se pudo guardar la plantilla.';} }
        } elseif($action==='reset_template'){
            $key=(string)($_POST['template_key']??''); $defaults=whatsapp_default_templates();
            if(isset($defaults[$key])){try{db()->prepare('INSERT INTO cp_whatsapp_templates(template_key,name,category,body,active,created_at,updated_at) VALUES(?,?,?,?,1,NOW(),NOW()) ON DUPLICATE KEY UPDATE body=VALUES(body),active=1,updated_at=NOW()')->execute([$key,$defaults[$key]['name'],$defaults[$key]['category'],$defaults[$key]['body']]);$success='Mensaje restaurado.';}catch(Throwable $e){$error='No se pudo restaurar el mensaje.';}}
        }
    }
}

$quotes=[];$orders=[];$promotions=[];$logs=[];
try{$quotes=db()->query("SELECT q.id,q.quote_number,q.issue_date,q.status,c.name customer_name FROM cp_quotes q LEFT JOIN cp_customers c ON c.id=q.customer_id ORDER BY q.id DESC LIMIT 12")->fetchAll();}catch(Throwable $e){}
try{$orders=db()->query("SELECT o.id,o.order_number,o.status,o.due_date,c.name customer_name FROM cp_orders o LEFT JOIN cp_customers c ON c.id=o.customer_id ORDER BY o.id DESC LIMIT 12")->fetchAll();}catch(Throwable $e){}
try{$promotions=promotion_active_list('whatsapp',12);}catch(Throwable $e){}
try{$logs=db()->query('SELECT l.*,u.name user_name,o.order_number,q.quote_number FROM cp_whatsapp_log l LEFT JOIN cp_users u ON u.id=l.prepared_by LEFT JOIN cp_orders o ON o.id=l.order_id LEFT JOIN cp_quotes q ON q.id=l.quote_id ORDER BY l.id DESC LIMIT 15')->fetchAll();}catch(Throwable $e){}

$built=null;
if($sourceId>0){try{$built=whatsapp_build_message($sourceType,$sourceId,$templateKey);$templateKey=$built['template_key'];}catch(Throwable $e){$error=$error?:$e->getMessage();}}
$templates=whatsapp_templates(true);
$serviceTemplates=array_values(array_filter($templates,static fn($t)=>(string)($t['category']??'')==='service'));
$commercialTemplates=array_values(array_filter($templates,static fn($t)=>(string)($t['category']??'')==='commercial'));

require __DIR__ . '/../includes/header.php';
?>
<link rel="stylesheet" href="/assets/css/whatsapp.css?v=20260917-central-1">
<div class="wa-toolbar no-print"><div><span class="eyebrow">CENTRO DE COMUNICACIONES</span><h2>WhatsApp</h2><p class="muted">Un solo lugar para preparar, revisar y abrir todos los mensajes de Colibrí Print.</p></div></div>
<?php if($error): ?><div class="notice danger no-print"><?=e($error)?></div><?php endif; ?>
<?php if($success): ?><div class="notice no-print"><span class="ok">✓</span> <?=e($success)?></div><?php endif; ?>

<section class="card wa-intro no-print"><div><span class="eyebrow">CENTRALIZADO</span><h3>Una sola bandeja para servicio y promociones</h3><p>Las comunicaciones operativas y comerciales usan el mismo centro, pero conservan plantillas y registros separados.</p></div><div class="wa-legend"><span>🧾 Cotización</span><span>🛠️ Orden</span><span>🏭 Producción</span><span>🏷️ Promoción</span></div></section>

<section class="wa-center-grid no-print">
  <div>
    <section class="card wa-source-card">
      <div class="section-heading"><div><span class="eyebrow">1 · SELECCIONA</span><h3>Qué quieres comunicar</h3></div></div>
      <div class="wa-source-tabs">
        <a class="<?= $sourceType==='quote'?'active':'' ?>" href="/admin/whatsapp.php?source=quote">🧾 Cotización</a>
        <a class="<?= $sourceType==='order'?'active':'' ?>" href="/admin/whatsapp.php?source=order">🛠️ Orden</a>
        <a class="<?= $sourceType==='promotion'?'active':'' ?>" href="/admin/whatsapp.php?source=promotion">🏷️ Promoción</a>
      </div>
      <div class="wa-record-list">
      <?php if($sourceType==='quote'): foreach($quotes as $r): ?>
        <a class="wa-record <?= $sourceId===(int)$r['id']?'selected':'' ?>" href="/admin/whatsapp.php?source=quote&id=<?=((int)$r['id'])?>&template=quote_sent"><div><strong><?=e($r['quote_number'])?></strong><span><?=e($r['customer_name']??'Sin cliente')?></span></div><small><?=e(date('d/m/Y',strtotime((string)$r['issue_date'])))?></small></a>
      <?php endforeach; elseif($sourceType==='order'): foreach($orders as $r): ?><a class="wa-record <?= $sourceId===(int)$r['id']?'selected':'' ?>" href="/admin/whatsapp.php?source=order&id=<?=((int)$r['id'])?>&template=<?=e(whatsapp_stage_template_key((string)$r['status']))?>"><div><strong><?=e($r['order_number'])?></strong><span><?=e($r['customer_name']??'Sin cliente')?></span></div><small><?=e((string)$r['status'])?></small></a>
      <?php endforeach; else: foreach($promotions as $r): ?><a class="wa-record <?= $sourceId===(int)$r['id']?'selected':'' ?>" href="/admin/whatsapp.php?source=promotion&id=<?=((int)$r['id'])?>&template=promotion_offer"><div><strong><?=e($r['title'])?></strong><span><?=e($r['label'])?></span></div><small><?=e(promotion_effective_state_label(promotion_effective_state($r)))?></small></a>
      <?php endforeach; endif; ?>
      <?php if(($sourceType==='quote'&&!$quotes)||($sourceType==='order'&&!$orders)||($sourceType==='promotion'&&!$promotions)): ?><div class="empty">No hay registros disponibles.</div><?php endif; ?>
      </div>
    </section>

    <section class="card wa-template-select no-print">
      <div class="section-heading"><div><span class="eyebrow">2 · PLANTILLA</span><h3>Mensaje que se utilizará</h3></div></div>
      <div class="wa-template-pills">
      <?php $list=$sourceType==='promotion'?$commercialTemplates:$serviceTemplates; foreach($list as $t): ?><a class="wa-template-pill <?= $templateKey===$t['template_key']?'active':'' ?>" href="/admin/whatsapp.php?source=<?=e($sourceType)?>&id=<?=$sourceId?>&template=<?=e($t['template_key'])?>"><?=e($t['name'])?></a><?php endforeach; ?>
      </div>
    </section>
  </div>

  <div>
    <section class="card wa-compose <?= $built?'has-preview':'' ?>">
      <div class="section-heading"><div><span class="eyebrow">3 · REVISAR</span><h3>Vista previa</h3></div><?php if($built): ?><span class="wa-category-pill <?= $built['template']['category']==='commercial'?'commercial':'service' ?>"><?=e($built['template']['category']==='commercial'?'COMERCIAL':'SERVICIO')?></span><?php endif; ?></div>
      <?php if(!$built): ?><div class="wa-empty-state"><div class="wa-empty-icon">💬</div><strong>Selecciona una comunicación</strong><p>El mensaje se construirá automáticamente aquí.</p></div>
      <?php else: ?>
        <div class="wa-preview-meta"><div><span>Origen</span><strong><?=e($built['source']['label'])?></strong></div><div><span>Plantilla</span><strong><?=e($built['template']['name'])?></strong></div><div><span>Destino</span><strong><?=e($built['source']['phone']?:'Seleccionar contacto en WhatsApp')?></strong></div></div>
        <?php if($sourceType==='quote'): ?><div class="wa-pdf-note">📄 El mensaje incluye automáticamente el enlace público del PDF de la cotización.</div><?php endif; ?>
        <textarea class="wa-message-preview" readonly><?=e($built['message'])?></textarea>
        <form method="post" class="wa-send-form"><input type="hidden" name="_csrf" value="<?=e(csrf_token())?>"><input type="hidden" name="action" value="open_whatsapp"><input type="hidden" name="source" value="<?=e($sourceType)?>"><input type="hidden" name="id" value="<?=((int)$sourceId)?>"><input type="hidden" name="template_key" value="<?=e($templateKey)?>"><button class="btn btn-primary wa-open-btn" type="submit">💬 Abrir WhatsApp</button><a class="btn btn-secondary" href="/admin/whatsapp.php?source=<?=e($sourceType)?>">Limpiar</a></form>
      <?php endif; ?>
    </section>
  </div>
</section>

<section class="card wa-log-card no-print"><div class="section-heading"><div><span class="eyebrow">HISTORIAL</span><h3>Últimas comunicaciones preparadas</h3></div><span class="count-pill"><?=count($logs)?></span></div><?php if(!$logs): ?><div class="empty">Todavía no hay mensajes preparados.</div><?php else: ?><div class="table-wrap"><table class="table"><thead><tr><th>Fecha</th><th>Tipo</th><th>Origen</th><th>Teléfono</th><th>Usuario</th></tr></thead><tbody><?php foreach($logs as $log): ?><tr><td><?=e(date('d/m/Y H:i',strtotime((string)$log['created_at'])))?></td><td><?=e((string)$log['template_key'])?></td><td><?=e(trim((string)($log['order_number']??'').' '.($log['quote_number']??''))?:'—')?></td><td><?=e((string)($log['phone']??''))?:'—'?></td><td><?=e($log['user_name']??'Sistema')?></td></tr><?php endforeach; ?></tbody></table></div><?php endif; ?></section>

<section class="wa-template-management no-print"><div class="section-heading"><div><span class="eyebrow">CONFIGURACIÓN</span><h3>Plantillas</h3><p class="muted">Edita los mensajes una sola vez y se reutilizan en todo el sistema.</p></div></div><div class="wa-template-grid"><?php foreach($templates as $t): ?><form class="card wa-template" method="post"><input type="hidden" name="_csrf" value="<?=e(csrf_token())?>"><input type="hidden" name="action" value="save_template"><input type="hidden" name="template_key" value="<?=e($t['template_key'])?>"><div class="wa-template-head"><div><span class="eyebrow"><?=e($t['category']==='commercial'?'COMERCIAL':'SERVICIO')?></span><h3><?=e($t['name'])?></h3></div><label class="wa-active"><input type="checkbox" name="active" <?=$t['active']?'checked':''?>> Activa</label></div><textarea name="body" rows="7" class="wa-body"><?=e($t['body'])?></textarea><div class="wa-template-actions"><button class="btn btn-secondary" type="submit">Guardar</button><button class="btn btn-secondary" type="submit" name="action" value="reset_template">Restaurar</button></div></form><?php endforeach; ?></div></section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
