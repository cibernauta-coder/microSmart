-- Procedimientos para la gestión de productos

-- 1. Crear producto
DELIMITER //
CREATE PROCEDURE sp_CrearProducto(IN p_nombre VARCHAR(100), IN p_precio DECIMAL(10,2), IN p_stock INT, IN p_etiqueta VARCHAR(50))
BEGIN
    INSERT INTO Productos (nombre, precio, stock, etiqueta, activo) VALUES (p_nombre, p_precio, p_stock, p_etiqueta, 1);
END //
DELIMITER ;

-- 2. Obtener todos los productos activos
DELIMITER //
CREATE PROCEDURE sp_ObtenerProductosActivos()
BEGIN
    SELECT * FROM Productos WHERE activo = 1;
END //
DELIMITER ;

-- 3. Obtener producto por ID
DELIMITER //
CREATE PROCEDURE sp_ObtenerProductoPorID(IN p_id INT)
BEGIN
    SELECT * FROM Productos WHERE id = p_id;
END //
DELIMITER ;

-- 4. Actualizar producto
DELIMITER //
CREATE PROCEDURE sp_ActualizarProducto(IN p_id INT, IN p_nombre VARCHAR(100), IN p_precio DECIMAL(10,2), IN p_stock INT, IN p_etiqueta VARCHAR(50))
BEGIN
    UPDATE Productos SET nombre = p_nombre, precio = p_precio, stock = p_stock, etiqueta = p_etiqueta WHERE id = p_id;
END //
DELIMITER ;

-- 5. Desactivar producto
DELIMITER //
CREATE PROCEDURE sp_DesactivarProducto(IN p_id INT)
BEGIN
    UPDATE Productos SET activo = 0 WHERE id = p_id;
END //
DELIMITER ;

-- 6. Reactivar producto
DELIMITER //
CREATE PROCEDURE sp_ReactivarProducto(IN p_id INT)
BEGIN
    UPDATE Productos SET activo = 1 WHERE id = p_id;
END //
DELIMITER ;

-- 7. Buscar productos por nombre
DELIMITER //
CREATE PROCEDURE sp_BuscarProductosPorNombre(IN p_nombre VARCHAR(100))
BEGIN
    SELECT * FROM Productos WHERE nombre LIKE CONCAT('%', p_nombre, '%') AND activo = 1;
END //
DELIMITER ;

-- 8. Actualizar solo el stock
DELIMITER //
CREATE PROCEDURE sp_ActualizarStockProducto(IN p_id INT, IN p_stock INT)
BEGIN
    UPDATE Productos SET stock = p_stock WHERE id = p_id;
END //
DELIMITER ;

-- 9. Listar productos con stock bajo
DELIMITER //
CREATE PROCEDURE sp_ListarProductosStockBajo(IN p_minimo INT)
BEGIN
    SELECT * FROM Productos WHERE stock < p_minimo AND activo = 1;
END //
DELIMITER ;

-- 10. Listar productos por etiqueta
DELIMITER //
CREATE PROCEDURE sp_ListarProductosPorEtiqueta(IN p_etiqueta VARCHAR(50))
BEGIN
    SELECT * FROM Productos WHERE etiqueta = p_etiqueta AND activo = 1;
END //
DELIMITER ;

-- 11. Listar productos asignados a un local
DELIMITER //
CREATE PROCEDURE sp_ListarProductosPorLocal(IN p_local_id INT)
BEGIN
    SELECT p.* FROM Productos p
    JOIN ProductosLocales pl ON p.id = pl.producto_id
    WHERE pl.local_id = p_local_id AND p.activo = 1;
END //
DELIMITER ;

-- 12. Listar productos sin movimientos recientes
DELIMITER //
CREATE PROCEDURE sp_ListarProductosSinMovimientosRecientes()
BEGIN
    SELECT p.* FROM Productos p
    LEFT JOIN Movimientos m ON p.id = m.producto_id AND m.fecha > DATE_SUB(NOW(), INTERVAL 30 DAY)
    WHERE m.id IS NULL AND p.activo = 1;
END //
DELIMITER ;

-- 13. Listar productos más vendidos
DELIMITER //
CREATE PROCEDURE sp_ListarProductosMasVendidos()
BEGIN
    SELECT p.id, p.nombre, SUM(vp.cantidad) AS cantidad_vendida
    FROM Productos p
    JOIN VentasProductos vp ON p.id = vp.producto_id
    GROUP BY p.id, p.nombre
    ORDER BY cantidad_vendida DESC;
END //
DELIMITER ;

-- 14. Listar productos y su último movimiento
DELIMITER //
CREATE PROCEDURE sp_ListarProductosUltimoMovimiento()
BEGIN
    SELECT p.id, p.nombre, MAX(m.fecha) AS ultimo_movimiento
    FROM Productos p
    JOIN Movimientos m ON p.id = m.producto_id
    GROUP BY p.id, p.nombre;
END //
DELIMITER ;

-- 15. Contar productos activos
DELIMITER //
CREATE PROCEDURE sp_ContarProductosActivos()
BEGIN
    SELECT COUNT(*) AS total FROM Productos WHERE activo = 1;
END //
DELIMITER ;
