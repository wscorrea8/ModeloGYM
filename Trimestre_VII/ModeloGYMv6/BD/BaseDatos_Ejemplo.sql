/*Sentencias DDL*/

-- Crear Base de datos ejemplo--
-- drop database ejemplo;
create database ejemplo;

use ejemplo;

/*Crear tabla clientes*/

create table clientes(
	codigo int not null identity (1,1),
	nombre varchar(40),
	primary key(codigo)
);


create table ventas(
	codigo int not null identity (1,1),
	nombre varchar(40),
	primary key(codigo)
);

/*Alterar la tabla clientes*/
alter table clientes add factura varchar(10);


/*Alterar la tabla ventas*/
alter table ventas add valor decimal(12,2);

/*Seleccionar registros de clientes*/
select * from clientes;
select * from ventas;

/*Sentencias DML*/

/*Modificar el tipo de campo en una tabla*/
alter table clientes alter column factura varchar(10);


/*insertar registros tabla clientes*/
	insert into clientes(nombre,factura) values ('Juliana Martines','FA301'),('Betilda Ocampo','FA302'),('Emerito Galindo','FA303'),
	('Carlos Gardel','FA304');


/*insertar registros tabla ventas*/
	insert into ventas(nombre,valor) values ('Manzanas',23600),('Tomates',18900),('Aguacates',21000),('Guayabas',13100);

/*Actualizar registros*/
	update clientes set nombre = 'Juliana Martinez' where codigo = 1;


/*Eliminar rtegistros*/
	delete clientes where codigo = 3;

/*Procedimientos Almacenados*/

/*SP Consulta Registros Clientes*/
create procedure SP_ConsultarRegistrosClientes
@factura varchar(10)
as
Begin
select factura from clientes;
end
go

/*Ejecutar Procedimiento*/
exec SP_ConsultarRegistrosClientes @factura='FA301';

select * from clientes where factura = 'FA301';


/*SP Consulta Registros ventas*/
create procedure SP_ConsultarRegistrosVentas
@codigo int
as
Begin
select @codigo from ventas;
end
go

/*Ejecutar Procedimiento*/
execute SP_ConsultarRegistrosVentas @codigo= 1; 


/*SP Insertar Registros Clientes*/
create procedure SP_InsertarRegistrosClientes
@nombre varchar(40),
@factura varchar(10)
as
Begin
insert into clientes(nombre,factura) values(@nombre, @factura);
end
go

/*Ejecutar Procedimiento*/
execute SP_InsertarRegistrosClientes @nombre='Julianita', @factura='FA305'; 

select * from clientes;

/*SP Insertar Registros ventas*/
create procedure SP_InsertarRegistrosVentas
@nombre varchar(40),
@valor decimal(12,2)
as
Begin
insert into ventas(nombre,valor) values(@nombre, @valor);
end
go

/*Ejecutar Procedimiento*/
execute SP_InsertarRegistrosVentas @nombre='Julianita', @valor=10500; 
select * from ventas;

/*SP Actualizar Registros Clientes*/
create procedure SP_ActualizarRegistrosClientes
@nombre varchar(40),
@factura varchar(10)
as
Begin
update clientes set nombre=@nombre,factura=@factura;
end
go

/*Ejecutar Procedimiento*/
execute SP_ActualizarRegistrosClientes @nombre='Julianita', @factura='FA302'; 

select * from clientes;


/*SP Actualizar Registros ventas*/
create procedure SP_ActualizarRegistrosVentas
@nombre varchar(40),
@valor decimal(12,2)
as
Begin
update ventas set nombre=@nombre,valor=@valor;
end
go


/*Ejecutar Procedimiento*/
execute SP_ActualizarRegistrosVentas @nombre='Juliania', @valor=10500; 
select * from ventas;


/*SP Eliminar Registros Clientes*/
create procedure SP_EliminarRegistrosClientes
@codigo int
as
Begin
delete from clientes where codigo = @codigo;
end
go

/*Ejecutar Procedimiento*/
execute SP_EliminarRegistrosClientes @codigo=2; 

select * from clientes;

/*SP Eliminar Registros ventas*/
create procedure SP_EliminarRegistrosVentas
@codigo int
as
Begin
delete from ventas where codigo=@codigo;
end
go


/*Ejecutar Procedimiento*/
execute SP_EliminarRegistrosVentas @codigo=2; 
select * from ventas;

/*******************CLAUSULA DE JOINS******************************/

/*INNER JOIN*/
select * from clientes c
JOIN ventas v
ON c.codigo = v.codigo;

/* LEFT JOIN*/
SELECT
c.nombre as 'Nombre',
v.valor as 'Valor'
from clientes c
left join ventas v
on c.codigo=c.codigo;

/* RIGHT JOIN*/
SELECT
c.nombre as 'Nombre',
v.valor as 'Valor'
from clientes c
right join ventas v
on c.codigo=c.codigo;

/* FULL JOIN*/
SELECT
c.nombre as 'Nombre',
v.valor as 'Valor'
from clientes c
full join ventas v
on c.codigo=c.codigo;