<?php
declare(strict_types=1);

/*
 * Colibrí Print México · Sitio corporativo público
 * Reemplaza solamente el index.php del sitio público.
 * El archivo es independiente de WordPress y tolera que el backoffice
 * esté temporalmente en mantenimiento.
 */

$company = [
    'name'       => 'Colibrí Print México',
    'short'      => 'Colibrí Print',
    'tagline'    => 'Imprimiendo con calidad.',
    'phone'      => '627 147 0053',
    'phone_raw'  => '526271470053',
    'phone_alt'  => '627 107 4512',
    'address'    => 'Alemania 87, Col. Loma Linda, C.P. 33820',
    'city'       => 'Hidalgo del Parral, Chihuahua, México',
    'facebook'   => 'https://www.facebook.com/ColibriPrintMexico/',
    'tiktok'     => 'https://www.tiktok.com/@colibriprintmexico',
    'maps'       => 'https://www.google.com/maps/search/?api=1&query=Colibr%C3%AD%20Print%20M%C3%A9xico%2C%20Alemania%2087%2C%20Loma%20Linda%2C%20Hidalgo%20del%20Parral%2C%20Chihuahua',
];

$whatsappBase = 'https://wa.me/' . $company['phone_raw'];
$waQuote = $whatsappBase . '?text=' . rawurlencode('Hola Colibrí Print México, quiero solicitar una cotización.');
$waProject = $whatsappBase . '?text=' . rawurlencode('Hola Colibrí Print México, quiero cotizar un proyecto. Quisiera información sobre materiales, medidas y tiempos.');
$waDesign = $whatsappBase . '?text=' . rawurlencode('Hola Colibrí Print México, necesito apoyo con diseño y quiero conocer sus opciones.');

$promotions = [];
try {
    $runtime = __DIR__ . '/config/runtime.php';
    if (is_file($runtime)) {
        require_once $runtime;
        if (function_exists('db')) {
            $pdo = db();
            $exists = (bool)$pdo->query("SHOW TABLES LIKE 'cp_promotions'")->fetchColumn();
            if ($exists) {
                $cols = [];
                foreach ($pdo->query('SHOW COLUMNS FROM cp_promotions')->fetchAll(PDO::FETCH_ASSOC) as $row) {
                    $cols[(string)$row['Field']] = true;
                }
                $pick = static function(array $names) use ($cols): ?string {
                    foreach ($names as $name) {
                        if (isset($cols[$name])) return $name;
                    }
                    return null;
                };
                $title  = $pick(['title','name','nombre','promotion_name']);
                $desc   = $pick(['description','descripcion','details']);
                $normal = $pick(['normal_price','regular_price','before_price','price_before']);
                $promo  = $pick(['promo_price','promotion_price','sale_price','price']);
                $disc   = $pick(['discount_percent','discount','descuento']);
                $from   = $pick(['valid_from','starts_at','start_date','fecha_inicio']);
                $to     = $pick(['valid_until','ends_at','end_date','fecha_fin']);
                $image  = $pick(['image_path','image_url','imagen','image']);
                $active = $pick(['is_active','active','activo','status']);
                $public = $pick(['is_published','published','publicado','show_on_web']);

                if ($title) {
                    $fields = [
                        'id',
                        "`$title` AS p_title",
                        $desc ? "`$desc` AS p_desc" : "'' AS p_desc",
                        $normal ? "`$normal` AS p_normal" : 'NULL AS p_normal',
                        $promo ? "`$promo` AS p_promo" : 'NULL AS p_promo',
                        $disc ? "`$disc` AS p_discount" : 'NULL AS p_discount',
                        $from ? "`$from` AS p_from" : 'NULL AS p_from',
                        $to ? "`$to` AS p_to" : 'NULL AS p_to',
                        $image ? "`$image` AS p_image" : 'NULL AS p_image',
                    ];
                    $where = [];
                    if ($active) {
                        if ($active === 'status') {
                            $where[] = "(`$active` = 'active' OR `$active` = 'published' OR `$active` = 1)";
                        } else {
                            $where[] = "`$active` = 1";
                        }
                    }
                    if ($public) $where[] = "`$public` = 1";
                    if ($from) $where[] = "(`$from` IS NULL OR `$from` = '0000-00-00' OR `$from` <= CURDATE())";
                    if ($to) $where[] = "(`$to` IS NULL OR `$to` = '0000-00-00' OR `$to` >= CURDATE())";

                    $sql = 'SELECT ' . implode(',', $fields) . ' FROM cp_promotions';
                    if ($where) $sql .= ' WHERE ' . implode(' AND ', $where);
                    $sql .= ' ORDER BY id DESC LIMIT 6';
                    foreach ($pdo->query($sql)->fetchAll(PDO::FETCH_ASSOC) as $row) {
                        $promotions[] = [
                            'title'    => trim((string)$row['p_title']),
                            'desc'     => trim((string)$row['p_desc']),
                            'normal'   => is_numeric($row['p_normal']) ? (float)$row['p_normal'] : null,
                            'promo'    => is_numeric($row['p_promo']) ? (float)$row['p_promo'] : null,
                            'discount' => is_numeric($row['p_discount']) ? (float)$row['p_discount'] : null,
                            'from'     => trim((string)$row['p_from']),
                            'to'       => trim((string)$row['p_to']),
                            'image'    => trim((string)$row['p_image']),
                        ];
                    }
                }
            }
        }
    }
} catch (Throwable $e) {
    $promotions = [];
}

