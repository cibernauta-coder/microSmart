-- 7. Agregar nuevo local
CREATE PROCEDURE sp_AgregarLocal
  @nombre NVARCHAR(25), @id_direccion INT
AS
BEGIN
  INSERT INTO Local (nombre, id_direccion) VALUES (@nombre, @id_direccion);
END;