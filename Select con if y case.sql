-- select con if y el case

select codigo_ar,
		descripcion_ar,
		if(estado=1,'activo','anulado')
from tb_articulos;

-- trabajando con case 
if(condition, value_if_true, value_if_false)

case
	when condicion1 then resultado1
    when condicion2 then resultado2
    else resultado_por_defecto
end;

select codigo_ar	
	(case descripcion_ar
		when 'Escritorio' then '(Nueva Oferta)'
        when 'Cementos' then '(Nueva Oferta)'
        else descripcion_ar
	end) as Articulos
from tb_articulos;

