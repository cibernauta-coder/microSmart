-- 5. Actualizar información de producto
CREATE PROCEDURE sp_ActualizarProducto
  @id_producto INT, @nombre NVARCHAR(30), @descripcion TEXT, @precio DECIMAL(10,2), @stock FLOAT, @id_medicion INT, @activo_producto BIT
AS
BEGIN
  UPDATE Producto SET nombre = @nombre, descripcion = @descripcion, precio = @precio, stock = @stock, id_medicion = @id_medicion, activo_producto = @activo_producto
  WHERE id_producto = @id_producto;
END;