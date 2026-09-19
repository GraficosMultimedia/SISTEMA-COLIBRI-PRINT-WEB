<?php
declare(strict_types=1);
require_once __DIR__ . '/../config/runtime.php';

function setting_get(string $key, string $default = ''): string {
    try {
        $stmt = db()->prepare('SELECT setting_value FROM cp_settings WHERE setting_key=? LIMIT 1');
        $stmt->execute([$key]);
        $value = $stmt->fetchColumn();
        return $value === false || $value === null ? $default : (string)$value;
    } catch (Throwable $e) {
        return $default;
    }
}

function setting_set(string $key, ?string $value): void {
    $stmt = db()->prepare('INSERT INTO cp_settings(setting_key,setting_value,created_at,updated_at) VALUES(?,?,NOW(),NOW()) ON DUPLICATE KEY UPDATE setting_value=VALUES(setting_value),updated_at=NOW()');
    $stmt->execute([$key, $value]);
}

function company_profile(): array {
    $defaults = [
        'legal_name' => 'Colibrí Print México',
        'trade_name' => 'Colibrí Print',
        'rfc' => '',
        'tax_regime' => '',
        'address' => '',
        'neighborhood' => '',
        'city' => '',
        'state' => '',
        'postal_code' => '',
        'country' => 'México',
        'phone' => '',
        'email' => '',
        'website' => 'https://colibriprint.com.mx',
        'logo_path' => '',
        'quote_footer' => 'Este documento es una cotización comercial y no sustituye un comprobante fiscal digital (CFDI).',
        'payment_info' => '',
    ];
    foreach ($defaults as $key => $default) $defaults[$key] = setting_get('company.' . $key, $default);
    return $defaults;
}
