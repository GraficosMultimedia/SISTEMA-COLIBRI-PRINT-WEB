-- FASE 9 · WHATSAPP Y COMUNICACIONES DE SERVICIO
CREATE TABLE IF NOT EXISTS cp_whatsapp_templates (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    template_key VARCHAR(80) NOT NULL,
    name VARCHAR(190) NOT NULL,
    category VARCHAR(30) NOT NULL DEFAULT 'service',
    body TEXT NOT NULL,
    active TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_cp_whatsapp_template_key (template_key),
    KEY idx_cp_whatsapp_template_category (category),
    KEY idx_cp_whatsapp_template_active (active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS cp_whatsapp_log (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    template_key VARCHAR(80) NOT NULL,
    order_id INT UNSIGNED NULL,
    quote_id INT UNSIGNED NULL,
    customer_id INT UNSIGNED NULL,
    phone VARCHAR(80) NULL,
    message TEXT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'prepared',
    prepared_by INT UNSIGNED NULL,
    created_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    KEY idx_cp_whatsapp_log_order (order_id),
    KEY idx_cp_whatsapp_log_quote (quote_id),
    KEY idx_cp_whatsapp_log_customer (customer_id),
    KEY idx_cp_whatsapp_log_created (created_at),
    CONSTRAINT fk_cp_whatsapp_log_order FOREIGN KEY (order_id) REFERENCES cp_orders(id) ON DELETE SET NULL,
    CONSTRAINT fk_cp_whatsapp_log_quote FOREIGN KEY (quote_id) REFERENCES cp_quotes(id) ON DELETE SET NULL,
    CONSTRAINT fk_cp_whatsapp_log_customer FOREIGN KEY (customer_id) REFERENCES cp_customers(id) ON DELETE SET NULL,
    CONSTRAINT fk_cp_whatsapp_log_user FOREIGN KEY (prepared_by) REFERENCES cp_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
