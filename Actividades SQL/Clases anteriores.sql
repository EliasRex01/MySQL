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


