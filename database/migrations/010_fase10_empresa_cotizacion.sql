ALTER TABLE cp_quotes
    ADD COLUMN client_reference VARCHAR(190) NULL AFTER valid_until,
    ADD COLUMN payment_terms VARCHAR(190) NULL AFTER client_reference,
    ADD COLUMN delivery_time VARCHAR(190) NULL AFTER payment_terms,
    ADD COLUMN delivery_place VARCHAR(190) NULL AFTER delivery_time;
