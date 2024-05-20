-- funciones para cadenas de caracteres
funcion: LEFT(contenido, 3);
-- left extrae una cantidad de caracteres de una cadena
-- comenzando del lado izquierdo
select left('elias oviedo', 2);

-- right extrae una cantidad de caracteres de una cadena
-- comenzando del lado derecho

-- length, devuelve la cantidad e caracteres de una expresion o campo
select length('campo');

-- trim, lo que hace es hace eliminacion de loas pasos iniciales y finales
-- de una cadena
select trim('    elias    ');

-- rtim, elimina los espacios finales (espacios en blanco, comienza desde derecha)

-- ltrim, elimina los espacios iniciales (espacios en blanco, comienza desde izquierda)

-- usando concat con los trim
select concat(ltrim('    ruta 2  '), 'km12');

-- upper y lower
select upper('casa');
select lower('CASA');

-- substring(contenido,posicion_actual,cant_caracteres) 
select substring('elias oviedo', 4, 3);

-- locate() ubicar la ocurrencia dentro de una cadena
select locate('i', 'elias');     -- devuelve la posicion de la i


-- Funciones Numericas
-- mod permite hallar el resto   mod(3,4)  3 entre 2

-- Round(dato_numerico,cant_decimales)

-- count cuenta a partir de una columna



-- Funciones de FECHA
-- Funcion CURDATE()
-- sirve para hallar la fecha del sistema
select curdate();         -- da anho, mes y dia

-- hora 
select curtime();    -- hora, minuto y segundo

-- fecha y hora
select current_timestamp();

-- fecha de una funcion
select date(current_timestamp());    -- el date me da solo la fecha
-- si pide la fecha de un campo y el campo tiene fecha y hora se usa el date

-- solo la hora de este tiempo
select time(current_timestamp());

-- como quitar el anho
select year(curdate());

-- como quiatr solo el mes
select mount(curdate());

-- como quitar solo el dia
select day(curdate());