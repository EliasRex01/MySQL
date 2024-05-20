-- Funciones Avanzadas o Adicionales

-- Funcion CAST()
-- hace una conversion de tipo de dato para el resultado

SELECT '2022-08-09';              -- es una cadena
select cast('2022-08-09' as date);    -- convirtiendo a tipo fecha

-- Concatenar una cadena con un número convertido a cadena
SELECT CAST(124 AS TEXT) || 'ruta';

-- is null evalua si la expresion es nula o no 
-- 1 es nulo pero 0 es no nulo


--        si   , pasa esto,      si no esto
SELECT CASE WHEN x = 5 THEN 'datos iguales' ELSE 'datos diferentes' END;

-- convert permite hacer conversiones de dato, parecido a cast pero con diferente sintaxis
SELECT CAST('2022-08-09' AS DATE);     

-- case evalua casos dependiendo de la alternativa brindada		
SELECT CASE 1                     -- se evalua en 1 aca, se puede reemplazar y evalua en ese valor
    WHEN 1 THEN 'uno'
    WHEN 2 THEN 'tres'
    WHEN 3 THEN 'cuatro'
    ELSE 'no encontrado'
END;
