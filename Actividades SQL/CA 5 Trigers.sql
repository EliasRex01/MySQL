-- el triger se hace sobre la tabla que queremos disparar el triger

-- creacion de un trigger para insertar
CREATE TRIGGER ins_stock               -- nombre del trigger
    ON pedidos_articulos               -- se indica sobre que tabla debe actuar
    AFTER INSERT                       -- que accion disparara este trigger
AS
BEGIN

    SET NOCOUNT ON      -- previene que existan resultados extras que interfieran con el trigger
