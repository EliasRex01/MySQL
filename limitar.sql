-- Como limitar las consultas de ciertas maneras usando LIMIT

USE world;
SELECT * FROM city;

-- obtener el top 5 de ciudades segun sus habitantes
SELECT Name, Population FROM city ORDER BY Population DESC LIMIT 5;
-- limit permite limitar el numero de registros obtenidos o filas
-- por ejemplo los 5 ultimos o 5 aleatorios

-- obtener 5 ciudades de forma aleatoria
SELECT Name FROM city ORDER BY RAND() LIMIT 5;



-- Limitar resultados por paginas
SELECT * FROM city
LIMIT 5,5;
-- la coma , signnifica despues de eso hallar los despues de la coma

-- ultimos 5
SELECT * FROM city ORDER BY ID DESC LIMIT 0,5;
-- se cuenta desde el 1 y muestra 5 elementos osea hasta el 6