-- Trigers o Disparadores
-- Es un conjunto de sentencias SQL las cuales se ejecutan de forma automatica
-- cuando ocurre algun evento que modifique a alguna tabla; pero non una modificacion
-- de estructura sino una modificacion en los datos almacenados, es decir, cuando
-- se ejecute una sentencia INSERT, UPDATE o DELETE.

-- A diferencia de una funcion o un procedure, un trigger no puede existir sin 
-- una tabla asociada.

-- Los trigrers se pueden programar de tal manera que se ejecuten antes o despues,
-- de dichas sentencias; Dando como resultado seis combinaciones de eventos.


-- Con la interfaz grafica
-- se da alter table sobre una tabla y se busca triggrer


-- Las 6 combinaciones son:
# BEFORE INSERT Acciones a realizar antes de insertar uno o mas registros en una tabla.
# AFTER INSERT Acciones a realizar despues de insertar uno o mas registrps en una tabla.
# BEFORE UPDATE Acciones a realizar antes de actualizar uno o mas registros en una tabla.
# AFTER UPDATE Acciones a realizar despues de actualizar uno o mas registrps en una tabla.
# BEFORE DELETE Acciones a realizar antes de eliminar uno o mas registros en una tabla.
# AFTER DELETE Acciones a realizar despues de eliminar uno o mas registros en una tabla.




-- permite monitorear lo que pasa en una tabla
-- En un caso por ejemplo si un usuario realiza una accion a que hora lo hizo
-- como lo hizo, etc.