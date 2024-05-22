-- Aumentar 10% todos los precios
UPDATE articulos SET preciounitario = (preciounitario * 1.1)
WHERE codigo_articulo = '31761292'

-- insertar valores en pedidos_articulos
INSERT INTO pedidos_articulos:
  factura, codigo_articulo, precio_venta, cantidad,
  anho, numero_pedido;
  VALUES ( 1, 100, '31701202', 90000, 1, 2021);
-- el codigo_detalle no se ingresa por que es autoincremental

-- COMO BORRAR UN DATO SI ES NECESARIO
-- primero los datos relacionados
DELETE FROM pedidos_articulos WHERE anho = 2017 AND codigo_pedido = 7700;

-- segundo el pedido
DELETE FROM pedidos WHERE ruc = 2483687;

-- tercero el cliente
DELETE FROM clientes WHERE ruc = 2483687;


-- total ventas por anho
SELECT anho, SUM(total) AS totalvendido FROM pedidos
GROUP BY anho
ORDER BY totalvedido DESC;

-- todos los clientes aun los que no compraron nada, con la sumatoria de los
-- clientes que si compraron todo
SELECT c.ruc, c.nombre, SUM(p.total) totalcliente
FROM clientes c LEFT JOIN pedidos p ON p.ruc = c.ruc 
GROUP BY c.ruc, c.nombre
ORDER BY totalcliente DESC;
-- LEFT Join trae todos los valores de la tabla 1 y los que cumplen condicion de la 2

-- los proveedores que proveen mas articulos
SELECT p.desc_proveedor, COUNT(a.*) AS cantidad 
FROM proveedores p JOIN articulos a
ON p.codigo_proveedor = a.codigo_proveedor
GROUP BY p.desc_proveedor
ORDER BY cantidad DESC, p.desc_proveedor;

-- promedio de ventas de cada pedido en 2016
SELECT anho, AVG(total)
FROM pedidos
WHERE anho = 2016   -- si quiero por anho se quita la condicion
GROUP BY anho;

-- total de pedidos
SELECT anho, numero_pedido, SUM(precio_venta*cantidad) AS Total
FROM pedidos_articulos
WHERE anho = 2021 AND numero_pedido = 100
GROUP BY anho, numero_pedido;

-- Crear vista basica
DROP VIEW vProveedoresArticulos;  -- si existe una vista 

CREATE VIEW vProveedoresArticulos AS
SELECT p.codigo_proveedor, p.desc_proveedor, COUNT(a.*) AS cantidad 
FROM proveedores p JOIN articulos a
ON p.codigo_proveedor = a.codigo_proveedor
GROUP BY p.codigo_proveedor, p.desc_proveedor
ORDER BY cantidad DESC, p.desc_proveedor;

-- consultar la vista y usarla en un join con otras tablas
SELECT v.*, p.direcc_proveedor as direcciones     -- v.* es todo lo que tenga la vista 
FROM vProveedoresArticulos v 
JOIN proveedores p
ON v.codigo_proveedor = p.codigo_proveedor
-- GROUP BY v.codigo_proveedor
-- ORDER BY cantidad DESC, p.desc_proveedor;
