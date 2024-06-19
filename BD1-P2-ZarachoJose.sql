-- Tema 1: Crear una vista SQL llamada vSuperProveedores que contenga el ranking 
-- de los proveedores del estado en la categoría programas computacionales.
-- Incluya el cálculo en dólares teniendo en cuenta una cotización de 7.300. 
-- Demuestre el uso de la vista desplegando los primeros 10 proveedores:
-- campos: ruc, proveedor, total, en US$, Cantidad

-- creacion de la vista
CREATE OR REPLACE VIEW vSuperProveedores AS
select p.id AS ruc, p.descripcion as "Proveedor",
ROUND(SUM(ad.monto)) as "Total", ROUND(SUM(ad.monto) / 7300) as "En US$",
count(ad.id) as "Cantidad"
from adjudicaciones ad
join llamados ll on ad.id_llamado = ll.id
join categorias c on ll.id_categoria = c.id
join proveedores p on ad.id_proveedor = p.id
where c.descripcion ilike '%programas computacionales%'
group by p.id, p.descripcion
having SUM(ad.monto) > 0
order by SUM(ad.monto) desc;

-- Demostracion de la vista
select * from vSuperProveedores
limit 10;

DROP VIEW IF EXISTS vSuperProveedores;

-- verificar la descripcion
select * from categorias where descripcion 
ilike '%programas computacionales%';


-- Tema 2: Despliegue un ranking de la cantidad de adjudicaciones según
-- el mes del año en el que fueron adjudicadas. Considere solamente el año 2020
-- y despliegue el periodo en el formato indicado abajo:

select 'Mes ' || EXTRACT(MONTH FROM ad.fecha_adjudicacion) || ' del año ' || 
	EXTRACT(YEAR FROM ad.fecha_adjudicacion) AS "Periodo",
    count(ad.id) AS "Adjudicaciones"
from adjudicaciones ad
where EXTRACT(YEAR FROM ad.fecha_adjudicacion) = 2020
GROUP BY 
    EXTRACT(MONTH FROM ad.fecha_adjudicacion),
    EXTRACT(YEAR FROM ad.fecha_adjudicacion)
order by count(ad.id) desc;

-- Tema 3: Considerando que le empresa EXCELSIS provee el DBMS Oracle, 
-- se requiere obtener todas las adjudicaciones a dicha empresa que 
-- no hayan sido por el método de llamado a Licitación.

SELECT 
    EXTRACT(YEAR FROM ad.fecha_adjudicacion) AS "Año Adjudicacion",
    ins.descripcion AS "Institucion",
    m.descripcion AS "Metodo",
    SUM(ad.monto) AS "Total"
FROM 
    adjudicaciones ad
JOIN 
    llamados ll ON ad.id_llamado = ll.id
JOIN 
    instituciones ins ON ll.id_institucion = ins.id
JOIN 
    (SELECT * FROM metodos WHERE descripcion NOT ILIKE '%Licitación%') m 
        ON ll.id_metodo = m.id
JOIN 
    proveedores p ON ad.id_proveedor = p.id
WHERE 
    p.descripcion ilike '%EXCELSIS%'
GROUP BY 
    EXTRACT(YEAR FROM ad.fecha_adjudicacion),
    ins.descripcion,
    m.descripcion
ORDER BY 
    SUM(ad.monto) DESC;




-- los que no sean de licitacion
select * from metodos where descripcion not ilike '%Licitación%'



-- Tema 4: Identifique las instituciones que han registrado llamados 
-- sin indicar el título del llamado, es decir con el campo título en blanco.

select ins.id as id,
ins.descripcion as descripcion
from instituciones ins
join llamados ll on ins.id = ll.id_institucion
where ll.titulo IS NULL OR ll.titulo = ''
group by ins.id, ins.descripcion
order by ins.id;