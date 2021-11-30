
/*Creacion Bd Sentencias DDL*/
create database alumnos;

/*Eliminar Bd*/
--drop database alumnos;

/*Usar Bd creada*/

use alumnos;

create table alumno(
	codigo int not null identity(1,1),
	nombre varchar(40),
	primary key(codigo)
	);

	/*Alterar la tabla agregar columna*/
		alter table alumno add materia varchar(20);

   /*Eliminar columna*/
		alter table alumno drop column materia;    

create table notas(
	codigo int not null identity(1,1),
	nota decimal(12,2),
	primary key (codigo),
	foreign key (codigo) references alumno(codigo)
);


/*Sentencias DML*/

/* Insertar en tablas*/

insert into alumno(nombre,materia) values('Hamilton Urrea Benítez','Matemáticas'),
('Marcela Paola Riñon','Quimica'),('Marcela Paola Riñon','Quimica'),('Martin Lutero','Religión'),
('Paola Sanabria','Español'),('Wilder Ocampo','Biología'),('Edmundo Dante','Filosofía'),
('Miguel Cervantes','Español'),('Steve Jobs','Informática'),('Billy Gates','Informática');

insert into notas(nota) values(3.5),(4.3),(5),(4.5),(3.8),(2.8),(4.2),(3.9),(5),(4.9);

/*Seleccionar Registros*/

select codigo,nombre,materia from alumno;
select * from notas;


/*Actualizar Registros*/

update alumno set materia = 'Religión' where codigo = 4;

update notas set nota = 5 where codigo = 6;

/*Eliminar Registros*/
delete from alumno where codigo = 6;

/*Porcedimientos almacenados*/

create procedure SP_ConsultarAlumnos

as
Begin
select * from alumno;
end
go

/*Ejecutar Procedimiento*/
execute SP_ConsultarAlumnos; 
select * from alumno;

create procedure SP_ConsultarNotas
as
Begin
select * from notas;
end
go

/*Ejecutar Procedimiento*/
execute SP_ConsultarNotas;
 

create procedure SP_InsertarAlumno
@nombre varchar(40),
@materia varchar(20)
as
Begin
insert into alumno(nombre,materia) values(@nombre,@materia);
end
go

/*Ejecutar Procedimiento*/
execute SP_InsertarAlumno @nombre='Pepe',@materia='Sociales';
select * from alumno;

create procedure SP_InsertarNotas
@nota decimal(12,2)
as
Begin
insert into notas(nota) values(@nota);
end
go

/*Ejecutar Procedimiento*/
execute SP_InsertarNotas @nota=4.6;
select * from notas;

create procedure SP_ActualizarAlumno
@nombre varchar(40),
@materia varchar(20)
as
Begin
update alumno set nombre=@nombre,materia=@materia;
end
go

/*Ejecutar Procedimiento*/
execute SP_ActualizarAlumno @nombre='Cristo',@materia='Español' where codigo='1';
select * from alumno;


create procedure SP_ActualizarNotas
@codigo int,
@nota decimal(12,2)
as
Begin
update notas set nota=@nota where codigo=@codigo;
end
go


/*Ejecutar Procedimiento*/
execute SP_ActualizarNotas @nota=3.8 where codigo=1;
select * from notas;

create procedure SP_EliminarAlumno
@codigo int
as
Begin
delete from alumno where codigo=@codigo;
end
go

exec SP_EliminarAlumno @codigo=1;


create procedure SP_EliminarNota
@codigo int
as
Begin
delete from notas where codigo=@codigo;
end
go


exec SP_EliminarNota @codigo=1;
select * from notas;


/*******************CLAUSULA DE JOINS******************************/

/*INNER JOIN*/
select * from alumno a
JOIN notas n
ON a.codigo = n.codigo;

/* LEFT JOIN*/
SELECT
a.nombre as 'Nombre',
n.nota as 'Notas'
from alumno a
left join notas n
on a.codigo=n.codigo;

/* RIGHT JOIN*/
SELECT
a.nombre as 'Nombre',
n.nota as 'Notas'
from alumno a
right join notas n
on a.codigo=n.codigo;


/* FULL JOIN*/
SELECT
a.nombre as 'Nombre',
n.nota as 'Notas'
from alumno a
full join notas n
on a.codigo=n.codigo;