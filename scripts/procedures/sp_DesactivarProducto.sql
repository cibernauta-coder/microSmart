-- 6. Desactivar producto
CREATE PROCEDURE sp_DesactivarProducto
  @id_producto INT
AS
BEGIN
  UPDATE Producto SET activo_producto = 0 WHERE id_producto = @id_producto;
END;
