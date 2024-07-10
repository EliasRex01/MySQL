/*
 * Fecha: 09/07/2024
 * Carrera: LCIK - FPUNA
 * Cátedra: Base de Datos I
 * Tema: Solución SQL del Primer Examen Parcial
 *  
 */

/*
 * TEMA 1. Cree la vista vClientesFrecuentes que identifique a los 10 clientes 
 * que más veces han comprado (imagen 1). Posteriormente, y usando la vista creada, 
 * indique cuáles de esos clientes han comprado carne tipo costilla y cuál fue 
 * la última factura que corresponde a dicha compra 
 */

-- Parte 1: Creacion de la vista
create view vClientesFrecuentes as
select  c.cliente_id, concat(cast(c.ruc_cliente as varchar),
'-',cast(c.dv as varchar) ) as "RUC", 
nombre as "Cliente", count(f.*) as "Frecuencia"
from clientes c join facturas f 
on c.cliente_id = f.cliente_id 
where nombre not ilike '%ocasional%' -- no debe incluir clientes ocasionales
group by 1,2,3
order by 4 desc
limit 10;

-- Demuestro que la vista funciona
select * from vclientesfrecuentes 


-- Parte 2 Agrego un subselect a la vista que incluya las facturas de costillas
-- Nótese que en el where va la relación de la vista con la factura
select v."RUC", v."Cliente", v."Frecuencia", 
	(select max(f.numero_factura) 
	from facturas f
	join facturas_articulos fa on f.factura_id = fa.factura_id
	join articulos a on fa.articulo_id = a.articulo_id
	where v.cliente_id = f.cliente_id 
	and a.descripcion ilike '%costilla%' 
	) as "Factura Costilla"
from vClientesFrecuentes v
order by 3 desc;

/*
 * TEMA 2. ¿Qué días de la semana, del mes de mayo del 2024, 
 * hubo menos clientes comprando bebidas alcohólicas? 
 */

select fn_nombredia(date_part('dow',f.fecha)) as "Día",
-- arriba se usa una función que el profe ya creó para facilitar la vida
-- el to_char() igual es correcto si trae en castellano
sum(fa.cantidad*fa.precio) as "Total Ventas" ,
count(distinct f.cliente_id) as "Cantidad de Clientes" 
-- para contar sin repetir se aplica distinct
from facturas f join facturas_articulos fa 
on f.factura_id = fa.factura_id 
join articulos a on fa.articulo_id = a.articulo_id 
join categorias c on a.categoria_id = c.id 
where date_part('month',f.fecha) = 5 -- mayo
and date_part('year',f.fecha) = 2024 -- de tal año
and c.categoria ilike '%alcoh%' -- segun la categoria
group by 1 order by 3;

/*
 * TEMA 3. Use Inteligencia Artificial para crear la función numero_a_letras(). 
 * Modifique y corrija si es necesario. Use la función para convertir la fecha 
 * en letras de las últimas 10 facturas del cliente con el RUC 3285291-6
 */
select concat(cast(c.ruc_cliente as varchar),
'-',cast(c.dv as varchar)) as "RUC", 
f.numero_factura as "Factura",
f.fecha as "Fecha", 
upper(concat(numero_a_letras(date_part('day', f.fecha)::integer),
' de ', to_char(f.fecha, 'tmmonth'), ' del año dos mil ',
numero_a_letras(date_part('year', f.fecha)::integer-2000))) as "Fecha en Letras"
from facturas f join clientes c 
on f.cliente_id = c.cliente_id 
where c.ruc_cliente = '3285291'
order by 2 desc
limit 10;

/*NOTA: Hice por partes, porque los numeros grandes fallaban
 * Para reemplazar el valor 'VEINTE Y ' por 'VEINTI' se podria usar REPLACE()
 * EJEMPLO: SELECT REPLACE('VEINTE Y UNO DE JUNIO', 'VEINTE Y ', 'VEINTI');
 */

-- Esta es la función creada con ChatGPT
-- Le hice unas pocas modificaciones al array decenas para que funcione mejor
CREATE OR REPLACE FUNCTION numero_a_letras(num INTEGER)
RETURNS TEXT AS $$
DECLARE
    unidades CONSTANT TEXT[] := ARRAY['cero', 'uno', 'dos', 'tres', 'cuatro', 'cinco', 'seis', 'siete', 'ocho', 'nueve'];
    especiales CONSTANT TEXT[] := ARRAY['diez', 'once', 'doce', 'trece', 'catorce', 'quince', 'dieciséis', 'diecisiete', 'dieciocho', 'diecinueve'];
    decenas CONSTANT TEXT[] := ARRAY['diez', 'veinte', 'treinta', 'cuarenta', 'cincuenta', 'sesenta', 'setenta', 'ochenta', 'noventa'];
    centenas CONSTANT TEXT[] := ARRAY['', 'ciento', 'doscientos', 'trescientos', 'cuatrocientos', 'quinientos', 'seiscientos', 'setecientos', 'ochocientos', 'novecientos'];
BEGIN
    IF num < 0 OR num > 3000 THEN
        RAISE EXCEPTION 'El número debe estar entre 0 y 3000';
    END IF;

    IF num = 0 THEN
        RETURN 'cero';
    END IF;

    IF num <= 9 THEN
        RETURN unidades[num + 1];
    END IF;

    IF num >= 10 AND num <= 19 THEN
        RETURN especiales[num - 9];
    END IF;

    IF num <= 99 THEN
        RETURN decenas[num / 10] || CASE WHEN num % 10 = 0 THEN '' ELSE ' y ' || unidades[num % 10 + 1] END;
    END IF;

    IF num <= 199 THEN
        RETURN 'ciento ' || numero_a_letras(num - 100);
    END IF;

    IF num <= 999 THEN
        RETURN centenas[num / 100] || CASE WHEN num % 100 = 0 THEN '' ELSE ' ' || numero_a_letras(num % 100) END;
    END IF;

    IF num <= 1999 THEN
        RETURN 'mil ' || numero_a_letras(num - 1000);
    END IF;

    IF num <= 2000 THEN
        RETURN 'mil ' || numero_a_letras(num - 1000);
    END IF;

    RETURN 'dos mil';
END;
$$ LANGUAGE PLPGSQL;
