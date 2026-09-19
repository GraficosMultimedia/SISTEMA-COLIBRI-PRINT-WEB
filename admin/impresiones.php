<?php
declare(strict_types=1);

require_once __DIR__ . '/../config/runtime.php';
require_once __DIR__ . '/../includes/impresiones.php';
require_auth();

$title = 'Control de metraje';
$error = null;
$saved = false;
$rollCreated = false;

try {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        if (!csrf_check($_POST['_csrf'] ?? null)) {
            throw new RuntimeException('La sesión del formulario expiró. Recarga la página.');
        }

        $action = (string)($_POST['action'] ?? '');
        if ($action === 'create_roll') {
            $id = print_meter_create_roll((string)($_POST['roll_name'] ?? ''), (float)($_POST['initial_m'] ?? 0));
            log_activity('create', 'print_rolls', 'Rollo creado #' . $id);
            redirect('/admin/impresiones.php?roll_created=1');
        }

        if ($action === 'register_print') {
            $payload = print_meter_normalize($_POST);
            if ($payload['roll_id'] <= 0 || $payload['linear_m'] <= 0 || $payload['job_name'] === '') {
                throw new RuntimeException('Completa rollo, trabajo y metros lineales.');
            }
            $id = print_meter_register($payload);
            log_activity('create', 'print_meter_logs', 'Trabajo impreso #' . $id . ' · ' . $payload['linear_m'] . ' m');
            redirect('/admin/impresiones.php?saved=1');
        }
    }
} catch (Throwable $e) {
    $error = $e instanceof RuntimeException ? $e->getMessage() : 'No se pudo guardar el registro.';
}

if (isset($_GET['saved'])) $saved = true;
if (isset($_GET['roll_created'])) $rollCreated = true;

$rolls = [];
$metrics = ['jobs'=>0,'printed_m'=>0,'waste_m'=>0,'good_m'=>0];
$activeRoll = null;
$rows = [];
try {
    $rolls = print_meter_active_rolls();
    $metrics = print_meter_dashboard();
    $activeRoll = print_meter_active_roll();
    $rows = print_meter_rows();
} catch (Throwable $e) {
    $error = $error ?: 'No se pudo cargar el módulo de metraje. Verifica que la migración 017 esté instalada.';
}

require __DIR__ . '/../includes/header.php';
?>
<link rel="stylesheet" href="/assets/css/impresiones.css?v=20260918-metros1">
<div class="meter-toolbar">
  <div>
    <span class="eyebrow">PRODUCCIÓN · CONTROL DE LONA</span>
    <h2>Metros de impresión</h2>
    <p class="muted">Solo registra los metros lineales consumidos por cada trabajo y descuéntalos del rollo utilizado.</p>
  </div>
</div>

<?php if ($error): ?><div class="notice danger"><?=e($error)?></div><?php endif; ?>
<?php if ($saved): ?><div class="notice"><span class="ok">✓</span> Impresión registrada y metros descontados del rollo.</div><?php endif; ?>
<?php if ($rollCreated): ?><div class="notice"><span class="ok">✓</span> Rollo creado correctamente.</div><?php endif; ?>

<div class="meter-kpis">
  <div class="meter-kpi"><span>Impreso</span><strong><?=number_format($metrics['printed_m'],3)?> m</strong><small>Total registrado</small></div>
  <div class="meter-kpi good"><span>Producción buena</span><strong><?=number_format($metrics['good_m'],3)?> m</strong><small>Impresión aprovechable</small></div>
  <div class="meter-kpi waste"><span>Merma</span><strong><?=number_format($metrics['waste_m'],3)?> m</strong><small>Tests, cancelados, atrapamientos y reimpresiones</small></div>
  <div class="meter-kpi"><span>Trabajos</span><strong><?=number_format($metrics['jobs'])?></strong><small>Registros</small></div>
</div>

