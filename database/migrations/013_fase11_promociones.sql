USE colibrip_abcsistema;

-- ABC Sistema | Fase 11 | Promociones, remates y liquidaciones
-- Esta migracion agrega el modulo comercial sin alterar el flujo operativo de ordenes.

CREATE TABLE IF NOT EXISTS cp_promotions (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    title VARCHAR(190) NOT NULL,
    slug VARCHAR(190) NOT NULL,
    label VARCHAR(60) NOT NULL DEFAULT 'OFERTA',
    description TEXT NULL,
    promo_type VARCHAR(20) NOT NULL DEFAULT 'fixed',
    normal_price DECIMAL(15,2) NULL,
    promo_price DECIMAL(15,2) NULL,
    discount_percent DECIMAL(6,2) NULL,
    quantity_available INT UNSIGNED NULL,
    start_date DATE NOT NULL,
    end_date DATE NULL,
    image_path VARCHAR(255) NULL,
    whatsapp_text TEXT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'draft',
    show_web TINYINT(1) NOT NULL DEFAULT 1,
    show_catalog TINYINT(1) NOT NULL DEFAULT 1,
    show_whatsapp TINYINT(1) NOT NULL DEFAULT 0,
    created_by INT UNSIGNED NULL,
    updated_by INT UNSIGNED NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_cp_promotions_slug (slug),
    KEY idx_cp_promotions_status_dates (status, start_date, end_date),
    KEY idx_cp_promotions_web (show_web, status),
    KEY idx_cp_promotions_catalog (show_catalog, status),
    KEY idx_cp_promotions_whatsapp (show_whatsapp, status),
    CONSTRAINT fk_cp_promotions_created_by FOREIGN KEY (created_by) REFERENCES cp_users(id) ON DELETE SET NULL,
    CONSTRAINT fk_cp_promotions_updated_by FOREIGN KEY (updated_by) REFERENCES cp_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS cp_promotion_products (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    promotion_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_cp_promotion_product (promotion_id, product_id),
    KEY idx_cp_promotion_products_product (product_id),
    CONSTRAINT fk_cp_promotion_products_promotion FOREIGN KEY (promotion_id) REFERENCES cp_promotions(id) ON DELETE CASCADE,
    CONSTRAINT fk_cp_promotion_products_product FOREIGN KEY (product_id) REFERENCES cp_products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
