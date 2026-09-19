<?php
declare(strict_types=1);

define('TIKTOK_CLIENT_KEY', '');
define('TIKTOK_CLIENT_SECRET', '');
define('TIKTOK_REDIRECT_URI', 'https://colibriprint.com.mx/tiktok-callback/');

/*
 * Scopes realmente utilizados por la integración actual.
 * El Sandbox configurado tiene user.info.basic + video.list.
 */
define('TIKTOK_SCOPES', 'user.info.basic,video.list');

function tiktok_configured(): bool
{
    return
        defined('TIKTOK_CLIENT_KEY') &&
        defined('TIKTOK_CLIENT_SECRET') &&
        trim((string) TIKTOK_CLIENT_KEY) !== '' &&
        trim((string) TIKTOK_CLIENT_SECRET) !== '' &&
        defined('TIKTOK_REDIRECT_URI') &&
        trim((string) TIKTOK_REDIRECT_URI) !== '' &&
        defined('TIKTOK_SCOPES') &&
        trim((string) TIKTOK_SCOPES) !== '';
}
