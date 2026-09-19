<?php
declare(strict_types=1);
require_once __DIR__ . '/config.php';
session_start();
header('Content-Type: text/html; charset=UTF-8');

function h(string $v): string { return htmlspecialchars($v, ENT_QUOTES, 'UTF-8'); }

if (!tiktok_configured()) exit('<h1>TikTok no configurado</h1>');

if (isset($_GET['error'])) {
    exit('<h1>Autorización no completada</h1><p>' .
        h((string)$_GET['error']) . '</p><p>' .
        h((string)($_GET['error_description'] ?? '')) . '</p>');
}

$code = (string)($_GET['code'] ?? '');
$state = (string)($_GET['state'] ?? '');
$expected = (string)($_SESSION['tiktok_oauth_state'] ?? '');

if ($code === '') exit('<h1>No se recibió el authorization code.</h1>');
if ($expected === '' || !hash_equals($expected, $state)) {
    http_response_code(400);
    exit('<h1>State inválido. Vuelve a iniciar la conexión.</h1>');
}
unset($_SESSION['tiktok_oauth_state']);

$post = http_build_query([
    'client_key' => TIKTOK_CLIENT_KEY,
    'client_secret' => TIKTOK_CLIENT_SECRET,
    'code' => $code,
    'grant_type' => 'authorization_code',
    'redirect_uri' => TIKTOK_REDIRECT_URI,
]);

$ch = curl_init('https://open.tiktokapis.com/v2/oauth/token/');
curl_setopt_array($ch, [
    CURLOPT_POST => true,
    CURLOPT_POSTFIELDS => $post,
    CURLOPT_HTTPHEADER => ['Content-Type: application/x-www-form-urlencoded', 'Cache-Control: no-cache'],
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_TIMEOUT => 30,
]);
$response = curl_exec($ch);
$http = (int)curl_getinfo($ch, CURLINFO_HTTP_CODE);
$error = curl_error($ch);
curl_close($ch);

if ($response === false) exit('<h1>Error cURL</h1><pre>'.h($error).'</pre>');

$data = json_decode($response, true);
if (!is_array($data) || $http < 200 || $http >= 300 || empty($data['access_token'])) {
    http_response_code(502);
    exit('<h1>TikTok rechazó el código</h1><p>HTTP '.$http.'</p><pre>'.h($response).'</pre>');
}

$token = [
    'open_id' => $data['open_id'] ?? null,
    'scope' => $data['scope'] ?? null,
    'access_token' => $data['access_token'],
    'refresh_token' => $data['refresh_token'] ?? null,
    'token_type' => $data['token_type'] ?? 'Bearer',
    'access_token_expires_at' => time() + (int)($data['expires_in'] ?? 86400),
    'refresh_token_expires_at' => time() + (int)($data['refresh_expires_in'] ?? 31536000),
    'updated_at' => time(),
];

if (!is_dir(dirname(TIKTOK_TOKEN_FILE))) mkdir(dirname(TIKTOK_TOKEN_FILE), 0700, true);
file_put_contents(TIKTOK_TOKEN_FILE, json_encode($token, JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES), LOCK_EX);
@chmod(TIKTOK_TOKEN_FILE, 0600);

if (file_exists(TIKTOK_CACHE_FILE)) @unlink(TIKTOK_CACHE_FILE);
?>
<!doctype html><html lang="es"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>TikTok conectado | Colibri Print</title>
<style>body{font-family:Arial;background:#f5f6f8;padding:40px}.card{max-width:720px;margin:auto;background:white;border-radius:18px;padding:32px;box-shadow:0 10px 35px #0001}.ok{color:#087a25}a{display:inline-block;background:#111;color:#fff;padding:12px 18px;border-radius:9px;text-decoration:none}</style>
</head><body><div class="card">
<h1 class="ok">&#10003; TikTok conectado correctamente</h1>
<h2>OAuth completado</h2>
<p>El access token y refresh token fueron recibidos y guardados en el servidor.</p>
<p><strong>Open ID:</strong> <?=h((string)($token['open_id']??''))?></p>
<a href="index.php">Ver videos de Colibri Print</a>
</div></body></html>
