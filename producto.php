<?php
declare(strict_types=1);

require_once __DIR__ . '/config/runtime.php';
require_once __DIR__ . '/includes/company.php';

$company = company_profile();
$pdo = db();

function h(string $value): string
{
    return htmlspecialchars($value, ENT_QUOTES, 'UTF-8');
}

function public_image(?string $value): string
{
    $value = trim((string)$value);

    if ($value === '') {
        return '';
    }

    if (preg_match('#^https?://#i', $value)) {
        return $value;
    }

    return '/' . ltrim($value, '/');
}

function money_public($value): string
{
    return is_numeric($value)
        ? '$' . number_format((float)$value, 2, '.', ',')
        : '';
}

function pricing_label(string $type): string
{
    return [
        'fixed'      => 'Precio fijo',
        'variable'   => 'Precio variable',
        'calculated' => 'Precio calculado',
        'project'    => 'Proyecto cotizable'
    ][$type] ?? 'Cotización';
}

/*
|--------------------------------------------------------------------------
| Producto
|--------------------------------------------------------------------------
*/

$productId = (int)($_GET['id'] ?? 0);

if ($productId <= 0) {
    http_response_code(404);
    exit('Producto no encontrado.');
}

$stmt = $pdo->prepare("
    SELECT
        p.id,
        p.name,
        p.sku,
        p.description,
        p.sale_price,
        p.pricing_type,
        p.category_id,
        c.name AS category_name
    FROM cp_products p
    LEFT JOIN cp_categories c
        ON c.id = p.category_id
    WHERE
        p.id = ?
        AND p.enabled = 1
        AND p.visible_web = 1
    LIMIT 1
");

$stmt->execute([$productId]);

$product = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$product) {
    http_response_code(404);
    exit('Producto no encontrado.');
}

/*
|--------------------------------------------------------------------------
| Imágenes
|--------------------------------------------------------------------------
*/

