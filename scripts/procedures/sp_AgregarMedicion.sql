-- 2. Agregar nueva medición
CREATE PROCEDURE sp_AgregarMedicion
  @nombre_medicion NVARCHAR(25),
  @abreviatura NVARCHAR(10)
AS
BEGIN
  INSERT INTO Medicion (nombre_medicion, abreviatura) VALUES (@nombre_medicion, @abreviatura);
END;