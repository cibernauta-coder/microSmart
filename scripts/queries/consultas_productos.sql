-- Consultas simples y multitabla para Productos

-- =====================
-- CONSULTAS SENCILLAS
-- =====================
-- 1. Listar todos los productos activos
SELECT * FROM Productos WHERE activo = 1;

-- 2. Buscar productos por nombre
SELECT * FROM Productos WHERE nombre LIKE '%Lapicero%';

-- 3. Contar productos activos
SELECT COUNT(*) AS total FROM Productos WHERE activo = 1;

-- 4. Listar productos con stock bajo
SELECT * FROM Productos WHERE stock < 10 AND activo = 1;

-- 5. Listar productos por etiqueta
SELECT * FROM Productos WHERE etiqueta = 'Papelería' AND activo = 1;

-- 6. Listar productos asignados a un local
SELECT p.* FROM Productos p
JOIN ProductosLocales pl ON p.id = pl.producto_id
WHERE pl.local_id = 1 AND p.activo = 1;

-- =====================
-- CONSULTAS MULTITABLA
-- =====================
-- 7. Listar productos sin movimientos recientes
SELECT p.* FROM Productos p
LEFT JOIN Movimientos m ON p.id = m.producto_id AND m.fecha > DATEADD(DAY, -30, GETDATE())
WHERE m.id IS NULL AND p.activo = 1;

-- 8. Listar productos más vendidos
SELECT p.id, p.nombre, SUM(vp.cantidad) AS cantidad_vendida
FROM Productos p
JOIN VentasProductos vp ON p.id = vp.producto_id
GROUP BY p.id, p.nombre
ORDER BY cantidad_vendida DESC;

-- 9. Listar productos y su último movimiento
SELECT p.id, p.nombre, MAX(m.fecha) AS ultimo_movimiento
FROM Productos p
JOIN Movimientos m ON p.id = m.producto_id
GROUP BY p.id, p.nombre;

-- 10. Listar productos y cantidad de ventas
SELECT p.id, p.nombre, SUM(vp.cantidad) AS total_vendido
FROM Productos p
JOIN VentasProductos vp ON p.id = vp.producto_id
GROUP BY p.id, p.nombre;

-- 11. Listar productos y locales donde están asignados
SELECT p.id, p.nombre, l.nombre AS local
FROM Productos p
JOIN ProductosLocales pl ON p.id = pl.producto_id
JOIN Locales l ON pl.local_id = l.id;

-- 12. Listar productos y movimientos
SELECT p.id, p.nombre, m.cantidad, m.tipo, m.fecha
FROM Productos p
JOIN Movimientos m ON p.id = m.producto_id;

-- 13. Listar productos y ventas por mes
SELECT p.id, p.nombre, MONTH(v.fecha) AS mes, SUM(vp.cantidad) AS ventas_mes
FROM Productos p
JOIN VentasProductos vp ON p.id = vp.producto_id
JOIN Ventas v ON vp.venta_id = v.id
GROUP BY p.id, p.nombre, MONTH(v.fecha);

-- 14. Listar productos y stock por local
SELECT p.id, p.nombre, pl.local_id, l.nombre AS local, pl.stock
FROM Productos p
JOIN ProductosLocales pl ON p.id = pl.producto_id
JOIN Locales l ON pl.local_id = l.id;

-- 15. Listar productos y total vendido por etiqueta
SELECT p.etiqueta, SUM(vp.cantidad) AS total_vendido
FROM Productos p
JOIN VentasProductos vp ON p.id = vp.producto_id
GROUP BY p.etiqueta;
