DROP DATABASE IF EXISTS Campeonato_Motociclismo;

CREATE DATABASE Campeonato_Motociclismo;

USE Campeonato_Motociclismo;


-- TABLA PILOTO

CREATE TABLE Piloto(

id_piloto INT NOT NULL PRIMARY KEY,
nombre NVARCHAR (30) NOT NULL UNIQUE,
apellido NVARCHAR (30) NOT NULL,
puntos INT NOT NULL,

CHECK(puntos >= 0)
);


-- TABLA MARCA

CREATE TABLE Marca(
id_marca INT NOT NULL PRIMARY KEY,
nombre NVARCHAR (40) NOT NULL
);


-- TABLA MOTO

CREATE TABLE Moto(
id_moto INT NOT NULL PRIMARY KEY,
numero INT NOT NULL UNIQUE,

CHECK (numero > 0)
);


-- TABLA EQUIPO

CREATE TABLE Equipo(
id_equipo INT NOT NULL PRIMARY KEY,
nombre NVARCHAR (30) NOT NULL
);


-- TABLA CARRERA

CREATE TABLE Carrera(
id_carrera INT NOT NULL PRIMARY KEY,
nombre NVARCHAR (50) NOT NULL
);


-- TABLA CATEGORIA

CREATE TABLE Categoria(
id_categoria INT NOT NULL PRIMARY KEY,
cilindrada ENUM ('250' , '500' , '1000')
);



-- TABLA INTERMEDIA ENTRE PILOTO CATEGORIA

CREATE TABLE Piloto_Categoria(
idPiloto_Categoria INT NOT NULL PRIMARY KEY,
idPiloto INT NOT NULL,
idCategoria INT NOT NULL,
idMarca INT NOT NULL,

FOREIGN KEY (idPiloto) REFERENCES Piloto(id_piloto),
FOREIGN KEY (idCategoria) REFERENCES Categoria (id_categoria),
FOREIGN KEY (idMarca) REFERENCES Marca (id_marca)
);



-- TABLA INTERMEDIA ENTRE PILOTO/CATEGORIA Y CARRERA

CREATE TABLE Pc_Carrera(
idPcCarrera INT NOT NULL PRIMARY KEY,
idCarrera INT NOT NULL,
idPilotoCategoria INT NOT NULL,
idMotos INT NOT NULL,

puntos INT NOT NULL,
posicion INT NOT NULL UNIQUE,

CHECK( puntos >= 0 ),
CHECK( posicion > 0 ),

FOREIGN KEY (idCarrera) REFERENCES Carrera(id_carrera),
FOREIGN KEY (idPilotoCategoria) REFERENCES Piloto_Categoria(idPiloto_Categoria),
FOREIGN KEY (idMotos) REFERENCES Moto(id_moto)
);


-- TABLE INTERMEDIA ENTRE EQUIPO Y CATEGORIA

CREATE TABLE Equipo_Categoria(
idEquipo_Categoria INT NOT NULL PRIMARY KEY,
idEquipo INT NOT NULL,
idCategoria INT NOT NULL,

FOREIGN KEY (idEquipo) REFERENCES Equipo(id_equipo),
FOREIGN KEY (idCategoria) REFERENCES Categoria(id_categoria)
);


-- UNION TABLAS PILOTO Y MOTO

ALTER TABLE Piloto
ADD COLUMN idMoto INT NOT NULL;

ALTER TABLE Piloto
ADD CONSTRAINT fk_Moto_Piloto
FOREIGN KEY (idMoto) REFERENCES Moto(id_moto);


-- UNION ENTRE TABLAS PILOTO EQUIPO

ALTER TABLE Piloto
ADD COLUMN idEquipo INT NOT NULL;

ALTER TABLE Piloto
ADD CONSTRAINT fk_Equipo_Piloto
FOREIGN KEY (idEquipo) REFERENCES Equipo(id_equipo);


-- UNION ENTRE TABLAS MARCA Y EQUIPO

ALTER TABLE Equipo
ADD COLUMN idMarca INT NOT NULL;

ALTER TABLE Equipo
ADD CONSTRAINT fk_Marca_Equipo
FOREIGN KEY (idMarca) REFERENCES Marca(id_marca);


-- UNION ENTRE TABLAS CARRERA Y CATEGORIA

ALTER TABLE Carrera
ADD COLUMN idCategoria INT NOT NULL;

ALTER TABLE Carrera
ADD CONSTRAINT fk_Categoria_Carrera
FOREIGN KEY (idCategoria) REFERENCES Categoria(id_categoria);


-- Carga de Datos :

-- Moto : id, numero
INSERT INTO Moto VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6);