function h(string $value): string {
    return htmlspecialchars($value, ENT_QUOTES, 'UTF-8');
}
function money_public(?float $value): string {
    return $value === null ? '' : '$' . number_format($value, 2, '.', ',');
}
function public_image(string $value): string {
    $value = trim($value);
    if ($value === '') return '';
    if (preg_match('#^https?://#i', $value)) return $value;
    return '/' . ltrim($value, '/');
}
function promo_date(string $value): string {
    if ($value === '' || $value === '0000-00-00') return '';
    $ts = strtotime($value);
    return $ts ? date('d/m/Y', $ts) : '';
}
?>
<!doctype html>
<html lang="es-MX">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Colibrí Print México en Hidalgo del Parral: diseño gráfico, gran formato, rotulación vehicular, personalización textil, grabado láser, sellos, corte CNC, promocionales y soluciones para eventos y negocios.">
<meta name="theme-color" content="#0f1715">
<meta property="og:title" content="Colibrí Print México | Diseño, impresión y personalización">
<meta property="og:description" content="Diseño, producción y personalización para empresas, negocios, eventos y proyectos especiales en Hidalgo del Parral.">
<meta property="og:type" content="website">
<meta property="og:url" content="https://colibriprint.com.mx/">
<link rel="canonical" href="https://colibriprint.com.mx/">
<title>Colibrí Print México | Diseño, impresión y personalización</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800&family=Playfair+Display:wght@700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/assets/css/public.css?v=20260918-corporativo-v4">
<script type="application/ld+json">
{
  "@context":"https://schema.org",
  "@type":"LocalBusiness",
  "name":"Colibrí Print México",
  "url":"https://colibriprint.com.mx/",
  "telephone":"+52 627 147 0053",
  "address":{
    "@type":"PostalAddress",
    "streetAddress":"Alemania 87, Col. Loma Linda",
    "postalCode":"33820",
    "addressLocality":"Hidalgo del Parral",
    "addressRegion":"Chihuahua",
    "addressCountry":"MX"
  },
  "sameAs":[
    "https://www.facebook.com/ColibriPrintMexico/",
    "https://www.tiktok.com/@colibriprintmexico"
  ],
  "openingHoursSpecification":[
    {"@type":"OpeningHoursSpecification","dayOfWeek":["Monday","Tuesday","Wednesday","Thursday","Friday"],"opens":"09:00","closes":"18:00"},
    {"@type":"OpeningHoursSpecification","dayOfWeek":"Saturday","opens":"09:00","closes":"14:00"}
  ]
}
</script>
</head>
<body>
<a class="skip-link" href="#contenido">Saltar al contenido</a>

