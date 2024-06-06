
DROP DATABASE campeonato;

CREATE DATABASE campeonato;

USE campeonato;

/*--------------------------------------------------------*/
/* Crear y cargar unas instancias de la tabla (Autodromo) */
/*--------------------------------------------------------*/
CREATE TABLE Autodromo
(
    /* Atributo Característico de la Tabla */
    idAutodromo INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    descripcionCorta VARCHAR(30) NOT NULL,

    /* Clave Primaria (PK) */
    PRIMARY KEY (idAutodromo),

    /* Clave Única (UK) */
    UNIQUE KEY (descripcion),
    UNIQUE KEY (descripcionCorta),
	
    /* Restriccion propia del atributo caracteristico (CK) */
    CHECK (idAutodromo > 0)
);

INSERT
    INTO
        Autodromo
    VALUES 
(3, 'Autodromo 3', 'A 3'),
(7, 'Autodromo 7', 'A 7'),
(4, 'Autodromo 4', 'A 4');

/*----------------------------------------------------*/
/* Crear y cargar unas instancias de la tabla (Marca) */
/*----------------------------------------------------*/
CREATE TABLE Marca
(
    /* Atributo Característico de la Tabla */
    idMarca INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    descripcionCorta VARCHAR(30) NOT NULL,

    /* Clave Primaria (PK) */
    PRIMARY KEY (idMarca),

    /* Clave Única (UK) */
    UNIQUE KEY (descripcion),
    UNIQUE KEY (descripcionCorta),
	
    /* Restriccion propia del atributo caracteristico (CK) */
    CHECK (idMarca > 0)
);

INSERT 
    INTO
        Marca
    VALUES
(22, 'Yamaha', 'Yam'),
(14, 'Kawasaki', 'Kaw'),
(35, 'Motomel', 'Mot'),
(5, 'Honda', 'Hon');

/*---------------------------------------------------------*/
/* Crear y cargar unas instancias de la tabla (Cilindrada) */
/*---------------------------------------------------------*/
CREATE TABLE Cilindrada
(
    /* Atributo Característico de la Tabla */
    idCilindrada INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    descripcionCorta VARCHAR(30) NOT NULL,

    /* Clave Primaria (PK) */
    PRIMARY KEY (idCilindrada),

    /* Clave Única (UK) */
    UNIQUE KEY (descripcion),
    UNIQUE KEY (descripcionCorta),
	
    /* Restriccion propia del atributo caracteristico (CK) */
    CHECK (idCilindrada > 0)
);

INSERT
    INTO
        Cilindrada
    VALUES
(12, '125 cc', '125'),
(5, '250 cc', '250'),
(16, '500 cc', '500');

/*-----------------------------------------------------*/
/* Crear y cargar unas instancias de la tabla (Puesto) */
/*-----------------------------------------------------*/
CREATE TABLE Puesto
(
    /* Atributo Característico de la Tabla */
    idPuesto INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    descripcionCorta VARCHAR(30) NOT NULL,
    puntaje INT NOT NULL,

    /* Clave Primaria (PK) */
    PRIMARY KEY (idPuesto),

    /* Clave Única (UK) */
    UNIQUE KEY (descripcion),
    UNIQUE KEY (descripcionCorta),

    /* Restriccion propia del Atributo Caracteristico (CK) */
	CHECK (idPuesto > 0),
    CHECK (puntaje > 0)
);

INSERT
    INTO
        Puesto
    VALUES
(1, 'Primer puesto', '1° Puesto', 10),
(2, 'Segundo puesto', '2° Puesto', 9),
(3, 'Tercero puesto', '3° Puesto', 8),
(4, 'Cuarto puesto', '4° Puesto', 7),
(5, 'Quinto puesto', '5° Puesto', 6),
(6, 'Sexto puesto', '6° Puesto', 5),
(7, 'Septimo puesto', '7° Puesto', 4),
(8, 'Octavo puesto', '8° Puesto', 3),
(9, 'Noveno puesto', '9° Puesto', 2),
(10, 'Decimo puesto', '10° Puesto', 1);

/*--------------------------------------------------------*/
/* Crear y cargar unas instancias de la tabla (Categoria) */
/*--------------------------------------------------------*/
CREATE TABLE Categoria
(
    /* Atributo Característico de la Tabla */
    idCategoria INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    descripcionCorta VARCHAR(30) NOT NULL,

    /* Atributo Característico de la Tabla, referenciado con otra Tabla */
    idCilindrada INT NOT NULL,

    /* Clave Primaria (PK) */
    PRIMARY KEY (idCategoria),

    /* Clave Única (UK) */
    UNIQUE KEY (descripcion),
    UNIQUE KEY (descripcionCorta),
	
    /* Restriccion propia del Atributo Caracteristico (CK) */
	CHECK (idCategoria > 0),

    /* Clave Lejana del Atributo Característico de la Tabla, referenciado con otra Tabla (FK) */
    FOREIGN KEY (idCilindrada) REFERENCES Cilindrada (idCilindrada)
);

