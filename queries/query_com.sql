-- 1. Productos y su categoría
SELECT p.id_producto, p.nombre, c.nombre_categoria
FROM Producto p
INNER JOIN ProductoCategoria pc ON p.id_producto = pc.id_producto
INNER JOIN Categoria c ON pc.id_categoria = c.id_categoria;

-- 2. Productos y el local donde están disponibles
SELECT p.id_producto, p.nombre, l.nombre AS local
FROM Producto p
INNER JOIN ProductoLocal pl ON p.id_producto = pl.id_producto
INNER JOIN Local l ON pl.id_local = l.id_local;

-- 3. Movimientos de inventario con nombre de producto y tipo de movimiento
SELECT mi.id_movimiento, p.nombre AS producto, tm.nombre_tipo, mi.cantidad_afectada, mi.fecha_movimiento
FROM MovimientoInventario mi
INNER JOIN Producto p ON mi.id_producto = p.id_producto
INNER JOIN TipoMovimiento tm ON mi.id_tipo_mov = tm.id_tipo_mov;

-- 4. Ventas con productos vendidos y cantidades
SELECT t.id_ticket, t.fecha_venta, p.nombre AS producto, vp.cantidad_vendida, vp.precio_unitario
FROM Ticket t
INNER JOIN Venta v ON t.id_ticket = v.id_ticket
INNER JOIN VentaProducto vp ON v.id_venta = vp.id_venta
INNER JOIN Producto p ON vp.id_producto = p.id_producto;

-- 5. Ventas por método de pago
SELECT t.id_ticket, t.fecha_venta, mp.nombre_tipo AS metodo_pago, t.total_venta
FROM Ticket t
INNER JOIN MetodoPago mp ON t.id_metodo_pago = mp.id_metodo_pago;

-- 6. Productos con su medición
SELECT p.id_producto, p.nombre, m.nombre_medicion, m.abreviatura
FROM Producto p
INNER JOIN Medicion m ON p.id_medicion = m.id_medicion;

-- 7. Productos con stock y local
SELECT p.id_producto, p.nombre, p.stock, l.nombre AS local
FROM Producto p
INNER JOIN ProductoLocal pl ON p.id_producto = pl.id_producto
INNER JOIN Local l ON pl.id_local = l.id_local;

-- 8. Ventas con estado y total
SELECT t.id_ticket, t.fecha_venta, ev.nombre_estado, t.total_venta
FROM Ticket t
INNER JOIN EstadoVenta ev ON t.id_estado_venta = ev.id_estado_venta;

-- 9. Productos vendidos en un ticket específico
SELECT t.id_ticket, p.nombre AS producto, vp.cantidad_vendida, vp.precio_unitario
FROM Ticket t
INNER JOIN Venta v ON t.id_ticket = v.id_ticket
INNER JOIN VentaProducto vp ON v.id_venta = vp.id_venta
INNER JOIN Producto p ON vp.id_producto = p.id_producto
WHERE t.id_ticket = @id_ticket;

-- 10. Historial de movimientos de un producto
SELECT p.nombre AS producto, mi.fecha_movimiento, tm.nombre_tipo, mi.cantidad_afectada, mi.razon_movimiento
FROM Producto p
INNER JOIN MovimientoInventario mi ON p.id_producto = mi.id_producto
INNER JOIN TipoMovimiento tm ON mi.id_tipo_mov = tm.id_tipo_mov
WHERE p.id_producto = @id_producto;

-- 11. Productos por categoría y local
SELECT p.nombre AS producto, c.nombre_categoria, l.nombre AS local
FROM Producto p
INNER JOIN ProductoCategoria pc ON p.id_producto = pc.id_producto
INNER JOIN Categoria c ON pc.id_categoria = c.id_categoria
INNER JOIN ProductoLocal pl ON p.id_producto = pl.id_producto
INNER JOIN Local l ON pl.id_local = l.id_local;

-- 12. Ventas por fecha y local
SELECT t.id_ticket, t.fecha_venta, l.nombre AS local, t.total_venta
FROM Ticket t
INNER JOIN Local l ON t.id_local = l.id_local
WHERE t.fecha_venta BETWEEN @fecha_inicio AND @fecha_fin;

-- 13. Productos con bajo stock y su local
SELECT p.nombre AS producto, p.stock, l.nombre AS local
FROM Producto p
INNER JOIN ProductoLocal pl ON p.id_producto = pl.id_producto
INNER JOIN Local l ON pl.id_local = l.id_local
WHERE p.stock < 100;

-- 14. Ventas y productos agrupados por método de pago
SELECT mp.nombre_tipo AS metodo_pago, COUNT(t.id_ticket) AS total_tickets, SUM(t.total_venta) AS total_ventas
FROM Ticket t
INNER JOIN MetodoPago mp ON t.id_metodo_pago = mp.id_metodo_pago
GROUP BY mp.nombre_tipo;

-- 15. Productos y total vendido
SELECT p.nombre AS producto, SUM(vp.cantidad_vendida) AS total_vendido
FROM Producto p
INNER JOIN VentaProducto vp ON p.id_producto = vp.id_producto
GROUP BY p.nombre;
