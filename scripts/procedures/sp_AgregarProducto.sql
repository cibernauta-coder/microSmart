-- 4. Agregar nuevo producto
CREATE PROCEDURE sp_AgregarProducto
  @nombre NVARCHAR(30), @descripcion TEXT, @precio DECIMAL(10,2), @stock FLOAT, @id_medicion INT, @activo_producto BIT
AS
BEGIN
  INSERT INTO Producto (nombre, descripcion, precio, stock, id_medicion, activo_producto)
  VALUES (@nombre, @descripcion, @precio, @stock, @id_medicion, @activo_producto);
END;