INSERT
    INTO
        Categoria
    VALUES
(8, 'Baja', 'Baj', 12),
(24, 'Media', 'Med', 5),
(13, 'Alta', 'Alt', 16);

/*-----------------------------------------------------*/
/* Crear y cargar unas instancias de la tabla (Equipo) */
/*-----------------------------------------------------*/
CREATE TABLE Equipo
(
    /* Atributo Característico de la Tabla */
    idEquipo INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    descripcionCorta VARCHAR(30) NOT NULL,

    /* Atributo Característico de la Tabla, referenciado con otra Tabla */
    idMarca INT NOT NULL,
    idCategoria INT NOT NULL,

    /* Clave Primaria (PK) */
    PRIMARY KEY (idEquipo, idCategoria),
	
    /* Restriccion propia del Atributo Caracteristico (CK) */
	CHECK (idEquipo > 0),

    /* Clave Lejana del Atributo Característico de la Tabla, referenciado con otra Tabla (FK) */
    FOREIGN KEY (idMarca) REFERENCES Marca (idMarca),
    FOREIGN KEY (idCategoria) REFERENCES Categoria (idCategoria)
);

INSERT
    INTO
        Equipo
    VALUES
(41, 'Amarillo', 'Ama', 22, 8),
(41, 'Amarillo', 'Ama', 22, 24),
(7, 'Azul', 'Azu', 35, 24),
(7, 'Azul', 'Azu', 35, 8),
(21, 'Rojo', 'Roj', 22, 8),
(21, 'Rojo', 'Roj', 22, 24),
(22, 'Celeste', 'Cel', 5, 24),
(22, 'Celeste', 'Cel', 5, 8);

/*---------------------------------------------------*/
/* Crear y cargar unas instancias de la tabla (Moto) */
/*---------------------------------------------------*/
CREATE TABLE Moto
(
    /* Atributo Característico de la Tabla */
    idMoto INT NOT NULL,
    idChasis VARCHAR(10) NOT NULL,

    /* Atributo Característico de la Tabla, referenciado con otra Tabla */
    idMarca INT NOT NULL,
    idCilindrada INT NOT NULL,
    idEquipo INT NOT NULL,
    idCategoria INT NOT NULL,

    /* Clave Primaria (PK) */
    PRIMARY KEY (idMoto),

    /* Clave Única (UK) */
    UNIQUE KEY (idChasis),
	
    /* Restriccion propia del Atributo Caracteristico (CK) */
	CHECK (idMoto > 0),

    /* Clave Lejana del Atributo Característico de la Tabla, referenciado con otra Tabla (FK) */
    FOREIGN KEY (idMarca) REFERENCES Marca (idMarca),
    FOREIGN KEY (idCilindrada) REFERENCES Cilindrada (idCilindrada),
    FOREIGN KEY (idEquipo, idCategoria) REFERENCES Equipo (idEquipo, idCategoria)
);

INSERT
    INTO
        Moto
    VALUES
(37, 'HES231', 22, 12, 41, 8),
(46, 'JSW121', 35, 5, 7, 24),
(55, 'FGR234', 22, 12, 21, 8),
(39, 'GRH123', 5, 12, 22, 8),
(56, 'GDA321', 22, 5, 21, 24),
(17, 'FDR342', 35, 5, 7, 24),
(18, 'MEA123', 35, 12, 7, 8),
(4, 'OLY368', 22, 5, 41, 24),
(24, 'LEA137', 35, 12, 7, 8),
(65, 'OPI387', 35, 12, 7, 8),
(83, 'GOR612', 22, 12, 21, 8),
(92, 'LMR417', 22, 12, 21, 8),
(58, 'SEI023', 35, 12, 7, 8),
(73, 'RGE353', 5, 12, 22, 8),
(22, 'LER759', 22, 5, 41, 24),
(61, 'NDE754', 5, 5, 22, 24),
(15, 'MNE351', 22, 5, 41, 24),
(50, 'HRO487', 35, 5, 7, 24),
(78, 'JUE613', 22, 5, 21, 24),
(94, 'NRE319', 35, 5, 7, 24),
(38, 'HEE290', 22, 5, 41, 24),
(62, 'MLF655', 22, 5, 41, 24);

