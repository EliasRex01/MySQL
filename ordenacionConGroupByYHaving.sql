-- clausulas de ordenacion group by y having
USE world;
SELECT * FROM country;

-- Encontrar la superficie total de cada continente
SELECT Continent, SUM(SurfaceArea) AS 'Area Total' 
FROM country group by Continent;

-- Encontrar la esperanza de vida media para cada continente
SELECT Continent, AVG(LifeExpectancy) AS 'Esperanza de vida media' 
FROM country group by Continent ORDER BY AVG(LifeExpectancy);
-- el group by es para agrupar datos y mostrar mas de una columna 
-- al momento de hacer funciones de agregacion, (las de agregacion 
-- no se aplican a toda la tabla sino a las de la consulta)



-- clausula having
-- es un analogo a where pero para datos agrupados
-- permite hacer filtros a los resultados que obtenemos al hacer un group by
USE world;
SELECT Continent, AVG(LifeExpectancy) AS 'Esperanza de vida'
FROM country group by Continent HAVING AVG(LifeExpectancy) > 70
ORDER BY AVG(LifeExpectancy) ;
-- Se compara una funcion de agregacion con algo
-- el where es a columnas normales y el having despues del group by

-- Mostrar los continentes con una esperanza de vida media mayor a 70 
SELECT * FROM country;