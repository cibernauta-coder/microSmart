# Documentación del Proyecto microSmart

## Tablas principales

### Local
- **Campos:** id_local, nombre, id_direccion
- **Propósito:** Almacena los locales físicos o virtuales donde se gestionan productos y ventas.

### Direccion
- **Campos:** id_direccion, num_casa_ext, num_casa_int, nombre_casa, id_cp
- **Propósito:** Almacena la información de direcciones asociadas a locales.

### CP
- **Campos:** id_cp, colonia, delegacion, estado
- **Propósito:** Catálogo de códigos postales y zonas de la CDMX y alrededores.

### Horario
- **Campos:** id_horario, id_local, horario_abierto, horario_cerrado
- **Propósito:** Horarios de apertura y cierre de cada local.

### Producto
- **Campos:** id_producto, nombre, descripcion, precio, stock, id_medicion, activo_producto
- **Propósito:** Almacena los productos disponibles para la venta y su información relevante.

### Medicion
- **Campos:** id_medicion, nombre_medicion, abreviatura
- **Propósito:** Catálogo de unidades de medida para productos (kg, litro, pieza, etc.).

### ProductoLocal
- **Campos:** id_producto, id_local
- **Propósito:** Relaciona productos con locales donde están disponibles.

### Categoria
- **Campos:** id_categoria, nombre_categoria
- **Propósito:** Catálogo de categorías para clasificar productos.

### ProductoCategoria
- **Campos:** id_producto, id_categoria
- **Propósito:** Relaciona productos con sus categorías.

### Inventario
- **Campos:** id_inventario, fecha_creacion
- **Propósito:** Almacena los inventarios creados para control de existencias.

### MovimientoInventario
- **Campos:** id_movimiento, id_inventario, id_producto, fecha_movimiento, id_tipo_mov, cantidad_afectada, razon_movimiento
- **Propósito:** Registra los movimientos de inventario (entradas, salidas, transferencias) de productos.

### TipoMovimiento
- **Campos:** id_tipo_mov, nombre_tipo
- **Propósito:** Catálogo de tipos de movimiento de inventario (Importado, Exportado, etc.).

### MetodoPago
- **Campos:** id_metodo_pago, nombre_tipo
- **Propósito:** Catálogo de métodos de pago aceptados (efectivo, tarjeta, transferencia, etc.).

### EstadoVenta
- **Campos:** id_estado_venta, nombre_estado
- **Propósito:** Catálogo de estados de una venta (Completado, Cancelado, Pendiente).

### Ticket
- **Campos:** id_ticket, id_local, id_metodo_pago, id_estado_venta, fecha_venta, total_venta
- **Propósito:** Almacena los tickets generados por cada venta.

### Venta
- **Campos:** id_venta, id_ticket, subtotal
- **Propósito:** Almacena las ventas realizadas, asociadas a un ticket.

### VentaProducto
- **Campos:** id_venta, id_producto, cantidad_vendida, precio_unitario, id_medicion
- **Propósito:** Relaciona ventas con los productos vendidos y la cantidad de cada uno.

---

## Inserts por defecto

- **CP:** Incluye 10 códigos postales de Iztacalco y zonas colindantes.
- **TipoMovimiento:** 'Importado', 'Exportado'.
- **EstadoVenta:** 'Completado', 'Cancelado', 'Pendiente'.
- **Medicion:** 6 tipos comunes (Kilogramo, Litro, Pieza, Metro, Caja, Paquete).
- **MetodoPago:** Métodos más usados en México (Efectivo, Tarjeta de Débito, Tarjeta de Crédito, Transferencia, Pago con QR, Vales, Mercado Pago).

---

## Procedimientos almacenados

Cada entidad cuenta con procedimientos para:
- Crear, leer, actualizar y eliminar (lógico) registros
- Búsquedas avanzadas (por nombre, etiqueta, stock, etc.)
- Reportes y listados (productos más vendidos, locales con más ventas, etc.)
- Operaciones específicas (asignaciones, movimientos, etc.)

Los procedimientos están organizados en la carpeta `scripts/procedures` en subcarpetas por entidad.

Ejemplo de nombres:
- `sp_CrearLocal`, `sp_ObtenerLocalesActivos`, `sp_ActualizarProducto`, `sp_ListarMovimientosPorTipo`, `sp_RegistrarVenta`, etc.

Cada procedimiento incluye comentarios y parámetros claros para su uso.

---

## Consultas SQL

Las consultas están organizadas en la carpeta `scripts/queries` en subcarpetas por entidad.

Incluyen:
- Consultas simples (listados, búsquedas, conteos)
- Consultas multitabla (joins entre locales, productos, movimientos, ventas, etc.)
- Reportes y análisis (productos más vendidos, ventas por mes, stock bajo, etc.)

Ejemplo de consultas:
- Listar productos con stock bajo
- Listar ventas y productos vendidos por local
- Listar movimientos recientes por usuario
- Listar locales y cantidad de productos asignados

Cada archivo contiene al menos 15 consultas por entidad, con comentarios y ejemplos de uso.

---

## Buenas prácticas
- Uso de nombres descriptivos y prefijos `sp_` para procedimientos
- Eliminación lógica con campo `activo` en vez de borrado físico
- Parámetros bien definidos y uso de transacciones donde aplique
- Comentarios en cada procedimiento y consulta para facilitar el mantenimiento
- Separación de lógica de negocio en procedimientos y reportes en consultas

---

Para más detalles, revisa los archivos `.sql` en las carpetas correspondientes.