/*-----------------------------------------------------*/
/* Crear y cargar unas instancias de la tabla (Piloto) */
/*-----------------------------------------------------*/
CREATE TABLE Piloto
(
    /* Atributo Característico de la Tabla */
    idPiloto INT NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    dni VARCHAR(15) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    nroMotoCategoria INT NOT NULL,
    telefono_1 VARCHAR(20),
    telefono_2 VARCHAR(20),
    telefono_3 VARCHAR(20),
    mail_1 VARCHAR(100),
    mail_2 VARCHAR(100),

    /* Atributo Característico de la Tabla, referenciado con otra Tabla */
    idEquipo INT NOT NULL,
    idCategoria INT NOT NULL,

    /* Clave Primaria (PK) */
    PRIMARY KEY (idPiloto, idCategoria),

    /* Clave Única (UK) */
    UNIQUE KEY (nroMotoCategoria, idCategoria),
	
	/* Restriccion propia del Atributo Caracteristico (CK) */
	CHECK (idPiloto > 0),
    CHECK (nroMotoCategoria > 0),

    /* Clave Lejana del Atributo Característico de la Tabla, referenciado con otra Tabla (FK) */
    FOREIGN KEY (idEquipo, idCategoria) REFERENCES Equipo (idEquipo, idCategoria)
);

INSERT
    INTO
        Piloto
    VALUES
