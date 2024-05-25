-- el triger se hace sobre la tabla en la que queremos disparar el triger, 
-- la del calculo es otra tabla

-- para alterar el trigger es ALTER TRIGGER

-- creacion de un trigger para insertar
CREATE TRIGGER ins_stock               -- nombre del trigger
    ON pedidos_articulos               -- se indica sobre que tabla debe actuar
    AFTER INSERT                       -- que accion disparara este trigger
AS 
DECLARE
    @ca int,
    @anio int,
    @num int,
    @cs int,
    @cant int,
    @cantart int
BEGIN

    SET NOCOUNT ON      -- previene que existan resultados extras que interfieran con el trigger

    -- actualizar el stock de una sucursal, se necesita cod_sucursal y cod_articulo
    select @ca = codigo_articulo from inserted; -- a la par que se recupera se guarda en ca
    select @anio = anho from inserted;
    select @num = numero_pedido from inserted;
    select @cant = cantidad from inserted;

    -- inserted es la tabla temporal del insert  (en este caso es copia de predidos_articulos)

    select @cs = codigo_sucursal from pedidos     -- codigo_sucursal se recupera de pedidos
    where anho = @anio and numero_pedido = @num

    -- obtener la cantidad que tenemos en articulo_sucursal (se recupera)
    select @cantart = stock from articulos_sucursal
    where codigo_articulo = @ca and codigo_sucursal = @cs

    if (@cant < @cantart)     -- si cantidad a vender es menor a cantidad que tengo
    begin
        -- dato a actualizar del stock. (update sobre articulos_sucursal para el campo stock)
        update articulos_sucursal
        set stock = stock - @cant            -- una venta, osea aumenta el pedido y baja el stock
        where codigo_articulo = @ca and codigo_sucursal = @cs
    end
        
END
GO


-- un numero de pedido que no exista en pedido_detalle
select * from pedidos where numero_pedido 
not in (select numero_pedido from pedidos_articulos)
limit 10;

-- borrar uno de esos datos encontrados
delete pedidos_articulos where numero_pedido = 11 and anho = 2016;

-- insertar un elemento en ese lugar vacio
insert into (codigo_detalle, factura, codigo_articulo, precio_venta, 
    cantidad, anho, numero_pedido)
values (85700, 10010058866, 105262, 100000, 10, 2016, 49781)    -- venta de 10

-- ver los cambios 
select * from articulos_sucursal where codigo_articulo = 105262;  





-- creacion de un trigger para borrar
CREATE TRIGGER del_stock               -- nombre del trigger
    ON pedidos_articulos               -- se indica sobre que tabla debe actuar
    AFTER DELETE                       -- que accion disparara este trigger
AS 
DECLARE
    @ca int,
    @anio int,
    @num int,
    @cs int,
    @cant int,
    @cantart int
BEGIN

    SET NOCOUNT ON      -- previene que existan resultados extras que interfieran con el trigger

    -- actualizar el stock de una sucursal, se necesita cod_sucursal y cod_articulo
    select @ca = codigo_articulo from deleted; -- a la par que se recupera se guarda en ca
    select @anio = anho from deleted;
    select @num = numero_pedido from deleted;
    select @cant = cantidad from deleted;

    -- inserted es la tabla temporal del insert  (en este caso es copia de predidos_articulos)

    select @cs = codigo_sucursal from pedidos     -- codigo_sucursal se recupera de pedidos
    where anho = @anio and numero_pedido = @num

    -- obtener la cantidad que tenemos en articulo_sucursal (se recupera)
    select @cantart = stock from articulos_sucursal
    where codigo_articulo = @ca and codigo_sucursal = @cs

    if (@cant < @cantart)     -- si cantidad a vender es menor a cantidad que tengo
    begin
        -- dato a actualizar del stock. (update sobre articulos_sucursal para el campo stock)
        update articulos_sucursal
        set stock = stock - @cant            -- una venta, osea aumenta el pedido y baja el stock
        where codigo_articulo = @ca and codigo_sucursal = @cs
    end
        
END
GO


-- creacion de un trigger para update
CREATE TRIGGER upd_stock               -- nombre del trigger
    ON pedidos_articulos               -- se indica sobre que tabla debe actuar
    AFTER UPDATE                       -- que accion disparara este trigger
AS 
DECLARE
    @ca int,
    @anio int,
    @num int,
    @cs int,
    @cant int,
    @cantart int
BEGIN

    SET NOCOUNT ON      -- previene que existan resultados extras que interfieran con el trigger

    -- actualizar el stock de una sucursal, se necesita cod_sucursal y cod_articulo
    select @ca = codigo_articulo from deleted; -- a la par que se recupera se guarda en ca
    select @anio = anho from deleted;
    select @num = numero_pedido from deleted;
    select @cant = cantidad from deleted;

    -- para update se crean 2 tablas temp  (en este caso es copia de predidos_articulos)
    -- la primera es deleted (anterior a modificacion)
    -- la segunda es inserted (el dato nuevo)

    select @cs = codigo_sucursal from pedidos     -- codigo_sucursal se recupera de pedidos
    where anho = @anio and numero_pedido = @num

    -- obtener la cantidad que tenemos en articulo_sucursal (se recupera)
    select @cantart = stock from articulos_sucursal
    where codigo_articulo = @ca and codigo_sucursal = @cs

    if (@cant < @cantart)     -- si cantidad a vender es menor a cantidad que tengo
    begin
        -- dato a actualizar del stock. (update sobre articulos_sucursal para el campo stock)
        update articulos_sucursal
        set stock = stock - @cant            -- una venta, osea aumenta el pedido y baja el stock
        where codigo_articulo = @ca and codigo_sucursal = @cs
    end
        
END
GO


-- Creacion de trigger
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

