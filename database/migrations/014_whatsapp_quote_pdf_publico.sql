-- Colibrí Print | WhatsApp + PDF público seguro de cotización
-- No depende de sesión administrativa para descargar el PDF.

CREATE TABLE IF NOT EXISTS cp_quote_public_tokens (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    quote_id INT UNSIGNED NOT NULL,
    token CHAR(64) NOT NULL,
    active TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL,
    last_access_at DATETIME NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_cp_quote_public_quote (quote_id),
    UNIQUE KEY uq_cp_quote_public_token (token),
    KEY idx_cp_quote_public_active (active),
    CONSTRAINT fk_cp_quote_public_quote FOREIGN KEY (quote_id) REFERENCES cp_quotes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
