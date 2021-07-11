set search_path = lab11;
--Numero de elementos
select count(nombre) from actor100;
-- 856421
select count(nombre) from actor1000;
-- 440234
select count(nombre) from actor10000;
-- 197219
select count(nombre) from pelicula100;
-- 72696
select count(nombre) from pelicula1000;
-- 22490
select count(nombre) from pelicula10000;
-- 6401
select count(a_nombre) from personaje100;
-- 2170454
select count(a_nombre) from personaje1000;
-- 944963
select count(a_nombre) from personaje10000;
-- 372367

set search_path = lab11i;
--Indexes disponibles:
--actor:
\d actor100
--btree en el primary key
--btree en genero
--btree en nombre
--pelicula:
\d pelicula100
--btree en el primary key
--btree en calificacion
--btree en nombre
--btree en votos
--personaje:
\d personaje100
--btree en el primary key
--btree en anombre (nombre del actor)
--btree en panho (año de la pelicula)
--btree en pnombre (nombre del personaje)
--btree en pnombreanho