-- contar los articulos por cada tipo, por sucursal, mostrar el codigo del articulo
-- la descripcion del tipo de articulo, el codigo sucursal y el nombre de la ciudad
SELECT COUNT(*), a.codigo_articulo, ta.descripciom_tipo,
a.codigo_sucursal     -- se podria quitar el codigo_articulo para mostrar por grupos
FROM articulos a JOIN tipo_articulos ta
ON a.codigo_tipo = ta.codigo_tipo
JOIN articulos_sucursal asu
ON a.codigo_articulo = asu.codigo_articulo
JOIN sucursales s
ON asu.codigo_sucursal = s.codigo_sucursal
JOIN ciudades c
ON s.codigo_sucursal = c.codigo_sucursal
GROUP BY a.codigo_articulo, ta.descripcion_tipo, 
  s.codigo_sucursal, c.nombre_ciudad
ORDER BY c.nombre_ciudad;

-- crear tabla en base a consulta (tabla auxiliar o tabla temporal)
-- solo existe durante la sesion abierta (en el bufer)
CREATE TEMP TABLE tabla1 AS
(SELECT COUNT(*), a.codigo_articulo, ta.descripciom_tipo,
a.codigo_sucursal     -- se podria quitar el codigo_articulo para mostrar por grupos
FROM articulos a JOIN tipo_articulos ta
ON a.codigo_tipo = ta.codigo_tipo
JOIN articulos_sucursal asu
ON a.codigo_articulo = asu.codigo_articulo
JOIN sucursales s
ON asu.codigo_sucursal = s.codigo_sucursal
JOIN ciudades c
ON s.codigo_sucursal = c.codigo_sucursal
GROUP BY a.codigo_articulo, ta.descripcion_tipo, 
  s.codigo_sucursal, c.nombre_ciudad
ORDER BY c.nombre_ciudad);

-- consultar tabla auxiliar
SELECT * FROM tabla1;

-- crear normal es solo CREATE TABLE tabla1 AS (no temporal)

-- creacion de la vista
CREATE VIEW vista1 AS
(SELECT COUNT(*), a.codigo_articulo, ta.descripciom_tipo,
a.codigo_sucursal     -- se podria quitar el codigo_articulo para mostrar por grupos
FROM articulos a JOIN tipo_articulos ta
ON a.codigo_tipo = ta.codigo_tipo
JOIN articulos_sucursal asu
ON a.codigo_articulo = asu.codigo_articulo
JOIN sucursales s
ON asu.codigo_sucursal = s.codigo_sucursal
JOIN ciudades c
ON s.codigo_sucursal = c.codigo_sucursal
GROUP BY a.codigo_articulo, ta.descripcion_tipo, 
  s.codigo_sucursal, c.nombre_ciudad
ORDER BY c.nombre_ciudad);

-- consultar la vista
SELECT * FROM vista1;
