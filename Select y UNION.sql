-- Esenciales de SELECT

select distinct columna1, columna2 from tabla;
-- busca el distinto con la columna 1 y 2, ojo se puede repeir el valor de una columna
-- pero la segunda tener otro valor y ser unico su conjunto como 1 , 2 y 1 , 3


-- el group by funciona mejor con una sola columna
-- con mas funciona pero crea pocos grupos
-- es mejor usarlo con count para saber cuantos de ese grupo hay
-- por ej codigo   1     3    veces


-- UNION
select column_name(s) from tabla1
union
select column_name(s) from tabla2;

-- union lo que hace es fusionar las tablas sin que halla repetidos en la
-- tabla resultante
