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

