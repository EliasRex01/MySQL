-- Crear base de datos nueva
#CREATE DATABASE nueva_BD;

-- Crear usuario nuevo con password
#CREATE USER 'nuevo_usuario'@'localhost' IDENTIFIED BY '1234';

-- Dar permisos de una tabla a un usuario
#GRANT ALL PRIVILEGES ON nueva_BD.* TO 'nuevo_usuario'@'localhost';
#FLUSH PRIVILEGES;

-- para usar una base de datos
#USE bd1;


#En SQL primero se ingresa el comando y luego la sentencia

-- para instalar una tabla descargada
-- primeramente en cmd ingreso mysql -uroot -p y luego la contra
-- para crear bd en cmd se usa   create database world; por ejemplo
-- para enlazar a un archivo sql se pone use world; en este caso
-- luego abajo se pone SOURCE Downloads\\world.sql; (o carpeta donde este)
-- o en lugar de downloads\wrold la direccion absoluta ej C:\Users\HP\Downloads\archivo

-- GRANT ALL PRIVILEGES ON numpibd.* TO 'root_user'@'localhost'; root no es un usuario
-- GRANT ALL PRIVILEGES ON numpibd.* TO 'root'@'localhost'; correcto
-- flush privileges;
