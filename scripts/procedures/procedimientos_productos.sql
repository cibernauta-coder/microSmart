-- Procedimientos para la gestión de productos (SQL Server)

-- 1. Crear producto
CREATE PROCEDURE sp_CrearProducto
    @nombre VARCHAR(100),
    @precio DECIMAL(10,2),
    @stock INT,
    @etiqueta VARCHAR(50)
AS
BEGIN
    INSERT INTO Productos (nombre, precio, stock, etiqueta, activo) VALUES (@nombre, @precio, @stock, @etiqueta, 1);
END
GO

-- 2. Obtener todos los productos activos
CREATE PROCEDURE sp_ObtenerProductosActivos
AS
BEGIN
    SELECT * FROM Productos WHERE activo = 1;
END
GO

-- 3. Obtener producto por ID
CREATE PROCEDURE sp_ObtenerProductoPorID
    @id INT
AS
BEGIN
    SELECT * FROM Productos WHERE id = @id;
END
GO

-- 4. Actualizar producto
CREATE PROCEDURE sp_ActualizarProducto
    @id INT,
    @nombre VARCHAR(100),
    @precio DECIMAL(10,2),
    @stock INT,
    @etiqueta VARCHAR(50)
AS
BEGIN
    UPDATE Productos SET nombre = @nombre, precio = @precio, stock = @stock, etiqueta = @etiqueta WHERE id = @id;
END
GO

-- 5. Desactivar producto
CREATE PROCEDURE sp_DesactivarProducto
    @id INT
AS
BEGIN
    UPDATE Productos SET activo = 0 WHERE id = @id;
END
GO

-- 6. Reactivar producto
CREATE PROCEDURE sp_ReactivarProducto
    @id INT
AS
BEGIN
    UPDATE Productos SET activo = 1 WHERE id = @id;
END
GO

-- 7. Buscar productos por nombre
CREATE PROCEDURE sp_BuscarProductosPorNombre
    @nombre VARCHAR(100)
AS
BEGIN
    SELECT * FROM Productos WHERE nombre LIKE '%' + @nombre + '%' AND activo = 1;
END
GO

-- 8. Actualizar solo el stock
CREATE PROCEDURE sp_ActualizarStockProducto
    @id INT,
    @stock INT
AS
BEGIN
    UPDATE Productos SET stock = @stock WHERE id = @id;
END
GO

-- 9. Listar productos con stock bajo
CREATE PROCEDURE sp_ListarProductosStockBajo
    @minimo INT
AS
BEGIN
    SELECT * FROM Productos WHERE stock < @minimo AND activo = 1;
END
GO

-- 10. Listar productos por etiqueta
CREATE PROCEDURE sp_ListarProductosPorEtiqueta
    @etiqueta VARCHAR(50)
AS
BEGIN
    SELECT * FROM Productos WHERE etiqueta = @etiqueta AND activo = 1;
END
GO

-- 11. Listar productos asignados a un local
CREATE PROCEDURE sp_ListarProductosPorLocal
    @local_id INT
AS
BEGIN
    SELECT p.* FROM Productos p
    JOIN ProductosLocales pl ON p.id = pl.producto_id
    WHERE pl.local_id = @local_id AND p.activo = 1;
END
GO

-- 12. Listar productos sin movimientos recientes
CREATE PROCEDURE sp_ListarProductosSinMovimientosRecientes
AS
BEGIN
    SELECT p.* FROM Productos p
    LEFT JOIN Movimientos m ON p.id = m.producto_id AND m.fecha > DATEADD(DAY, -30, GETDATE())
    WHERE m.id IS NULL AND p.activo = 1;
END
GO

-- 13. Listar productos más vendidos
CREATE PROCEDURE sp_ListarProductosMasVendidos
AS
BEGIN
    SELECT p.id, p.nombre, SUM(vp.cantidad) AS cantidad_vendida
    FROM Productos p
    JOIN VentasProductos vp ON p.id = vp.producto_id
    GROUP BY p.id, p.nombre
    ORDER BY cantidad_vendida DESC;
END
GO

-- 14. Listar productos y su último movimiento
CREATE PROCEDURE sp_ListarProductosUltimoMovimiento
AS
BEGIN
    SELECT p.id, p.nombre, MAX(m.fecha) AS ultimo_movimiento
    FROM Productos p
    JOIN Movimientos m ON p.id = m.producto_id
    GROUP BY p.id, p.nombre;
END
GO

-- 15. Contar productos activos
CREATE PROCEDURE sp_ContarProductosActivos
AS
BEGIN
    SELECT COUNT(*) AS total FROM Productos WHERE activo = 1;
END
GO
