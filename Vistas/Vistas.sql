-- vistas o views

CREATE VIEW nombre_view AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;

-- se crea una vista que es un tipo de objeto en sql

CREATE VIEW Articulos_consolidados AS
SELECT a.codigo_ar,
       a.descripcion_ar,
       a.marca_ar,
       c.descripcion_um,
       b.descripcion_ca,
       a.estado
FROM tb_articulos a
INNER JOIN tb_categorias b ON a.codigo_ca = b.codigo_ca
INNER JOIN tb_unidades_medidas c ON a.codigo_um = c.codigo_um;

-- en lugar de llamar el bloque entero se puede llamar la vista
SELECT * FROM Articulos_consolidados;
