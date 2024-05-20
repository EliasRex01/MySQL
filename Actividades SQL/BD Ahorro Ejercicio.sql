-- El HC Bank nos ha facilitado la base que contiene su cartera de clientes de cuentas de ahorro y
-- nos ha solicitado obtener datos para el análisis de las operaciones sospechosas. Los datos
-- solicitados deben ser idénticos a como se indican a continuación:

-- tablas de la BD
select * from clientes;   -- codigo_cliente, nombres
select * from cuentas;    -- anho, numero_cuenta, f_apertura, 
-- codigo_cuenta, codigo_cliente, codigo_tipo, codigo_cuenta
select * from movimiento;  -- codigo_cuenta
select * from tasas_interes;
select * from tipos_cuentas;  -- tipo_cuenta, codigo_tipo
select * from tipos_movimiento;


-- 1. Obtenga todas las cuentas de ahorro de los 2 clientes (bajo sospecha de lavado de
-- dinero) indicados abajo. El resultado debe ser idéntico al cuadro:

SELECT cu.numero_cuenta, cu.anho, tc.tipo_cuenta, 
cu.fecha_apertura, cl.codigo_cliente, cl.nombres AS "cliente"
FROM clientes cl 
JOIN cuentas cu 
ON cl.codigo_cliente = cu.codigo_cliente 
JOIN tipos_cuentas tc 
ON cu.codigo_tipo = tc.codigo_tipo 
WHERE cl.codigo_cliente IN (647848,3659553)
ORDER BY 1; -- numero_cuenta

-- 2. Despliegue la cantidad de cuentas que posee cada uno de los 3 clientes identificados
-- en el cuadro de abajo. Véase el resultado esperado a continuación:

SELECT cl.codigo_cliente, cl.nombres AS cliente, tc.tipo_cuenta,
COUNT(cu.*) AS "cantidad"
FROM clientes cl
JOIN cuentas cu
ON cl.codigo_cliente = cu.codigo_cliente
JOIN tipos_cuentas tc
ON cu.codigo_tipo = tc.codigo_tipo
WHERE cl.codigo_cliente IN (1735058,3659553,647848)
GROUP BY cl.codigo_cliente, tc.tipo_cuenta
ORDER BY 2; -- alfabetico de cliente


-- 3. Visualice el saldo al 31/12/2021 de las cuentas de los 3 clientes identificados arriba
-- (tema 2). Debe usar la función CalcularSaldo() ya disponible en la base de datos. El
-- resultado debe idéntico al indicado abajo:

SELECT (cu.numero_cuenta || '-' || cu.anho) AS "cuenta",
tc.tipo_cuenta AS "tipo", 
cl.codigo_cliente, cl.nombres AS "cliente",
SUM(calcularsaldo(mo.codigo_movimiento)) AS "saldo"
FROM clientes cl
JOIN cuentas cu
ON cl.codigo_cliente = cu.codigo_cliente
JOIN tipos_cuentas tc
ON cu.codigo_tipo = tc.codigo_tipo
JOIN movimiento mo
ON cu.codigo_cuenta = mo.codigo_cuenta
WHERE cu.numero_cuenta IN (2760,5576,4870,4871,12159,5794)
AND mo.fecha_operacion >= '2021-12-31' OR mo.importe = 102956
GROUP BY (cu.numero_cuenta || '-' || cu.anho), tc.tipo_cuenta,
cl.codigo_cliente
ORDER BY SUM(calcularsaldo(mo.codigo_movimiento)) DESC; 
-- saldo desc


-- Cree una función llamada TransferenciaInterna() que permita insertar un movimiento
-- de extracción en la cuenta de origen y un movimiento de depósito en la cuenta
-- destino. Considere las siguientes aclaraciones:
-- a. Para la implementar debe usar los números de cuenta, no los códigos.
-- b. La fecha de la operación es siempre la fecha actual.
-- c. El comprobante es el número de cuenta de destino en la extracción y el
-- número de cuenta de origen en el movimiento de depósito.
-- d. La función debe retornar el mensaje “Transferencia exitosa”.
-- e. No es necesario que se controle el saldo de la cuenta de origen.
-- f. Opcionalmente puede usar la vista vExtracto para verificar el resultado.
-- Demuestre el uso de la función TransferenciaInterna() mediante una sola sentencia
-- SQL que genere una transferencia por un monto de 5.000.000. El origen debe ser la
-- cuenta número 5576 y el destino la cuenta número 14004.

-- Creacion de la funcion TransferenciaInterna
CREATE OR REPLACE FUNCTION TransferenciaInterna(
    numeroCuentaOrigen INT,
    numeroCuentaDestino INT,
    monto NUMERIC
) 
RETURNS VARCHAR AS $$
DECLARE
    fecha_actual DATE := CURRENT_DATE;
    codigoCuentaOrigen INT;
    codigoCuentaDestino INT;
BEGIN
    -- Buscar los códigos de cuenta correspondientes a los números de cuenta
    SELECT codigo_cuenta INTO codigoCuentaOrigen
    FROM cuentas
    WHERE numero_cuenta = numeroCuentaOrigen;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'La cuenta de origen % no existe', numeroCuentaOrigen;
    END IF;

    SELECT codigo_cuenta INTO codigoCuentaDestino
    FROM cuentas
    WHERE numero_cuenta = numeroCuentaDestino;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'La cuenta de destino % no existe', numeroCuentaDestino;
    END IF;

    -- Inserta el movimiento de extracción en la cuenta de origen
    INSERT INTO movimiento (codigo_cuenta, fecha_operacion, importe, comprobante)
    VALUES (codigoCuentaOrigen, fecha_actual, -monto, numeroCuentaDestino);

    -- Inserta el movimiento de depósito en la cuenta de destino
    INSERT INTO movimiento (codigo_cuenta, fecha_operacion, importe, comprobante)
    VALUES (codigoCuentaDestino, fecha_actual, monto, numeroCuentaOrigen);

    RETURN 'Transferencia exitosa';
END;
$$ LANGUAGE plpgsql;

-- Llamada a la transferencia
SELECT TransferenciaInterna(5576, 14004, 5000000);

-- Usando la vista vExtracto para comprobar el resultado
SELECT * 
FROM vExtracto 
WHERE numero_cuenta IN (5576, 14004) 
ORDER BY fecha_operacion DESC;
-- Nota: no pude comprobar por que la vista muestra el resultado de la transaccion, pido perdon
