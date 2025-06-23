-- 3. Agregar nuevo método de pago
CREATE PROCEDURE sp_AgregarMetodoPago
  @nombre_tipo NVARCHAR(20)
AS
BEGIN
  INSERT INTO MetodoPago (nombre_tipo) VALUES (@nombre_tipo);
END;