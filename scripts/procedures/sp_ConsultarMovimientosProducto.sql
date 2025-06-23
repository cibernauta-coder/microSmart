-- 12. Consultar historial de movimientos de un producto
CREATE PROCEDURE sp_ConsultarMovimientosProducto
  @id_producto INT
AS
BEGIN
  SELECT * FROM MovimientoInventario WHERE id_producto = @id_producto ORDER BY fecha_movimiento DESC;
END;