<div class="announcement">
  <div class="container announcement-inner">
    <span><b>COLIBRÍ PRINT MÉXICO</b> · Diseño · Producción · Instalación</span>
    <div class="announcement-links">
      <a href="tel:+52<?=h($company['phone_raw'])?>">☎ <?=h($company['phone'])?></a>
      <span>Hidalgo del Parral, Chih.</span>
    </div>
  </div>
</div>

<header class="site-header" id="inicio">
  <div class="container nav-wrap">
    <a class="brand" href="#inicio" aria-label="Colibrí Print México, inicio">
      <span class="brand-bird" aria-hidden="true">✦</span>
      <span class="brand-copy"><strong>Colibrí<span>Print</span></strong><small>MÉXICO · <?=h($company['tagline'])?></small></span>
    </a>
    <button class="nav-toggle" type="button" aria-expanded="false" aria-controls="main-nav" aria-label="Abrir menú">☰</button>
    <nav class="main-nav" id="main-nav">
      <a href="#servicios">Servicios</a>
      <a href="#soluciones">Soluciones</a>
      <a href="#proyectos">Proyectos</a>
      <a href="#promociones">Promociones</a>
      <a href="#nosotros">Nosotros</a>
      <a href="#preguntas">Preguntas</a>
      <a href="#contacto">Contacto</a>
      <a class="nav-cta" href="<?=h($waQuote)?>" target="_blank" rel="noopener">Cotizar por WhatsApp ↗</a>
    </nav>
  </div>
</header>

<main id="contenido">
<section class="hero" aria-labelledby="hero-title">
  <div class="hero-noise" aria-hidden="true"></div>
  <div class="hero-pattern" aria-hidden="true"></div>
  <div class="container hero-grid">
    <div class="hero-copy">
      <div class="hero-kicker"><span class="dot"></span> DISEÑO · IMPRESIÓN · PERSONALIZACIÓN</div>
      <h1 id="hero-title">Tu idea entra aquí.<br><em>Sale convertida en impacto.</em></h1>
      <p class="hero-lead">Creamos piezas, espacios y soluciones visuales para marcas, negocios, empresas, eventos y proyectos que necesitan verse bien y comunicar mejor.</p>
      <div class="hero-actions">
        <a class="btn btn-primary" href="<?=h($waQuote)?>" target="_blank" rel="noopener">Solicitar cotización <span>↗</span></a>
        <a class="btn btn-light-outline" href="#servicios">Explorar servicios <span>↓</span></a>
      </div>
      <div class="hero-proof">
        <span><b>01</b> Atención personalizada</span>
        <span><b>02</b> Producción a medida</span>
        <span><b>03</b> Seguimiento del pedido</span>
      </div>
    </div>
    <div class="hero-visual" aria-label="Galería de aplicaciones visuales">
      <div class="hero-card hero-main-card">
        <img src="/assets/img/web/impacto-visual.webp" alt="Aplicaciones visuales y rotulación">
        <div class="hero-card-overlay">
          <span>DISEÑO · PRODUCCIÓN · INSTALACIÓN</span>
          <strong>Más que impresión.</strong>
        </div>
      </div>
      <div class="hero-card hero-side-card">
        <img src="/assets/img/web/papel-picado.webp" alt="Papel picado personalizado">
        <div class="hero-side-caption"><span>PERSONALIZACIÓN</span><strong>Tradición + color</strong></div>
      </div>
      <div class="hero-badge"><b>CP</b><span>Ideas que<br>se imprimen</span></div>
    </div>
  </div>
</section>

<section class="quick-nav" aria-label="Accesos rápidos">
  <div class="container quick-nav-grid">
    <a href="#servicios"><span>✦</span><div><b>Servicios</b><small>Descubre todo lo que hacemos</small></div><strong>↗</strong></a>
    <a href="#soluciones"><span>▣</span><div><b>Productos y soluciones</b><small>Personalizados para cada proyecto</small></div><strong>↗</strong></a>
    <a href="#proyectos"><span>◌</span><div><b>Portafolio</b><small>Conoce nuestra propuesta visual</small></div><strong>↗</strong></a>
    <a href="<?=h($company['facebook'])?>" target="_blank" rel="noopener"><span>f</span><div><b>Facebook</b><small>Noticias, trabajos y promociones</small></div><strong>↗</strong></a>
  </div>
