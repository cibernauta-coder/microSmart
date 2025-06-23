-- 1. Agregar nueva categoría
CREATE PROCEDURE sp_AgregarCategoria
  @nombre_categoria NVARCHAR(25)
AS
BEGIN
  INSERT INTO Categoria (nombre_categoria) VALUES (@nombre_categoria);
END;