
DROP DATABASE proyecto;

CREATE DATABASE proyecto;

USE proyecto;

/*---------------------------------------------------------*/
/* Crear y cargar unas instancias de la tabla (Cientifico) */
/*---------------------------------------------------------*/
CREATE TABLE Cientifico
(
    /* Atributo Característico de la Tabla */
    idCientifico INT NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL,

    /* Clave Primaria (PK) */
    PRIMARY KEY (idCientifico)
);

INSERT
    INTO
        Cientifico
    VALUES
        (23, 'Echeverría', 'Juan Carlos'),
        (12, 'Sanchez', 'Oscar'),
        (24, 'Vicuña', 'María'),
        (59, 'Rosales', 'Pedro');

/*-------------------------------------------------------*/
/* Crear y cargar unas instancias de la tabla (Proyecto) */
/*-------------------------------------------------------*/
CREATE TABLE Proyecto
(
    /* Atributo Característico de la Tabla */
    idProyecto INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    
    /* Clave Primaria (PK) */
    PRIMARY KEY (idProyecto)
);

INSERT
    INTO
        Proyecto
    VALUES
        (392, 'Sistema Integral de Ticket (GIT)'),
        (817, 'Sistema Gestion Comercial (SIGECO)');

/*-------------------------------------------------------*/
/* Crear y cargar unas instancias de la tabla (Proyecto_Cientifico) */
/*-------------------------------------------------------*/
CREATE TABLE Proyecto_Cientifico
(
    /* Atributo Característico de la Tabla */
    horas INT NOT NULL,

    /* Atributo Característico de la Tabla, referenciado con otra Tabla */
    Proyecto_idProyecto INT NOT NULL,
    Cientifico_idCientifico INT NOT NULL,

    /* Clave Primaria (PK) */
    PRIMARY KEY (Proyecto_idProyecto, Cientifico_idCientifico),

    /* Restricción propia del Atributo Característico (CK) */
    CHECK (horas > 0),

    /* Clave Lejana del Atributo Característico de la Tabla, referenciado con otra Tabla (FK) */
    FOREIGN KEY (Proyecto_idProyecto) REFERENCES Proyecto (idProyecto),
    FOREIGN KEY (Cientifico_idCientifico) REFERENCES Cientifico (idCientifico)
);

INSERT
    INTO
        Proyecto_Cientifico
    VALUES
        (32, 392, 24),
        (14,  817, 24),
        (21, 817, 59),
        (28, 392, 23),
        (39, 392, 59);

/*--------------------------------------------------------------------------------------------------*/
/* Seleccionar todos los Atributos Característicos de la tabla (Cientifico), ordenados por apellido y nombre */
/*--------------------------------------------------------------------------------------------------*/
SELECT 
    A.idCientifico AS 'Cientifico',
    A.apellido     AS 'Apellido',
    A.nombre       AS 'Nombre'

FROM Cientifico AS A

ORDER BY
    A.apellido,
    A.nombre;

/*--------------------------------------------------------------------------------------------------*/
/* Seleccionar todos los Atributos Característicos de la tabla (Proyecto), ordenado por descripcion */
/*--------------------------------------------------------------------------------------------------*/
SELECT 
    A.idProyecto  AS 'Proyecto',
    A.descripcion AS 'Descripcion'

FROM Proyecto AS A

ORDER BY
    A.descripcion;

/*---------------------------------------------------------------------------------------------------------------------------------*/
/* Seleccionar todos los Atributos Característicos de la tabla (Proyecto_Cientifico), ordenado por numero de proyecto y cientifico */
/*---------------------------------------------------------------------------------------------------------------------------------*/
SELECT 
    A.Proyecto_idProyecto     AS 'Proyecto',
    A.Cientifico_idCientifico AS 'Cientifico',
    A.horas                   AS 'Horas'

FROM Proyecto_Cientifico AS A

ORDER BY
    A.Proyecto_idProyecto,
    A.Cientifico_idCientifico;

/*------------------------------------------------------------------------------------------------------------------------------*/
/* 1) Obtener todos los datos de los científicos incluyendo el nombre de los proyectos asignados a cada uno de los científicos. */
/*------------------------------------------------------------------------------------------------------------------------------*/
SELECT 
    B.idCientifico AS 'Cientifico',
    B.apellido     AS 'Apellido',
    B.nombre       AS 'Nombre',
    C.descripcion  AS 'Descripcion'

FROM Proyecto_Cientifico   AS A

INNER JOIN Cientifico AS B ON A.Cientifico_idCientifico = B.idCientifico
INNER JOIN Proyecto   AS C ON A.Proyecto_idProyecto = C.idProyecto

ORDER BY
    B.apellido,
    B.nombre,
    C.descripcion;

/*-----------------------------------------------------------------------------------------------------------------------*/
/* 2) Cuál es el o los proyectos asignados al científico cuyo código es 24, informando código y nombre de cada  */
/*-----------------------------------------------------------------------------------------------------------------------*/
SELECT 
    B.idProyecto  AS 'Proyecto',
    B.descripcion AS 'Descripcion'
