<?php
declare(strict_types=1);

require_once __DIR__ . '/config.php';

if (session_status() !== PHP_SESSION_ACTIVE) {
    session_start();
}

if (!tiktok_configured()) {
    http_response_code(500);
    exit('TikTok no está configurado. Revisa config.php');
}

$state = bin2hex(random_bytes(24));
$_SESSION['tiktok_oauth_state'] = $state;

$params = [
    'client_key'    => TIKTOK_CLIENT_KEY,
    'response_type' => 'code',
    'scope'         => TIKTOK_SCOPES,
    'redirect_uri'  => TIKTOK_REDIRECT_URI,
    'state'         => $state,
];

$authorize_url = 'https://www.tiktok.com/v2/auth/authorize/?' . http_build_query(
    $params,
    '',
    '&',
    PHP_QUERY_RFC3986
);

header('Location: ' . $authorize_url, true, 302);
exit;
