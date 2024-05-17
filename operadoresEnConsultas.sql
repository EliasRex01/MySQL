-- Operadores aritmeticos
SELECT * FROM country;
SELECT Name, (Population/SurfaceArea) AS "Habitantes por km2" FROM country;
-- usar operadores ayuda a mostrar nuevas tablas en base a otras

-- Operadores de comparacion =, < , > , <= , >= , <>
SELECT 5 <= 0; -- un operador de comparacion devuelve 1 o 0, 1 es vedaderro y 0 es falso
SELECT 9 <= 1;

-- Operadores AND, OR y NOT
SELECT TRUE AND TRUE; -- devuelve 1 que es verdadero, and es 1 si ambos son verdaderos, and es interseccion
SELECT TRUE OR FALSE; -- devuelve 1 si alguno de los dos se cumple
SELECT NOT TRUE;   -- NOT niega la hipotesis y lo cambia

SELECT * FROM employees WHERE gender = "M" AND last_name = "FACELLO"; 

SELECT 'HOLA' != 'HOLA'; -- != operador es diferente?
SELECT * FROM employees WHERE gender != 'M'; -- los que tengan genero diferente a M
-- se podria hacer where not gender pero no seria eficiente

