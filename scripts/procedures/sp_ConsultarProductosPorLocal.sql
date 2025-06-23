-- 18. Consultar productos por local
CREATE PROCEDURE sp_ConsultarProductosPorLocal
  @id_local INT
AS
BEGIN
  SELECT p.id_producto, p.nombre, p.descripcion, p.precio, p.stock, p.id_medicion, p.activo_producto
  FROM Producto p
  INNER JOIN ProductoLocal pl ON p.id_producto = pl.id_producto
  WHERE pl.id_local = @id_local;
END;