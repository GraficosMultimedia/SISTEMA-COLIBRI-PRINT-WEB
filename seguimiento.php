<?php
declare(strict_types=1);
require_once __DIR__ . '/includes/seguimiento.php';
require_once __DIR__ . '/includes/company.php';

$company = company_profile();
$token = trim((string)($_GET['t'] ?? ''));
$order = $token !== '' ? tracking_order_by_token($token) : null;
$currentInternal = $order ? tracking_current_stage((int)$order['id']) : '';
$history = $order ? tracking_history((int)$order['id']) : [];
$clientStages = tracking_client_stages();
$currentClient = $order ? tracking_internal_to_client_stage($currentInternal) : 'received';
$clientKeys = array_keys($clientStages);
$currentIndex = array_search($currentClient, $clientKeys, true);
if ($currentIndex === false) $currentIndex = 0;
$showApproval = $order ? tracking_has_design_approval($history, $currentInternal) : false;
$clientHistory = $order ? tracking_client_history($history, $showApproval) : [];
$latestMessage = $order ? tracking_latest_client_message($history, $currentInternal) : '';

function track_e(?string $value): string { return htmlspecialchars((string)$value, ENT_QUOTES, 'UTF-8'); }
function track_money(float $value): string { return '$' . number_format($value, 2, '.', ','); }
function track_date(?string $value, string $format='d/m/Y'): string {
    if (!$value) return 'Por confirmar';
    $ts = strtotime($value);
    return $ts ? date($format, $ts) : 'Por confirmar';
}
function track_company_address(array $company): string {
    $parts = [];
    foreach (['address','neighborhood','city','state','postal_code','country'] as $key) {
        $value = trim((string)($company[$key] ?? ''));
        if ($value !== '') $parts[] = $value;
    }
    return implode(' · ', $parts);
}
$companyDisplayName = trim((string)($company['trade_name'] ?? '')) !== ''
    ? (string)$company['trade_name']
    : ((string)($company['legal_name'] ?? '') !== '' ? (string)$company['legal_name'] : 'Colibrí Print');
$companyLegalName = trim((string)($company['legal_name'] ?? ''));
$companyAddress = track_company_address($company);
$companyPhone = trim((string)($company['phone'] ?? ''));
$companyEmail = trim((string)($company['email'] ?? ''));
$companyWebsite = trim((string)($company['website'] ?? ''));
$companyRfc = trim((string)($company['rfc'] ?? ''));
$companyWebsiteLabel = preg_replace('#^https?://#i', '', $companyWebsite);
$companyPhoneHref = preg_replace('/[^0-9+]/', '', $companyPhone);
$companyWhatsAppHref = preg_replace('/[^0-9]/', '', $companyPhone);
if ($companyWhatsAppHref !== '' && strlen($companyWhatsAppHref) === 10) $companyWhatsAppHref = '52' . $companyWhatsAppHref;
?>
<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="robots" content="noindex,nofollow">
<title>Seguimiento de pedido | <?=track_e($companyDisplayName)?></title>
<link rel="stylesheet" href="/assets/css/seguimiento.css?v=20260917-4">
</head>
<body>
<div class="tracking-page">
<header class="tracking-company-header">
    <div class="tracking-company-top">
        <div class="tracking-company-brand">
            <?php if (!empty($company['logo_path'])): ?><div class="company-logo"><img src="<?=track_e($company['logo_path'])?>" alt="<?=track_e($companyDisplayName)?>"></div>
            <?php else: ?><div class="company-logo company-logo-fallback">🐦</div><?php endif; ?>
            <div class="company-identity">
                <strong><?=track_e($companyDisplayName)?></strong>
                <?php if ($companyLegalName !== '' && $companyLegalName !== $companyDisplayName): ?><span><?=track_e($companyLegalName)?></span><?php endif; ?>
                <small>Seguimiento de pedidos</small>
            </div>
        </div>
        <div class="company-header-badge">
            <span class="badge-dot"></span> Consulta segura
        </div>
    </div>
    <?php if ($companyAddress !== '' || $companyPhone !== '' || $companyEmail !== '' || $companyWebsite !== '' || $companyRfc !== ''): ?>
    <div class="tracking-company-details">
        <?php if ($companyAddress !== ''): ?><div class="company-address">📍 <?=track_e($companyAddress)?></div><?php endif; ?>
        <div class="contact-line">
            <?php if ($companyPhone !== ''): ?><a href="tel:<?=track_e($companyPhoneHref)?>">📞 <?=track_e($companyPhone)?></a><?php endif; ?>
            <?php if ($companyPhone !== '' && $companyWhatsAppHref !== ''): ?><a href="https://wa.me/<?=track_e($companyWhatsAppHref)?>" target="_blank" rel="noopener noreferrer">💬 WhatsApp</a><?php endif; ?>
            <?php if ($companyEmail !== ''): ?><a href="mailto:<?=track_e($companyEmail)?>">✉️ <?=track_e($companyEmail)?></a><?php endif; ?>
            <?php if ($companyWebsite !== ''): ?><a href="<?=track_e($companyWebsite)?>" target="_blank" rel="noopener noreferrer">🌐 <?=track_e($companyWebsiteLabel)?></a><?php endif; ?>
            <?php if ($companyRfc !== ''): ?><span>RFC: <?=track_e($companyRfc)?></span><?php endif; ?>
        </div>
    </div>
    <?php endif; ?>
