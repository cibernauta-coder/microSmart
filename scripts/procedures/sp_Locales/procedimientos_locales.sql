-- Procedimientos para la gestión de locales (SQL Server)

-- 1. Crear un nuevo local
CREATE PROCEDURE sp_CrearLocal
    @nombre VARCHAR(100),
    @direccion VARCHAR(255)
AS
BEGIN
    INSERT INTO Locales (nombre, direccion, activo) VALUES (@nombre, @direccion, 1);
END
GO

-- 2. Obtener todos los locales activos
CREATE PROCEDURE sp_ObtenerLocalesActivos
AS
BEGIN
    SELECT * FROM Locales WHERE activo = 1;
END
GO

-- 3. Obtener local por ID
CREATE PROCEDURE sp_ObtenerLocalPorID
    @id INT
AS
BEGIN
    SELECT * FROM Locales WHERE id = @id;
END
GO

-- 4. Actualizar datos de un local
CREATE PROCEDURE sp_ActualizarLocal
    @id INT,
    @nombre VARCHAR(100),
    @direccion VARCHAR(255)
AS
BEGIN
    UPDATE Locales SET nombre = @nombre, direccion = @direccion WHERE id = @id;
END
GO

-- 5. Desactivar (eliminar lógico) un local
CREATE PROCEDURE sp_DesactivarLocal
    @id INT
AS
BEGIN
    UPDATE Locales SET activo = 0 WHERE id = @id;
END
GO

-- 6. Reactivar un local
CREATE PROCEDURE sp_ReactivarLocal
    @id INT
AS
BEGIN
    UPDATE Locales SET activo = 1 WHERE id = @id;
END
GO

-- 7. Buscar locales por nombre
CREATE PROCEDURE sp_BuscarLocalesPorNombre
    @nombre VARCHAR(100)
AS
BEGIN
    SELECT * FROM Locales WHERE nombre LIKE '%' + @nombre + '%' AND activo = 1;
END
GO

-- 8. Contar locales activos
CREATE PROCEDURE sp_ContarLocalesActivos
AS
BEGIN
    SELECT COUNT(*) AS total FROM Locales WHERE activo = 1;
END
GO

-- 9. Listar locales con productos asignados
CREATE PROCEDURE sp_ListarLocalesConProductos
AS
BEGIN
    SELECT l.id, l.nombre, COUNT(pl.producto_id) AS productos_asignados
    FROM Locales l
    LEFT JOIN ProductosLocales pl ON l.id = pl.local_id
    WHERE l.activo = 1
    GROUP BY l.id, l.nombre;
END
GO

-- 10. Listar locales sin productos asignados
CREATE PROCEDURE sp_ListarLocalesSinProductos
AS
BEGIN
    SELECT l.* FROM Locales l
    LEFT JOIN ProductosLocales pl ON l.id = pl.local_id
    WHERE pl.producto_id IS NULL AND l.activo = 1;
END
GO

-- 11. Obtener dirección de un local
CREATE PROCEDURE sp_ObtenerDireccionLocal
    @id INT
AS
BEGIN
    SELECT direccion FROM Locales WHERE id = @id;
END
GO

-- 12. Actualizar solo la dirección de un local
CREATE PROCEDURE sp_ActualizarDireccionLocal
    @id INT,
    @direccion VARCHAR(255)
AS
BEGIN
    UPDATE Locales SET direccion = @direccion WHERE id = @id;
END
GO

-- 13. Listar locales y cantidad de ventas
CREATE PROCEDURE sp_ListarLocalesConVentas
AS
BEGIN
    SELECT l.id, l.nombre, COUNT(v.id) AS total_ventas
    FROM Locales l
    LEFT JOIN Ventas v ON l.id = v.local_id
    WHERE l.activo = 1
    GROUP BY l.id, l.nombre;
END
GO

-- 14. Listar locales con más de X productos
CREATE PROCEDURE sp_ListarLocalesConMasDeXProductos
    @cantidad INT
AS
BEGIN
    SELECT l.id, l.nombre, COUNT(pl.producto_id) AS productos_asignados
    FROM Locales l
    JOIN ProductosLocales pl ON l.id = pl.local_id
    WHERE l.activo = 1
    GROUP BY l.id, l.nombre
    HAVING COUNT(pl.producto_id) > @cantidad;
END
GO

-- 15. Listar locales y su último movimiento de producto
CREATE PROCEDURE sp_ListarLocalesUltimoMovimiento
AS
BEGIN
    SELECT l.id, l.nombre, MAX(m.fecha) AS ultimo_movimiento
    FROM Locales l
    JOIN ProductosLocales pl ON l.id = pl.local_id
    JOIN Movimientos m ON pl.producto_id = m.producto_id
    WHERE l.activo = 1
    GROUP BY l.id, l.nombre;
END
GO
