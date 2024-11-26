create database libros 
go 
use libros
go 

create table autor 
(
id int identity primary key,
nombre varchar (100) not null
)
insert into autor values ('Ramno Valdes'),('Bruce Banner')
select*from autor 
create table libro
(
id int identity primary key ,
nombre varchar(100)not null,
fecha_public date ,
idautor int foreign key references autor(id)
)
insert into libro(nombre,fecha_public,idautor)values('La vencidad','2024/11/22',1)
insert into libro(nombre,fecha_public,idautor)values('El gran hulk','2023/01/22',2)
--procedimiento alamcenados
--ingresar 
create procedure Ingresar 
@nombre varchar (100)
as
begin
insert intate o autor values (@nombre)
end 

create  procedure BorrarAutor
@id int 
as 
begin
delete autor where id= @id
end

create procedure ModificarAutor
@id int,
@nombre varchar (100)
as
begin
update autor set nombre=@nombre where id = @id
end
exec Modificar3.'Jhon Maxwell'
exec ConsultarAutor

create procedure ConsultarAutor
as 
begin
select*from autor
end
