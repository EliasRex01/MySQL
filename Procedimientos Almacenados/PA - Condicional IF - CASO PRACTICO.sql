-- Procedimientos Almacenados - Condicional IF CASO PRACTICO


use world;
desc country;   -- Name char(52), Region char(26), SurfaceArea decimal(10,2)
-- Population int, LieExpectancy decimal(3,1)
-- se quiere un PA que permita insertar registros como actualizar usando if


-- EstadoGuarda es una variable admin, si lleva un valor 1 se hace una insertado
-- si lleva un valor 2 se hace una actualizacion
delimiter $$
	create procedure Mantenimiento_curso(in Codigo int,
										  in NombreCurso char(52),
                                          in EstadoGuarda int)
    begin
		if EstadoGuarda = 1 then
			insert into cursos(nombre_curso, id_curso) values (NombreCurso,5);
		elseif EstadoGuarda = 2 then
			update cursos set nombre_curso = NombreCurso where id_curso = Codigo;
		else
			select 'Accion de tarea no permitida';
		end if;
    end;
$$
-- el parametro codigo se usa para el escenario de actualizacion
-- en la insercion no se usa
call Mantenimiento_curso(0,'Informatica',1);

-- para ver el resultado se usa el select de la tabla afectada, en este caso cursos;

-- para insertar se usa el parametro 0 o vacio, por que no se usa el codigo en 
-- la insercion
