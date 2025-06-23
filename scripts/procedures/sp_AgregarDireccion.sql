-- 8. Agregar nueva dirección
CREATE PROCEDURE sp_AgregarDireccion
  @num_casa_ext INT, @num_casa_int INT = NULL, @nombre_casa NVARCHAR(25) = NULL, @id_cp CHAR(5)
AS
BEGIN
  INSERT INTO Direccion (num_casa_ext, num_casa_int, nombre_casa, id_cp)
  VALUES (@num_casa_ext, @num_casa_int, @nombre_casa, @id_cp);
END;