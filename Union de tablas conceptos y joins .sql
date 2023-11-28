-- Union de tablas 

-- LLAVE PRIMARIA

-- La clave primaria (primary key) se utiliza para identificar en forma unica
-- cada linea de la tabla
-- NOTAS: en sintesis es un campo que identifica un registro en la tabla unica 
-- va contener valores unicos, las filas no tendran valores iguales
-- la tabla no tendra valores nulos

-- LLAVE FORANEA

-- Llave foranea (Foreign key)es una limitacion referencial entre dos tablas.
-- La clave foranea identifica un campo en una tabla (tabla hija o referendo)
-- que se refiere a un campo de otra tabla (tabla padre o referenciada)
-- NOTAS: es un campo que hace referencia a un campo de otra tabla

-- En data Database -> reverse engineer se puede ver el grafico de relacion donde se muesta el pk y el foreigh key
-- indica que tabla esta referenciada
-- por ejemplo usando el employee y world el country code hace referencia a country
-- es por que el country code tiene el codigo que hace referencia al pais al cual pertenece a esa ciudad

-- pk es un identificador de registro de una tabla
-- fk es un campo que va a hacer referencia a un campo de otra tabla
-- se puede extraer informacion de las tablas usando las relaciones que existen entre las tablas


-- INTRODUCCION A JOINS
-- la sintaxis base es 
-- SELECT * FROM TABLA1 T1      -- T1 Y T1 SON COMO ALIAS PARA HACER REFERENCIA A LAS TABLAS 1 Y 2
-- JOIN TABLA2 T2       -- CON JOIN SE VA RELACIONAR T1 Y T2
-- ON T1.CAMPO1 = T2.CAMPO2          -- LOS ALIAS SON PARA NO ESCRIBIR LOS NOM COMPLETOS DE LA TABLAS

-- al relacionar estos dos campos al relacionarse va permitir que la consulta va a generar una 
-- nueva tabla con registros de las dos tablas 
-- osea un join lo que hace es PERMITIR RELACIONAR O EN ESTE CASO COMBINAR DOS O MAS TABLAS

-- HAY VARIOS TIPOS DE JOIN
-- INNER JOIN es el join por default al escribir join sinmas
-- el inner join funciona como tener dos conjuntos y en la interseccion pedir los elementos comunes en t1 y t2

-- LEFT JOIN es como tener dos conjuntos t1 y t2 y al interceptar pedir los elementos de t1
-- y los de t2 que sean comunes a t1 (los de t2 que no son comunes a t1 no se muestran) left seria como izquierda

-- RIGHT JOIN es como el left join pero con los de la derecha o t2 y los de t1 comunes a t2

-- osea los join permiten manipular o analizar los datos que tenga en mas de una tabla


-- INNER JOIN
USE numpibd;
select * from estudiantes;
select * from secciones;

-- combinacion con la seccion id, solo los que tengan seccion id
SELECT * FROM estudiantes E
JOIN secciones S    -- o inner join
ON E.seccion_id = S.id;
-- solo aparecen registros comunes a ambas que cumplen con la codicion definida

-- especificando los campos a ver
SELECT E.nombre AS estudiante, S.nombre AS seccion FROM estudiantes E
JOIN secciones S    -- o inner join
ON E.seccion_id = S.id;
-- da nombre del estudiante y seccion

SELECT E.nombre AS estudiante, S.id AS seccion FROM estudiantes E
JOIN secciones S    -- o inner join
ON E.seccion_id = S.id;
-- da nombre del estudiante y id


-- LEFT JOIN
USE numpibd;
select * from estudiantes;
select * from secciones;

-- registros que pertenecen a la tabla 1 que cumplen con la condicion
SELECT * FROM estudiantes E 
LEFT JOIN secciones S
ON E.seccion_id = S.id;
-- tambien trae los que no tienen pareja de la tabla 1 o los estudiantes sin secciones
-- trae todos los datos de la tabla 1 y los de la 2 que cumplen con la condicion


-- RIGHT JOIN
USE numpibd;
select * from estudiantes;
select * from secciones;

-- todos los registros de la tabla 2 y los que cumplen la condicion de la tabla 1
SELECT * FROM estudiantes E 
RIGHT JOIN secciones S
ON E.seccion_id = S.id;
-- aparecen todas las secciones hasta la D que no tiene estudiantes

