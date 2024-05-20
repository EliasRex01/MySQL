-- Procedimientos Almacenados - Condicional IF ELSEIF ELSE END IF
-- es una estrutura condicional anidada

-- Sintaxis es:
if [condicion] then
	[instrucciones]
elseif [condicion] then
[instrucciones]
elseif [condicion] then
[instrucciones]
.....
else
	[instrucciones]
end if;


-- usando multiples condiciones
delimiter $$
	create procedure Operacion_matematica_full(in Valor1 int,
										  in Valor2 int,
                                          in Operacion varchar(20))
    begin
		if Operacion = 'SUMA' then
			select Valor1 + Valor2;
		elseif Operacion = 'RESTA' then
			select Valor1 - Valor2;
		elseif Operacion = 'MULTIPLICA' then
			select Valor1 * Valor2;
		else
			select 'No tengo esa operacion matematica';
		end if;
    end;
$$

call Operacion_matematica_full(5,10,'MULTIPLICA');