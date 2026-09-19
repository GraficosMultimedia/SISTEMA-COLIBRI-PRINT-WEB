USE colibrip_abcsistema;

CREATE TABLE IF NOT EXISTS cp_print_rolls (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    roll_name VARCHAR(120) NOT NULL,
    initial_m DECIMAL(12,3) NOT NULL DEFAULT 0.000,
    remaining_m DECIMAL(12,3) NOT NULL DEFAULT 0.000,
    opened_at DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    created_by INT UNSIGNED NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    KEY idx_cp_print_rolls_status (status),
    KEY idx_cp_print_rolls_opened_at (opened_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS cp_print_meter_logs (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    roll_id BIGINT UNSIGNED NOT NULL,
    printed_at DATETIME NOT NULL,
    job_name VARCHAR(190) NOT NULL,
    job_length_mm DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    linear_m DECIMAL(12,3) NOT NULL DEFAULT 0.000,
    result_status VARCHAR(40) NOT NULL DEFAULT 'good',
    waste_m DECIMAL(12,3) NOT NULL DEFAULT 0.000,
    created_by INT UNSIGNED NULL,
    created_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    KEY idx_cp_print_meter_roll (roll_id),
    KEY idx_cp_print_meter_date (printed_at),
    KEY idx_cp_print_meter_result (result_status),
    CONSTRAINT fk_cp_print_meter_roll FOREIGN KEY (roll_id) REFERENCES cp_print_rolls(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
