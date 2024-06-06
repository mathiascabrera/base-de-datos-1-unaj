drop database if exists cine;

create database if not exists cine;
use cine;

create table peliculas(
codigo int not null primary key,
nombre NVARCHAR(100) not null,
calificacionedad enum('0','13','16','18') not null
);

create table salas(
codigo int not null primary key,
nombre varchar(100) not null,
pelicula int not null,
foreign key (pelicula) references peliculas(codigo)
);



INSERT INTO peliculas VALUES (1,"Avangers","0"),
(2,"Rambo","18"),
(3,"Crepusculo","13"),
(4,"Ñoño","16");

INSERT INTO salas VALUES (10,"Sala1",1),(11,"Sala2",2),(12,"Sala3",3),(13,"Sala4",4);


SELECT*FROM peliculas;

SELECT*FROM salas;

SELECT nombre, calificacionedad FROM peliculas;

SELECT nombre FROM peliculas
WHERE calificacionedad = "18";

-- 1.	Traer el nombre de todas las películas formateando la salida a “Nombre de la película”.
SELECT nombre AS "Nombre de la pelicula" FROM peliculas;

-- 2.	Traer las calificaciones posibles para las películas .
SELECT DISTINCT calificacionedad FROM peliculas;

-- 3.	Traer el nombre de aquellas películas que aún no tienen calificación.
SELECT nombre FROM peliculas
WHERE calificacionedad IS NULL;

 -- 4.	Traer aquellas salas que no proyectan ninguna película.

SELECT s.nombre, p.nombre FROM salas s
INNER JOIN peliculas p ON s.pelicula = p.codigo
WHERE p.calificacionedad = "0";

-- RESPUESTA
SELECT nombre FROM salas
WHERE pelicula = NULL;

-- 5.	Traer el nombre de aquellas películas que tienen una ñ o Ñ en su nombre.

SELECT nombre from peliculas where nombre LIKE ("%Ñ%") OR nombre LIKE ("%ñ%");
















