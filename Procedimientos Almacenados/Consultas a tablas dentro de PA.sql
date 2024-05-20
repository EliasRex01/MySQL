-- Consultas a tablas dentro de un Procedimiento Almacenado

use world;
select * from city;
select * from country;
select * from cursos;

delimiter $$
	create procedure Listado_paises_consolidado()
	begin
		select co.Name, co.Population, ci.District 
		from country co
		inner join city ci on ci.CountryCode = co.Code;
	end;
$$

call Listado_paises_consolidado()