$imageStmt = $pdo->prepare("
    SELECT
        id,
        path,
        alt_text
    FROM cp_product_images
    WHERE
        product_id = ?
        AND enabled = 1
    ORDER BY sort_order ASC, id ASC
");

$imageStmt->execute([$productId]);

$images = $imageStmt->fetchAll(PDO::FETCH_ASSOC);

$mainImage = '';

if (!empty($images)) {
    $mainImage = public_image($images[0]['path'] ?? '');
}

/*
|--------------------------------------------------------------------------
| WhatsApp
|--------------------------------------------------------------------------
*/

$phoneRaw = preg_replace(
    '/\D+/',
    '',
    (string)$company['phone']
);

if (
    $phoneRaw !== ''
    && !str_starts_with($phoneRaw, '52')
) {
    $phoneRaw = '52' . $phoneRaw;
}

$waBase = $phoneRaw !== ''
    ? 'https://wa.me/' . $phoneRaw
    : '';

$whatsappMessage =
    'Hola Colibrí Print México, quiero cotizar el producto: '
    . $product['name']
    . '. Me gustaría conocer opciones, medidas, materiales, cantidades, tiempos y precio.';

$whatsappUrl = $waBase !== ''
    ? $waBase . '?text=' . rawurlencode($whatsappMessage)
    : '#';

/*
|--------------------------------------------------------------------------
| Productos relacionados
|--------------------------------------------------------------------------
*/

$related = [];

if (!empty($product['category_id'])) {

    $relatedStmt = $pdo->prepare("
        SELECT
            p.id,
            p.name,
            p.sale_price,
            p.pricing_type,
            (
                SELECT i.path
                FROM cp_product_images i
                WHERE
                    i.product_id = p.id
                    AND i.enabled = 1
                ORDER BY i.sort_order ASC, i.id ASC
                LIMIT 1
            ) AS image_path
        FROM cp_products p
        WHERE
            p.enabled = 1
            AND p.visible_web = 1
            AND p.category_id = ?
            AND p.id <> ?
        ORDER BY p.id DESC
        LIMIT 3
    ");

    $relatedStmt->execute([
        (int)$product['category_id'],
        $productId
    ]);

    $related = $relatedStmt->fetchAll(PDO::FETCH_ASSOC);
}

$companyName = $company['trade_name']
    ?: $company['legal_name'];

$description = trim((string)($product['description'] ?? ''));

if ($description === '') {
    $description = 'Producto personalizable de Colibrí Print México.';
}

?>
<!doctype html>
<html lang="es-MX">

<head>

<meta charset="utf-8">

<meta
    name="viewport"
    content="width=device-width,initial-scale=1"
>

<meta
    name="description"
    content="<?= h($product['name']) ?> | <?= h($companyName) ?>"
>

<meta
    name="theme-color"
    content="#0f1715"
>

<link
    rel="canonical"
    href="https://colibriprint.com.mx/producto.php?id=<?= (int)$product['id'] ?>"
>

<title>
    <?= h($product['name']) ?> | <?= h($companyName) ?>
</title>

<link
    rel="stylesheet"
    href="/assets/css/public.css?v=20260918-corporativo-v4"
>

<style>

:root{
    --cp-dark:#0f1715;
    --cp-green:#0d8b72;
    --cp-light:#f5f2ec;
    --cp-border:#e3e5df;
    --cp-muted:#707973;
}

*{
    box-sizing:border-box;
}

body{
    margin:0;
    background:var(--cp-light);
    color:var(--cp-dark);
}

.product-page-container{
    width:min(calc(100% - 44px),1180px);
    margin:0 auto;
}

.product-header{
    position:sticky;
    top:0;
    z-index:100;
    background:rgba(248,246,241,.96);
    backdrop-filter:blur(16px);
    border-bottom:1px solid var(--cp-border);
}

.product-nav{
    min-height:76px;
    display:flex;
    align-items:center;
    justify-content:space-between;
    gap:25px;
}

.product-brand{
    display:flex;
    align-items:center;
    gap:11px;
    text-decoration:none;
    color:inherit;
}

.product-brand img{
    width:52px;
    height:52px;
    object-fit:contain;
    background:#fff;
    border-radius:10px;
}

.product-mark{
    width:46px;
    height:46px;
    border-radius:13px;
    background:var(--cp-dark);
    color:#a0ecd6;
    display:grid;
    place-items:center;
    font-weight:800;
}

.product-brand strong{
    display:block;
    font-size:17px;
}

.product-brand small{
    display:block;
    font-size:9px;
    letter-spacing:.15em;
    color:#77817b;
    font-weight:800;
}

.product-nav nav{
    display:flex;
    gap:22px;
    font-size:12px;
    font-weight:800;
}

.product-nav nav a{
    color:#56605b;
    text-decoration:none;
}

.product-nav nav a:hover{
    color:var(--cp-green);
}

.product-main{
    padding:70px 0 100px;
}

.product-breadcrumb{
    margin-bottom:30px;
    font-size:11px;
    font-weight:700;
}

.product-breadcrumb a{
    color:var(--cp-green);
    text-decoration:none;
}

.product-breadcrumb span{
    color:#87908a;
    margin:0 7px;
}

.product-layout{
    display:grid;
    grid-template-columns:minmax(0,1.05fr) minmax(360px,.95fr);
    gap:55px;
    align-items:start;
}

.product-gallery{
    background:#fff;
    border:1px solid var(--cp-border);
    border-radius:24px;
    overflow:hidden;
}

.product-main-image{
    height:540px;
    background:#eef1ed;
    display:flex;
    align-items:center;
    justify-content:center;
}

.product-main-image img{
    width:100%;
    height:100%;
    object-fit:contain;
}

.product-placeholder{
    text-align:center;
    color:#7b857f;
}

.product-placeholder strong{
    display:block;
    font-size:60px;
    color:var(--cp-green);
}

.product-placeholder span{
    font-size:12px;
}

.product-thumbnails{
    display:flex;
    gap:10px;
    padding:14px;
    border-top:1px solid var(--cp-border);
    overflow:auto;
}

.product-thumb{
    width:76px;
    height:76px;
    flex:0 0 76px;
    border:1px solid var(--cp-border);
    border-radius:12px;
    overflow:hidden;
    background:#f1f3ef;
}

.product-thumb img{
    width:100%;
    height:100%;
    object-fit:cover;
}

.product-info{
    padding-top:8px;
}

.product-eyebrow{
    color:var(--cp-green);
    font-size:10px;
    font-weight:800;
    letter-spacing:.15em;
    text-transform:uppercase;
}

.product-info h1{
    font-family:"Playfair Display",Georgia,serif;
    font-size:clamp(40px,5vw,64px);
    line-height:1.02;
    letter-spacing:-.045em;
    margin:12px 0 18px;
}

.product-category{
    display:inline-block;
    background:#dff3ec;
    color:var(--cp-green);
    padding:7px 11px;
    border-radius:999px;
    font-size:10px;
    font-weight:800;
    margin-bottom:18px;
}

.product-description{
    color:var(--cp-muted);
    font-size:15px;
    line-height:1.8;
    margin-bottom:25px;
}

.product-meta-box{
    display:flex;
    gap:10px;
    flex-wrap:wrap;
    margin-bottom:25px;
}

.product-meta-item{
    background:#fff;
    border:1px solid var(--cp-border);
    border-radius:12px;
    padding:11px 13px;
}

.product-meta-item small{
    display:block;
    color:#87908a;
    font-size:9px;
    text-transform:uppercase;
    letter-spacing:.1em;
    font-weight:800;
    margin-bottom:4px;
}

.product-meta-item strong{
    font-size:12px;
}

.product-price-box{
    padding:20px 0;
    border-top:1px solid var(--cp-border);
    border-bottom:1px solid var(--cp-border);
    margin-bottom:25px;
}

.product-price-label{
    display:block;
    color:#7b847f;
    font-size:10px;
    text-transform:uppercase;
    letter-spacing:.12em;
    font-weight:800;
    margin-bottom:5px;
}

.product-price{
    font-size:32px;
    font-weight:900;
}

.product-price.quote{
    color:var(--cp-green);
}

.product-actions{
    display:flex;
    gap:10px;
    flex-wrap:wrap;
}

.product-button{
    display:inline-flex;
    align-items:center;
    justify-content:center;
    text-decoration:none;
    border-radius:999px;
    padding:14px 21px;
    font-size:12px;
    font-weight:800;
}

.product-button.primary{
    background:var(--cp-green);
    color:#fff;
}

.product-button.secondary{
    background:#fff;
    color:var(--cp-dark);
    border:1px solid var(--cp-border);
}

.related-section{
    margin-top:85px;
}

.related-section h2{
    font-size:30px;
    letter-spacing:-.03em;
    margin-bottom:25px;
}

.related-grid{
    display:grid;
    grid-template-columns:repeat(3,minmax(0,1fr));
    gap:16px;
}

.related-card{
    background:#fff;
    border:1px solid var(--cp-border);
    border-radius:18px;
    overflow:hidden;
    text-decoration:none;
    color:inherit;
    transition:.2s;
}

.related-card:hover{
    transform:translateY(-3px);
    box-shadow:0 15px 35px rgba(15,23,21,.09);
}

.related-image{
    height:190px;
    background:#eef1ed;
}

.related-image img{
    width:100%;
    height:100%;
    object-fit:cover;
}

.related-content{
    padding:16px;
}

.related-content small{
    color:var(--cp-green);
    font-weight:800;
    font-size:9px;
    text-transform:uppercase;
}

.related-content h3{
    font-size:18px;
    margin:7px 0 0;
}

.product-footer{
    background:var(--cp-dark);
    color:#fff;
    padding:35px 0;
}

.product-footer-grid{
    display:flex;
    justify-content:space-between;
    gap:30px;
}

.product-footer p{
    color:#aeb8b2;
    font-size:11px;
    margin:7px 0 0;
}

.product-footer a{
    color:#a0ecd6;
    font-weight:800;
    text-decoration:none;
}

@media(max-width:850px){

    .product-layout{
        grid-template-columns:1fr;
        gap:35px;
    }

    .product-main-image{
        height:430px;
    }

    .related-grid{
        grid-template-columns:repeat(2,minmax(0,1fr));
    }

    .product-nav nav a:not(:first-child){
        display:none;
    }
}

@media(max-width:560px){

    .product-page-container{
        width:min(calc(100% - 28px),1180px);
    }

    .product-main{
        padding:40px 0 70px;
    }

    .product-main-image{
        height:330px;
    }

    .product-info h1{
        font-size:42px;
    }

    .related-grid{
        grid-template-columns:1fr;
    }

    .product-footer-grid{
        flex-direction:column;
    }

}

</style>

</head>

<body>

<header class="product-header">

    <div class="product-page-container product-nav">

        <a class="product-brand" href="/">

            <?php if (!empty($company['logo_path'])): ?>

                <img
                    src="<?= h($company['logo_path']) ?>"
                    alt="<?= h($companyName) ?>"
                >

            <?php else: ?>

                <span class="product-mark">CP</span>

            <?php endif; ?>

            <span>
                <strong><?= h($companyName) ?></strong>
                <small>CATÁLOGO WEB</small>
            </span>

        </a>

        <nav>

            <a href="/">Inicio</a>

            <a href="/catalogo.php">Catálogo</a>

            <?php if ($company['phone'] !== ''): ?>

                <a href="tel:<?= h($phoneRaw) ?>">
                    ☎ <?= h($company['phone']) ?>
                </a>

            <?php endif; ?>

        </nav>

    </div>

</header>


<main class="product-main">

<div class="product-page-container">

    <div class="product-breadcrumb">

        <a href="/catalogo.php">Catálogo</a>

        <span>›</span>

        <?= h($product['name']) ?>

    </div>


    <div class="product-layout">

        <!-- GALERÍA -->

        <div class="product-gallery">

            <div class="product-main-image">

                <?php if ($mainImage): ?>

                    <img
                        src="<?= h($mainImage) ?>"
                        alt="<?= h($product['name']) ?>"
                    >

                <?php else: ?>

                    <div class="product-placeholder">

                        <strong>CP</strong>

                        <span>
                            Imagen del producto próximamente
                        </span>

                    </div>

                <?php endif; ?>

            </div>


            <?php if (count($images) > 1): ?>

                <div class="product-thumbnails">

                    <?php foreach ($images as $image): ?>

                        <?php $thumb = public_image($image['path'] ?? ''); ?>

                        <?php if ($thumb): ?>

                            <div class="product-thumb">

                                <img
                                    src="<?= h($thumb) ?>"
                                    alt="<?= h($image['alt_text'] ?: $product['name']) ?>"
                                    loading="lazy"
                                >

                            </div>

                        <?php endif; ?>

                    <?php endforeach; ?>

                </div>

            <?php endif; ?>

        </div>


        <!-- INFORMACIÓN -->

        <div class="product-info">

            <?php if (!empty($product['category_name'])): ?>

                <div class="product-category">
                    <?= h($product['category_name']) ?>
                </div>

            <?php endif; ?>

            <div class="product-eyebrow">
                Colibrí Print · Producto
            </div>

            <h1>
                <?= h($product['name']) ?>
            </h1>

            <p class="product-description">
                <?= nl2br(h($description)) ?>
            </p>


            <div class="product-meta-box">

                <div class="product-meta-item">

                    <small>Tipo de precio</small>

                    <strong>
                        <?= h(pricing_label((string)$product['pricing_type'])) ?>
                    </strong>

                </div>


                <?php if (!empty($product['sku'])): ?>

                    <div class="product-meta-item">

                        <small>SKU</small>

                        <strong>
                            <?= h($product['sku']) ?>
                        </strong>

                    </div>

                <?php endif; ?>

            </div>


            <div class="product-price-box">

                <span class="product-price-label">
                    Precio
                </span>

                <?php if (
                    $product['pricing_type'] === 'fixed'
                    && $product['sale_price'] !== null
                ): ?>

                    <strong class="product-price">
                        <?= h(money_public($product['sale_price'])) ?>
                    </strong>

                <?php else: ?>

                    <strong class="product-price quote">
                        Cotización personalizada
                    </strong>

                <?php endif; ?>

            </div>


            <div class="product-actions">

                <?php if ($waBase): ?>

                    <a
                        class="product-button primary"
                        href="<?= h($whatsappUrl) ?>"
                        target="_blank"
                        rel="noopener"
                    >
                        Cotizar por WhatsApp ↗
                    </a>

                <?php endif; ?>

                <a
                    class="product-button secondary"
                    href="/catalogo.php"
                >
                    ← Volver al catálogo
                </a>

            </div>

        </div>

    </div>


    <?php if ($related): ?>

        <section class="related-section">

            <div class="product-eyebrow">
                También puedes ver
            </div>

            <h2>
                Productos relacionados
            </h2>

            <div class="related-grid">

                <?php foreach ($related as $item): ?>

                    <?php
                    $relatedImage = public_image(
                        $item['image_path'] ?? ''
                    );
                    ?>

                    <a
                        class="related-card"
                        href="/producto.php?id=<?= (int)$item['id'] ?>"
                    >

                        <div class="related-image">

                            <?php if ($relatedImage): ?>

                                <img
                                    src="<?= h($relatedImage) ?>"
                                    alt="<?= h($item['name']) ?>"
                                    loading="lazy"
                                >

                            <?php else: ?>

                                <div class="product-placeholder">
                                    <strong>CP</strong>
                                </div>

                            <?php endif; ?>

                        </div>

                        <div class="related-content">

                            <small>
                                <?= h(pricing_label((string)$item['pricing_type'])) ?>
                            </small>

                            <h3>
                                <?= h($item['name']) ?>
                            </h3>

                        </div>

                    </a>

                <?php endforeach; ?>

            </div>

        </section>

    <?php endif; ?>

</div>

</main>


<footer class="product-footer">

    <div class="product-page-container product-footer-grid">

        <div>

            <strong>
                <?= h($companyName) ?>
            </strong>

            <p>

                <?= h($company['address']) ?>

                <?= $company['neighborhood']
                    ? ', ' . h($company['neighborhood'])
                    : '' ?>

                ·

                <?= h($company['city']) ?>,
                <?= h($company['state']) ?>

            </p>

        </div>


        <div>

            <?php if ($waBase): ?>

                <a
                    href="<?= h($whatsappUrl) ?>"
                    target="_blank"
                    rel="noopener"
                >
                    ¿Quieres personalizarlo? Hablemos ↗
                </a>

            <?php endif; ?>

        </div>

    </div>

</footer>

</body>

</html>
