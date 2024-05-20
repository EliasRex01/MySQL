-- CREATE FUNCTION - crear funciones

-- es parecido al PA pero va aplicado a realizar una determinada tarea

-- Sintaxis es
-- CREATE FUNCTION 'nueva funcion' ()
-- RETURNS INTEGER
-- BEGIN

-- RETURN 1;
-- END


-- Ejemplo de una funcion
delimiter $$
	CREATE FUNCTION `HolaMundo` ()
	RETURNS varchar(30)
	DETERMINISTIC
	BEGIN
		RETURN 'Hola Mundo de MySQL Server';
	END;
$$

-- llamar a la funcion con  select
select HolaMundo();


-- Ejemplo de funcion suma
delimiter $$
	create function Suma(Valor1 int, Valor2 int) returns int
    deterministic
    begin
		declare Resultado int;
        set Resultado = Valor1+Valor2;
		return Resultado;
	end;
$$

select Suma(3,5);


-- Ejemplo de funcion mas compleja
delimiter $$
	create function Operacion_full(Valor1 int,
									Valor2 int,
                                    Op varchar(15)) 
	returns int
    deterministic
    begin
		declare Resultado int;
        if Op = 'SUMA' then
			set Resultado = Valor1+Valor2;
        elseif Op = 'RESTA' then
			set Resultado = Valor1-Valor2;
		elseif Op = 'MULTIPLICA' then
            set Resultado = Valor1*Valor2;
		else
			set Resultado=0;
		end if;
		return Resultado;
	end;
$$

select Operacion_full(3,5,'RESTA');