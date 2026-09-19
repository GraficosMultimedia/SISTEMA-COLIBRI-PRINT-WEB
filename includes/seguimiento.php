<?php
declare(strict_types=1);
require_once __DIR__ . '/../config/runtime.php';
require_once __DIR__ . '/produccion.php';

function tracking_token_for_order(int $orderId): string {
    $st = db()->prepare('SELECT token FROM cp_tracking_tokens WHERE order_id=? AND active=1 LIMIT 1');
    $st->execute([$orderId]);
    $token = $st->fetchColumn();
    if (is_string($token) && $token !== '') return $token;

    for ($i=0; $i<3; $i++) {
        $token = bin2hex(random_bytes(32));
        try {
            db()->prepare('INSERT INTO cp_tracking_tokens(order_id,token,active,created_at) VALUES(?,?,1,NOW())')
                ->execute([$orderId, $token]);
            return $token;
        } catch (Throwable $e) {
            if ($i === 2) throw $e;
        }
    }
    throw new RuntimeException('No se pudo generar el acceso de seguimiento.');
}

function tracking_url_for_order(int $orderId): string {
    return '/seguimiento.php?t=' . rawurlencode(tracking_token_for_order($orderId));
}

function tracking_order_by_token(string $token): ?array {
    if (!preg_match('/^[a-f0-9]{64}$/i', $token)) return null;
    $st = db()->prepare(
        'SELECT o.id,o.order_number,o.order_date,o.due_date,o.total,o.status,o.notes,
                q.quote_number,c.name AS customer_name
         FROM cp_tracking_tokens t
         INNER JOIN cp_orders o ON o.id=t.order_id
         LEFT JOIN cp_quotes q ON q.id=o.quote_id
         LEFT JOIN cp_customers c ON c.id=o.customer_id
         WHERE t.token=? AND t.active=1 LIMIT 1'
    );
    $st->execute([$token]);
    $row = $st->fetch();
    if (!$row) return null;
    db()->prepare('UPDATE cp_tracking_tokens SET last_access_at=NOW() WHERE token=?')->execute([$token]);
    return $row;
}

function tracking_history(int $orderId): array {
    $st = db()->prepare(
        'SELECT h.new_status,h.note,h.created_at
         FROM cp_order_history h
         WHERE h.order_id=?
           AND h.new_status IN (\'pending\',\'design\',\'approval\',\'printing\',\'production\',\'quality\',\'ready\',\'delivered\')
         ORDER BY h.id ASC'
    );
    $st->execute([$orderId]);
    return $st->fetchAll();
}

function tracking_client_stages(): array {
    return [
        'received' => [
            'label'=>'Pedido recibido',
            'icon'=>'📥',
            'description'=>'Recibimos tu pedido y ya comenzamos a prepararlo.',
        ],
        'preparing' => [
            'label'=>'Preparando tu pedido',
            'icon'=>'🎨',
            'description'=>'Estamos preparando los detalles y dejando todo listo para producirlo.',
        ],
        'production' => [
            'label'=>'En producción',
            'icon'=>'🔧',
            'description'=>'Estamos trabajando en tu pedido. ¡Ya está en camino!',
        ],
        'ready' => [
            'label'=>'Listo para entrega',
            'icon'=>'🚚',
            'description'=>'Tu pedido está terminado y listo para que lo recibas.',
        ],
        'delivered' => [
            'label'=>'Entregado',
            'icon'=>'🎉',
            'description'=>'Tu pedido fue entregado. ¡Gracias por confiar en Colibrí Print!',
        ],
    ];
}

function tracking_internal_to_client_stage(string $stage): string {
    $map = [
        'pending'=>'received',
        'design'=>'preparing',
        'approval'=>'preparing',
        'printing'=>'production',
        'production'=>'production',
        'quality'=>'production',
        'ready'=>'ready',
        'delivered'=>'delivered',
    ];
    return $map[$stage] ?? 'received';
}

function tracking_current_stage(int $orderId): string {
    $internal = production_get_stage($orderId);
    return tracking_internal_stage_exists($internal) ? $internal : 'pending';
}

function tracking_internal_stage_exists(string $stage): bool {
    return in_array($stage, [
        'pending','design','approval','printing','production','quality','ready','delivered'
    ], true);
}

function tracking_has_design_approval(array $history, string $currentInternal): bool {
    if ($currentInternal === 'approval') return true;
    foreach ($history as $entry) {
        if ((string)($entry['new_status'] ?? '') === 'approval') return true;
    }
    return false;
}

/**
 * Devuelve solo un registro por etapa comercial principal para no abrumar al cliente.
 * El detalle interno de Diseño/Impresión/Calidad sigue conservado en administración.
 */
function tracking_client_history(array $history, bool $showApproval): array {
    $main = [];
    $approval = null;

    foreach ($history as $entry) {
        $internal = (string)($entry['new_status'] ?? '');
        if ($internal === 'approval' && $showApproval) {
            $approval = [
                'key'=>'approval',
                'label'=>'Aprobación de diseño',
                'icon'=>'✅',
                'note'=>(string)($entry['note'] ?? ''),
                'created_at'=>$entry['created_at'] ?? null,
            ];
            continue;
        }

        $key = tracking_internal_to_client_stage($internal);
        if (!isset(tracking_client_stages()[$key])) continue;
        $main[$key] = [
            'key'=>$key,
            'label'=>tracking_client_stages()[$key]['label'],
            'icon'=>tracking_client_stages()[$key]['icon'],
            'note'=>(string)($entry['note'] ?? ''),
            'created_at'=>$entry['created_at'] ?? null,
        ];
    }

    $result = array_values($main);
    usort($result, static function(array $a, array $b): int {
        return strtotime((string)($b['created_at'] ?? '')) <=> strtotime((string)($a['created_at'] ?? ''));
    });

    if ($approval !== null) {
        $result[] = $approval;
    }
    return $result;
}

function tracking_latest_client_message(array $history, string $currentInternal): string {
    $clientKey = tracking_internal_to_client_stage($currentInternal);
    for ($i=count($history)-1; $i>=0; $i--) {
        $entry = $history[$i];
        if (tracking_internal_to_client_stage((string)($entry['new_status'] ?? '')) !== $clientKey) continue;
        $note = trim((string)($entry['note'] ?? ''));
        if ($note !== '') return $note;
    }

    $stages = tracking_client_stages();
    return $stages[$clientKey]['description'] ?? 'Tu pedido está siendo atendido por nuestro equipo.';
}
