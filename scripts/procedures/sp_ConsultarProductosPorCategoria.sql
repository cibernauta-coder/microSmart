-- 17. Consultar productos por categoría
CREATE PROCEDURE sp_ConsultarProductosPorCategoria
  @id_categoria INT
AS
BEGIN
  SELECT p.id_producto, p.nombre, p.descripcion, p.precio, p.stock, p.id_medicion, p.activo_producto
  FROM Producto p
  INNER JOIN ProductoCategoria pc ON p.id_producto = pc.id_producto
  WHERE pc.id_categoria = @id_categoria;
END;