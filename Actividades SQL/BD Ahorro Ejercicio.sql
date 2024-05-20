-- El HC Bank nos ha facilitado la base que contiene su cartera de clientes de cuentas de ahorro y
-- nos ha solicitado obtener datos para el análisis de las operaciones sospechosas. Los datos
-- solicitados deben ser idénticos a como se indican a continuación:


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
