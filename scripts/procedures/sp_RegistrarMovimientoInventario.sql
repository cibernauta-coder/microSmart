-- 11. Registrar movimiento de inventario
CREATE PROCEDURE sp_RegistrarMovimientoInventario
  @id_inventario INT, @id_producto INT, @fecha_movimiento DATETIME, @id_tipo_mov INT, @cantidad_afectada FLOAT, @razon_movimiento TEXT
AS
BEGIN
  INSERT INTO MovimientoInventario (id_inventario, id_producto, fecha_movimiento, id_tipo_mov, cantidad_afectada, razon_movimiento)
  VALUES (@id_inventario, @id_producto, @fecha_movimiento, @id_tipo_mov, @cantidad_afectada, @razon_movimiento);
END;