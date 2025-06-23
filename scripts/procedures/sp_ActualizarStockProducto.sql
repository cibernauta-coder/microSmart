-- 16. Actualizar stock de producto
CREATE PROCEDURE sp_ActualizarStockProducto
  @id_producto INT, @nuevo_stock FLOAT
AS
BEGIN
  UPDATE Producto SET stock = @nuevo_stock WHERE id_producto = @id_producto;
END;