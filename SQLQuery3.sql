create database db1

create table categoria 
(
id int identity primary key,
Nombre varchar (50) 
)
 

create table medicamento 
( 
id int identity ,
nombre varchar (35),
precio float default 0, 
idcategoria int,
constraint id_categoria foreign key (idcategoria)references categoria(id)

)