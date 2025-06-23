-- 14. Cancelar venta (actualiza estado y revierte inventario)
CREATE PROCEDURE sp_CancelarVenta
  @id_venta INT
AS
BEGIN
  DECLARE @id_ticket INT;
  SELECT @id_ticket = id_ticket FROM Venta WHERE id_venta = @id_venta;
  UPDATE Ticket SET id_estado_venta = 3 WHERE id_ticket = @id_ticket; -- 3 = Cancelado
  -- Aquí podrías agregar lógica para revertir inventario si lo deseas
END;