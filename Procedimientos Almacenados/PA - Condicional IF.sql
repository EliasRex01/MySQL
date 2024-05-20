-- Procedimientos Almacenados - Condicional IF
-- Se usa dentro del PA

-- Sintaxis del if
if [condicion] then
   [instrucciones]
end if;


-- ejemplo usando if dentro del PA
delimiter $$
	create procedure Saber_nombre(in Nombre varchar(20))
    begin
		if Nombre = 'Elias' then
			select 'Hola Elias';
		end if;
    end;
$$

call Saber_nombre('Elias');