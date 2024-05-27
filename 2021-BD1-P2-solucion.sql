/*
 * FECHA: 02/11/2021
 * AUTOR: jorge.meza@upa.edu.py
 * NOTA: Proyecto de SOLUCION DE examen parcial 2
 */


-- #1. Desplegar todos los viajes realizados por choferes con apellido GAUTO
-- realizados durante el 2021 indicando deposito de origen y de destino.
SELECT v.fechasalida, v.fechallegada, UPPER(c.nombre) "Chofer" ,
d.nombre "Destino", d2.nombre "Origen"
FROM viajes v 
JOIN choferes c ON v.idchofer = c.id 
JOIN depositos d ON v.iddepositodestino = d.id 
JOIN depositos d2 ON v.iddepositoorigen = d2.id
WHERE v.fechasalida >= '01/01/2021'
--AND UPPER(c.nombre) LIKE '%GAUT%' -- otra forma correcta
AND c.nombre ILIKE '%GAUT%' 
ORDER BY 1 desc;


-- #2. Cantidad de viajes realizados por cada uno de los choferes con apellido GAUTO
-- durante los anhos 2020 y 2021
SELECT date_part('year', v.fechasalida) "Año", c.nombre "Chofer", COUNT(*) "cantidad de viajes"
FROM viajes v 
JOIN choferes c ON v.idchofer = c.id 
WHERE UPPER(c.nombre) LIKE '%GAUT%' -- c.nombre ILIKE '%GAUT%'  -- otra forma correcta
AND date_part('year', v.fechasalida) IN (2020, 2021)
GROUP BY  date_part('year', v.fechasalida), c.nombre -- debo agrupar por un criterio
ORDER BY 1 desc, 2 ;

-- #3. Los datos de los camiones que no hayan hecho ningun viaje
select * from camiones 
where camiones.id NOT in 
(select viajes.idcamion from viajes 
WHERE VIAJES.IDCAMION IS NOT NULL );

-- Otra forma posible
SELECT ca.id, ca.chapa, ca.tara 
FROM camiones ca
LEFT JOIN viajes vi ON vi.idcamion = ca.id
WHERE vi.idcamion IS NULL;

/* 4
 * Crear una una funcion que calcule el flete a pagar por un viaje
 * considerando las distancias y los precios indicados en la 
 * tabla llamada parametros
 */
					
CREATE FUNCTION CalcularFlete(pDepositoDestino bigint, pDepositoOrigen bigint, pAnho integer)
RETURNS NUMERIC(12,2) AS
$BODY$
DECLARE
   vMontokm NUMERIC(12,2);
   vDistancia integer;
BEGIN
   SELECT distancia INTO vDistancia
   FROM distancias WHERE id_origen = pDepositoOrigen
   AND id_destino = pDepositoDestino;
   
   SELECT monto_kilometros INTO vMontoKm
   FROM parametros
   WHERE anho = pAnho
   AND vDistancia BETWEEN distancia_minima and distancia_maxima;
   
   RETURN vMontoKm*vDistancia;
END
$BODY$ LANGUAGE PLPGSQL;

/*  * Demostrar el uso de la funcion CalcularFlete()
 * para todos los viajes iniciados en 2020 y que terminaron en 2021
 * Considere que el precio de flete vario en 2021 y se toma el año de la llegada a destino.
 * Indique ademas cuanto se hubiere pagado si terminaban durante 2020 
 */
SELECT v.id "id viaje", v.fechasalida, v.fechallegada, 
d.distancia ,
CalcularFlete(iddepositoorigen, iddepositodestino, date_part('year', fechasalida)::integer) as "Flete en 2020",
CalcularFlete(iddepositoorigen, iddepositodestino, date_part('year', fechallegada)::integer) as "Flete en 2021"
from VIAJES v JOIN distancias d 
ON v.iddepositoorigen = d.id_origen 
AND v.iddepositodestino = d.id_destino 
WHERE date_part('year', fechasalida) = 2020
AND date_part('year', fechallegada) = 2021;


/* 5 EXTRA
* Implemente un trigger que no permite modificar los datos de los choferes si el chofer 
* ya ha realizado algún viaje. Demuestre el funcionamiento usando el chofer con id = 4
*/

CREATE OR REPLACE FUNCTION fnc_upd_choferes() 
RETURNS TRIGGER AS 
$BODY$
BEGIN

	IF EXISTS (SELECT 1 FROM viajes
	   WHERE idchofer = NEW.id) THEN
		
		RAISE EXCEPTION 'No se puede modificar datos de % porque tiene viajes registrados', OLD.nombre;
    END IF;
	
    RETURN OLD;	
	
END;
$BODY$ LANGUAGE plpgsql;


-- Paso #2. Crear el disparador (trigger) que llama a la función
CREATE TRIGGER trg_upd_choferes
BEFORE UPDATE
ON choferes
FOR EACH ROW EXECUTE PROCEDURE fnc_upd_choferes();

-- PROBAR
UPDATE choferes set NOMBRE ='CONDE FATWALD' where id = 4;


