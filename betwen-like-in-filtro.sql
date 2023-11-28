-- operadores between, like y in, ademas de posibles ejemplos de filtrado

-- usando between, where y and para pedir un rango de valores, se coloca menor y mayor
USE employees;
SELECT * FROM employees WHERE emp_no between 10001 AND 10005;

-- rango sin el uso de betwen
SELECT * FROM employees WHERE emp_no >= 10001 AND emp_no <= 10005;

-- tambien se puede negar para obtener los que no estan en ese rango con NOT between

-- usando between con fechas
SELECT * FROM employees WHERE birth_date between "1953-01-01" AND "1953-03-08";

-- Operador Like
SELECT * FROM employees;
-- el like se usa para hallar patrones como los que empiecen con una letra como g
-- mysql tiene 2 comodines % y _ , % no importa lo que siga, _ significa es un solo caracter cualquiera
SELECT * FROM employees WHERE first_name LIKE "Ge%";
SELECT * FROM employees WHERE first_name LIKE "_e%";
SELECT * FROM employees WHERE birth_date LIKE "1953%";
SELECT * FROM employees WHERE birth_date LIKE "%09___";
SELECT * FROM employees WHERE birth_date LIKE "%o";
SELECT * FROM employees WHERE birth_date LIKE "p%o";
-- al usar % al final puede llenar el espacio de la cadena que restart
-- al usar % al comienzo puede representar cualquier espacio que se le deje
-- lo que esta dentro de las comillas no distinge mayusculas y minusculas


-- para que ver ciertos nombres o ciertos elementos se puede filtrar con el IN en lugar de usar muchos OR
SELECT * FROM employees;
SELECT * FROM employees WHERE first_name = "Parto" OR first_name = "Georgi";
SELECT * FROM employees WHERE first_name IN ("Parto","Georgi","Anneke");


-- Ejemplos de filtros basicos
-- Encontrar los empleados contratados luego de una determinada fecha


-- Encontrar los empleados varones que tienen una edad actual de 60
SELECT * FROM employees;
-- vamos a usar la funcion DATEDIFF para hallar la dif entre la fecha de entrada y la fecha de nac del emp
SELECT first_name, last_name, DATEDIFF ('2023-12-08',birth_date)/365  AS edad FROM employees 
WHERE DATEDIFF ('2023-12-08',birth_date)/365 >= 60 AND DATEDIFF ('2023-12-08',birth_date)/365 < 61;