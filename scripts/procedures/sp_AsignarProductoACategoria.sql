-- 10. Asignar producto a categoría
CREATE PROCEDURE sp_AsignarProductoACategoria
  @id_producto INT, @id_categoria INT
AS
BEGIN
  IF NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @id_producto AND id_categoria = @id_categoria)
    INSERT INTO ProductoCategoria (id_producto, id_categoria) VALUES (@id_producto, @id_categoria);
END;