</section>

<section class="section section-services" id="servicios">
  <div class="container">
    <div class="section-head split">
      <div><p class="eyebrow">TODO EL TALLER EN UN SOLO LUGAR</p><h2>Un proyecto.<br><span>Muchas posibilidades.</span></h2></div>
      <p>El sitio histórico de Colibrí Print reúne servicios de diseño, grabado láser, sellos, rotulación, impresión textil, alto formato, promocionales, renta de togas y birretes y diseño web. Aquí los convertimos en una experiencia corporativa más clara.</p>
    </div>
    <div class="service-groups">
      <article class="service-group group-dark">
        <div class="group-head"><span class="group-index">01</span><span class="group-tag">PUBLICIDAD & EXTERIOR</span></div>
        <h3>Haz que tu marca se vea.</h3>
        <p>Soluciones para comunicar en calle, fachadas, vehículos y espacios de gran formato.</p>
        <div class="chip-list"><span>Lonas</span><span>Vinil</span><span>Cartelería</span><span>Rotulación vehicular</span><span>Publicidad móvil</span></div>
        <a href="<?=h($waProject)?>" target="_blank" rel="noopener">Cotizar publicidad <b>↗</b></a>
      </article>
      <article class="service-group">
        <div class="group-head"><span class="group-index">02</span><span class="group-tag">MARCA & DISEÑO</span></div>
        <h3>Primero la idea.<br>Luego la pieza.</h3>
        <p>Diseño de imagen corporativa y materiales gráficos para que tu comunicación tenga coherencia.</p>
        <div class="chip-list"><span>Logotipos</span><span>Branding</span><span>Folletos</span><span>Tarjetas</span><span>Catálogos</span></div>
        <a href="<?=h($waDesign)?>" target="_blank" rel="noopener">Hablar de diseño <b>↗</b></a>
      </article>
      <article class="service-group">
        <div class="group-head"><span class="group-index">03</span><span class="group-tag">PERSONALIZACIÓN</span></div>
        <h3>Hazlo tuyo.<br>Que parezca pensado para ti.</h3>
        <p>Personalización de prendas y productos para regalos, campañas, equipos y ocasiones especiales.</p>
        <div class="chip-list"><span>Playeras</span><span>Tazas</span><span>Mousepads</span><span>Cojines</span><span>Promocionales</span></div>
        <a href="<?=h($waQuote)?>" target="_blank" rel="noopener">Ver opciones <b>↗</b></a>
      </article>
      <article class="service-group">
        <div class="group-head"><span class="group-index">04</span><span class="group-tag">FABRICACIÓN & ACABADOS</span></div>
        <h3>Del archivo<br>al objeto.</h3>
        <p>Procesos para convertir diseños en piezas físicas, señalética y elementos personalizados.</p>
        <div class="chip-list"><span>Grabado láser</span><span>Corte CNC</span><span>Sellos</span><span>Señalética</span><span>Proyectos especiales</span></div>
        <a href="<?=h($waProject)?>" target="_blank" rel="noopener">Cuéntanos tu proyecto <b>↗</b></a>
      </article>
    </div>
  </div>
</section>

