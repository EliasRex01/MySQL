-- limitando y ordenando resultados
USE world;
SELECT * FROM city;

-- por default el unico ordenado es ID, los demas no, por esto se usa el ORDER BY para ordenar respecto a algo
SELECT * FROM city ORDER BY Name;
-- en el name por ejemplo ordena por alfabeto y de mayuscula a minuscula

SELECT * FROM city ORDER BY Population;
-- population lo ordena de menor a mayor

-- filtrando por nombre de ciudad y habitantes de la ciudad
SELECT Name AS Ciudad, Population AS Habitantes FROM city ORDER BY Population;

-- agregando condicion donde o where
SELECT Name AS Ciudad, Population AS Habitantes FROM city WHERE Population < 1000 ORDER BY Population;
-- las letras se ordenan en alfabetico y los numeros en ascendente

-- el order by funciona con datos ya consultados o "seleccionados"
-- Operador NUll o IS NULL opera como un definidor de elemento
