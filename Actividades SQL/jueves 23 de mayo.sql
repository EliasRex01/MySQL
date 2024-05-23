-- consulta interna
select * from clientes cl where nombres n ilike 'Gamarra%';

-- subconsulta
select * from cuentas where codigo_cliente in (select cl.codigo_cliente
												   from clientes cl 
												   where cl.nombres 
												   ilike '%Gamarra%');





