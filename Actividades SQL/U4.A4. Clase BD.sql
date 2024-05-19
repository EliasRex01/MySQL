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
ORDER BY COUNT(a.*) DESC;


--  Los mismos datos de la consulta anterior pero debe agregar cuál es el
-- articulo más barato y cuál es el artículo más caro. El resultado esperado
-- se indica abajo:
SELECT 
    p.desc_proveedor AS "PROVEEDOR",
    COUNT(a.*) AS "ARTICULOS",
    MIN(a.ultimo_costo) AS "MAS BARATO",
    MAX(a.ultimo_costo) AS "MAS CARO",
    (
        SELECT a1.codigo_articulo || ' - ARTICULO ' || a1.codigo_articulo 
        FROM articulos a1 
        WHERE a1.codigo_proveedor = p.codigo_proveedor 
          AND a1.ultimo_costo = (SELECT MIN(a2.ultimo_costo)
                                 FROM articulos a2 
                                 WHERE a2.codigo_proveedor = p.codigo_proveedor 
                                   AND a2.ultimo_costo != 0)
        LIMIT 1
    ) AS "CODIGO ARTICULO MAS BARATO",
    (
        SELECT a3.codigo_articulo || ' - ARTICULO ' || a3.codigo_articulo 
        FROM articulos a3 
        WHERE a3.codigo_proveedor = p.codigo_proveedor 
          AND a3.ultimo_costo = (SELECT MAX(a4.ultimo_costo)
                                 FROM articulos a4 
                                 WHERE a4.codigo_proveedor = p.codigo_proveedor 
                                   AND a4.ultimo_costo != 0)
        LIMIT 1
    ) AS "CODIGO ARTICULO MAS CARO"
FROM proveedores p
JOIN articulos a ON a.codigo_proveedor = p.codigo_proveedor
WHERE a.ultimo_costo != 0
GROUP BY p.desc_proveedor, p.codigo_proveedor
ORDER BY COUNT(a.*) DESC;
