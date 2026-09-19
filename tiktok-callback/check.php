<?php
declare(strict_types=1);
require_once __DIR__.'/config.php';
function h(string $v):string{return htmlspecialchars($v,ENT_QUOTES,'UTF-8');}
$configured=tiktok_configured();
$exists=file_exists(TIKTOK_TOKEN_FILE);
$token=$exists?json_decode((string)file_get_contents(TIKTOK_TOKEN_FILE),true):null;
$valid=is_array($token)&&!empty($token['access_token']);
?>
<!doctype html><html lang="es"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Diagnóstico TikTok</title><style>body{font-family:Arial;background:#f5f6f8;padding:30px}.wrap{max-width:850px;margin:auto}.card{background:#fff;padding:25px;border-radius:16px;margin-bottom:18px}.ok{color:#087a25}.bad{color:#b42318}.btn{display:inline-block;background:#111;color:#fff;padding:10px 14px;text-decoration:none;border-radius:8px;margin-right:8px}</style></head><body><div class="wrap">
<h1>Diagnóstico TikTok</h1><div class="card"><h2>Configuración</h2><p class="<?= $configured?'ok':'bad'?>"><?= $configured?'&#10003; Configuración cargada':'&#10007; Configuración incompleta'?></p><p>Redirect URI: <code><?=h(TIKTOK_REDIRECT_URI)?></code></p></div>
<div class="card"><h2>Token</h2><p class="<?= $valid?'ok':'bad'?>"><?= $valid?'&#10003; Access token encontrado':'&#10007; Access token no encontrado'?></p><?php if($valid):?><p>Open ID: <?=h((string)($token['open_id']??''))?></p><p>Refresh token: <?=!empty($token['refresh_token'])?'guardado':'no disponible'?></p><p>Expira: <?=!empty($token['access_token_expires_at'])?date('Y-m-d H:i:s',(int)$token['access_token_expires_at']):'desconocido'?></p><?php endif;?></div>
<div class="card"><a class="btn" href="login.php">Conectar TikTok</a><a class="btn" href="index.php">Ver videos</a></div>
</div></body></html>
