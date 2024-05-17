-- JOIN con multiples tablas (mas de dos)
USE employees;
SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM departments;
-- se usan columnas comunes para relacionar todas las tablas con el JOIN

SELECT * FROM employees E
JOIN dept_emp DE
ON E.emp_no = DE.emp_no
JOIN departments D
ON D.dept_no = DE.dept_no;

-- solo el nombre del empleado y su departamento perteneciente
SELECT E.first_name AS Nombre, E.last_name AS Apellido, D.dept_name FROM employees E
JOIN dept_emp DE
ON E.emp_no = DE.emp_no
JOIN departments D
ON D.dept_no = DE.dept_no;

-- nombre del empleado, departamento y sueldo
SELECT 
E.first_name AS Nombre, 
E.last_name AS Apellido,
S.salary AS Salario, 
D.dept_name AS Departamento
FROM employees E
JOIN dept_emp DE
ON E.emp_no = DE.emp_no
JOIN departments D
ON D.dept_no = DE.dept_no
JOIN salaries S
ON S.emp_no = E.emp_no;


-- Ejercicio de JOIN
-- Determinar el salario promedio de cada departamento y ordenar los
-- resultados de mayor a menor
USE employees;
-- inner join y los campos que se relacionan

-- primero se ven todos los campos
SELECT * FROM departments D
JOIN dept_emp DE
ON DE.dept_no = D.dept_no
JOIN salaries S
ON S.emp_no = DE.emp_no;

-- los campos que se quieren
SELECT D.dept_name AS Departamento, AVG(S.salary) AS "Salario Promedio"
 FROM departments D
JOIN dept_emp DE
ON DE.dept_no = D.dept_no
JOIN salaries S
ON S.emp_no = DE.emp_no
GROUP BY D.dept_name
ORDER BY AVG(S.salary) DESC;
-- departamento y salario promedio de cada departamento

-- Nota: primero se crea una nueva tabla con los join y luego se aplican las funciones sobre la nueva tabla
