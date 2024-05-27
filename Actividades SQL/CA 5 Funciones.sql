-- caso 3 de la actividad 4.4 donde se implementa codigo - ARTICULO codigo

SELECT p.desc_proveedor AS "PROVEEDORES", COUNT(*) AS "ARTICULOS",
MIN(ultimo_costo) AS "COSTO MAS BARATO",
ArticuloMasBarato(a.codigo_proveedor) AS "EL MAS BARATO",
MAX(ultimo_costo) AS "COSTO MAS BARATO",
ArticuloMasCaro(a.codigo_proveedor) AS "EL MAS CARO",
FROM articulos a JOIN proveedores p
ON a.codigo_proveedor = p.codigo_proveedor
WHERE a.ultimo_costo > 0
GROUP BY a.codigo_proveedor, p.codigo_proveedor
ORDER BY 2 DESC;

-- creacion de la funcion ArticuloMasBarato
CREATE OR REPLACE FUNCTION ArticuloMasBarato(pProveedor int)
RETURNS varchar(200) AS
$BODY$
DECLARE
  vCosto numeric;
  vArticulo varchar(130);
BEGIN
      SELECT codigo_articulo || ' - ' || descripcion,
      MIN(ultimo_costo) INTO vArticulo, vCosto
      FROM articulos a
      WHERE a.codigo_articulo = pProveedor
      AND a.ultimo_costo > 0
      GROUP BY codigo_articulo, descripcion
      ORDER BY 2 ASC
      LIMIT 1;

      -- Devuelve el parametro de salida (OUTPUT)
      RETURN vArticulo;
END
$BODY$
LANGUAGE plpgsql;

--- ejemplo uso
SELECT codigo_proveedor, desc_proveedor, ArticuloMasBarato(codigo_proveedor) ElMasBarato
  FROM proveedores;

-- creacion de la funcion ArticuloMasCaro
CREATE OR REPLACE FUNCTION ArticuloMasCaro(pProveedor int)
RETURNS varchar(200) AS
$BODY$
DECLARE
  vCosto numeric;
  vArticulo varchar(130);
BEGIN
      SELECT codigo_articulo || ' - ' || descripcion,
      MAX(ultimo_costo) INTO vArticulo, vCosto
      FROM articulos a
      WHERE a.codigo_articulo = pProveedor
      AND a.ultimo_costo > 0
      GROUP BY codigo_articulo, descripcion
      ORDER BY 2 DESC
      LIMIT 1;

      -- Devuelve el parametro de salida (OUTPUT)
      RETURN vArticulo;
END
$BODY$
LANGUAGE plpgsql;


-- creacion de la funcion ArticulosCostos
-- explicacion: si le paso 1 quiero el mas caro, 2 el mas barato
CREATE OR REPLACE FUNCTION ArticulosCostos(pProveedor bigint, pFlag integer)
RETURNS varchar(200) AS
$BODY$
DECLARE
  vCosto numeric;
  vMensaje varchar(130);
BEGIN
  IF pFlag = 1 THEN -- El mas caro
        SELECT codigo_articulo || ' - ' || descripcion,
        MAX(ultimo_costo) INTO vArticulo, vCosto
        FROM articulos a
        WHERE a.codigo_articulo = pProveedor
        AND a.ultimo_costo > 0
        GROUP BY codigo_articulo, descripcion
        ORDER BY 2 DESC
        LIMIT 1;
  END IF;

  IF pFlag = 2 THEN -- El mas barato
        SELECT codigo_articulo || ' - ' || descripcion,
      MIN(ultimo_costo) INTO vArticulo, vCosto
      FROM articulos a
      WHERE a.codigo_articulo = pProveedor
      AND a.ultimo_costo > 0
      GROUP BY codigo_articulo, descripcion
      ORDER BY 2 ASC
      LIMIT 1;
  END IF;

        -- Devuelve el parametro de salida (OUTPUT)
        RETURN vArticulo;
END
$BODY$
LANGUAGE plpgsql;

-- uso de la funcion con if e if e endif
-- se le pasa la bandera ArticulosCostos(pProveedor, 1) o 2 para min