<section class="section category-section" id="soluciones">
  <div class="container">
    <div class="section-head">
      <p class="eyebrow">PRODUCTOS Y SOLUCIONES</p>
      <h2>Lo cotidiano también puede<br><span>tener identidad.</span></h2>
      <p>Entre los productos publicados históricamente aparecen playeras, tazas, mousepads, cojines, artículos promocionales, invitaciones y piezas personalizadas. Los precios y disponibilidad pueden cambiar, por eso aquí mostramos familias de producto y no tarifas fijas.</p>
    </div>
    <div class="solution-grid">
      <article class="solution-card solution-photo"><img src="/assets/img/web/papel-picado.webp" alt="Papel picado personalizado"><div><span>EVENTOS</span><h3>Papel picado & decoración</h3><p>Personalizado para celebraciones, temporadas y espacios.</p></div></article>
      <article class="solution-card"><span class="solution-icon">◉</span><small>TEXTIL</small><h3>Playeras y prendas</h3><p>Ideas para equipos, familias, eventos, negocios y regalos.</p><a href="<?=h($waQuote)?>" target="_blank" rel="noopener">Consultar <b>↗</b></a></article>
      <article class="solution-card"><span class="solution-icon">▥</span><small>REGALOS</small><h3>Tazas, mousepads & cojines</h3><p>Productos personalizados para momentos y campañas especiales.</p><a href="<?=h($waQuote)?>" target="_blank" rel="noopener">Consultar <b>↗</b></a></article>
      <article class="solution-card"><span class="solution-icon">✺</span><small>IDENTIDAD</small><h3>Sellos y papelería</h3><p>Elementos de uso diario para empresas, negocios y profesionales.</p><a href="<?=h($waQuote)?>" target="_blank" rel="noopener">Consultar <b>↗</b></a></article>
      <article class="solution-card"><span class="solution-icon">⬡</span><small>PUBLICIDAD</small><h3>Lonas, vinil & señalética</h3><p>Material para promoción, comunicación visual y aplicaciones de espacio.</p><a href="<?=h($waProject)?>" target="_blank" rel="noopener">Cotizar <b>↗</b></a></article>
      <article class="solution-card solution-accent"><span class="solution-icon">⌂</span><small>GRADUACIONES & EVENTOS</small><h3>Togas, birretes y detalles</h3><p>Soluciones para celebraciones y momentos que merecen una producción completa.</p><a href="<?=h($waQuote)?>" target="_blank" rel="noopener">Preguntar disponibilidad <b>↗</b></a></article>
    </div>
  </div>
</section>

<section class="statement-band">
  <div class="container statement-grid">
    <div><span class="eyebrow">NUESTRA FORMA DE TRABAJAR</span><h2>Diseño que piensa.<br><em>Producción que responde.</em></h2></div>
    <p>Para proyectos cotizables, la operación del nuevo sistema conecta cotización, aprobación, orden de servicio, producción, seguimiento y comunicación por WhatsApp. El sitio público es la puerta de entrada; el proceso continúa detrás de escena.</p>
  </div>
</section>

<section class="section section-portfolio" id="proyectos">
  <div class="container">
    <div class="section-head split portfolio-head">
      <div><p class="eyebrow">APLICACIONES VISUALES</p><h2>Proyectos que se<br><span>hacen notar.</span></h2></div>
      <a class="btn btn-dark" href="<?=h($company['facebook'])?>" target="_blank" rel="noopener">Ver publicaciones en Facebook <span>↗</span></a>
    </div>
    <div class="portfolio-grid">
      <figure class="portfolio-item portfolio-large"><img src="/assets/img/web/impacto-visual.webp" alt="Aplicaciones de gran formato, rotulación e identidad"><figcaption><span>GRAN FORMATO · EXTERIOR</span><b>Impacto visual</b></figcaption></figure>
      <figure class="portfolio-item"><img src="/assets/img/web/rotulacion-vehicular.webp" alt="Rotulación vehicular"><figcaption><span>ROTULACIÓN</span><b>Publicidad móvil</b></figcaption></figure>
      <figure class="portfolio-item"><img src="/assets/img/web/espacios-comerciales.webp" alt="Espacio comercial con identidad visual"><figcaption><span>ESPACIOS</span><b>Interiorismo comercial</b></figcaption></figure>
      <figure class="portfolio-item portfolio-wide"><img src="/assets/img/web/papel-picado.webp" alt="Decoración personalizada en papel picado"><figcaption><span>EVENTOS · PERSONALIZACIÓN</span><b>Tradición que también comunica</b></figcaption></figure>
    </div>
    <p class="portfolio-note">Las imágenes de esta galería funcionan como muestras visuales y aplicaciones del universo de servicios de Colibrí Print; para ver publicaciones y trabajos del día a día, consulta nuestras redes.</p>
  </div>
</section>

