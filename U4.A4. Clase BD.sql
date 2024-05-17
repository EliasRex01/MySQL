select * from articulos a 
join proveedores p
on a.codigo_proveedor= p.codigo_proveedor
limit 10;

SELECT * FROM articulos
LIMIT 5;


-- solo los articulos proveidos por algodonera guarani
SELECT * FROM articulos a
JOIN proveedores p
ON a.codigo_proveedor = p.codigo_proveedor
WHERE desc_proveedor like 'ALGO%';

-- cuantos articulos nos provee algodonera guarani
SELECT COUNT(*) FROM articulos
WHERE codigo_proveedor = 3;

-- contar por grupos con las cantidades de cada grupo
SELECt p.desc_proveedor "PROVEEDOR",
COUNT(a.*) "ARTICULOS"
FROM proveedores p
JOIN articulos a
ON a.codigo_proveedor = p.codigo_proveedor
GROUP BY p.desc_proveedor
ORDER BY 1;


-- Los proveedores, la cantidad de artículos proveídos por cada uno, cuál
-- es el artículo con el ultimo costo más barato y cuál es el artículo con el
-- ultimo costo más caro. El resultado esperado se indica abajo:
SELECt p.desc_proveedor "PROVEEDOR",
COUNT(a.*) "ARTICULOS",
MIN(a.ultimo_costo) "MAS BARATO",
MAX(a.ultimo_costo) "MAS CARO"
FROM proveedores p
JOIN articulos a
ON a.codigo_proveedor = p.codigo_proveedor
WHERE a.ultimo_costo !=0
GROUP BY p.desc_proveedor
ORDER BY 1;
