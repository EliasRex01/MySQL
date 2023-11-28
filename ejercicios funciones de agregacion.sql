-- ejercicio funcion de agregacion

-- Encontrar un intervalo tipico para la esperanza de vida
USE world;
SELECT * FROM country;
SELECT AVG(LifeExpectancy) AS 'Media', 
STDDEV(LifeExpectancy) AS 'Desviacion Estandar' FROM country;

-- hallando limite inferior y superior
SELECT ROUND(AVG(LifeExpectancy) -
STDDEV(LifeExpectancy)) AS 'Limite Inferior', ROUND(AVG(LifeExpectancy) +
STDDEV(LifeExpectancy)) AS 'Limite Superior' FROM country;
-- esperanza de vida menor y mayor de los paises de la tabla redondeados