<section class="section social-section" id="social">
  <div class="container social-wrap">
    <div class="social-copy">
      <p class="eyebrow">CONTENIDO EN MOVIMIENTO</p>
      <h2>La parte que no cabe<br><span>en una página.</span></h2>
      <p>En redes mostramos trabajos, procesos, temporadas, promociones y novedades. Facebook es el punto de información comercial; TikTok reúne contenido en formato video.</p>
      <div class="social-actions">
        <a class="social-btn facebook" href="<?=h($company['facebook'])?>" target="_blank" rel="noopener"><span>f</span> Facebook <b>↗</b></a>
        <a class="social-btn tiktok" href="<?=h($company['tiktok'])?>" target="_blank" rel="noopener"><span>♪</span> TikTok <b>↗</b></a>
      </div>
    </div>
    <div class="social-mosaic">
      <div class="social-tile tile-one"><img src="/assets/img/web/rotulacion-vehicular.webp" alt="Ejemplo de rotulación vehicular"></div>
      <div class="social-tile tile-two"><img src="/assets/img/web/papel-picado.webp" alt="Ejemplo de personalización para eventos"></div>
      <div class="social-card"><span>ACTUALIDAD</span><strong>Trabajos · promociones · ideas</strong><small>@colibriprintmexico</small></div>
    </div>
  </div>
</section>

<section class="section process-section" id="como-trabajamos">
  <div class="container">
    <div class="section-head center"><p class="eyebrow">DE LA IDEA A LA ENTREGA</p><h2>Un proceso claro, sin <span>vueltas innecesarias.</span></h2><p>El recorrido público se conecta con el sistema de cotizaciones, producción, seguimiento y WhatsApp.</p></div>
    <div class="process-line">
      <div class="process-step"><span>01</span><i>✦</i><h3>Cuéntanos</h3><p>Nos compartes qué necesitas, medidas, cantidades, referencias y fecha.</p></div>
      <div class="process-step"><span>02</span><i>⌁</i><h3>Cotizamos</h3><p>Definimos materiales, alcance y precio según el proyecto.</p></div>
      <div class="process-step"><span>03</span><i>✓</i><h3>Aprobamos</h3><p>Confirmas la propuesta y, cuando aplica, el diseño.</p></div>
      <div class="process-step"><span>04</span><i>▣</i><h3>Producimos</h3><p>El pedido pasa a producción y control de calidad.</p></div>
      <div class="process-step"><span>05</span><i>↗</i><h3>Entregamos</h3><p>Recibes la actualización de listo y el seguimiento hasta la entrega.</p></div>
    </div>
  </div>
</section>

<section class="section promotion-section" id="promociones">
  <div class="container">
    <div class="section-head split">
      <div><p class="eyebrow">PROMOCIONES</p><h2>Cuando aparece una buena<br><span>oferta, aquí vive.</span></h2></div>
      <p>Las promociones activas del administrador se pueden mostrar aquí automáticamente, reutilizando imagen, precio y vigencia.</p>
    </div>
    <?php if ($promotions): ?>
      <div class="promo-grid">
      <?php foreach ($promotions as $promotion): ?>
        <article class="promo-card">
          <div class="promo-img">
            <?php if ($promotion['image'] !== ''): ?><img src="<?=h(public_image($promotion['image']))?>" alt="<?=h($promotion['title'])?>"><?php else: ?><div class="promo-placeholder"><span>CP</span></div><?php endif; ?>
          </div>
          <div class="promo-body">
            <span class="promo-label">OFERTA ACTIVA</span>
            <h3><?=h($promotion['title'])?></h3>
            <?php if ($promotion['desc'] !== ''): ?><p><?=nl2br(h($promotion['desc']))?></p><?php endif; ?>
            <div class="promo-price">
              <?php if ($promotion['normal'] !== null): ?><del><?=h(money_public($promotion['normal']))?></del><?php endif; ?>
              <?php if ($promotion['promo'] !== null): ?><strong><?=h(money_public($promotion['promo']))?></strong><?php endif; ?>
              <?php if ($promotion['discount'] !== null): ?><b>-<?=h(number_format($promotion['discount'], 0))?>%</b><?php endif; ?>
            </div>
            <?php $from = promo_date($promotion['from']); $to = promo_date($promotion['to']); if ($from || $to): ?><small>Vigencia: <?=h($from ?: '—')?> <?=($to ? ' al ' . h($to) : '')?></small><?php endif; ?>
            <a class="text-link" href="<?=h($waQuote)?>" target="_blank" rel="noopener">Preguntar por esta promoción ↗</a>
          </div>
        </article>
      <?php endforeach; ?>
      </div>
    <?php else: ?>
      <div class="promo-empty">
        <div class="promo-empty-mark">%</div>
        <div><span class="eyebrow">PRÓXIMAMENTE EN ESTA SECCIÓN</span><h3>Promociones conectadas con el sistema</h3><p>Las ofertas que se publiquen desde administración podrán aparecer aquí sin reconstruir la página principal.</p></div>
        <a class="btn btn-primary" href="<?=h($company['facebook'])?>" target="_blank" rel="noopener">Ver promociones en Facebook <span>↗</span></a>
      </div>
    <?php endif; ?>
  </div>
