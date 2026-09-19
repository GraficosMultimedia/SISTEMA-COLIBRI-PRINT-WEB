<?php
declare(strict_types=1);

require_once __DIR__ . '/config.php';

/*
 * Compatibilidad con el config.php que ya tienes instalado.
 * Si alguna constante nueva no existe, se crea aquí.
 * NO necesitas modificar tus credenciales.
 */
if (!defined('TIKTOK_TOKEN_FILE')) {
    define('TIKTOK_TOKEN_FILE', __DIR__ . '/storage/tiktok_token.json');
}
if (!defined('TIKTOK_CACHE_FILE')) {
    define('TIKTOK_CACHE_FILE', __DIR__ . '/storage/videos_cache.json');
}
if (!defined('TIKTOK_CACHE_TTL')) {
    define('TIKTOK_CACHE_TTL', 600);
}

function tiktok_read_token(): array {
    if (!file_exists(TIKTOK_TOKEN_FILE)) {
        throw new RuntimeException('No existe el token de TikTok. Conecta la cuenta primero.');
    }

    $raw = file_get_contents(TIKTOK_TOKEN_FILE);
    $data = json_decode((string)$raw, true);

    if (!is_array($data) || empty($data['access_token'])) {
        throw new RuntimeException('El token guardado no es válido.');
    }

    return $data;
}

function tiktok_write_token(array $token): void {
    $dir = dirname(TIKTOK_TOKEN_FILE);

    if (!is_dir($dir)) {
        mkdir($dir, 0700, true);
    }

    file_put_contents(
        TIKTOK_TOKEN_FILE,
        json_encode($token, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES),
        LOCK_EX
    );

    @chmod(TIKTOK_TOKEN_FILE, 0600);
}

function tiktok_refresh_token_if_needed(array $token): array {
    $expiresAt = (int)($token['access_token_expires_at'] ?? 0);

    if ($expiresAt > time() + 1200) {
        return $token;
    }

    if (empty($token['refresh_token'])) {
        throw new RuntimeException(
            'El access token expiró y no existe refresh token. Vuelve a conectar TikTok.'
        );
    }

    $post = http_build_query([
        'client_key' => TIKTOK_CLIENT_KEY,
        'client_secret' => TIKTOK_CLIENT_SECRET,
        'grant_type' => 'refresh_token',
        'refresh_token' => $token['refresh_token']
    ]);

    $ch = curl_init('https://open.tiktokapis.com/v2/oauth/token/');

    curl_setopt_array($ch, [
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => $post,
        CURLOPT_HTTPHEADER => [
            'Content-Type: application/x-www-form-urlencoded',
            'Cache-Control: no-cache'
        ],
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 30
    ]);

    $response = curl_exec($ch);
    $http = (int)curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $error = curl_error($ch);

    curl_close($ch);

    if ($response === false) {
        throw new RuntimeException('Error cURL al renovar el token: ' . $error);
    }

    $data = json_decode($response, true);

    if (!is_array($data) || $http < 200 || $http >= 300 || empty($data['access_token'])) {
        throw new RuntimeException(
            'No se pudo renovar el token de TikTok. HTTP ' . $http
        );
    }

    $token['access_token'] = $data['access_token'];
    $token['token_type'] = $data['token_type'] ?? 'Bearer';
    $token['access_token_expires_at'] =
        time() + (int)($data['expires_in'] ?? 86400);

    if (!empty($data['refresh_token'])) {
        $token['refresh_token'] = $data['refresh_token'];
    }

    if (isset($data['refresh_expires_in'])) {
        $token['refresh_token_expires_at'] =
            time() + (int)$data['refresh_expires_in'];
    }

    $token['updated_at'] = time();

    tiktok_write_token($token);

    return $token;
}

function tiktok_fetch_videos(bool $force = false): array {

    /*
     * Caché para no llamar a TikTok en cada visita.
     */
    if (
        !$force &&
        file_exists(TIKTOK_CACHE_FILE) &&
        (time() - (int)filemtime(TIKTOK_CACHE_FILE)) < TIKTOK_CACHE_TTL
    ) {
        $cached = json_decode(
            (string)file_get_contents(TIKTOK_CACHE_FILE),
            true
        );

        if (is_array($cached) && isset($cached['videos'])) {
            return $cached;
        }
    }

    $token = tiktok_read_token();
    $token = tiktok_refresh_token_if_needed($token);

    $fields = implode(',', [
        'id',
        'title',
        'video_description',
        'duration',
        'cover_image_url',
        'embed_link',
        'share_url',
        'create_time',
        'like_count',
        'comment_count',
        'share_count',
        'view_count'
    ]);

    $url =
        'https://open.tiktokapis.com/v2/video/list/?fields=' .
        urlencode($fields);

    $payload = json_encode([
        'max_count' => 20
    ]);

    $ch = curl_init($url);

    curl_setopt_array($ch, [
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => $payload,
        CURLOPT_HTTPHEADER => [
            'Authorization: Bearer ' . $token['access_token'],
            'Content-Type: application/json'
        ],
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 30
    ]);

    $response = curl_exec($ch);
    $http = (int)curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $error = curl_error($ch);

    curl_close($ch);

    if ($response === false) {
        throw new RuntimeException(
            'Error cURL consultando TikTok: ' . $error
        );
    }

    $data = json_decode($response, true);

    if (!is_array($data)) {
        throw new RuntimeException(
            'TikTok devolvió una respuesta JSON inválida.'
        );
    }

    if ($http === 401) {
        throw new RuntimeException(
            'TikTok devolvió HTTP 401. Vuelve a conectar la cuenta.'
        );
    }

    if (
        !empty($data['error']) &&
        ($data['error']['code'] ?? '') !== 'ok'
    ) {
        throw new RuntimeException(
            'TikTok API: ' .
            ($data['error']['message'] ?? 'Error desconocido')
        );
    }

    $result = [
        'videos' => $data['data']['videos'] ?? [],
        'cursor' => $data['data']['cursor'] ?? null,
        'has_more' => $data['data']['has_more'] ?? false,
        'updated_at' => time()
    ];

    $dir = dirname(TIKTOK_CACHE_FILE);

    if (!is_dir($dir)) {
        mkdir($dir, 0700, true);
    }

    file_put_contents(
        TIKTOK_CACHE_FILE,
        json_encode(
            $result,
            JSON_PRETTY_PRINT |
            JSON_UNESCAPED_SLASHES |
            JSON_UNESCAPED_UNICODE
        ),
        LOCK_EX
    );

    @chmod(TIKTOK_CACHE_FILE, 0600);

    return $result;
}
