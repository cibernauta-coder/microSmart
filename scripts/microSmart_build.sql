-- Para el Sistema
CREATE TABLE CP (
  id_cp char(5) PRIMARY KEY,
  colonia nvarchar(50),
  delegacion nvarchar(50),
  estado nvarchar(50)
);

CREATE TABLE TipoMovimiento (
  id_tipo_mov int PRIMARY KEY,
  nombre_tipo nvarchar(20)
);

CREATE TABLE EstadoVenta (
  id_estado_venta int PRIMARY KEY,
  nombre_estado nvarchar(20)
);

CREATE TABLE Medicion (
  id_medicion int PRIMARY KEY,
  nombre_medicion nvarchar(25),
  abreviatura nvarchar(10)
);
ALTER TABLE Producto ADD CONSTRAINT FK_Producto_Medicion FOREIGN KEY (id_medicion) REFERENCES Medicion(id_medicion);

CREATE TABLE ProductoCategoria (
  id_producto int,
  id_categoria int,
  PRIMARY KEY (id_producto, id_categoria)
);
ALTER TABLE ProductoCategoria ADD CONSTRAINT FK_ProductoCategoria_Producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto);
ALTER TABLE ProductoCategoria ADD CONSTRAINT FK_ProductoCategoria_Categoria FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria);

CREATE TABLE MetodoPago (
  id_metodo_pago int PRIMARY KEY,
  nombre_tipo nvarchar(20)
);

-- Para el Local
CREATE TABLE Local (
  id_local int PRIMARY KEY,
  nombre nvarchar(25),
  id_direccion int
);

CREATE TABLE Direccion (
  id_direccion int PRIMARY KEY,
  num_casa_ext int,
  num_casa_int int,
  nombre_casa nvarchar(25),
  id_cp char(5)
);

ALTER TABLE Local ADD CONSTRAINT FK_Local_Direccion FOREIGN KEY (id_direccion) REFERENCES Direccion(id_direccion);
ALTER TABLE Direccion ADD CONSTRAINT FK_Direccion_CP FOREIGN KEY (id_cp) REFERENCES CP(id_cp);

CREATE TABLE Horario (
  id_horario int PRIMARY KEY,
  id_local int,
  horario_abierto time,
  horario_cerrado time
);
ALTER TABLE Horario ADD CONSTRAINT FK_Horario_Local FOREIGN KEY (id_local) REFERENCES Local(id_local);

-- Para el Almacen
CREATE TABLE Inventario (
  id_inventario int PRIMARY KEY,
  fecha_creacion datetime
);

CREATE TABLE Producto (
  id_producto int PRIMARY KEY,
  nombre nvarchar(30),
  descripcion text,
  precio decimal(10,2),
  stock float,
  id_medicion int,
  activo_producto bit
);

CREATE TABLE ProductoLocal (
  id_producto int,
  id_local int,
  PRIMARY KEY (id_producto, id_local)
);
ALTER TABLE ProductoLocal ADD CONSTRAINT FK_ProductoLocal_Producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto);
ALTER TABLE ProductoLocal ADD CONSTRAINT FK_ProductoLocal_Local FOREIGN KEY (id_local) REFERENCES Local(id_local);

CREATE TABLE Categoria (
  id_categoria int PRIMARY KEY,
  nombre_categoria nvarchar(25)
);

CREATE TABLE MovimientoInventario (
  id_movimiento int PRIMARY KEY,
  id_inventario int,
  id_producto int,
  fecha_movimiento datetime,
  id_tipo_mov int,
  cantidad_afectada float,
  razon_movimiento text
);
ALTER TABLE MovimientoInventario ADD CONSTRAINT FK_MovInv_Inventario FOREIGN KEY (id_inventario) REFERENCES Inventario(id_inventario);
ALTER TABLE MovimientoInventario ADD CONSTRAINT FK_MovInv_Producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto);
ALTER TABLE MovimientoInventario ADD CONSTRAINT FK_MovInv_TipoMov FOREIGN KEY (id_tipo_mov) REFERENCES TipoMovimiento(id_tipo_mov);

-- Para la Venta
CREATE TABLE Ticket (
  id_ticket int PRIMARY KEY,
  id_local int,
  id_metodo_pago int,
  id_estado_venta int,
  fecha_venta datetime,
  total_venta float
);
ALTER TABLE Ticket ADD CONSTRAINT FK_Ticket_Local FOREIGN KEY (id_local) REFERENCES Local(id_local);
ALTER TABLE Ticket ADD CONSTRAINT FK_Ticket_MetodoPago FOREIGN KEY (id_metodo_pago) REFERENCES MetodoPago(id_metodo_pago);
ALTER TABLE Ticket ADD CONSTRAINT FK_Ticket_EstadoVenta FOREIGN KEY (id_estado_venta) REFERENCES EstadoVenta(id_estado_venta);

CREATE TABLE Venta (
  id_venta int PRIMARY KEY,
  id_ticket int,
  subtotal decimal(10,2)
);
ALTER TABLE Venta ADD CONSTRAINT FK_Venta_Ticket FOREIGN KEY (id_ticket) REFERENCES Ticket(id_ticket);

CREATE TABLE VentaProducto (
  id_venta int,
  id_producto int,
  cantidad_vendida float,
  precio_unitario float,
  id_medicion int,
  PRIMARY KEY (id_venta, id_producto)
);
ALTER TABLE VentaProducto ADD CONSTRAINT FK_VentaProducto_Venta FOREIGN KEY (id_venta) REFERENCES Venta(id_venta);
ALTER TABLE VentaProducto ADD CONSTRAINT FK_VentaProducto_Producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto);
ALTER TABLE VentaProducto ADD CONSTRAINT FK_VentaProducto_Medicion FOREIGN KEY (id_medicion) REFERENCES Medicion(id_medicion);