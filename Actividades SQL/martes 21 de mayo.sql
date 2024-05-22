-- cuantos pedidos se tuvieron en estas fechas
select * from pedidos p
where fecha between '01/01/2016'
and '31/01/2016'
limit 5;