</section>

<section class="section about-section" id="nosotros">
  <div class="container about-grid">
    <div class="about-visual">
      <div class="about-tile dark"><span class="eyebrow">COLIBRÍ PRINT MÉXICO</span><strong>Imprimiendo<br>con calidad.</strong><p>Hidalgo del Parral · Chihuahua</p></div>
      <div class="about-tile light"><b>Diseño</b><b>Producción</b><b>Instalación</b><small>Una misma experiencia.</small></div>
    </div>
    <div class="about-copy">
      <p class="eyebrow">SOBRE LA MARCA</p>
      <h2>Un taller creativo con <span>vocación de servicio.</span></h2>
      <p>La información histórica publicada por Colibrí Print describe una empresa enfocada en diseño gráfico y soluciones de impresión y personalización, con presencia en Hidalgo del Parral. La nueva web organiza ese universo alrededor de una idea sencilla: ayudarte a resolver el proyecto completo, no solo la pieza final.</p>
      <div class="about-points">
        <div><span>01</span><strong>Atención cercana</strong><p>Un canal directo para explicar lo que necesitas.</p></div>
        <div><span>02</span><strong>Soluciones a medida</strong><p>Medidas, materiales y acabados según proyecto.</p></div>
        <div><span>03</span><strong>Seguimiento</strong><p>Tu pedido puede continuar desde el sistema hasta WhatsApp.</p></div>
      </div>
    </div>
  </div>
</section>

<section class="section faq-section" id="preguntas">
  <div class="container faq-grid">
    <div><p class="eyebrow">PREGUNTAS FRECUENTES</p><h2>Antes de escribirnos,<br><span>esto puede ayudarte.</span></h2><p class="faq-intro">Y si tu proyecto no encaja en ninguna pregunta, cuéntanoslo igual. Los proyectos especiales empiezan mejor cuando alguien explica la idea completa.</p><a class="btn btn-dark" href="<?=h($waQuote)?>" target="_blank" rel="noopener">Hablar por WhatsApp <span>↗</span></a></div>
    <div class="faq-list">
      <details open><summary>¿Qué información necesito para pedir una cotización?</summary><p>Medidas, cantidad, material o acabado deseado, uso final, fecha y cualquier referencia visual que tengas. Una fotografía o ejemplo ayuda mucho.</p></details>
      <details><summary>¿También realizan diseño?</summary><p>Sí. El sitio histórico de Colibrí Print incluye diseño gráfico e imagen corporativa. Podemos partir desde una idea, una referencia o una necesidad de comunicación.</p></details>
      <details><summary>¿Puedo pedir un producto personalizado?</summary><p>Sí. El catálogo histórico incluye ejemplos de playeras, tazas, mousepads, cojines y otros artículos personalizados, además de productos para eventos y promociones.</p></details>
      <details><summary>¿Cómo sé en qué etapa va mi pedido?</summary><p>Los pedidos gestionados por la nueva plataforma pueden contar con una URL individual de seguimiento y actualizaciones relacionadas con producción y entrega.</p></details>
      <details><summary>¿Dónde están ubicados?</summary><p>En Alemania 87, Col. Loma Linda, C.P. 33820, Hidalgo del Parral, Chihuahua.</p></details>
    </div>
  </div>
