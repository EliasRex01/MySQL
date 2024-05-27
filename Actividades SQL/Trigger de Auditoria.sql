-- guardar los datos viejos y los nuevos
-- en la auditoria indicar cual es la fila que se modifico, con el dato anterior 
-- y cual es la fila con el dato nuevo

-- version del sql server
ALTER TRIGGER articulos_UPDATE ON articulos AFTER UPDATE
AS 
INSERT INTO (codigo_articulo, descripcion, ultimo_costo, costo_promedio, precio_unitario,
    porcentaje_iva, codigo_tipo, codigo_proveedor)
SELECT (codigo_articulo, descripcion, ultimo_costo, costo_promedio, precio_unitario,
    porcentaje_iva, codigo_tipo, codigo_proveedor)
    'DELETE'.GETDATE().SUSER.$NAME
FROM deleted;

ALTER TRIGGER articulos_UPDATE ON articulos AFTER UPDATE
AS 
INSERT INTO (codigo_articulo, descripcion, ultimo_costo, costo_promedio, precio_unitario,
    porcentaje_iva, codigo_tipo, codigo_proveedor)
SELECT (codigo_articulo, descripcion, ultimo_costo, costo_promedio, precio_unitario,
    porcentaje_iva, codigo_tipo, codigo_proveedor)
FROM deleted;


-- select la tabla auditoria
select * from articulosAUDIT;


-- en el insert se puede usar un select para insertar valores
-- en el update se puede usar select para modificar valores

update articulos set descripcion = 
where codigo_articulo 





