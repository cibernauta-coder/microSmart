CREATE TABLE [Locales] (
  [id_Local] int PRIMARY KEY,
  [nombreLocal] nvarchar(25),
  [direccion] nvarchar(40),
  [id_Horario] int
)
GO

CREATE TABLE [Horarios] (
  [id_Horario] int PRIMARY KEY,
  [diaSemana] nvarchar(25),
  [horarioAbierto] time,
  [horarioCerrado] time
)
GO

CREATE TABLE [Productos] (
  [id_Producto] int PRIMARY KEY,
  [id_Local] int,
  [id_Categoria] int,
  [nombreProducto] nvarchar(30),
  [descripcionProducto] text,
  [precioProducto] decimal(10,2),
  [stockActual] float,
  [id_Medicion] int,
  [activoProducto] bit
)
GO

CREATE TABLE [Categorias] (
  [id_Categoria] int PRIMARY KEY,
  [nombreCategoria] nvarchar(25)
)
GO

CREATE TABLE [Mediciones] (
  [id_Medicion] int PRIMARY KEY,
  [nombreMedicion] nvarchar(25),
  [abreviaturaMedicion] nvarchar(10)
)
GO

CREATE TABLE [RegistroInventarios] (
  [id_RegInv] int PRIMARY KEY,
  [id_Productos] int,
  [fechaMovimiento] datetime,
  [id_TipoMov] int,
  [cantidadAfectada] float,
  [id_Medicion] int,
  [razonMovimiento] text
)
GO

CREATE TABLE [TiposMovimientos] (
  [id_TipoMov] int PRIMARY KEY,
  [tipoMovimiento] nvarchar(20)
)
GO

CREATE TABLE [Tickets] (
  [id_Ticket] int PRIMARY KEY,
  [id_Local] int,
  [id_MetodoPago] int,
  [id_Estatus] int,
  [fechaVenta] datetime,
  [totalVenta] float
)
GO

CREATE TABLE [Ventas] (
  [id_Venta] int PRIMARY KEY,
  [id_Ticket] int,
  [id_Producto] int,
  [cantidadVendida] float,
  [precioUnitario] float,
  [id_Medicion] int,
  [subtotal] decimal(10,2)
)
GO

CREATE TABLE [EstadosVentas] (
  [id_EstadoVenta] int PRIMARY KEY,
  [estatus] nvarchar(20)
)
GO

CREATE TABLE [MetodosPagos] (
  [id_MetodoPago] int PRIMARY KEY,
  [tipoPago] nvarchar(20)
)
GO

ALTER TABLE [Locales] ADD FOREIGN KEY ([id_Horario]) REFERENCES [Horarios] ([id_Horario])
GO

ALTER TABLE [Productos] ADD FOREIGN KEY ([id_Local]) REFERENCES [Locales] ([id_Local])
GO

ALTER TABLE [Productos] ADD FOREIGN KEY ([id_Categoria]) REFERENCES [Categorias] ([id_Categoria])
GO

ALTER TABLE [Productos] ADD FOREIGN KEY ([id_Medicion]) REFERENCES [Mediciones] ([id_Medicion])
GO

ALTER TABLE [RegistroInventarios] ADD FOREIGN KEY ([id_Productos]) REFERENCES [Productos] ([id_Producto])
GO

ALTER TABLE [RegistroInventarios] ADD FOREIGN KEY ([id_TipoMov]) REFERENCES [TiposMovimientos] ([id_TipoMov])
GO

ALTER TABLE [RegistroInventarios] ADD FOREIGN KEY ([id_Medicion]) REFERENCES [Mediciones] ([id_Medicion])
GO

ALTER TABLE [Tickets] ADD FOREIGN KEY ([id_Local]) REFERENCES [Locales] ([id_Local])
GO

ALTER TABLE [Tickets] ADD FOREIGN KEY ([id_MetodoPago]) REFERENCES [MetodosPagos] ([id_MetodoPago])
GO

ALTER TABLE [Tickets] ADD FOREIGN KEY ([id_Estatus]) REFERENCES [EstadosVentas] ([id_EstadoVenta])
GO

ALTER TABLE [Ventas] ADD FOREIGN KEY ([id_Ticket]) REFERENCES [Tickets] ([id_Ticket])
GO

ALTER TABLE [Ventas] ADD FOREIGN KEY ([id_Producto]) REFERENCES [Productos] ([id_Producto])
GO

ALTER TABLE [Ventas] ADD FOREIGN KEY ([id_Medicion]) REFERENCES [Mediciones] ([id_Medicion])
GO
