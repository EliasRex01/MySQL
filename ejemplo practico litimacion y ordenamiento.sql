-- ejemplo practico limitacion y consulta

-- 1. Consulta para obtener los cinco paises mas pequeños en area
-- de la tabla "country"
USE world;
SELECT Name, SurfaceArea
FROM country
ORDER BY SurfaceArea  
LIMIT 5;      -- el default de order by es ASC o ascendente


-- 2. Consulta para obtener los cinco empleados mas jovenes de la 
-- tabla "employees"
-- los mas jovenes nacieron mas tarde
USE employees;
SELECT first_name, last_name, birth_date
FROM employees
ORDER BY birth_date DESC  
LIMIT 5;

-- 3. Consulta para obtener los cinco departamentos con los nombres 
-- mas largos de la tabla "departments"
USE employees;
SELECT dept_name
FROM departments
ORDER BY LENGTH(dept_name) DESC     
LIMIT 5;    -- con el lenght contabilisamos

-- 4. Consulta para obtener los 20 paises con la mayor poblacion
-- de la tabla "country":alter
USE world;
SELECT Name, Population
FROM country
ORDER BY Population DESC 
LIMIT 20; 


