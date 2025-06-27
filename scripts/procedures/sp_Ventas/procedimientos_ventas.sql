-- Procedimientos para la gestión de ventas

-- 1. Registrar venta
DELIMITER //
CREATE PROCEDURE sp_RegistrarVenta(IN p_fecha DATETIME, IN p_total DECIMAL(10,2), IN p_metodo_pago VARCHAR(50), IN p_local_id INT)
BEGIN
    INSERT INTO Ventas (fecha, total, metodo_pago, local_id) VALUES (p_fecha, p_total, p_metodo_pago, p_local_id);
END //
DELIMITER ;

-- 2. Obtener todas las ventas
DELIMITER //
CREATE PROCEDURE sp_ObtenerVentas()
BEGIN
    SELECT * FROM Ventas;
END //
DELIMITER ;

-- 3. Obtener venta por ID
DELIMITER //
CREATE PROCEDURE sp_ObtenerVentaPorID(IN p_id INT)
BEGIN
    SELECT * FROM Ventas WHERE id = p_id;
END //
DELIMITER ;

-- 4. Actualizar venta
DELIMITER //
CREATE PROCEDURE sp_ActualizarVenta(IN p_id INT, IN p_fecha DATETIME, IN p_total DECIMAL(10,2), IN p_metodo_pago VARCHAR(50), IN p_local_id INT)
BEGIN
    UPDATE Ventas SET fecha = p_fecha, total = p_total, metodo_pago = p_metodo_pago, local_id = p_local_id WHERE id = p_id;
END //
DELIMITER ;

-- 5. Eliminar venta
DELIMITER //
CREATE PROCEDURE sp_EliminarVenta(IN p_id INT)
BEGIN
    DELETE FROM Ventas WHERE id = p_id;
END //
DELIMITER ;

-- 6. Listar ventas por local
DELIMITER //
CREATE PROCEDURE sp_ListarVentasPorLocal(IN p_local_id INT)
BEGIN
    SELECT * FROM Ventas WHERE local_id = p_local_id;
END //
DELIMITER ;

-- 7. Listar ventas por fecha
DELIMITER //
CREATE PROCEDURE sp_ListarVentasPorFecha(IN p_fecha DATETIME)
BEGIN
    SELECT * FROM Ventas WHERE DATE(fecha) = DATE(p_fecha);
END //
DELIMITER ;

-- 8. Listar ventas por método de pago
DELIMITER //
CREATE PROCEDURE sp_ListarVentasPorMetodoPago(IN p_metodo_pago VARCHAR(50))
BEGIN
    SELECT * FROM Ventas WHERE metodo_pago = p_metodo_pago;
END //
DELIMITER ;

-- 9. Contar ventas por local
DELIMITER //
CREATE PROCEDURE sp_ContarVentasPorLocal(IN p_local_id INT)
BEGIN
    SELECT COUNT(*) AS total FROM Ventas WHERE local_id = p_local_id;
END //
DELIMITER ;

-- 10. Sumar total vendido por local
DELIMITER //
CREATE PROCEDURE sp_SumarTotalVendidoPorLocal(IN p_local_id INT)
BEGIN
    SELECT SUM(total) AS total_vendido FROM Ventas WHERE local_id = p_local_id;
END //
DELIMITER ;

-- 11. Listar ventas y productos vendidos
DELIMITER //
CREATE PROCEDURE sp_ListarVentasConProductos()
BEGIN
    SELECT v.id, v.fecha, v.total, p.nombre AS producto, vp.cantidad
    FROM Ventas v
    JOIN VentasProductos vp ON v.id = vp.venta_id
    JOIN Productos p ON vp.producto_id = p.id;
END //
DELIMITER ;

-- 12. Listar ventas por rango de fechas
DELIMITER //
CREATE PROCEDURE sp_ListarVentasPorRangoFechas(IN p_inicio DATETIME, IN p_fin DATETIME)
BEGIN
    SELECT * FROM Ventas WHERE fecha BETWEEN p_inicio AND p_fin;
END //
DELIMITER ;

-- 13. Listar ventas por usuario (si aplica)
-- (Asumiendo que hay un campo usuario_id)
DELIMITER //
CREATE PROCEDURE sp_ListarVentasPorUsuario(IN p_usuario_id INT)
BEGIN
    SELECT * FROM Ventas WHERE usuario_id = p_usuario_id;
END //
DELIMITER ;

-- 14. Listar ventas y métodos de pago usados
DELIMITER //
CREATE PROCEDURE sp_ListarVentasPorMetodoPagoAgrupado()
BEGIN
    SELECT metodo_pago, COUNT(*) AS cantidad FROM Ventas GROUP BY metodo_pago;
END //
DELIMITER ;

-- 15. Listar ventas y total vendido por mes
DELIMITER //
CREATE PROCEDURE sp_ListarVentasPorMes()
BEGIN
    SELECT MONTH(fecha) AS mes, SUM(total) AS total_vendido FROM Ventas GROUP BY mes;
END //
DELIMITER ;
