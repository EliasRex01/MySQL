-- FUNCIONES DE AGREGACION USANDO LA TABLA numpidb

-- 1. Obtener el indide de masa corporal promedio para las mujeres
-- y para los hombres
USE numpibd;
SELECT * FROM imc;
SELECT sexo, ROUND(AVG(imc),3) AS IMC_AVG FROM imc GROUP BY sexo;


-- 2. Calcular la edad promedio de los estudiantes
SELECT * FROM estudiantes;
SELECT ROUND(AVG(edad)) AS "EDAD PROMEDIO" FROM estudiantes;

-- 3. Obtener el maximo indice de masa corporal para cada edad

SELECT * FROM imc;
SELECT edad, MIN(imc) AS "IMC minimo", 
ROUND(AVG(IMC),2) AS "IMC promedio", 
MAX(imc) AS "IMC maximo" FROM imc GROUP BY edad;