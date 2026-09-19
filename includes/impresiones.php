<?php
declare(strict_types=1);

require_once __DIR__ . '/../config/runtime.php';

function print_meter_results(): array
{
    return [
        'good' => 'Impresión buena',
        'test' => 'Test de impresión',
        'cancelled' => 'Cancelada',
        'damaged_jam' => 'Dañada por atrapamiento',
        'reprint' => 'Reimpresión',
    ];
}

function print_meter_result_label(string $status): string
{
    $map = print_meter_results();
    return $map[$status] ?? 'Impresión buena';
}

function print_meter_to_m(float $mm): float
{
    return round(max(0.0, $mm) / 1000, 3);
}

function print_meter_normalize(array $src): array
{
    $lengthMm = max(0.0, (float)($src['job_length_mm'] ?? 0));
    $linearM = max(0.0, (float)($src['linear_m'] ?? 0));

    if ($linearM <= 0 && $lengthMm > 0) {
        $linearM = print_meter_to_m($lengthMm);
    }
    if ($lengthMm <= 0 && $linearM > 0) {
        $lengthMm = round($linearM * 1000, 2);
    }

    $status = (string)($src['result_status'] ?? 'good');
    if (!array_key_exists($status, print_meter_results())) {
        $status = 'good';
    }

    $printedAt = trim((string)($src['printed_at'] ?? ''));
    $printedAt = str_replace('T', ' ', $printedAt);
    if ($printedAt !== '' && preg_match('/^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$/', $printedAt)) {
        $printedAt .= ':00';
    }
    if ($printedAt === '') {
        $printedAt = date('Y-m-d H:i:s');
    }

    return [
        'roll_id' => max(0, (int)($src['roll_id'] ?? 0)),
        'printed_at' => $printedAt,
        'job_name' => trim((string)($src['job_name'] ?? '')),
        'job_length_mm' => round($lengthMm, 2),
        'linear_m' => round($linearM, 3),
        'result_status' => $status,
        'waste_m' => $status === 'good' ? 0.0 : round($linearM, 3),
    ];
}

function print_meter_active_rolls(): array
{
    return db()->query("SELECT id, roll_name, initial_m, remaining_m, opened_at, status FROM cp_print_rolls ORDER BY CASE WHEN status='active' THEN 0 WHEN status='empty' THEN 1 ELSE 2 END, id DESC")->fetchAll();
}

function print_meter_create_roll(string $name, float $meters): int
{
    $name = trim($name);
    if ($name === '') {
        throw new RuntimeException('Indica el nombre o identificación del rollo.');
    }
    if ($meters <= 0) {
        throw new RuntimeException('La longitud inicial del rollo debe ser mayor que 0.');
    }

    $pdo = db();
    $st = $pdo->prepare("INSERT INTO cp_print_rolls(roll_name,initial_m,remaining_m,opened_at,status,created_by,created_at,updated_at) VALUES(?,?,?,NOW(),'active',?,NOW(),NOW())");
    $uid = (int)(current_user()['id'] ?? 0);
    $st->execute([$name, round($meters, 3), round($meters, 3), $uid]);
    return (int)$pdo->lastInsertId();
}

function print_meter_register(array $payload): int
{
    if ($payload['roll_id'] <= 0) {
        throw new RuntimeException('Selecciona el rollo que se está utilizando.');
    }
    if ($payload['job_name'] === '') {
        throw new RuntimeException('Captura el nombre del trabajo de Printexp.');
    }
    if ($payload['linear_m'] <= 0) {
        throw new RuntimeException('Captura el largo del Job Size o los metros lineales.');
    }

    $pdo = db();
    $pdo->beginTransaction();
    try {
        $st = $pdo->prepare('SELECT id, roll_name, remaining_m, status FROM cp_print_rolls WHERE id=? FOR UPDATE');
        $st->execute([$payload['roll_id']]);
        $roll = $st->fetch();
        if (!$roll) {
            throw new RuntimeException('El rollo seleccionado no existe.');
        }
        if ((string)$roll['status'] !== 'active') {
            throw new RuntimeException('El rollo seleccionado no está activo.');
        }
        $remaining = (float)$roll['remaining_m'];
        $consumption = (float)$payload['linear_m'];
        if ($consumption > $remaining + 0.0001) {
            throw new RuntimeException('El rollo solo tiene ' . number_format($remaining, 3) . ' m disponibles.');
        }

        $newRemaining = round(max(0.0, $remaining - $consumption), 3);
        $newStatus = $newRemaining <= 0.0001 ? 'empty' : 'active';

        $ins = $pdo->prepare('INSERT INTO cp_print_meter_logs(roll_id,printed_at,job_name,job_length_mm,linear_m,result_status,waste_m,created_by,created_at) VALUES(?,?,?,?,?,?,?,?,NOW())');
        $ins->execute([
            $payload['roll_id'],
            $payload['printed_at'],
            $payload['job_name'],
            $payload['job_length_mm'],
            $payload['linear_m'],
            $payload['result_status'],
            $payload['waste_m'],
            current_user()['id'] ?? null,
        ]);
        $id = (int)$pdo->lastInsertId();

        $up = $pdo->prepare('UPDATE cp_print_rolls SET remaining_m=?, status=?, updated_at=NOW() WHERE id=?');
        $up->execute([$newRemaining, $newStatus, $payload['roll_id']]);

        $pdo->commit();
        return $id;
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        throw $e;
    }
}

function print_meter_dashboard(): array
{
    $sql = "SELECT COUNT(*) jobs,
                   COALESCE(SUM(linear_m),0) printed_m,
                   COALESCE(SUM(waste_m),0) waste_m,
                   COALESCE(SUM(CASE WHEN result_status='good' THEN linear_m ELSE 0 END),0) good_m
            FROM cp_print_meter_logs";
    $row = db()->query($sql)->fetch() ?: [];
    return [
        'jobs' => (int)($row['jobs'] ?? 0),
        'printed_m' => (float)($row['printed_m'] ?? 0),
        'waste_m' => (float)($row['waste_m'] ?? 0),
        'good_m' => (float)($row['good_m'] ?? 0),
    ];
}

function print_meter_active_roll(): ?array
{
    $st = db()->query("SELECT id, roll_name, initial_m, remaining_m, opened_at, status FROM cp_print_rolls WHERE status='active' ORDER BY id DESC LIMIT 1");
    $row = $st->fetch();
    return $row ?: null;
}

function print_meter_rows(int $limit = 100): array
{
    $limit = max(1, min(500, $limit));
    $sql = "SELECT l.id,l.printed_at,l.job_name,l.job_length_mm,l.linear_m,l.result_status,l.waste_m,
                   r.roll_name
            FROM cp_print_meter_logs l
            INNER JOIN cp_print_rolls r ON r.id=l.roll_id
            ORDER BY l.id DESC LIMIT {$limit}";
    return db()->query($sql)->fetchAll();
}
