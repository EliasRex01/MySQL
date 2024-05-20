-- Funciones para cadenas de caracteres

-- left extrae una cantidad de caracteres de una cadena
-- comenzando del lado izquierdo
SELECT SUBSTRING('elias oviedo' FROM 1 FOR 2);

-- right extrae una cantidad de caracteres de una cadena
-- comenzando del lado derecho
SELECT SUBSTRING('elias oviedo' FROM LENGTH('elias oviedo') - 1 FOR 2);

-- length, devuelve la cantidad de caracteres de una expresión o campo
SELECT LENGTH('campo');

-- trim, lo que hace es eliminar los espacios iniciales y finales
-- de una cadena
SELECT TRIM('    elias    ');

-- rtrim, elimina los espacios finales (espacios en blanco, comienza desde derecha)
SELECT RTRIM('    elias    ');

-- ltrim, elimina los espacios iniciales (espacios en blanco, comienza desde izquierda)
SELECT LTRIM('    elias    ');

-- usando concat con los trim
SELECT CONCAT(LTRIM('    ruta 2  '), 'km12');

-- upper y lower
SELECT UPPER('casa');
SELECT LOWER('CASA');

-- substring(contenido, posicion_actual, cant_caracteres) 
SELECT SUBSTRING('elias oviedo' FROM 4 FOR 3);

-- locate() ubicar la ocurrencia dentro de una cadena
SELECT POSITION('i' IN 'elias');     -- devuelve la posición de la 'i'


-- Funciones Numéricas

-- mod permite hallar el resto   mod(3,4)  3 entre 2
SELECT MOD(3, 2);

-- round(dato_numerico, cant_decimales)
SELECT ROUND(123.456, 2);

-- count cuenta a partir de una columna
SELECT COUNT(*) FROM tabla;


-- Funciones de Fecha

-- Funcion CURRENT_DATE
-- sirve para hallar la fecha del sistema
SELECT CURRENT_DATE;         -- da año, mes y día

-- hora 
SELECT CURRENT_TIME;    -- hora, minuto y segundo

-- fecha y hora
SELECT CURRENT_TIMESTAMP;

-- fecha de una función
SELECT DATE(CURRENT_TIMESTAMP);    -- el DATE me da solo la fecha
-- si pide la fecha de un campo y el campo tiene fecha y hora se usa el DATE

-- solo la hora de este tiempo
SELECT TIME(CURRENT_TIMESTAMP);

-- como quitar el año
SELECT EXTRACT(YEAR FROM CURRENT_DATE);

-- como quitar solo el mes
SELECT EXTRACT(MONTH FROM CURRENT_DATE);

-- como quitar solo el día
SELECT EXTRACT(DAY FROM CURRENT_DATE);
