CREATE TABLE IF NOT EXISTS cp_order_status (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    order_id INT UNSIGNED NOT NULL,
    stage VARCHAR(30) NOT NULL DEFAULT 'pending',
    note TEXT NULL,
    updated_by INT UNSIGNED NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_cp_order_status_order (order_id),
    KEY idx_cp_order_status_stage (stage),
    CONSTRAINT fk_cp_order_status_order FOREIGN KEY (order_id) REFERENCES cp_orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_cp_order_status_user FOREIGN KEY (updated_by) REFERENCES cp_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO cp_order_status (order_id, stage, note, updated_by, created_at, updated_at)
SELECT o.id,
       CASE o.status
         WHEN 'in_progress' THEN 'production'
         WHEN 'completed' THEN 'quality'
         WHEN 'delivered' THEN 'delivered'
         WHEN 'cancelled' THEN 'cancelled'
         ELSE 'pending'
       END,
       'Inicialización de seguimiento de producción',
       o.updated_by,
       COALESCE(o.created_at, NOW()),
       COALESCE(o.updated_at, NOW())
FROM cp_orders o
LEFT JOIN cp_order_status s ON s.order_id = o.id
WHERE s.id IS NULL;
