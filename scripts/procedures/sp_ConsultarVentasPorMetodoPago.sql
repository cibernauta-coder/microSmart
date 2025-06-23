-- 20. Consultar ventas por método de pago
CREATE PROCEDURE sp_ConsultarVentasPorMetodoPago
  @id_metodo_pago INT
AS
BEGIN
  SELECT t.id_ticket, t.fecha_venta, t.total_venta, mp.nombre_tipo AS metodo_pago
  FROM Ticket t
  INNER JOIN MetodoPago mp ON t.id_metodo_pago = mp.id_metodo_pago
  WHERE t.id_metodo_pago = @id_metodo_pago;
END;