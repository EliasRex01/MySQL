-- Como funcionan los Trigrers
-- Entre otras cosas permiten monitorear cada vez que se inserte, actualice o elimine,
-- monitorear qué usuario lo hizo ya, a qué hora lo hizo y qué tipo de acción 
-- realizó en ese momento.



use bd1;
desc tb_categorias;
insert into tb_categorias (descripcion_ca, estado)
values 
('prueba2', 1);

select * from tb_categorias;

-- quien inserto el registro, la fecha, de cada caegoria, despues que se inserte
-- after insert


select current_user();      -- que usuario esta en uso
select user();            -- de otra forma
-- al consultar la tabla de auditoria registrara los campos creados con el trigger

-- triger de tb_unidades_medidas
insert into tb_unidades_medidas (descripcion_um, estado)
values ('prueba',1);


-- haciendo update para probar
-- insert into tb_auditorias(nombre_tabla,usuario_accion,fecha_accion,accion)
--    values('tb_categorias',user(),now(),'INSERTADO DE REGISTRO');
-- ese es el codigo de after insert, after update y after delete del trigger

-- update de ejemplo
update tb_categorias set descripcion_ca = 'categoria 2023' where codigo_ca=3;

-- detele de ejemplo
delete from tb_categorias where codigo_ca=3;
-- se mira el monitoreo con el select sobre la tabla auditoria