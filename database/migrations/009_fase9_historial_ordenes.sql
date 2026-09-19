-- FASE 9 · HISTORIAL Y CIERRE DE ÓRDENES
-- Sincroniza las órdenes entregadas con la etapa final de producción.
-- No crea una tabla nueva: reutiliza cp_order_status y cp_order_history.

INSERT INTO cp_order_status (order_id, stage, note, updated_by, created_at, updated_at)
SELECT o.id, 'delivered', 'Sincronización de Fase 9: orden ya entregada.',
       o.updated_by, COALESCE(o.updated_at, NOW()), COALESCE(o.updated_at, NOW())
FROM cp_orders o
LEFT JOIN cp_order_status s ON s.order_id=o.id
WHERE o.status='delivered' AND s.id IS NULL;

UPDATE cp_order_status s
INNER JOIN cp_orders o ON o.id=s.order_id
SET s.stage='delivered',
    s.updated_by=o.updated_by,
    s.updated_at=COALESCE(o.updated_at, NOW())
WHERE o.status='delivered' AND s.stage<>'delivered';

-- Índices para que el historial y el tablero mantengan buen rendimiento.
CREATE INDEX idx_cp_order_history_new_status ON cp_order_history (new_status);
CREATE INDEX idx_cp_order_status_updated_at ON cp_order_status (updated_at);
