-- vistas o views

create view nombre_view as
select column1, column2, ...
from table_name
where condition;

-- se crea una vista que es un tipo de objeto en sql

create view Articulos_consolidados as
select a.codigo_ar,
	   a.descripcion_ar,
       a.marca_ar,
       c.descripcion_um,
       b.descripcion_ca,
       a.estado
from tb_articulos a
inner join tb_categorias b on a.codigo_ca = b.codigo_ca
inner join tb_unidades_medidas c on a.codigo_um = c.codigo_um;

-- en lugar de llamar el bloque entero se puede llamar la vista
select * from Articulos_consolidados;