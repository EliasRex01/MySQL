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

    -- inserted es la tabla temporal del insert

    select @cs = codigo_sucursal from pedidos
    where anho = @anio and numero_pedido = @num

    -- la fila a actualizar
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

