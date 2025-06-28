-- Consultas simples y multitabla para Locales

-- =====================
-- CONSULTAS SENCILLAS
-- =====================
-- 1. Listar todos los locales activos
SELECT * FROM Locales WHERE activo = 1;

-- 2. Buscar locales por nombre
SELECT * FROM Locales WHERE nombre LIKE '%Tienda%';

-- 3. Contar locales activos
SELECT COUNT(*) AS total FROM Locales WHERE activo = 1;

-- =====================
-- CONSULTAS MULTITABLA
-- =====================
-- 4. Listar locales y cantidad de productos asignados
SELECT l.id, l.nombre, COUNT(pl.producto_id) AS productos_asignados
FROM Locales l
LEFT JOIN ProductosLocales pl ON l.id = pl.local_id
WHERE l.activo = 1
GROUP BY l.id, l.nombre;

-- 5. Listar locales sin productos asignados
SELECT l.* FROM Locales l
LEFT JOIN ProductosLocales pl ON l.id = pl.local_id
WHERE pl.producto_id IS NULL AND l.activo = 1;

-- 6. Listar locales y cantidad de ventas
SELECT l.id, l.nombre, COUNT(v.id) AS total_ventas
FROM Locales l
LEFT JOIN Ventas v ON l.id = v.local_id
WHERE l.activo = 1
GROUP BY l.id, l.nombre;

-- 7. Listar locales con más de 5 productos
SELECT l.id, l.nombre, COUNT(pl.producto_id) AS productos_asignados
FROM Locales l
JOIN ProductosLocales pl ON l.id = pl.local_id
WHERE l.activo = 1
GROUP BY l.id, l.nombre
HAVING COUNT(pl.producto_id) > 5;

-- 8. Listar locales y su último movimiento de producto
SELECT l.id, l.nombre, MAX(m.fecha) AS ultimo_movimiento
FROM Locales l
JOIN ProductosLocales pl ON l.id = pl.local_id
JOIN Movimientos m ON pl.producto_id = m.producto_id
WHERE l.activo = 1
GROUP BY l.id, l.nombre;

-- 9. Listar locales y productos asignados
SELECT l.id, l.nombre AS local, p.nombre AS producto
FROM Locales l
JOIN ProductosLocales pl ON l.id = pl.local_id
JOIN Productos p ON pl.producto_id = p.id;

-- 10. Listar locales y ventas por mes
SELECT l.id, l.nombre, MONTH(v.fecha) AS mes, COUNT(v.id) AS ventas_mes
FROM Locales l
JOIN Ventas v ON l.id = v.local_id
WHERE l.activo = 1
GROUP BY l.id, l.nombre, MONTH(v.fecha);

-- 11. Listar locales y total vendido
SELECT l.id, l.nombre, SUM(v.total) AS total_vendido
FROM Locales l
JOIN Ventas v ON l.id = v.local_id
WHERE l.activo = 1
GROUP BY l.id, l.nombre;

-- 12. Listar locales y productos con stock bajo
SELECT l.id, l.nombre, p.nombre AS producto, p.stock
FROM Locales l
JOIN ProductosLocales pl ON l.id = pl.local_id
JOIN Productos p ON pl.producto_id = p.id
WHERE p.stock < 10 AND l.activo = 1;

-- 13. Listar locales y productos sin movimientos recientes
SELECT l.id, l.nombre, p.nombre AS producto
FROM Locales l
JOIN ProductosLocales pl ON l.id = pl.local_id
JOIN Productos p ON pl.producto_id = p.id
LEFT JOIN Movimientos m ON p.id = m.producto_id AND m.fecha > DATEADD(DAY, -30, GETDATE())
WHERE m.id IS NULL AND l.activo = 1;

-- 14. Listar locales y productos más vendidos
SELECT l.id, l.nombre, p.nombre AS producto, SUM(vp.cantidad) AS cantidad_vendida
FROM Locales l
JOIN Ventas v ON l.id = v.local_id
JOIN VentasProductos vp ON v.id = vp.venta_id
JOIN Productos p ON vp.producto_id = p.id
WHERE l.activo = 1
GROUP BY l.id, l.nombre, p.nombre
ORDER BY cantidad_vendida DESC;

-- 15. Listar locales y métodos de pago usados
SELECT l.id, l.nombre, v.metodo_pago, COUNT(v.id) AS cantidad
FROM Locales l
JOIN Ventas v ON l.id = v.local_id
WHERE l.activo = 1
GROUP BY l.id, l.nombre, v.metodo_pago;
