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

-- en una sola sentencia cual es el saldo de mi cuenta modificando el anterior codigo


Select numero_cuenta,
Sum(ingreso) depósitos,
Sum(egreso) cheques,
Sum(ingreso) - sum(egreso) saldo
from cheques
Order by 1 desc
Limit 1;


-- muestre el saldo linea por linea usando calcularsaldo
select *,
calcularsaldo(numero_cuenta, numero, operacion) as saldo
from vextractocuentas v
where numero_cuenta = '100100123'
order by fecha desc;
