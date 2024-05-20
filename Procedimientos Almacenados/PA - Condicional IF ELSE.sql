-- Procedimiento Almacenados - Condicional IF ElSE
-- se tiene una respuesta si se cumple y sino tambien una respuesta

-- sintaxis es
if [condicion] then
	[instrucciones]
else
	[instrucciones]
end if;



-- ejemplo usando if else dentro del PA
delimiter $$
	create procedure Saber_nombre(in Nombre varchar(20))
    begin
		if Nombre = 'Elias' then
			select 'Hola Elias';
		else
			select 'Nombre desconocido';
		end if;
    end;
$$

call Saber_nombre('Eli');


-- usando matematicas como ejemplo
delimiter $$
	create procedure Operacion_matematica(in Valor1 int,
										  in Valor2 int,
                                          in Operacion varchar(20))
    begin
		if Operacion = 'SUMA' then
			select Valor1 + Valor2;
		else
			select 'No tengo esa operacion matematica';
		end if;
    end;
$$

call Operacion_matematica(5,10,'RESTA');