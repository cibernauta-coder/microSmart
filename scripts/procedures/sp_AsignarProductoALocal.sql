-- 9. Asignar producto a local
CREATE PROCEDURE sp_AsignarProductoALocal
  @id_producto INT, @id_local INT
AS
BEGIN
  IF NOT EXISTS (SELECT 1 FROM ProductoLocal WHERE id_producto = @id_producto AND id_local = @id_local)
    INSERT INTO ProductoLocal (id_producto, id_local) VALUES (@id_producto, @id_local);
END;