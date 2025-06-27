-- Consultas simples y multitabla para Ventas

-- 1. Listar todas las ventas
SELECT * FROM Ventas;

-- 2. Listar ventas por local
SELECT * FROM Ventas WHERE local_id = 1;

-- 3. Listar ventas por fecha
SELECT * FROM Ventas WHERE DATE(fecha) = '2024-06-01';

-- 4. Listar ventas por método de pago
SELECT * FROM Ventas WHERE metodo_pago = 'Efectivo';

-- 5. Contar ventas por local
SELECT local_id, COUNT(*) AS total FROM Ventas GROUP BY local_id;

-- 6. Sumar total vendido por local
SELECT local_id, SUM(total) AS total_vendido FROM Ventas GROUP BY local_id;

-- 7. Listar ventas y productos vendidos
SELECT v.id, v.fecha, v.total, p.nombre AS producto, vp.cantidad
FROM Ventas v
JOIN VentasProductos vp ON v.id = vp.venta_id
JOIN Productos p ON vp.producto_id = p.id;

-- 8. Listar ventas por rango de fechas
SELECT * FROM Ventas WHERE fecha BETWEEN '2024-01-01' AND '2024-12-31';

-- 9. Listar ventas y métodos de pago usados
SELECT metodo_pago, COUNT(*) AS cantidad FROM Ventas GROUP BY metodo_pago;

-- 10. Listar ventas y total vendido por mes
SELECT MONTH(fecha) AS mes, SUM(total) AS total_vendido FROM Ventas GROUP BY mes;

-- 11. Listar ventas y locales
SELECT v.id, v.fecha, v.total, l.nombre AS local
FROM Ventas v
JOIN Locales l ON v.local_id = l.id;

-- 12. Listar ventas y usuarios (si aplica)
SELECT v.id, v.fecha, v.total, u.nombre AS usuario
FROM Ventas v
JOIN Usuarios u ON v.usuario_id = u.id;

-- 13. Listar ventas y productos más vendidos
SELECT p.id, p.nombre, SUM(vp.cantidad) AS cantidad_vendida
FROM VentasProductos vp
JOIN Productos p ON vp.producto_id = p.id
GROUP BY p.id, p.nombre
ORDER BY cantidad_vendida DESC;

-- 14. Listar ventas y productos por local
SELECT v.id, v.fecha, l.nombre AS local, p.nombre AS producto, vp.cantidad
FROM Ventas v
JOIN Locales l ON v.local_id = l.id
JOIN VentasProductos vp ON v.id = vp.venta_id
JOIN Productos p ON vp.producto_id = p.id;

-- 15. Listar ventas y total vendido por usuario (si aplica)
SELECT usuario_id, SUM(total) AS total_vendido FROM Ventas GROUP BY usuario_id;
