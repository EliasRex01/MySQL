-- marcar las filas con formatos de fecha
-- marcar buscar y reemplazar y cambiar la letra del signo por vacio
-- poner como entero eliminando los decimales
-- guardar como csv
-- Eliminar las tildas y los espacios de los nombres de columnas

-- en postgresql se debe crear primero la tabla antes de importar
-- se puede crear la tabla con los nombres de las columnas pero sin los datos
-- se puede abrir el csv con exel y formatear para luego copiar los nombres de columnas
-- se le agrega un tipo de valor en una hoja aparte del excel

-- importar archivos planos desde el gestor postgresql
-- 1. crear la bd
-- 2. click en la bd y opcion task / import flat file

-- buscar los valores distintos (distinct elimina las filas repetidas)
SELECT DISTINCT chapa, vehiculo FROM automoviles;

-- crear una tabla no normalizada
SELECT DISTINCT ruccliente, razonsocial
INTO clientes
FROM tmprepartos;

-- si no hay pk se crea
ALTER TABLE repartos_detalle ADD codigo_detalle BIGINT IDENTIFY;

-- asi se agrega una pk
ALTER TABLE vehiculo ADD PRIMARY KEY (chapa);

-- se agregan fk si faltan
ALTER TABLE repartos ADD FOREIGN KEY (chapa) REFERENCES vehiculo(chapa);
