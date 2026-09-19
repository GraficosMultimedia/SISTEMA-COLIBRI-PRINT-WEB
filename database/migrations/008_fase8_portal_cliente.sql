CREATE TABLE IF NOT EXISTS cp_tracking_tokens (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    order_id INT UNSIGNED NOT NULL,
    token CHAR(64) NOT NULL,
    active TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL,
    last_access_at DATETIME NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_cp_tracking_order (order_id),
    UNIQUE KEY uq_cp_tracking_token (token),
    KEY idx_cp_tracking_active (active),
    CONSTRAINT fk_cp_tracking_order FOREIGN KEY (order_id) REFERENCES cp_orders(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
