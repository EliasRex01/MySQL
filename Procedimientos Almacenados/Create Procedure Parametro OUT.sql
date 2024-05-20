-- Parametro de salida o OUT

-- El valor del parametro OUT puede ser cambiado en el procedimiento y
-- su valor modificado sera enviado devuelta al codigo o programa que 
-- invoca el procedimiento;

-- ejemplo
delimiter $$
	create procedure Total_Ciudades(out total int)
	begin
		select count(ID) into total        -- que envie el total al parametro
        from city;
	end;
$$

-- llamando al PA
call Total_Ciudades(@nTotal);          -- esta variable guardara lo que se obtenga en el PA
select @nTotal;

-- el parametro estara a la espera de lo que genere el PA
-- expulsa el total y @nTotal lo recibe


-- Usando IN con OUT
delimiter $$
	create procedure Encontrar_ciudad(in cNombre char(35), 
									  out nRespuesta int)
	begin
		select count(ID) into nRespuesta
        from city
        where upper(trim(Name)) = upper(trim(cNombre));
	end;
$$

-- llamando al PA
call Encontrar_ciudad('Amsterdam',@nResp);
select @nResp;         -- si da 1 se encuentra, 0 no se encuentra

-- si hay error llevar en un scipt aparte el procedimiento


-- editar el PA se puede hacer con la inetrfaz grafica cick y alter procedure


