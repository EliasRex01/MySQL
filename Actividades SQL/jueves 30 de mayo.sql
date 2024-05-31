# cual es el numero de cheques
select * from chequera where numero_chequera = 1;

-- seleccionar el ultimo insertado en numero_chequera
select max() from chequera
where numero_chequera =1 and fecha;

select * from chequera
where numero_chequera and fecha
order by 1 desc
limit 1;
