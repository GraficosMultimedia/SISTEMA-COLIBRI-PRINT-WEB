<?php
declare(strict_types=1);
require_once __DIR__.'/api.php';
function h(string $v): string{return htmlspecialchars($v,ENT_QUOTES,'UTF-8');}
$error=null;$result=['videos'=>[]];
try{$result=tiktok_fetch_videos(isset($_GET['refresh'])&&$_GET['refresh']==='1');}catch(Throwable $e){$error=$e->getMessage();}
$videos=$result['videos']??[];
?>
<!doctype html><html lang="es"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>TikTok | Colibri Print</title>
<style>
*{box-sizing:border-box}body{margin:0;background:#f4f5f7;color:#111827;font-family:Arial,sans-serif}
.header{background:#fff;border-bottom:1px solid #e5e7eb}.header-in{max-width:1240px;margin:auto;padding:16px 24px;display:flex;justify-content:space-between;align-items:center;gap:15px}.brand{font-size:22px;font-weight:800}.brand span{color:#fe2c55}
.btn{display:inline-block;text-decoration:none;background:#111;color:#fff;border-radius:9px;padding:10px 14px;font-size:14px}.secondary{background:#fff;color:#111;border:1px solid #d1d5db}
.hero{max-width:1240px;margin:32px auto 20px;padding:0 24px}.hero h1{font-size:34px;margin:0 0 8px}.hero p{margin:0;color:#6b7280}
.status{max-width:1240px;margin:auto;padding:0 24px 22px}.ok,.error{padding:14px 16px;border-radius:12px}.ok{background:#e8f8ed;color:#166534}.error{background:#feecec;color:#991b1b}
.grid{max-width:1240px;margin:auto;padding:0 24px 50px;display:grid;grid-template-columns:repeat(4,1fr);gap:20px}.card{background:#fff;border-radius:16px;overflow:hidden;border:1px solid #e5e7eb;box-shadow:0 5px 18px #0000000d}.cover{display:block;aspect-ratio:9/16;background:#e5e7eb}.cover img{width:100%;height:100%;object-fit:cover;display:block}.content{padding:15px}.title{font-weight:800;line-height:1.3}.desc{font-size:13px;color:#4b5563;line-height:1.45;margin-top:8px;display:-webkit-box;-webkit-line-clamp:3;-webkit-box-orient:vertical;overflow:hidden;min-height:55px}.stats{display:grid;grid-template-columns:1fr 1fr;gap:6px;margin-top:12px;color:#6b7280;font-size:12px}.card .btn{margin-top:14px;width:100%;text-align:center}
@media(max-width:1000px){.grid{grid-template-columns:repeat(3,1fr)}}@media(max-width:700px){.grid{grid-template-columns:repeat(2,1fr);padding:0 12px 30px}.hero,.status{padding-left:12px;padding-right:12px}}@media(max-width:460px){.grid{grid-template-columns:1fr}}
</style></head><body>
<header class="header"><div class="header-in"><div class="brand">Colibri <span>Print</span> · TikTok</div><div>
<a class="btn secondary" href="check.php">Estado</a>
<a class="btn" href="?refresh=1">Actualizar</a>
</div></div></header>
<section class="hero"><h1>Videos de Colibri Print</h1><p>Contenido público mostrado mediante TikTok Display API.</p></section>
<div class="status"><?php if($error): ?><div class="error"><strong>No se pudieron cargar los videos.</strong><br><?=h($error)?><br><br><a href="login.php">Conectar TikTok</a></div><?php else: ?><div class="ok">&#10003; TikTok conectado · <?=count($videos)?> videos disponibles</div><?php endif;?></div>
<div class="grid">
<?php foreach($videos as $video): $link=$video['embed_link']??$video['share_url']??'#';?>
<article class="card"><a class="cover" href="<?=h((string)$link)?>" target="_blank" rel="noopener"><?php if(!empty($video['cover_image_url'])):?><img src="<?=h((string)$video['cover_image_url'])?>" alt="<?=h((string)($video['title']??'TikTok'))?>" loading="lazy"><?php endif;?></a>
<div class="content"><div class="title"><?=h((string)($video['title']??'Video TikTok'))?></div><div class="desc"><?=nl2br(h((string)($video['video_description']??'')))?></div>
<div class="stats"><span>Duración: <?=h((string)($video['duration']??0))?> s</span><span>Likes: <?=h((string)($video['like_count']??0))?></span><span>Comentarios: <?=h((string)($video['comment_count']??0))?></span><span>Compartidos: <?=h((string)($video['share_count']??0))?></span><span>Vistas: <?=h((string)($video['view_count']??0))?></span></div>
<a class="btn" href="<?=h((string)$link)?>" target="_blank" rel="noopener">Ver video en TikTok</a></div></article>
<?php endforeach;?>
</div></body></html>
