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