(126, 'Aldana', 'Guillermo Nicolas', '36809667', 'Suipacha 342 Piso: 3 Depto: B (1010)', 7, '46573421', '1589723458', NULL, 'galdana@gmail.com', 'galdana@hotmail.com', 41, 8),
(126, 'Aldana', 'Guillermo Nicolas', '36809667', 'Suipacha 342 Piso: 3 Depto: B (1010)', 5, '46573421', '1589723458', NULL, 'galdana@gmail.com', 'galdana@hotmail.com', 41, 24),
(26, 'Alvarez', 'Yesica Soledad', '37882598', 'Juan B Justo 4536 (2030)', 8, '47458932', '1543905672', '1532416755', 'alvarezol@live.com.ar', 'alvarezol@gmail.com.ar', 7, 24),
(26, 'Alvarez', 'Yesica Soledad', '37882598', 'Juan B Justo 4536 (2030)', 2, '47458932', '1543905672', '1532416755', 'alvarezol@live.com.ar', 'alvarezol@gmail.com.ar', 7, 8),
(45, 'Basteiro', 'Maria Mercedes', '35780373', 'Triunvirato 234 Piso: 10 Depto: 11 (3021)', 9, '46579023', '1576534210', NULL, 'mbasteiro@hotmail.com', 'mbasteiro@live.com.ar', 21, 8),
(45, 'Basteiro', 'Maria Mercedes', '35780373', 'Triunvirato 234 Piso: 10 Depto: 11 (3021)', 7, '46579023', '1576534210', NULL, 'mbasteiro@hotmail.com', 'mbasteiro@live.com.ar', 21, 24),
(654, 'Belohlavek', 'Daniel', '39098582', 'Cabildo 234 (1467)', 22, '43527852', '1536437859', NULL, 'daniel.b@gmail.com', NULL, 7, 8),
(654, 'Belohlavek', 'Daniel', '39098582', 'Cabildo 234 (1467)', 32, '43527852', '1536437859', NULL, 'daniel.b@gmail.com', NULL, 7, 24),
(231, 'Costantino', 'Federico', '38907168', 'Rivadavia 1204 Piso: 4 Depto: 6 (2010)', 4, '48543469', '1543946295', NULL, 'f.costanti@gmail.com', NULL, 22, 24),
(231, 'Costantino', 'Federico', '38907168', 'Rivadavia 1204 Piso: 4 Depto: 6 (2010)', 6, '48543469', '1543946295', NULL, 'f.costanti@gmail.com', NULL, 22, 8),
(456, 'Diaz', 'Nicolas Alejandro', '37607418', 'Alvarez Jonte 540 (4051)', 4, '43431548', '1545637829', NULL, 'nadiaz1993@hotmail.com', NULL, 7, 8),
(456, 'Diaz', 'Nicolas Alejandro', '37607418', 'Alvarez Jonte 540 (4051)', 44, '43431548', '1545637829', NULL, 'nadiaz1993@hotmail.com', NULL, 7, 24),
(356, 'Eguibar', 'Matias', '35937834', 'Lopez de Vega 3146 (5063)', 3, '45413634', '1543214573', NULL, 'matiasegui@hotmail.com', 'matiasegui@gmail.com', 21, 8),
(123, 'Franco', 'Carlos Alberto', '94403335', 'Darwin 524 Piso: 1 Depto: F (1305)', 10, '43267547', '1534265387', NULL, 'ca.fran@gmail.com', NULL, 21, 24),
(123, 'Franco', 'Carlos Alberto', '94403335', 'Darwin 524 Piso: 1 Depto: F (1305)', 1, '43267547', '1534265387', NULL, 'ca.fran@gmail.com', NULL, 21, 8),
(471, 'Gonzalez Rosas', 'Maria Isabel', '32954241', 'Ciudad de la Paz 1640 Piso: 8 Dept:4 (1460)', 8, '45433792', '1542423563', '1564127644', 'igrosas@gmail.com', NULL, 7, 8),
(471, 'Gonzalez Rosas', 'Maria Isabel', '32954241', 'Ciudad de la Paz 1640 Piso: 8 Dept:4 (1460)', 1, '45433792', '1542423563', '1564127644', 'igrosas@gmail.com', NULL, 7, 24),
(311, 'Luna', 'Jose', '37191155', 'Callao 1300 (1060)', 5, '45553743', '1587694567', NULL, 'jiluna@hotmail.com', 'jiluna@live.com.ar', 41, 8),
(311, 'Luna', 'Jose', '37191155', 'Callao 1300 (1060)', 6, '45553743', '1587694567', NULL, 'jiluna@hotmail.com', 'jiluna@live.com.ar', 41, 24),
(276, 'Mariano', 'Jonathan J.', '35187906', 'Echevarria 2450 Piso: 5 Depto: A (1780)', 10, '45764518', '1565737648', NULL, 'jonamari@hotmail.com', 'jonamari@gmail.com', 7, 8),
(876, 'Nakamura', 'Federico Kenji', '34960325', 'Paseo Colón 564 (1005)', 3, '43443581', '1576879046', NULL, 'fe.naka@gmail.com', NULL, 22, 24),
(876, 'Nakamura', 'Federico Kenji', '34960325', 'Paseo Colón 564 (1005)', 12, '43443581', '1576879046', NULL, 'fe.naka@gmail.com', NULL, 22, 8),
(234, 'Oshiro', 'Alejandro', '36087456', 'Pasco 41 (1100)', 9, '48994503', '1546571232', NULL, 'aleoshi@gmail.com', NULL, 21, 24),
(234, 'Oshiro', 'Alejandro', '36087456', 'Pasco 41 (1100)', 11, '48994503', '1546571232', NULL, 'aleoshi@gmail.com', NULL, 21, 8),
(35, 'Salvador', 'Emanuel', '37899250', 'Agüero 3023 Piso: PB Depto:2 (1350)', 12, '47776582', '1546378760', '1534265489', 'ema.salvador@hotmail.com', NULL, 22, 24),
(35, 'Salvador', 'Emanuel', '37899250', 'Agüero 3023 Piso: PB Depto:2 (1350)', 25, '47776582', '1546378760', '1534265489', 'ema.salvador@hotmail.com', NULL, 22, 8),
(221, 'Salvatore', 'Lucio', '38786253', 'Lima 2047 Piso: 4 Depto:33 (2020)', 14, '47652364', '1587974053', NULL, 'luchosalva@yahoo.com.ar', NULL, 41, 8),
(221, 'Salvatore', 'Lucio', '38786253', 'Lima 2047 Piso: 4 Depto:33 (2020)', 13, '47652364', '1587974053', NULL, 'luchosalva@yahoo.com.ar', NULL, 41, 24),
(67, 'Trillo', 'Agostina Paula', '37178098', 'Alma Fuerte 34 (6043)', 13, '47844361', '1563454910', '1544789015', 'atrillo.95@gmail.com', 'atrillo.95@hotmail.com', 7, 8),
(67, 'Trillo', 'Agostina Paula', '37178098', 'Alma Fuerte 34 (6043)', 11, '47844361', '1563454910', '1544789015', 'atrillo.95@gmail.com', 'atrillo.95@hotmail.com', 7, 24);

