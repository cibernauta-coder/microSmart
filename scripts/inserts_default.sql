-- CP: Códigos postales de Iztacalco y colindantes
INSERT INTO CP (id_cp, colonia, delegacion, estado) VALUES
('08710', 'Granjas México', 'Iztacalco', 'CDMX'),
('08720', 'Agrícola Oriental', 'Iztacalco', 'CDMX'),
('08800', 'Gabriel Ramos Millán', 'Iztacalco', 'CDMX'),
('08810', 'Infonavit Iztacalco', 'Iztacalco', 'CDMX'),
('08830', 'Viaducto Piedad', 'Iztacalco', 'CDMX'),
('08900', 'Pantitlán', 'Iztacalco', 'CDMX'),
('08100', 'Jardín Balbuena', 'Venustiano Carranza', 'CDMX'),
('09000', 'Moctezuma 2a Sección', 'Venustiano Carranza', 'CDMX'),
('08400', 'Santa Anita', 'Iztacalco', 'CDMX'),
('08970', 'Los Picos', 'Iztacalco', 'CDMX');

-- TipoMovimiento
INSERT INTO TipoMovimiento (id_tipo_mov, nombre_tipo) VALUES
(1, 'Importado'),
(2, 'Exportado');

-- EstadoVenta
INSERT INTO EstadoVenta (id_estado_venta, nombre_estado) VALUES
(1, 'Completado'),
(2, 'Cancelado'),
(3, 'Pendiente');

-- Medicion
INSERT INTO Medicion (id_medicion, nombre_medicion, abreviatura) VALUES
(1, 'Kilogramo', 'kg'),
(2, 'Litro', 'l'),
(3, 'Pieza', 'pz'),
(4, 'Metro', 'm'),
(5, 'Caja', 'cj'),
(6, 'Paquete', 'paq');

-- MetodoPago
INSERT INTO MetodoPago (id_metodo_pago, nombre_tipo) VALUES
(1, 'Efectivo'),
(2, 'Tarjeta de Débito'),
(3, 'Tarjeta de Crédito'),
(4, 'Transferencia'),
(5, 'Pago con QR'),
(6, 'Vales'),
(7, 'Mercado Pago');
