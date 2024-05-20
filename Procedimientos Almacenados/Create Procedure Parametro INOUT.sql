-- Parametro INOUT o entrada-salida

-- El INOUT es una mezcla del in y el out, la aplicacion o codigo que invoca
-- al procedimiento puede pasarle un valor a este, devolviendo el valor modificado
-- al terminar la ejecucion. En caso de resultante confuso, echa un ojo al
-- ejemplo que veras mas adelante. 

use world;
select * from city;    -- ID y District char(20)
desc city;
-- El parametro INOUT puede tener un valor inicial y un valor final

-- el id es de tipo int y el distrito es char, hay que castear
delimiter $$
	create procedure Mostrar_Distrito(inout Contenido char(20))
    begin
		select District into Contenido
		from city
        where trim(cast(id as char)) = trim(Contenido);
    end;
$$
-- Contenido viene con un valor que es el id de la ciudad
-- y se va con el valor del distrito de la ciudad

-- se debe suar el set para mandar otro valor
set @Texto='5';
call Mostrar_Distrito(@Texto);
select @Texto;
-- primero se almacena el valor en la variable con un valor original
-- se manda la variable al procedimiento y se consulta la varible
-- se ve que el valor de vuelta ya no es el definido 