/*------------------------------------------------------*/
/* Crear y cargar unas instancias de la tabla (Carrera) */
/*------------------------------------------------------*/
CREATE TABLE Carrera
(
    /* Atributo Característico de la Tabla */
    idCarrera INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    descripcionCorta VARCHAR(30) NOT NULL,

    /* Atributo Característico de la Tabla, referenciado con otra Tabla */
    idPiloto INT,
    idCategoria INT NOT NULL,
    idAutodromo INT NOT NULL,
    idMoto INT,
    idPuesto INT,

    /* Clave Primaria (PK) */
    PRIMARY KEY (idCarrera, idPiloto),

    /* Clave Única (UK) */
    UNIQUE KEY (idCarrera, idMoto),
    UNIQUE KEY (idCarrera, idPuesto),
	
	/* Restriccion propia del Atributo Caracteristico (CK) */
	CHECK (idCarrera > 0),

    /* Clave Lejana del Atributo Característico de la Tabla, referenciado con otra Tabla (FK) */
    FOREIGN KEY (idAutodromo) REFERENCES Autodromo (idAutodromo),
    FOREIGN KEY (idMoto) REFERENCES Moto (idMoto),
    FOREIGN KEY (idPuesto) REFERENCES Puesto (idPuesto),
    FOREIGN KEY (idPiloto, idCategoria) REFERENCES Piloto (idPiloto, idCategoria)
);

INSERT
    INTO
        Carrera
    VALUES
(41, 'Tercer campeonato y primera carrera', '3° - 1° Carrera', 126, 8, 7, 37, 4),
(41, 'Tercer campeonato y primera carrera', '3° - 1° Carrera', 231, 8, 7, 39, 3),
(41, 'Tercer campeonato y primera carrera', '3° - 1° Carrera', 654, 8, 7, 18, 8),
(41, 'Tercer campeonato y primera carrera', '3° - 1° Carrera', 45, 8, 7, 55, 1),
(41, 'Tercer campeonato y primera carrera', '3° - 1° Carrera', 456, 8, 7, 24, 7),
(41, 'Tercer campeonato y primera carrera', '3° - 1° Carrera', 26, 8, 7, 65, 9),
(41, 'Tercer campeonato y primera carrera', '3° - 1° Carrera', 234, 8, 7, 83, 10),
(41, 'Tercer campeonato y primera carrera', '3° - 1° Carrera', 356, 8, 7, 92, 2),
(41, 'Tercer campeonato y primera carrera', '3° - 1° Carrera', 471, 8, 7, 58, 5),
(41, 'Tercer campeonato y primera carrera', '3° - 1° Carrera', 35, 8, 7, 73, 6),
(65, 'Tercer campeonato y segunda carrera', '3° - 2° Carrera', 67, 24, 4, 46, 7),
(65, 'Tercer campeonato y segunda carrera', '3° - 2° Carrera', 311, 24, 4, 4, 3),
(65, 'Tercer campeonato y segunda carrera', '3° - 2° Carrera', 221, 24, 4, 22, 4),
(65, 'Tercer campeonato y segunda carrera', '3° - 2° Carrera', 876, 24, 4, 61, 1),
(65, 'Tercer campeonato y segunda carrera', '3° - 2° Carrera', 45, 24, 4, 56, 9),
(65, 'Tercer campeonato y segunda carrera', '3° - 2° Carrera', 126, 24, 4, 15, 5),
(65, 'Tercer campeonato y segunda carrera', '3° - 2° Carrera', 654, 24, 4, 17, 10),
(65, 'Tercer campeonato y segunda carrera', '3° - 2° Carrera', 456, 24, 4, 50, 8),
(65, 'Tercer campeonato y segunda carrera', '3° - 2° Carrera', 234, 24, 4, 78, 2),
(65, 'Tercer campeonato y segunda carrera', '3° - 2° Carrera', 471, 24, 4, 94, 6),
(82, 'Tercer campeonato y tercera carrera', '3° - 3° Carrera', 67, 24, 4, 46, 10),
(82, 'Tercer campeonato y tercera carrera', '3° - 3° Carrera', 311, 24, 4, 62, 1),
(82, 'Tercer campeonato y tercera carrera', '3° - 3° Carrera', 221, 24, 4, 22, 6),
(82, 'Tercer campeonato y tercera carrera', '3° - 3° Carrera', 876, 24, 4, 61, 2),
(82, 'Tercer campeonato y tercera carrera', '3° - 3° Carrera', 45, 24, 4, 56, 3),
(82, 'Tercer campeonato y tercera carrera', '3° - 3° Carrera', 126, 24, 4, 38, 4),
(82, 'Tercer campeonato y tercera carrera', '3° - 3° Carrera', 654, 24, 4, 17, 5),
(82, 'Tercer campeonato y tercera carrera', '3° - 3° Carrera', 456, 24, 4, 50, 8),
(82, 'Tercer campeonato y tercera carrera', '3° - 3° Carrera', 234, 24, 4, 78, 9),
(82, 'Tercer campeonato y tercera carrera', '3° - 3° Carrera', 471, 24, 4, 94, 7);
