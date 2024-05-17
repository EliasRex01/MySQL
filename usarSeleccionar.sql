-- Como usar la funcion seleccionar
USE world;
SELECT * FROM city;
SELECT Name, ID FROM city;
-- en el orden de escritura se mostraran las columnas
SELECT Name FROM city;
-- el * implica todos los campos de la tabla seleccionada

-- usar el alias AS para llamar una columna de una tabla por un nombre que elija
USE world;
SELECT Name AS Nombres, Region FROM country;
-- otras pruebas con el alias, se puede usar palabras compuestas con el operador "" 
-- o nombrar 2 columnas con el mismo nombre --
SELECT Name AS Nombre, Region "Region de la persona" FROM country;

-- seleccionar una columna sin elementos repetidos
SELECT * FROM city;
SELECT countrycode AS "Codigo de pais" FROM city; -- aqui se repiten las filas
SELECT DISTINCT countrycode AS "Codigo de pais" FROM city; -- usando select distinct
SELECT DISTINCT countrycode AS "Codigo de pais", Name FROM city; -- consultando 2 columnas
-- el distinct elimina elementos repetidos de la consulta y no de la base de datos

-- seleccionar un empleado en especifico usando where
USE employees;
SELECT * FROM salaries WHERE emp_no=10001;   -- impongo una condicion respecto a la consulta
SELECT * FROM salaries WHERE salary=40000;    -- basicamente hago filtros a las busquedas

-- seleccionar lo que cobro en total cada empleado usando su codigo de empleado
SELECT * FROM salaries;
SELECT emp_no, SUM(salary) AS total_cobrado FROM salaries GROUP BY emp_no;
