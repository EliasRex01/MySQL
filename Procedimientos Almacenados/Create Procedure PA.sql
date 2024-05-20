-- Procedimientos Almacenados
-- Contienen varias declaraciones separadas por punto y coma. Son varias instrucciones que nosotros 
-- podríamos definir y todo eso podríamos fijarlo como solo un bloque de tarea, o sea, un procedimiento almacenado.
-- Viene con tener varias declaraciones y todo ese conjunto lo enviamos como un como una sola tarea.
-- Ahora los procedimientos almacenados nosotros lo podemos crear, guardar y o solicitarlas cada vez que
-- nosotros lo necesitemos ya para poder realizar ciertas acciones que definamos dentro de ellos.

-- Dentro de un procedimiento almacenado vamos a tener varias declaraciones que van a requerir que finalicen 
-- como el punto y coma. Entonces vamos a tener varias líneas de codificación donde termina el punto y coma.

-- Entonces, como nosotros le indicamos a ver que eso no son tareas por separado, sino que todo eso es
-- un bloque de procesos, entonces es ahí donde nosotros vamos a utilizar un pequeño proceso que se llama
-- de limitadores para poder encapsular toda esa parte o porción de código en una sola tarea.


-- begin para poder saber que es el inicio del contenido del procedimiento.
-- Siempre los procedimiento almacenado finalizan con el N, con el punto y coma y están encapsulado con un delimitador.
-- Tenemos que apoyarnos con el comando call ya para poder invocar la acción que tiene este procedimiento almacenado.

-- Cuando nosotros hacemos call lo que va a hacer es ir a encontrar este procedimiento almacenado y ejecutar
-- todo lo que tiene en la parte interna.

-- el encapsulador o delimitador delimita un bloque de codigo que sera un procedimiento almacenado


-- Create procedure
CREATE PROCEDURE sp_name(parametros)
BEGIN
	-- statements
END;

use world;
-- procedimiento almacenado que guarda una consulta
delimiter $$
	CREATE PROCEDURE Listado_paises()
	begin	
			select * from country;
	end;
$$

-- delimitadores $$ para indicar que es un bloque
-- delimites $$
--       procedimiento almacenado
-- $$

-- para ejecutar el procedimiento almacenado se usa call
call Listado_paises()

-- Y qué es lo que tiene en la parte interna?
-- Una consulta hacia la tabla Artículos.