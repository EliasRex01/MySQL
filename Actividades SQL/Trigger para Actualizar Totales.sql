-- seria el trigger totalizar

-- Creacion de la funcion
CREATE OR REPLACE FUNCTION fnc_act_total_pedidos() 
RETURNS TRIGGGER AS $fnc_act_total_pedidos$
    DECLARE
        vPorcentaje_iva, articulos.porcentaje_iva%type;   
        -- %type indica que tomara el tipo de dato de la columna 
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            SELECT porcentaje_iva INTO vPorcentaje_iva
            FROM articulos
            WHERE codigo_articulo = NEW.codigo_articulo;

            UPDATE pedidos
            SET total = COALESCE:(total, 0) + (NEW.PRECIO_VENTA * NEW.CANTIDAD),
                montoiva = COALESCE(montoiva, 0) + ((NEW.PRECIO_VENTA * NEW.CANTIDAD) - 
                                                    ((NEW.PRECIO_VENTA * NEW.CANTIDAD) / 
                                                    (1 + COALESCE(vPorcentaje_iva, 0)))) 
            WHERE anho            = NEW.anho
            AND numero_pedido     = NEW.numero_pedido;

            RETURN NEW;
        END IF;

        IF (TG_OP = 'UPDATE') THEN
            IF NEW.cantidad <> OLD.cantidad OR NEW.precio_venta <> OLD.precio_venta
            THEN
                SELECT porcentaje_iva
                INTO vPorcentaje_iva
                FROM articulos
                WHERE codigo_articulo = NEW.codigo_articulo;

                UPDATE pedidos
                    SET total = COALESCE(total, 0) - (OLD.PRECIO_VENTA * OLD.CANTIDAD)
                    + (NEW.PRECIO_VENTA * NEW.CANTIDAD),
                    montoiva = COALESCE(montoiva, 0) - ((OLD.PRECIO_VENTA * OLD.CANTIDAD) 
                    - ((OLD.PRECIO_VENTA * OLD.CANTIDAD) / (1 + COALESCE(vPorcentaje_iva, 0
                    ))))
                    + ((NEW.PRECIO_VENTA * NEW.CANTIDAD) - ((NEW.PRECIO_VENTA * NEW.CANTIDAD)
                    / (1 + COALESCE(vPorcentaje_iva, 0))))
                WHERE anho            = NEW.anho
                AND numero_pedido     = NEW.numero_pedido;

                RETURN NEW;
            END IF;
        END IF;

        /* ??? IF (TG_OP = 'DELETE') THEN
            IF (TG_OP = 'DELETE') THEN
                -- debe restar del total para volver a reponer
            RETURN OLD;
        */
        
    END;
$fnc_act_total_pedidos$ LANGUAGE plpgsql;


-- creacion del trigger
CREATE TRIGGER trg_act_total_pedidos
AFTER INSERT OR UPDATE OR DELETE     -- se puede poner solo uno o dos tambien
ON pedidos_articulos
FOR EACH ROW EXECUTE PROCEDURE fnc_act_total_pedidos();
-- antes o despues de la operacion se puede disparar el trigger

-- realizar una insercion en la tabla pedidos_articulos
-- crear secuencia para la columna codigo_detalle (columna no definida como autoincremental)
SELECT MAX(codigo_detalle)
FROM pedidos_articulos;

-- uso del trigger
SELECT * FROM pedidos WHERE numero_pedido = 59219;
-- 130000 = 1 articulo
-- 276000 = 2 articulos

-- relizar la insercion de ese dato copiando su informacion y ver los cambios en total por ej
SELECT * FROM pedidos_articulos WHERE numero_pedido = 59219;
INSERT INTO pedidos_articulos (codigo_detalle, factura, codigo_articulo, precio_venta, 
    cantidad, anho, numero_pedido)
VALUES (9999999999, '10010059219', '317705644', '130000', 1, 2016, 59200)

--probar update
UPDATE pedidos_articulos SET cantidad = 2
    WHERE numero_pedido = 76607;

-- recomendacion del prof jorge meza:
-- lo que hay que poner en un trigger es que aun que no haya datos relacionados
-- no permita borrar y colocas una logica tuya del negocio y tiras un mensaje
-- es decir se puede hacer un trigger que implemente alguna logica que realice algo
-- basado en las reglas de mi empresa

-- ejemplo: un cliente no tiene ningun pedido pero no se quiere que se borre
-- y se coloca un trigger donde dice "no se permite borrar ningun cliente"
-- y asi el trigger no deja borrar el cliente

-- los triggers sirven para las ventas, controlar stock, varias cosas.
-- TG_OP es una variable propia de postgresql

-- para modificar el trigger se puede modiicar la funcion o modificar el trigger directo
-- 
-- todos los clientes
SELECT cl.ruc, cl.nombre, SUM(p.total) AS TotalPedidos
FROM clientes cl JOIN pedidos p ON cl.ruc = p.ruc
GROUP BY cl.ruc, cl.nombre
ORDER BY 3 DESC;

-- si quiero eso para reporte se usa una vista 
CREATE VIEW vClientesPedidos AS
SELECT cl.ruc, cl.nombre, SUM(p.total) AS TotalPedidos
FROM clientes cl JOIN pedidos p ON cl.ruc = p.ruc
GROUP BY cl.ruc, cl.nombre
ORDER BY 3 DESC;
