-- Procedimientos para la gestión de movimientos (SQL Server)

-- 1. Registrar movimiento
CREATE PROCEDURE sp_RegistrarMovimiento
    @producto_id INT,
    @cantidad INT,
    @tipo VARCHAR(50),
    @fecha DATETIME,
    @local_id INT
AS
BEGIN
    INSERT INTO Movimientos (producto_id, cantidad, tipo, fecha, local_id) VALUES (@producto_id, @cantidad, @tipo, @fecha, @local_id);
END
GO

-- 2. Obtener todos los movimientos
CREATE PROCEDURE sp_ObtenerMovimientos
AS
BEGIN
    SELECT * FROM Movimientos;
END
GO

-- 3. Obtener movimientos por producto
CREATE PROCEDURE sp_ObtenerMovimientosPorProducto
    @producto_id INT
AS
BEGIN
    SELECT * FROM Movimientos WHERE producto_id = @producto_id;
END
GO

-- 4. Obtener movimientos por local
CREATE PROCEDURE sp_ObtenerMovimientosPorLocal
    @local_id INT
AS
BEGIN
    SELECT * FROM Movimientos WHERE local_id = @local_id;
END
GO

-- 5. Obtener movimientos por tipo
CREATE PROCEDURE sp_ObtenerMovimientosPorTipo
    @tipo VARCHAR(50)
AS
BEGIN
    SELECT * FROM Movimientos WHERE tipo = @tipo;
END
GO

-- 6. Obtener movimientos en un rango de fechas
CREATE PROCEDURE sp_ObtenerMovimientosPorFecha
    @inicio DATETIME,
    @fin DATETIME
AS
BEGIN
    SELECT * FROM Movimientos WHERE fecha BETWEEN @inicio AND @fin;
END
GO

-- 7. Contar movimientos por producto
CREATE PROCEDURE sp_ContarMovimientosPorProducto
    @producto_id INT
AS
BEGIN
    SELECT COUNT(*) AS total FROM Movimientos WHERE producto_id = @producto_id;
END
GO

-- 8. Listar productos con más movimientos
CREATE PROCEDURE sp_ListarProductosConMasMovimientos
AS
BEGIN
    SELECT producto_id, COUNT(*) AS total_movimientos
    FROM Movimientos
    GROUP BY producto_id
    ORDER BY total_movimientos DESC;
END
GO

-- 9. Listar movimientos recientes
CREATE PROCEDURE sp_ListarMovimientosRecientes
AS
BEGIN
    SELECT * FROM Movimientos WHERE fecha > DATEADD(DAY, -7, GETDATE());
END
GO

-- 10. Eliminar movimiento por ID
CREATE PROCEDURE sp_EliminarMovimiento
    @id INT
AS
BEGIN
    DELETE FROM Movimientos WHERE id = @id;
END
GO

-- 11. Actualizar cantidad de un movimiento
CREATE PROCEDURE sp_ActualizarCantidadMovimiento
    @id INT,
    @cantidad INT
AS
BEGIN
    UPDATE Movimientos SET cantidad = @cantidad WHERE id = @id;
END
GO

-- 12. Listar movimientos por usuario (si aplica)
CREATE PROCEDURE sp_ObtenerMovimientosPorUsuario
    @usuario_id INT
AS
BEGIN
    SELECT * FROM Movimientos WHERE usuario_id = @usuario_id;
END
GO

-- 13. Listar movimientos de entrada
CREATE PROCEDURE sp_ListarMovimientosEntrada
AS
BEGIN
    SELECT * FROM Movimientos WHERE tipo = 'entrada';
END
GO

-- 14. Listar movimientos de salida
CREATE PROCEDURE sp_ListarMovimientosSalida
AS
BEGIN
    SELECT * FROM Movimientos WHERE tipo = 'salida';
END
GO

-- 15. Obtener último movimiento de un producto
CREATE PROCEDURE sp_ObtenerUltimoMovimientoProducto
    @producto_id INT
AS
BEGIN
    SELECT TOP 1 * FROM Movimientos WHERE producto_id = @producto_id ORDER BY fecha DESC;
END
GO
