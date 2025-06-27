-- Procedimientos para la gestión de movimientos

-- 1. Registrar movimiento
DELIMITER //
CREATE PROCEDURE sp_RegistrarMovimiento(IN p_producto_id INT, IN p_cantidad INT, IN p_tipo VARCHAR(50), IN p_fecha DATETIME, IN p_local_id INT)
BEGIN
    INSERT INTO Movimientos (producto_id, cantidad, tipo, fecha, local_id) VALUES (p_producto_id, p_cantidad, p_tipo, p_fecha, p_local_id);
END //
DELIMITER ;

-- 2. Obtener todos los movimientos
DELIMITER //
CREATE PROCEDURE sp_ObtenerMovimientos()
BEGIN
    SELECT * FROM Movimientos;
END //
DELIMITER ;

-- 3. Obtener movimientos por producto
DELIMITER //
CREATE PROCEDURE sp_ObtenerMovimientosPorProducto(IN p_producto_id INT)
BEGIN
    SELECT * FROM Movimientos WHERE producto_id = p_producto_id;
END //
DELIMITER ;

-- 4. Obtener movimientos por local
DELIMITER //
CREATE PROCEDURE sp_ObtenerMovimientosPorLocal(IN p_local_id INT)
BEGIN
    SELECT * FROM Movimientos WHERE local_id = p_local_id;
END //
DELIMITER ;

-- 5. Obtener movimientos por tipo
DELIMITER //
CREATE PROCEDURE sp_ObtenerMovimientosPorTipo(IN p_tipo VARCHAR(50))
BEGIN
    SELECT * FROM Movimientos WHERE tipo = p_tipo;
END //
DELIMITER ;

-- 6. Obtener movimientos en un rango de fechas
DELIMITER //
CREATE PROCEDURE sp_ObtenerMovimientosPorFecha(IN p_inicio DATETIME, IN p_fin DATETIME)
BEGIN
    SELECT * FROM Movimientos WHERE fecha BETWEEN p_inicio AND p_fin;
END //
DELIMITER ;

-- 7. Contar movimientos por producto
DELIMITER //
CREATE PROCEDURE sp_ContarMovimientosPorProducto(IN p_producto_id INT)
BEGIN
    SELECT COUNT(*) AS total FROM Movimientos WHERE producto_id = p_producto_id;
END //
DELIMITER ;

-- 8. Listar productos con más movimientos
DELIMITER //
CREATE PROCEDURE sp_ListarProductosConMasMovimientos()
BEGIN
    SELECT producto_id, COUNT(*) AS total_movimientos
    FROM Movimientos
    GROUP BY producto_id
    ORDER BY total_movimientos DESC;
END //
DELIMITER ;

-- 9. Listar movimientos recientes
DELIMITER //
CREATE PROCEDURE sp_ListarMovimientosRecientes()
BEGIN
    SELECT * FROM Movimientos WHERE fecha > DATE_SUB(NOW(), INTERVAL 7 DAY);
END //
DELIMITER ;

-- 10. Eliminar movimiento por ID
DELIMITER //
CREATE PROCEDURE sp_EliminarMovimiento(IN p_id INT)
BEGIN
    DELETE FROM Movimientos WHERE id = p_id;
END //
DELIMITER ;

-- 11. Actualizar cantidad de un movimiento
DELIMITER //
CREATE PROCEDURE sp_ActualizarCantidadMovimiento(IN p_id INT, IN p_cantidad INT)
BEGIN
    UPDATE Movimientos SET cantidad = p_cantidad WHERE id = p_id;
END //
DELIMITER ;

-- 12. Listar movimientos por usuario (si aplica)
-- (Asumiendo que hay un campo usuario_id)
DELIMITER //
CREATE PROCEDURE sp_ObtenerMovimientosPorUsuario(IN p_usuario_id INT)
BEGIN
    SELECT * FROM Movimientos WHERE usuario_id = p_usuario_id;
END //
DELIMITER ;

-- 13. Listar movimientos de entrada
DELIMITER //
CREATE PROCEDURE sp_ListarMovimientosEntrada()
BEGIN
    SELECT * FROM Movimientos WHERE tipo = 'entrada';
END //
DELIMITER ;

-- 14. Listar movimientos de salida
DELIMITER //
CREATE PROCEDURE sp_ListarMovimientosSalida()
BEGIN
    SELECT * FROM Movimientos WHERE tipo = 'salida';
END //
DELIMITER ;

-- 15. Obtener último movimiento de un producto
DELIMITER //
CREATE PROCEDURE sp_ObtenerUltimoMovimientoProducto(IN p_producto_id INT)
BEGIN
    SELECT * FROM Movimientos WHERE producto_id = p_producto_id ORDER BY fecha DESC LIMIT 1;
END //
DELIMITER ;
