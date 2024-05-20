-- Funciones Avanzadas o Adicionales

-- Funcion CAST()
-- hace una conversion de tipo de dato para el resultado

select '2022-08-09';              -- es una cadena
select cast('2022-08-09' as date);    -- convirtiendo a tipo fecha


select concat(cast(124 as char), 'ruta');

-- is null evalua si la expresion es nula o no 
-- 1 es nulo pero 0 es no nulo

-- funcion if()
--        si   , pasa esto,      si no esto
select if(x=5, 'datos iguales', 'datos diferentes');

-- convert permite hacer conversiones de dato, parecido a cast pero con diferente sintaxis
select convert('2020-08-09', date);      

-- case evalua casos dependiendo de la alternativa brindada
select (case 1                          -- se evalua en 1 aca, se puede reemplazar y evalua en ese valor
		when 1 then 'uno'
        when 2 then 'tres'
        when 3 then 'cuatro'
        else 'no encontrado' 
        end);
