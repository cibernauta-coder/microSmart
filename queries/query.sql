-- 1. Listar todos los productos
SELECT * FROM Producto;

-- 2. Listar todas las categorías
SELECT * FROM Categoria;

-- 3. Listar todos los locales
SELECT * FROM Local;

-- 4. Listar todos los métodos de pago
SELECT * FROM MetodoPago;

-- 5. Listar todos los movimientos de inventario
SELECT * FROM MovimientoInventario;

-- 6. Listar todos los tickets
SELECT * FROM Ticket;

-- 7. Listar todos los productos activos
SELECT * FROM Producto WHERE activo_producto = 1;

-- 8. Listar productos con stock menor a 100
SELECT * FROM Producto WHERE stock < 100;

-- 9. Listar productos por nombre que contenga 'a'
SELECT * FROM Producto WHERE nombre LIKE '%a%';

-- 10. Listar ventas realizadas (estado realizado)
SELECT * FROM Ticket WHERE id_estado_venta = 2;

-- 11. Listar productos ordenados por precio descendente
SELECT * FROM Producto ORDER BY precio DESC;

-- 12. Listar categorías ordenadas alfabéticamente
SELECT * FROM Categoria ORDER BY nombre_categoria ASC;

-- 13. Listar los 5 productos con mayor stock
SELECT TOP 5 * FROM Producto ORDER BY stock DESC;

-- 14. Listar los 5 productos con menor stock
SELECT TOP 5 * FROM Producto ORDER BY stock ASC;

-- 15. Listar todos los horarios de un local específico
SELECT * FROM Horario WHERE id_local = 1;