FROM
    Proyecto_Cientifico AS A
    INNER JOIN Proyecto AS B ON A.Proyecto_idProyecto = B.idProyecto

WHERE
    A.Cientifico_idCientifico = 24
ORDER BY
    B.descripcion;

/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 3) Cuál es el o los científicos asignados al proyecto cuyo código sea 817, informando apellido y nombre ordenado por apellido ascendentemente. */
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT 
    B.idCientifico AS 'Cientifico',
    B.apellido     AS 'Apellido',
    B.nombre       AS 'Nombre'

FROM Proyecto_Cientifico   AS A

INNER JOIN Cientifico AS B ON A.Cientifico_idCientifico = B.idCientifico


WHERE
    A.Proyecto_idProyecto = 817
ORDER BY
	B.apellido,
    B.nombre;

/*-------------------------------------------------------------------------------------*/
/* 4) Obtener número de proyectos asignados a cada uno de los científicos y sus datos. */
/*-------------------------------------------------------------------------------------*/
SELECT 
    B.idCientifico AS 'Cientifico',
    B.apellido     AS 'Apellido',
    B.nombre       AS 'Nombre',
    COUNT(*)       AS 'Cantidad Proyectos'

FROM Proyecto_Cientifico   AS A

INNER JOIN Cientifico AS B ON A.Cientifico_idCientifico = B.idCientifico

GROUP BY
    B.idCientifico
    
ORDER BY
    B.apellido,
    B.nombre;

/*---------------------------------------------------------------------------------------*/
/* 5) Obtener el número de horas totales de cada proyecto por los científicos asignados. */
/*---------------------------------------------------------------------------------------*/
SELECT
    B.idProyecto   AS 'Proyecto',
    B.descripcion  AS 'Descripcion',
    SUM(horas)     AS 'Horas por Proyectos'

FROM Proyecto_Cientifico AS A

INNER JOIN Proyecto AS B ON A.Proyecto_idProyecto = B.idProyecto

GROUP BY
    B.idProyecto
ORDER BY
    B.descripcion;

/*-------------------------------------------------------------------------------*/
/* 6) Obtener todos los datos de los científicos asignados a más de un  */
/*-------------------------------------------------------------------------------*/
SELECT 
    B.idCientifico AS 'Cientifico',
    B.apellido     AS 'Apellido',
    B.nombre       AS 'Nombre',
    COUNT(*)       AS 'Cantidad Proyectos'

FROM Proyecto_Cientifico   AS A

INNER JOIN Cientifico AS B ON A.Cientifico_idCientifico = B.idCientifico

GROUP BY
    B.idCientifico

HAVING
    COUNT(*) > 1
    
ORDER BY
    B.apellido,
    B.nombre;



/*----------------------------------------------------------------------------------------------------*/
/* 7) Informar todos los proyectos que tienen científicos cuyos apellidos comienzan con la letra “S”. */
/*----------------------------------------------------------------------------------------------------*/
SELECT
    B.idProyecto   AS 'Proyecto',
    B.descripcion  AS 'Descripcion',
    C.idCientifico AS 'Cientifico',
    C.apellido     AS 'Apellido',
    C.nombre       AS 'Nombre'

FROM Proyecto_Cientifico   AS A

INNER JOIN Proyecto   AS B ON A.Proyecto_idProyecto = B.idProyecto
INNER JOIN Cientifico  AS C ON A.Cientifico_idCientifico = C.idCientifico

WhERE
    C.apellido LIKE 'S%'
GROUP BY
    B.idProyecto
ORDER BY
    B.descripcion;

/*------------------------------------------------------------------------*/
/* 8) Cuál es el proyecto o los proyectos con mayor número de científico. */
/*------------------------------------------------------------------------*/

SELECT 
    A.Proyecto_idProyecto AS Proyecto,
    COUNT(*)              AS cantidadCientificos

FROM Proyecto_Cientifico AS A

GROUP BY
    A.Proyecto_idProyecto
HAVING
    MAX(cantidadCientificos);

/*--------------------------------------------------------------------------*/
/* 9) Cuál es el proyecto o los proyectos con menor número de científicos. */
/*--------------------------------------------------------------------------*/

SELECT 
    A.Proyecto_idProyecto AS Proyecto,
    COUNT(*)              AS cantidadCientificos

FROM Proyecto_Cientifico AS A

GROUP BY
    A.Proyecto_idProyecto
HAVING
    MIN(cantidadCientificos);



/*----------------------------------------------------------------------*/
/* 10) Cuál es el proyecto o los proyectos con menor cantidad de horas. */
/*----------------------------------------------------------------------*/

SELECT 
    A.Proyecto_idProyecto AS Proyecto,
    SUM(A.horas)          AS CantidadHoras

FROM Proyecto_Cientifico AS A

GROUP BY
    A.Proyecto_idProyecto
HAVING
    MIN(CantidadHoras);
            