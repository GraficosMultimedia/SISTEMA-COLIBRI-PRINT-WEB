CREATE TABLE IF NOT EXISTS cp_quotes (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    quote_number VARCHAR(40) NOT NULL,
    customer_id INT UNSIGNED NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'draft',
    issue_date DATE NOT NULL,
    valid_until DATE NULL,
    notes TEXT NULL,
    terms TEXT NULL,
    internal_notes TEXT NULL,
    source_calculator VARCHAR(40) NULL,
    source_data LONGTEXT NULL,
    created_by INT UNSIGNED NULL,
    updated_by INT UNSIGNED NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_cp_quotes_number (quote_number),
    KEY idx_cp_quotes_customer (customer_id),
    KEY idx_cp_quotes_status (status),
    KEY idx_cp_quotes_issue_date (issue_date),
    CONSTRAINT fk_cp_quotes_customer FOREIGN KEY (customer_id) REFERENCES cp_customers(id) ON DELETE SET NULL,
    CONSTRAINT fk_cp_quotes_created_by FOREIGN KEY (created_by) REFERENCES cp_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_cp_quotes_updated_by FOREIGN KEY (updated_by) REFERENCES cp_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS cp_quote_items (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    quote_id INT UNSIGNED NOT NULL,
    description VARCHAR(500) NOT NULL,
    quantity DECIMAL(12,3) NOT NULL DEFAULT 1,
    unit_price DECIMAL(15,2) NOT NULL DEFAULT 0,
    subtotal DECIMAL(15,2) NOT NULL DEFAULT 0,
    calculator_source VARCHAR(40) NULL,
    sort_order INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    KEY idx_cp_quote_items_quote (quote_id),
    CONSTRAINT fk_cp_quote_items_quote FOREIGN KEY (quote_id) REFERENCES cp_quotes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS cp_quote_costs (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    quote_id INT UNSIGNED NOT NULL,
    concept VARCHAR(190) NOT NULL,
    amount DECIMAL(15,2) NOT NULL DEFAULT 0,
    details TEXT NULL,
    created_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    KEY idx_cp_quote_costs_quote (quote_id),
    CONSTRAINT fk_cp_quote_costs_quote FOREIGN KEY (quote_id) REFERENCES cp_quotes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS cp_quote_totals (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    quote_id INT UNSIGNED NOT NULL,
    subtotal DECIMAL(15,2) NOT NULL DEFAULT 0,
    discount DECIMAL(15,2) NOT NULL DEFAULT 0,
    tax DECIMAL(15,2) NOT NULL DEFAULT 0,
    total DECIMAL(15,2) NOT NULL DEFAULT 0,
    internal_cost DECIMAL(15,2) NOT NULL DEFAULT 0,
    profit DECIMAL(15,2) NOT NULL DEFAULT 0,
    margin_pct DECIMAL(7,3) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_cp_quote_totals_quote (quote_id),
    CONSTRAINT fk_cp_quote_totals_quote FOREIGN KEY (quote_id) REFERENCES cp_quotes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
