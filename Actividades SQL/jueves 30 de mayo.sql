# cual es el numero de cheques
select * from chequera where numero_chequera = 1;

-- seleccionar el ultimo insertado en numero_chequera
select max() from chequera
where numero_chequera =1 and fecha;

select * from chequera
where numero_chequera and fecha
order by 1 desc
limit 1;

-- uso de la vista
select * from vextractocuentasv
where numero_cuenta = '100100123'
order by fecha desc;


