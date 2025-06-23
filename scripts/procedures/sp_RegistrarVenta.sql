-- 13. Registrar venta (genera ticket, ventas y venta-producto)
CREATE PROCEDURE sp_RegistrarVenta
  @id_local INT, @id_metodo_pago INT, @id_estado_venta INT, @total_venta FLOAT, @productosVenta TVP_ProductosVenta READONLY
AS
BEGIN
  DECLARE @id_ticket INT;
  INSERT INTO Ticket (id_local, id_metodo_pago, id_estado_venta, fecha_venta, total_venta)
  VALUES (@id_local, @id_metodo_pago, @id_estado_venta, GETDATE(), @total_venta);
  SET @id_ticket = SCOPE_IDENTITY();
  DECLARE @id_venta INT;
  INSERT INTO Venta (id_ticket, subtotal) VALUES (@id_ticket, @total_venta);
  SET @id_venta = SCOPE_IDENTITY();
  INSERT INTO VentaProducto (id_venta, id_producto, cantidad_vendida, precio_unitario, id_medicion)
  SELECT @id_venta, id_producto, cantidad_vendida, precio_unitario, id_medicion FROM @productosVenta;
END;