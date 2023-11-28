-- Las funciones de agregacion y como usarlas
-- una funcion de agregacion nos permite algo de una columna, una info
-- que no se encuentra como tal guardada en la tabla sino que nos permite
-- operar o aplicar una funcion a una determinada para extraer info

USE WORLD;
SELECT * FROM country;
-- por ejemplo hallar la suma de valores de una columna con SUM
SELECT SUM(SurfaceArea) AS 'Area total' FROM country;

-- calcular promedios, por ejemplo esperanza de vida media
SELECT SUM(SurfaceArea) AS 'Area total',
AVG(LifeExpectancy) AS 'Esperanza de vida media' FROM country;
-- average es promedio

-- count por ejemplo se puede usar para contar las filas
SELECT 
COUNT(*) AS 'Total de paises',
SUM(SurfaceArea) AS 'Area total',
AVG(LifeExpectancy) AS 'Esperanza de vida media' FROM country;

-- min y max por ejemplo la minima esperanza de vida
SELECT COUNT(*) AS 'Total de paises',
SUM(SurfaceArea) AS 'Area total',
AVG(LifeExpectancy) AS 'Esperanza de vida media',
MIN(LifeExpectancy) AS 'Minima esperanza de vida' FROM country;

