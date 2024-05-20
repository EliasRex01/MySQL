-- Create Procedure - Parametro IN


CREATE PROCEDURE sp_name(param1, param2, param3)
BEGIN
	-- codigo
END;

-- Con el parametro IN, la app o el codigo que invoque el Procedimiento tendra que pasar
-- un argumento para este parametro. El procedimiento trabajara con una copia de su valor,
-- teniendo el parametro su valor original al terminar la ejecucion del procedimiento.

-- El parametro IN, es un parametro que va estar a la espera de recibir un contenido
-- para que se complemente con toda la parte del codigo del PA y se accione un resultado
-- , esto hace mas eficiente la tarea del PA 

-- ejemplo
use world;
select * from city where ID = 2;

-- siempre se debe definir el tipo de dato del parametro
delimiter $$
	create procedure Buscar_ciudad(in Xcodigo int)
	begin
		select * from city where ID = Xcodigo;
    end;
$$

-- se llama al PA
call Buscar_ciudad(3);
-- es como usar un procedimiento o subrutina

desc population;
select * from city;
-- PA que permite insertar datos dentro de una tabla
-- Un dato a definir en el procedimiento y otro a colocar manual en codigo
delimiter $$
	create procedure Insertar_ciudad(in xName char(35))
    begin
		insert into city (Name, Population)
        values( xName, 1500000);
    end;
$$
-- el tipo de dato del parametro debe tener el mismo tipo y largor que en la tabla del dato ingresado
call Insertar_ciudad('Luque');
-- ahora la tabla city ya debe tener una nueva ciudad