-- Marca : id, nombre
INSERT INTO Marca VALUES
(1,"Kawasaki"),
(2,"Bmw"),
(3,"Yamaha"),
(4,"Honda"),
(5,"Ducati"),
(6,"Ktm");

-- Equipo : id_equipo , nombre, idMarca
INSERT INTO Equipo VALUES
(1,"Equipo 1",1),
(2,"Equipo 2",1),
(3,"Equipo 3",2),
(4,"Equipo 4",3);

-- Piloto : id, nombre, apellido, puntos, idMoto, idEquipo
INSERT INTO Piloto VALUES
(1,"Juan","Rodriguez",23,1,1),
(2,"Rodrigo","Cabrera",33,2,1),
(3,"Marcos","Quiroga",45,3,2),
(4,"Rosa","Gonzalez",23,4,2),
(5,"Julieta","Fariña",17,5,3),
(6,"Marisa","Pereyra",4,6,3);

-- Categoria : id_categoria, cilindrada ('250' , '500' , '1000')
INSERT INTO Categoria VALUES
(1,"250"),
(2,"500"),
(3,"1000");

-- Carrera : id_carrera, nombre, idCategoria
INSERT INTO Carrera VALUES
(1,"Carrera 1",1),
(2,"Carrera 2",2),
(3,"Carrera 3",3),
(4,"Carrera 4",1),
(5,"Carrera 5",2),
(6,"Carrera 6",3);

-- Piloto_Categoria : idPiloto_Categoria, idPiloto, idCategoria, idMarca
INSERT INTO Piloto_Categoria VALUES
(1,1,1,1),
(2,1,2,1),
(3,2,1,1),
(4,2,2,2),
(5,3,3,3),
(6,4,1,3),
(7,5,2,4),
(8,6,3,5);

-- Pc_Carrera :  idPcCarrera ,  idCarrera,   idPilotoCategoria,   idMotos,   puntos,   posicion
INSERT INTO Pc_Carrera VALUES
(1,1,1,1,33,1),
(2,1,3,2,22,2),
(3,1,5,3,20,3),
(4,1,6,4,18,4),
(5,1,7,5,16,5),
(6,1,8,6,14,6);

-- Equipo_Categoria : idEquipo_Categoria, idEquipo, idCategoria
INSERT INTO Equipo_Categoria VALUES
(1,1,1),
(2,1,2),
(3,2,2),
(4,3,3),
(5,4,3),
(6,4,2);


-- CONSULTAS

-- 1) Informar apellido y nombre de los pilotos que componen el equipo 41.

SELECT p.apellido, p.nombre FROM Piloto p
INNER JOIN Equipo e ON p.idEquipo = e.id_equipo
WHERE e.nombre = "41";

-- No existe 

-- Probamos con valores que sí existen :

SELECT p.apellido 'Apellido', p.nombre 'Nombre' FROM Piloto AS p
INNER JOIN Equipo e ON p.idEquipo = e.id_equipo
WHERE e.nombre = "Equipo 2"
ORDER BY p.nombre;


-- 2) Seleccionar los nombres de los equipos para la marca ‘Yamaha’.

SELECT e.nombre 'Equipo Y' FROM Equipo e
INNER JOIN Marca m ON e.idMarca = m.id_marca
WHERE m.nombre = "Yamaha";


-- 3) Informar la cantidad de motos por cada nombre de equipo.

-- Moto : id_moto, numero
-- Equipo : id_equipo , nombre, idMarca
-- Piloto : id_piloto, nombre, apellido, puntos, idMoto, idEquipo

SELECT e.nombre 'Equipo Nombre' , COUNT(m.id_moto) 'Total Motos' FROM Piloto p
INNER JOIN Equipo e ON p.idEquipo = e.id_equipo
INNER JOIN Moto m ON p.idMoto = m.id_moto
GROUP BY e.nombre;


-- 4) Informar la cantidad de pilotos por cada nombre de categoria.

-- Piloto : id_piloto, nombre, apellido, puntos, idMoto, idEquipo

-- Piloto_Categoria : idPiloto_Categoria  , idPiloto  , idCategoria  , idMarca

-- Categoria : id_categoria, cilindrada ('250' , '500' , '1000')

SELECT c.cilindrada 'Categoria', COUNT(pc.idPiloto) 'Total Pilotos'
FROM Categoria c
INNER JOIN Piloto_Categoria pc ON c.id_categoria = pc.idCategoria
INNER JOIN Piloto p ON pc.idPiloto = p.id_piloto
GROUP BY c.cilindrada;


-- 5) Consultar los pilotos cuyos apellidos comienzan con la letras S
-- y hayan participado en alguna carrera de cualquier categoria.

-- Piloto : id_piloto, nombre, apellido, puntos, idMoto, idEquipo