</section>

<section class="contact-section" id="contacto">
  <div class="container contact-grid">
    <div class="contact-copy">
      <p class="eyebrow">HABLEMOS DEL PROYECTO</p>
      <h2>Lo difícil es tener la idea.<br><span>Nosotros ayudamos con lo demás.</span></h2>
      <p>Cuéntanos qué necesitas y te orientamos sobre la mejor forma de producirlo.</p>
      <div class="contact-actions"><a class="btn btn-primary" href="<?=h($waQuote)?>" target="_blank" rel="noopener">Cotizar por WhatsApp <span>↗</span></a><a class="btn btn-outline-dark" href="tel:+52<?=h($company['phone_raw'])?>">Llamar ahora <span>☎</span></a></div>
    </div>
    <div class="contact-card">
      <div class="contact-row"><span>VISÍTANOS</span><strong><?=h($company['address'])?></strong><small><?=h($company['city'])?></small><a href="<?=h($company['maps'])?>" target="_blank" rel="noopener">Abrir ubicación en Maps ↗</a></div>
      <div class="contact-row"><span>LLÁMANOS</span><a class="contact-phone" href="tel:+52<?=h($company['phone_raw'])?>"><?=h($company['phone'])?></a><small>Alternativo: <?=h($company['phone_alt'])?></small></div>
      <div class="contact-row"><span>HORARIO</span><strong>Lun–Vie · 9:00–18:00</strong><strong>Sáb · 9:00–14:00</strong><small>Domingo · Cerrado</small></div>
      <div class="contact-row"><span>REDES</span><div class="contact-socials"><a href="<?=h($company['facebook'])?>" target="_blank" rel="noopener">Facebook ↗</a><a href="<?=h($company['tiktok'])?>" target="_blank" rel="noopener">TikTok ↗</a></div></div>
    </div>
  </div>
</section>
</main>

<footer class="site-footer">
  <div class="container footer-top">
    <div class="footer-brand"><div class="brand"><span class="brand-bird" aria-hidden="true">✦</span><span class="brand-copy"><strong>Colibrí<span>Print</span></strong><small>MÉXICO</small></span></div><p><?=h($company['tagline'])?> · Diseño, producción, personalización y soluciones visuales.</p></div>
    <div><span class="footer-title">NAVEGA</span><a href="#servicios">Servicios</a><a href="#soluciones">Soluciones</a><a href="#proyectos">Portafolio</a><a href="#promociones">Promociones</a><a href="#contacto">Contacto</a></div>
    <div><span class="footer-title">ENCUÉNTRANOS</span><a href="<?=h($company['facebook'])?>" target="_blank" rel="noopener">Facebook</a><a href="<?=h($company['tiktok'])?>" target="_blank" rel="noopener">TikTok</a><a href="tel:+52<?=h($company['phone_raw'])?>"><?=h($company['phone'])?></a><span>Hidalgo del Parral, Chih.</span></div>
  </div>
  <div class="container footer-bottom"><span>© <?=date('Y')?> Colibrí Print México. Todos los derechos reservados.</span><a href="#inicio">Volver arriba ↑</a></div>
</footer>

<a class="floating-wa" href="<?=h($waQuote)?>" target="_blank" rel="noopener" aria-label="Cotizar por WhatsApp"><span>Cotiza por WhatsApp</span>✆</a>

<script>
(() => {
  const toggle = document.querySelector('.nav-toggle');
  const nav = document.getElementById('main-nav');
  if (toggle && nav) {
    toggle.addEventListener('click', () => {
      const open = nav.classList.toggle('open');
      toggle.setAttribute('aria-expanded', open ? 'true' : 'false');
    });
    nav.querySelectorAll('a').forEach(a => a.addEventListener('click', () => nav.classList.remove('open')));
  }
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) entry.target.classList.add('visible');
    });
  }, {threshold: .12});
  document.querySelectorAll('.service-group,.solution-card,.portfolio-item,.process-step,.about-tile').forEach(el => observer.observe(el));
})();
</script>
</body>
</html>
