-- 15. Consultar ventas por fecha/local
CREATE PROCEDURE sp_ConsultarVentasPorFechaLocal
  @fecha_inicio DATETIME, @fecha_fin DATETIME, @id_local INT
AS
BEGIN
  SELECT t.id_ticket, t.fecha_venta, t.total_venta, v.id_venta, v.subtotal
  FROM Ticket t
  INNER JOIN Venta v ON t.id_ticket = v.id_ticket
  WHERE t.fecha_venta BETWEEN @fecha_inicio AND @fecha_fin
    AND t.id_local = @id_local;
END;