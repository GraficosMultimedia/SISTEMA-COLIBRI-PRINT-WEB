-- ABC Sistema | Fase 4 | Motor de cotización
-- Ejecutar una sola vez sobre colibrip_abcsistema.

INSERT INTO cp_settings (setting_key, setting_value, created_at, updated_at) VALUES
('calculator.bastidor.ptr_m', '65.00', NOW(), NOW()),
('calculator.bastidor.canvas_m2', '55.00', NOW(), NOW()),
('calculator.bastidor.print_m2', '85.00', NOW(), NOW()),
('calculator.bastidor.labor_hour', '120.00', NOW(), NOW()),
('calculator.bastidor.waste_pct', '10.00', NOW(), NOW()),
('calculator.bastidor.margin_pct', '35.00', NOW(), NOW()),
('calculator.cnc.material_m2', '450.00', NOW(), NOW()),
('calculator.cnc.machine_hour', '250.00', NOW(), NOW()),
('calculator.cnc.labor_hour', '120.00', NOW(), NOW()),
('calculator.cnc.consumption_pct', '10.00', NOW(), NOW()),
('calculator.cnc.margin_pct', '35.00', NOW(), NOW())
ON DUPLICATE KEY UPDATE setting_value=VALUES(setting_value), updated_at=NOW();