-- Piloto_Categoria : idPiloto_Categoria  , idPiloto  , idCategoria  , idMarca

-- Pc_Carrera :  idPcCarrera ,  idCarrera,   idPilotoCategoria,   idMotos,   puntos,   posicion

SELECT p.*, COUNT(pca.idPcCarrera) cantidad FROM Piloto p
INNER JOIN Piloto_Categoria pc ON p.id_piloto = pc.idPiloto
INNER JOIN Pc_Carrera pca ON pc.idPiloto_Categoria = pca.idPilotoCategoria
WHERE p.apellido LIKE 'S%' -- AGREGAR PARTICIPANTE CON S
GROUP BY p.id_piloto
HAVING cantidad > 0;

-- Ejemplo teniendo en cuenta Distinct
SELECT DISTINCT p.* FROM Piloto p
INNER JOIN Piloto_Categoria pc ON p.id_piloto = pc.idPiloto
WHERE p.apellido LIKE 'C%';


-- 6) Informar los 5 pilotos con mayor puntaje para todas las categorias

-- Piloto : id_piloto, nombre, apellido, puntos, idMoto, idEquipo

-- Piloto_Categoria : idPiloto_Categoria  , idPiloto  , idCategoria  , idMarca

-- Pc_Carrera :  idPcCarrera ,  idCarrera,   idPilotoCategoria,   idMotos,   puntos,   posicion

SELECT p.nombre 'Nombre', p.apellido 'Apellido', pca.puntos 'Puntos' FROM Piloto p
INNER JOIN  Piloto_Categoria pc ON p.id_piloto = pc.idPiloto
INNER JOIN Pc_Carrera pca ON pc.idPiloto_Categoria = pca.idPilotoCategoria
GROUP BY pca.idPcCarrera
ORDER BY pca.idPcCarrera
LIMIT 2;

-- 7) Cantidad de puntos por nombre de marca y por los nombres de cada una de las categorias.

-- Marca : id_marca, nombre
-- Piloto_Categoria : idPiloto_Categoria, idPiloto, idCategoria, idMarca
-- Piloto : id_piloto, nombre, apellido, puntos, idMoto, idEquipo
-- Pc_Carrera :  idPcCarrera ,  idCarrera,   idPilotoCategoria,   idMotos,   puntos,   posicion
-- Categoria : id_categoria, cilindrada ('250' , '500' , '1000')

SELECT m.nombre AS Nombre, c.cilindrada AS Categoria , pca.puntos AS Puntos FROM Marca m
INNER JOIN Piloto_Categoria pc ON m.id_marca = pc.idMarca
INNER JOIN Categoria c ON pc.idCategoria = c.id_categoria
INNER JOIN PC_Carrera pca ON pca.idPilotoCategoria = pc.idPiloto_Categoria; -- TERMINAR

SELECT m.nombre AS nombre_marca, c.cilindrada, SUM(p.puntos) AS puntos_totales
FROM Marca m
JOIN Piloto_Categoria pc ON pc.idMarca = m.id_marca
JOIN Categoria c ON pc.idCategoria = c.id_categoria
JOIN Piloto p ON pc.idPiloto = p.id_piloto
GROUP BY m.nombre, c.cilindrada;

-- 8)¿Se necesita conocer los nombres de las categorias de los pilotos con la cantidad de veces accedidas a cada
-- una de las posiciones de los puestos (1,2,3) del podio?.



-- 9) ¿Cual es el nombre de la categoria con mayor numero de pilotos?.

-- Piloto_Categoria : idPiloto_Categoria, idPiloto, idCategoria, idMarca
-- Piloto : id_piloto, nombre, apellido, puntos, idMoto, idEquipo
-- Pc_Carrera :  idPcCarrera ,  idCarrera,   idPilotoCategoria,   idMotos,   puntos,   posicion
-- Categoria : id_categoria, cilindrada ('250' , '500' , '1000')

SELECT c.cilindrada AS Nombre, COUNT(pc.idPiloto) AS Cantidad_Pilotos FROM Categoria c
INNER JOIN Piloto_Categoria pc ON c.id_categoria = pc.idCategoria
GROUP BY Nombre
ORDER BY Cantidad_Pilotos DESC
LIMIT 1; -- REVISAR: 250CC Y 500CC TIENEN 3 PILOTOS CADA UNA

-- 10) ¿Cual es o son los pilotos con mayor puntaje en cada categoria?.

SELECT p.nombre AS Nombre, p.apellido AS Apellido, pca.puntos AS Puntos FROM Piloto p
INNER JOIN Piloto_Categoria pc ON pc.idPiloto = p.id_piloto
INNER JOIN Pc_Carrera pca ON idPilotoCategoria = idPiloto_Categoria;






