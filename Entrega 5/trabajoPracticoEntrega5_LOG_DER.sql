DROP DATABASE IF EXISTS Empresa;

CREATE DATABASE Empresa;

USE Empresa;

CREATE TABLE Departamento
(
    idDepto INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    
    Empleado_idEmpleGerente INT,
    Departamento_idDeptoPadre INT,

    PRIMARY KEY (idDepto)
);

CREATE TABLE Empleado
(
    /*Atributos*/
    idEmple INT NOT NULL,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    direccion VARCHAR(40),
    codigoPostal INT,
    fechaNacimiento DATE,
    fechaIngreso DATE,
    sueldoBasico INT,
    telefono INT,
    
    Departamento_idDepto INT NOT NULL,
    Empleado_idEmpleJefe INT,

    PRIMARY KEY (idEmple)
);

ALTER TABLE Departamento ADD
(
    FOREIGN KEY (Empleado_idEmpleGerente) REFERENCES Empleado (idEmple),
    FOREIGN KEY (Departamento_idDeptoPadre) REFERENCES Departamento (idDepto)
);

ALTER TABLE Empleado ADD
(
    FOREIGN KEY (Departamento_idDepto) REFERENCES Departamento (idDepto),
    FOREIGN KEY (Empleado_idEmpleJefe) REFERENCES Empleado (idEmple)
);

INSERT
    INTO
        Departamento
    VALUES
(311, "Departamento Posicionado en el sector 24", NULL, NULL),
(51, "Departamento posicionado en el sector 20", NULL, 311);

INSERT
    INTO
        Empleado
    VALUES
(1, "Maria", "Faria", "Avenida Bolsonaro", 1400, STR_TO_DATE('2000/09/04', '%Y/%m/%d'), STR_TO_DATE('2019/04/14', '%Y/%m/%d'), 15000, 1132456296, 51, NULL),
(22, "Pablo","Echeverria", "Avenida Brasil", 1710, STR_TO_DATE('2010/05/16', '%Y/%m/%d'), STR_TO_DATE('2022/06/24', '%Y/%m/%d'), 15000, 1132456296, 51, 1);

CREATE TABLE Articulo
(
    idArticulo INT NOT NULL,
    descripcion VARCHAR(50),
    marca VARCHAR(20),
    tipoArticulo VARCHAR(1),
    precio INT,

    PRIMARY KEY (idArticulo),

    CHECK (tipoArticulo = "A" OR tipoArticulo = "B" OR tipoArticulo = "C")
);

INSERT
    INTO
        Articulo
    VALUES
(30,"Un producto de los tiempos modernos","Estrellada","C",50000.50),
(19,"Un produto perfecto para el hogar","Leones","B",49999.99);

CREATE TABLE Cliente
(
    idCliente INT NOT NULL,
    razonSocial VARCHAR(10),
    direccion VARCHAR(50),

    PRIMARY KEY (idCliente)
);

INSERT
    INTO
        Cliente
    VALUES
(622, "Trabajo", "Avenida Nueva Aguinal"),
(211,"Trabajo","Barrio Santa Rosa");

CREATE TABLE Deposito
(
    idDeposito INT NOT NULL,
    ubicacionDeposito VARCHAR(50),

    PRIMARY KEY (idDeposito)
);

INSERT
    INTO
        Deposito
    VALUES
(531,"Sector 31"),
(411,"Sector 61");

CREATE TABLE Pedido(
    idPedido INT NOT NULL,
    fechaPactadaEntrega DATE,
    fechaRealEntrega DATE,
    
    Deposito_idDepositoEntrega INT NOT NULL,
    Cliente_idCliente INT NOT NULL,
    Empleado_idEmple INT NOT NULL,

    PRIMARY KEY (idPedido),

    FOREIGN KEY (Deposito_idDepositoEntrega) REFERENCES Deposito (idDeposito),
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente (idCliente),
    FOREIGN KEY (Empleado_idEmple) REFERENCES Empleado (idEmple)

);
INSERT
    INTO
        Pedido
    VALUES
(62, STR_TO_DATE('2022/06/22', '%Y/%m/%d'), STR_TO_DATE('2022/06/23', '%Y/%m/%d'), 531, 622, 22),
(68, STR_TO_DATE('2022/06/21', '%Y/%m/%d'), STR_TO_DATE('2022/07/21', '%Y/%m/%d'), 531, 211, 1);


CREATE TABLE Deposito_has_Articulo(
    idDeptArticulo INT NOT NULL,
    stockActual INT,

    Deposito_idDeposito INT NOT NULL,
    Articulo_idArticulo INT NOT NULL,

    PRIMARY KEY (idDeptArticulo),

    FOREIGN KEY (Deposito_idDeposito) REFERENCES Deposito (idDeposito),
    FOREIGN KEY (Articulo_idArticulo) REFERENCES Articulo (idArticulo)
);
INSERT
    INTO
        Deposito_has_Articulo
    VALUES
(727,50000,531,30),
(318,31022,411,19);
