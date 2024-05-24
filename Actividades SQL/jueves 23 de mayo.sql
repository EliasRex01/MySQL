-- consulta interna
select * from clientes cl where nombres n ilike 'Gamarra%';

-- subconsulta
select * from cuentas where codigo_cliente in (select cl.codigo_cliente
												   from clientes cl 
												   where cl.nombres 
												   ilike '%Gamarra%');

-- ahorristas cuyo apellido es gamarra (50 son personas, osea un cliente puede tener mas de una cuenta)
select count(distinct c.codigo_cliente) from cuentas c where codigo_cliente in (select cl.codigo_cliente
												   from clientes cl 
												   where cl.nombres 
												   ilike '%Gamarra%');

-- usando join, por cada cliente la cantidad de cuentas que tiene
select cl.nombres, count(cu.codigo_cuenta) as cantidad from clientes cl
join cuentas cu on cl.codigo_cliente = cu.codigo_cliente
group by cl.nombres
order by 2 desc
limit 10;

-- cuantos clientes tengo


-- los que no tienen cuentas
select codigo_cliente, nombres from clientes where codigo_cliente not in 
(select codigo_cliente from cuentas)
 
-- cantidad de personas que no tienen cuentas
select codigo_cliente, nombres from clientes where codigo_cliente not in 
(select codigo_cliente from cuentas)

-- los que son clientes
select * from clientes cl
where exists (select 1 from cuentas cu where cu.codigo_tipo = 3 
			  and cu.codigo_cliente = cl.codigo_cliente);
			  
-- los que no
select distinct cl.codigo_cliente, cl.nombres from clientes cl
where exists (select 1 from cuentas cu where cu.codigo_tipo = 3 
			  and cu.codigo_cliente = cl.codigo_cliente);
