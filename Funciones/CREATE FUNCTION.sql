-- CREATE FUNCTION - crear funciones

-- es parecido al PA pero va aplicado a realizar una determinada tarea

-- Sintaxis es
-- CREATE OR REPLACE FUNCTION nueva_funcion()
-- RETURNS INTEGER AS $$
-- BEGIN
--     RETURN 1;
-- END;
-- $$ LANGUAGE plpgsql;


-- Ejemplo de funcion suma
CREATE OR REPLACE FUNCTION sumar(Valor1 INTEGER, Valor2 INTEGER)
RETURNS INTEGER AS $$
BEGIN
    RETURN Valor1 + Valor2;
END;
$$ LANGUAGE plpgsql;

select Suma(3,5);


-- Ejemplo de funcion mas compleja

CREATE OR REPLACE FUNCTION operacion_full(
    valor1 INT,
    valor2 INT,
    op VARCHAR(15)
) 
RETURNS INT AS $$
DECLARE
    resultado INT;
BEGIN
    IF op = 'SUMA' THEN
        resultado = valor1 + valor2;
    ELSIF op = 'RESTA' THEN
        resultado = valor1 - valor2;
    ELSIF op = 'MULTIPLICA' THEN
        resultado = valor1 * valor2;
    ELSE
        resultado = 0;
    END IF;
    RETURN resultado;
END;
$$ LANGUAGE plpgsql;

select Operacion_full(3,5,'RESTA');