<section class="meter-grid-top">
  <article class="card meter-roll-card">
    <div class="section-heading">
      <div><span class="eyebrow">ROLLO ACTIVO</span><h3><?=e($activeRoll['roll_name'] ?? 'No hay rollo activo')?></h3></div>
      <?php if ($activeRoll): ?><span class="meter-balance"><?=number_format((float)$activeRoll['remaining_m'],3)?> m</span><?php endif; ?>
    </div>
    <?php if ($activeRoll): ?>
      <div class="meter-progress"><span style="width:<?=max(0,min(100,((float)$activeRoll['remaining_m']/max(0.001,(float)$activeRoll['initial_m']))*100))?>%"></span></div>
      <p class="muted">Inicial: <?=number_format((float)$activeRoll['initial_m'],3)?> m · Disponible: <?=number_format((float)$activeRoll['remaining_m'],3)?> m</p>
    <?php else: ?>
      <p class="muted">Crea un rollo nuevo para comenzar a registrar impresiones.</p>
    <?php endif; ?>
    <form method="post" class="meter-roll-form">
      <input type="hidden" name="_csrf" value="<?=e(csrf_token())?>">
      <input type="hidden" name="action" value="create_roll">
      <div class="field"><label>Nuevo rollo</label><input name="roll_name" placeholder="Ej. Rollo Lona 1" required></div>
      <div class="field"><label>Metros iniciales</label><input type="number" step="0.001" min="0.001" name="initial_m" placeholder="50.000" required></div>
      <button class="btn btn-primary" type="submit">+ Abrir rollo</button>
    </form>
  </article>

  <article class="card meter-register-card">
    <div class="section-heading"><div><span class="eyebrow">PRONTEXP · CAPTURA MÍNIMA</span><h3>Registrar impresión</h3></div></div>
    <form method="post" class="meter-form" id="meterForm">
      <input type="hidden" name="_csrf" value="<?=e(csrf_token())?>">
      <input type="hidden" name="action" value="register_print">
      <div class="meter-form-grid">
        <div class="field"><label>Fecha y hora</label><input type="datetime-local" name="printed_at" value="<?=e(date('Y-m-d\TH:i'))?>" required></div>
        <div class="field"><label>Rollo</label><select name="roll_id" required><option value="">Seleccionar rollo</option><?php foreach($rolls as $r): ?><option value="<?=((int)$r['id'])?>" <?=($activeRoll && (int)$activeRoll['id']===(int)$r['id'])?'selected':''?>><?=e($r['roll_name'])?> · <?=number_format((float)$r['remaining_m'],3)?> m disponibles</option><?php endforeach; ?></select></div>
        <div class="field field-wide"><label>Nombre del trabajo en Printexp</label><input name="job_name" placeholder="Ej. lonas figuras y mtra.prt" required></div>
        <div class="field"><label>Job Size · largo (mm)</label><input id="job_length_mm" type="number" step="0.01" min="0" name="job_length_mm" placeholder="3810.00"></div>
        <div class="field"><label>Metros lineales</label><input id="linear_m" type="number" step="0.001" min="0" name="linear_m" placeholder="3.810" required></div>
        <div class="field"><label>Resultado</label><select name="result_status" id="result_status"><?php foreach(print_meter_results() as $k=>$label): ?><option value="<?=e($k)?>"><?=e($label)?></option><?php endforeach; ?></select></div>
      </div>
      <div class="meter-preview"><span>Consumo del rollo</span><strong id="consumption_preview">0.000 m</strong><small>Todo trabajo impreso consume material. Test, cancelación, atrapamiento y reimpresión se registran como merma.</small></div>
      <button class="btn btn-primary" type="submit">Registrar y descontar</button>
    </form>
  </article>
</section>

<section class="card meter-history-card">
  <div class="section-heading"><div><span class="eyebrow">HISTORIAL</span><h3>Trabajos impresos</h3><p class="muted">Metros descontados del rollo por cada trabajo.</p></div></div>
  <div class="table-wrap"><table class="meter-table"><thead><tr><th>Fecha</th><th>Rollo</th><th>Trabajo</th><th>Metros</th><th>Resultado</th><th>Merma</th></tr></thead><tbody>
  <?php foreach($rows as $r): ?><tr><td><?=e(date('d/m/Y H:i',strtotime((string)$r['printed_at'])))?></td><td><?=e($r['roll_name'])?></td><td><?=e($r['job_name'])?></td><td><strong><?=number_format((float)$r['linear_m'],3)?> m</strong></td><td><span class="meter-status meter-status-<?=e((string)$r['result_status'])?>"><?=e(print_meter_result_label((string)$r['result_status']))?></span></td><td><?=number_format((float)$r['waste_m'],3)?> m</td></tr><?php endforeach; ?>
  <?php if(!$rows): ?><tr><td colspan="6" class="empty">Todavía no hay trabajos registrados.</td></tr><?php endif; ?>
  </tbody></table></div>
</section>

<script>
(function(){
  const mm=document.getElementById('job_length_mm');
  const m=document.getElementById('linear_m');
  const p=document.getElementById('consumption_preview');
  function sync(fromMm){
    const mmVal=parseFloat(mm?.value||'0')||0;
    const mVal=parseFloat(m?.value||'0')||0;
    if(fromMm && mmVal>0){ m.value=(mmVal/1000).toFixed(3); }
    const finalM=parseFloat(m.value||'0')||0;
    p.textContent=finalM.toFixed(3)+' m';
  }
  mm?.addEventListener('input',()=>sync(true));
  m?.addEventListener('input',()=>sync(false));
  sync(false);
})();
</script>
<?php require __DIR__ . '/../includes/footer.php'; ?>
