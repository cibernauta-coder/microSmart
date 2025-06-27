-- Consultas simples y multitabla para Movimientos

-- 1. Listar todos los movimientos
SELECT * FROM Movimientos;

-- 2. Listar movimientos por producto
SELECT * FROM Movimientos WHERE producto_id = 1;

-- 3. Listar movimientos por local
SELECT * FROM Movimientos WHERE local_id = 1;

-- 4. Listar movimientos por tipo
SELECT * FROM Movimientos WHERE tipo = 'entrada';

-- 5. Listar movimientos en un rango de fechas
SELECT * FROM Movimientos WHERE fecha BETWEEN '2024-01-01' AND '2024-12-31';

-- 6. Contar movimientos por producto
SELECT producto_id, COUNT(*) AS total FROM Movimientos GROUP BY producto_id;

-- 7. Listar productos con más movimientos
SELECT producto_id, COUNT(*) AS total_movimientos
FROM Movimientos
GROUP BY producto_id
ORDER BY total_movimientos DESC;

-- 8. Listar movimientos recientes
SELECT * FROM Movimientos WHERE fecha > DATE_SUB(NOW(), INTERVAL 7 DAY);

-- 9. Listar movimientos y productos
SELECT m.id, m.cantidad, m.tipo, m.fecha, p.nombre AS producto
FROM Movimientos m
JOIN Productos p ON m.producto_id = p.id;

-- 10. Listar movimientos y locales
SELECT m.id, m.cantidad, m.tipo, m.fecha, l.nombre AS local
FROM Movimientos m
JOIN Locales l ON m.local_id = l.id;

-- 11. Listar movimientos, productos y locales
SELECT m.id, m.cantidad, m.tipo, m.fecha, p.nombre AS producto, l.nombre AS local
FROM Movimientos m
JOIN Productos p ON m.producto_id = p.id
JOIN Locales l ON m.local_id = l.id;

-- 12. Listar movimientos de entrada
SELECT * FROM Movimientos WHERE tipo = 'entrada';

-- 13. Listar movimientos de salida
SELECT * FROM Movimientos WHERE tipo = 'salida';

-- 14. Obtener último movimiento de un producto
SELECT * FROM Movimientos WHERE producto_id = 1 ORDER BY fecha DESC LIMIT 1;

-- 15. Listar movimientos por usuario (si aplica)
SELECT * FROM Movimientos WHERE usuario_id = 1;