</header>

<?php if (!$order): ?>
<section class="tracking-card not-found">
    <div class="big-icon">🔎</div>
    <h1>No encontramos este pedido</h1>
    <p>El enlace de seguimiento no es válido o ya no está disponible.</p>
</section>
<?php else: ?>
<section class="hero-card">
    <div>
        <span class="eyebrow">SEGUIMIENTO DE PEDIDO</span>
        <h1><?=track_e($order['order_number'])?></h1>
        <p><?=track_e($order['customer_name'] ?: 'Cliente')?> · <?=track_e($order['quote_number'] ?: 'Orden de servicio')?></p>
        <div class="tracking-tagline">En 1, 2 por 3, tu pedido listo. ✨</div>
    </div>
    <div class="current-pill"><span>Estado actual</span><strong><?=$clientStages[$currentClient]['icon']?> <?=track_e($clientStages[$currentClient]['label'])?></strong></div>
</section>
<section class="tracking-card">
    <div class="section-title"><div><span class="eyebrow">PROGRESO</span><h2>Así va tu pedido</h2></div></div>
    <div class="progress-line client-progress">
    <?php foreach ($clientStages as $key=>$stage): $idx=array_search($key,$clientKeys,true); $done=$idx < $currentIndex; $active=$key===$currentClient; ?>
        <div class="stage <?=($done?'done ':'').($active?'active':'')?>">
            <div class="stage-dot"><?=($done?'✓':$stage['icon'])?></div>
            <span><?=track_e($stage['label'])?></span>
        </div>
    <?php endforeach; ?>
    </div>
    <?php if ($showApproval): ?>
    <div class="approval-note <?=($currentInternal==='approval'?'is-current':'')?>">
        <div class="approval-note-icon">✅</div>
        <div><strong>Aprobación de diseño</strong><span><?=$currentInternal==='approval'?'Estamos esperando tu aprobación para continuar.':'El diseño ya pasó por esta etapa.'?></span></div>
    </div>
    <?php endif; ?>
</section>
<section class="two-col">
    <article class="tracking-card current-message">
        <span class="eyebrow">ACTUALIZACIÓN</span>
        <h2><?=$clientStages[$currentClient]['icon']?> <?=track_e($clientStages[$currentClient]['label'])?></h2>
        <p><?=nl2br(track_e($latestMessage))?></p>
        <small>Última actualización: <?=track_date($history ? $history[count($history)-1]['created_at'] : null,'d/m/Y H:i')?></small>
    </article>
    <article class="tracking-card order-summary">
        <span class="eyebrow">INFORMACIÓN</span>
        <div class="info-row"><span>Pedido</span><strong><?=track_e($order['order_number'])?></strong></div>
        <div class="info-row"><span>Fecha de pedido</span><strong><?=track_date($order['order_date'])?></strong></div>
        <div class="info-row"><span>Entrega estimada</span><strong><?=track_date($order['due_date'])?></strong></div>
        <div class="info-row total"><span>Total</span><strong><?=track_money((float)$order['total'])?></strong></div>
    </article>
</section>
<section class="tracking-card history">
    <div class="section-title"><div><span class="eyebrow">ACTUALIZACIONES</span><h2>Lo que ha pasado</h2></div></div>
    <?php if (!$clientHistory): ?><p class="muted">Aún no hay actualizaciones registradas.</p>
    <?php else: ?><div class="timeline">
        <?php foreach ($clientHistory as $entry): ?>
        <div class="timeline-item <?=($entry['key']==='approval'?'timeline-approval':'')?>">
            <div class="timeline-dot"><?=$entry['icon']?></div>
            <div><strong><?=track_e($entry['label'])?></strong><time><?=track_date($entry['created_at'],'d/m/Y H:i')?></time><?php if(trim((string)$entry['note'])!==''): ?><p><?=nl2br(track_e($entry['note']))?></p><?php endif; ?></div>
        </div>
        <?php endforeach; ?>
    </div><?php endif; ?>
</section>
<?php endif; ?>
<footer>
    <strong><?=track_e($companyDisplayName)?></strong>
    <?php if ($companyAddress !== ''): ?> · <?=track_e($companyAddress)?><?php endif; ?>
    <br><span>Seguimiento de pedido · La información mostrada es de carácter informativo y operativo.</span>
</footer>
</div>
</body>
</html>
