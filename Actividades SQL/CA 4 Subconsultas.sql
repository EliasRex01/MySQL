-- todos los tipos de articulos que tengan un codigo con un articulo
select * from tipos_articulos
where codigo_tipo in (select codigo_tipo from articulos);

-- actualizar stock


