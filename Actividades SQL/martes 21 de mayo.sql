-- cuantos pedidos se tuvieron en estas fechas
select * from pedidos p
where fecha between '01/01/2016'
and '31/01/2016'
limit 5;


-- que dia hubo mas pedidos
select fecha "Fecha", count(*) "Cantidad", sum(total) "Monto Total" 
from pedidos p
where fecha 
between '01/01/2016'and '31/01/2016'
group by fecha
order by 2 desc
limit 5;
