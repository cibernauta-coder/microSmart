-- Procedimientos para la gestión de ventas (SQL Server)

-- 1. Registrar venta
CREATE PROCEDURE sp_RegistrarVenta
    @fecha DATETIME,
    @total DECIMAL(10,2),
    @metodo_pago VARCHAR(50),
    @local_id INT
AS
BEGIN
    INSERT INTO Ventas (fecha, total, metodo_pago, local_id) VALUES (@fecha, @total, @metodo_pago, @local_id);
END
GO

-- 2. Obtener todas las ventas
CREATE PROCEDURE sp_ObtenerVentas
AS
BEGIN
    SELECT * FROM Ventas;
END
GO

-- 3. Obtener venta por ID
CREATE PROCEDURE sp_ObtenerVentaPorID
    @id INT
AS
BEGIN
    SELECT * FROM Ventas WHERE id = @id;
END
GO

-- 4. Actualizar venta
CREATE PROCEDURE sp_ActualizarVenta
    @id INT,
    @fecha DATETIME,
    @total DECIMAL(10,2),
    @metodo_pago VARCHAR(50),
    @local_id INT
AS
BEGIN
    UPDATE Ventas SET fecha = @fecha, total = @total, metodo_pago = @metodo_pago, local_id = @local_id WHERE id = @id;
END
GO

-- 5. Eliminar venta
CREATE PROCEDURE sp_EliminarVenta
    @id INT
AS
BEGIN
    DELETE FROM Ventas WHERE id = @id;
END
GO

-- 6. Listar ventas por local
CREATE PROCEDURE sp_ListarVentasPorLocal
    @local_id INT
AS
BEGIN
    SELECT * FROM Ventas WHERE local_id = @local_id;
END
GO

-- 7. Listar ventas por fecha
CREATE PROCEDURE sp_ListarVentasPorFecha
    @fecha DATETIME
AS
BEGIN
    SELECT * FROM Ventas WHERE CAST(fecha AS DATE) = CAST(@fecha AS DATE);
END
GO

-- 8. Listar ventas por método de pago
CREATE PROCEDURE sp_ListarVentasPorMetodoPago
    @metodo_pago VARCHAR(50)
AS
BEGIN
    SELECT * FROM Ventas WHERE metodo_pago = @metodo_pago;
END
GO

-- 9. Contar ventas por local
CREATE PROCEDURE sp_ContarVentasPorLocal
    @local_id INT
AS
BEGIN
    SELECT COUNT(*) AS total FROM Ventas WHERE local_id = @local_id;
END
GO

-- 10. Sumar total vendido por local
CREATE PROCEDURE sp_SumarTotalVendidoPorLocal
    @local_id INT
AS
BEGIN
    SELECT SUM(total) AS total_vendido FROM Ventas WHERE local_id = @local_id;
END
GO

-- 11. Listar ventas y productos vendidos
CREATE PROCEDURE sp_ListarVentasConProductos
AS
BEGIN
    SELECT v.id, v.fecha, v.total, p.nombre AS producto, vp.cantidad
    FROM Ventas v
    JOIN VentasProductos vp ON v.id = vp.venta_id
    JOIN Productos p ON vp.producto_id = p.id;
END
GO

-- 12. Listar ventas por rango de fechas
CREATE PROCEDURE sp_ListarVentasPorRangoFechas
    @inicio DATETIME,
    @fin DATETIME
AS
BEGIN
    SELECT * FROM Ventas WHERE fecha BETWEEN @inicio AND @fin;
END
GO

-- 13. Listar ventas por usuario (si aplica)
CREATE PROCEDURE sp_ListarVentasPorUsuario
    @usuario_id INT
AS
BEGIN
    SELECT * FROM Ventas WHERE usuario_id = @usuario_id;
END
GO

-- 14. Listar ventas y métodos de pago usados
CREATE PROCEDURE sp_ListarVentasPorMetodoPagoAgrupado
AS
BEGIN
    SELECT metodo_pago, COUNT(*) AS cantidad FROM Ventas GROUP BY metodo_pago;
END
GO

-- 15. Listar ventas y total vendido por mes
CREATE PROCEDURE sp_ListarVentasPorMes
AS
BEGIN
    SELECT MONTH(fecha) AS mes, SUM(total) AS total_vendido FROM Ventas GROUP BY MONTH(fecha);
END
GO
