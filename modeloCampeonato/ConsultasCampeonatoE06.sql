USE Campeonato;
/*Informar apellido y nombre de los pilotos que componen el equipo 41.*/
SELECT nombre,apellido FROM Piloto WHERE(idEquipo = 41);
/*Selecciona los nombres de Equipo donde la marca sea Yamaha*/
SELECT A.descripcion 
FROM Equipo A INNER JOIN Marca B ON A.idEquipo = B.idMarca
WHERE (B.descripcion = "Yamaha");

/*Informa la cantidad de motos por cada nombre de equipo*/
SELECT A.idMoto, COUNT(*) 
FROM Moto A INNER JOIN Equipo B ON A.idEquipo = B.idEquipo
GROUP BY B.descripcion 

/*Consultar los pilotos cuyo apellido comienza con la letra ´S´ y hayan 
participado en alguna carrera de cualquier categoría.*/

SELECT A.apellido
FROM Piloto A INNER JOIN Carrera B ON B.idPiloto = A.idPiloto 
 WHERE A.apellido LIKE 'S%'; 
 
 /*Informar los cinco pilotos con mayor puntaje para todas categorías*/
 
select a.idPiloto, b.Puntaje
from Carrera a inner join Puesto b
on a.idPuesto = b.idPuesto
WHERE a.idPiloto
order by b.Puntaje desc	LIMIT 5;

/*¿Cantidad de puntos por nombre de marca y por los nombres de cada 
una de las categorías?*/
SELECT 
    D.idMarca,
    D.descripcion,
    C.idEquipo,
	A.idCategoria,
    SUM(B.puntaje)
FROM
	Piloto A
	INNER JOIN
	(
		SELECT
			A.idCategoria  Categoria,
			A.idPiloto     Piloto,
			SUM(B.puntaje) Puntaje
		FROM 
			Carrera A
			INNER JOIN Puesto B
			ON
			(
				A.idPuesto = B.idPuesto
			)
		GROUP BY
			A.idCategoria, 
			A.idPiloto
	) B
	ON
	(
		A.idPiloto = B.Piloto 
		AND
		A.idCategoria = B.categoria
	)
	INNER JOIN Equipo C
	ON 
	(
		A.idEquipo = C.idEquipo
		AND
		A.idCategoria = C.idCategoria
	)
	INNER JOIN Marca D
	ON 
	(
		C.idMarca = D.idMarca
	)
GROUP BY
	D.idMarca, 
	C.idEquipo, 
	C.idCategoria
ORDER BY
	D.idMarca,
	C.idEquipo,
	C.idCategoria;


/*SHOW COLUMNS FROM Categoria;*/
/*SHOW TABLES FROM Campeonato;*/
/*
Informar la cantidad de pilotos por cada nombre de categoría.
*/
SELECT B.Descripcion, COUNT(*) 
FROM Piloto A INNER JOIN Categoria B ON A.idCategoria = B.idCategoria 
GROUP BY B.idCategoria