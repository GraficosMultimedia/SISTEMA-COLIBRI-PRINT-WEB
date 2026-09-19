CREATE TABLE IF NOT EXISTS cp_orders (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    order_number VARCHAR(40) NOT NULL,
    quote_id INT UNSIGNED NOT NULL,
    customer_id INT UNSIGNED NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'pending',
    order_date DATE NOT NULL,
    due_date DATE NULL,
    responsible_user_id INT UNSIGNED NULL,
    total DECIMAL(15,2) NOT NULL DEFAULT 0,
    notes TEXT NULL,
    internal_notes TEXT NULL,
    created_by INT UNSIGNED NULL,
    updated_by INT UNSIGNED NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_cp_orders_number (order_number),
    UNIQUE KEY uq_cp_orders_quote (quote_id),
    KEY idx_cp_orders_customer (customer_id),
    KEY idx_cp_orders_status (status),
    KEY idx_cp_orders_due_date (due_date),
    CONSTRAINT fk_cp_orders_quote FOREIGN KEY (quote_id) REFERENCES cp_quotes(id) ON DELETE RESTRICT,
    CONSTRAINT fk_cp_orders_customer FOREIGN KEY (customer_id) REFERENCES cp_customers(id) ON DELETE SET NULL,
    CONSTRAINT fk_cp_orders_responsible FOREIGN KEY (responsible_user_id) REFERENCES cp_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_cp_orders_created_by FOREIGN KEY (created_by) REFERENCES cp_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_cp_orders_updated_by FOREIGN KEY (updated_by) REFERENCES cp_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS cp_order_items (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    order_id INT UNSIGNED NOT NULL,
    quote_item_id INT UNSIGNED NULL,
    description VARCHAR(500) NOT NULL,
    quantity DECIMAL(12,3) NOT NULL DEFAULT 1,
    unit_price DECIMAL(15,2) NOT NULL DEFAULT 0,
    subtotal DECIMAL(15,2) NOT NULL DEFAULT 0,
    sort_order INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    KEY idx_cp_order_items_order (order_id),
    CONSTRAINT fk_cp_order_items_order FOREIGN KEY (order_id) REFERENCES cp_orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_cp_order_items_quote_item FOREIGN KEY (quote_item_id) REFERENCES cp_quote_items(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS cp_order_history (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    order_id INT UNSIGNED NOT NULL,
    old_status VARCHAR(30) NULL,
    new_status VARCHAR(30) NOT NULL,
    note TEXT NULL,
    changed_by INT UNSIGNED NULL,
    created_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    KEY idx_cp_order_history_order (order_id),
    CONSTRAINT fk_cp_order_history_order FOREIGN KEY (order_id) REFERENCES cp_orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_cp_order_history_user FOREIGN KEY (changed_by) REFERENCES cp_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
