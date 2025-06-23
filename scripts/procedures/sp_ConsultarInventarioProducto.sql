-- 19. Consultar inventario actual de un producto
CREATE PROCEDURE sp_ConsultarInventarioProducto
  @id_producto INT
AS
BEGIN
  SELECT p.id_producto, p.nombre, p.stock, m.nombre_medicion, m.abreviatura
  FROM Producto p
  INNER JOIN Medicion m ON p.id_medicion = m.id_medicion
  WHERE p.id_producto = @id_producto;
END;
