/*
FECHA: 11/05/2021
ASIGNATURA: BASE DE DATOS I
CARRERA: CIENCIAS INFORMATICAS
COMENTARIO: Soluciones del ejercicio U5.A3. 
*/

-- TEMA 1: Es solo restaurar y analizar la BD

-- TEMA 2: Trigger que actualiza el ultimo numero de cheque utilizado en la chequera
CREATE TRIGGER ai_actualiza_chequera
  AFTER INSERT 
  ON cheques
  FOR EACH ROW
  EXECUTE PROCEDURE ActualizaNumeroCheque();


-- Esta es la función que se invoca el trigger
CREATE OR REPLACE FUNCTION ActualizaNumeroCheque()
  RETURNS trigger AS
$BODY$
DECLARE vUltimoNumero Integer;
BEGIN

    --Como el trigger se ejecuta AFTER INSERT en cheques, tomo el máximo ya guardado
    SELECT MAX(numero_cheque) into vUltimoNumero FROM cheques
    WHERE codigo_chequera = NEW.codigo_chequera; -- Pero del talonario que estoy insertando

    -- Hago un update a chequeras (talonario). Antes tuve que crear el campo que se llama ultimo_numero en chequeras (ver tema 4)
    UPDATE chequeras SET ultimo_numero = vUltimoNumero
    WHERE codigo_chequera = NEW.codigo_chequera;

    /*
    Falta implementar un control para que no permita inertar si el ultimo nro es superior al numero_hasta
    */
    
    RETURN NULL;
END;
$BODY$
  LANGUAGE plpgsql ;


-- TEMA 3: Función que ObtieneNumeroCheque() el siguiente número de cheque a utilizar
CREATE OR REPLACE FUNCTION ObtieneNumeroCheque(pTalonario integer)
  RETURNS Integer AS
$BODY$
DECLARE vUltimoNumero Integer;

BEGIN

    -- Obtengo el máximo ya utilizado de la chequera o talonario en cuestión...
    SELECT MAX(numero_cheque) into vUltimoNumero FROM cheques
    WHERE codigo_chequera = pTalonario;

    --- ... y le sumo 1
    RETURN vUltimoNumero+1;
END;
$BODY$
  LANGUAGE plpgsql ;

  

-- TEMA 4: Ajuste DDL necesario a la tabla chequeras para guardar el ultimo numero utilizado
ALTER TABLE chequeras ADD COLUMN ultimo_numero integer;

-- TEMA 5: Insertar un cheque con mis datos
-- Primero necesito insertar mis datos a la tabla PERSONA
INSERT INTO personas (ruc, nombre, direccion, telefonos, correo)
   VALUES ('1234567-0', 'ANUEL BENITEZ', 'Tarumandy S/N', '0988678965', 'anueel_91@gmail.com');

-- Ahora inserto el cheque
INSERT INTO cheques(Numero_cheque, fecha, monto, codigo_chequera, ruc)
    VALUES (ObtieneNumeroCheque(1), now(), 1000000, 1, '1234567-0');


-- TEMA 6: Verifico los resultados de la función y del trigger
SELECT * FROM cheques;

SELECT * FROM chequeras;

    

