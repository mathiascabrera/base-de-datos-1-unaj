DROP DATABASE IF EXISTS Entrega5;
CREATE DATABASE Entrega5;
USE Entrega5;






CREATE TABLE Articulo(
idArticulo INT NOT NULL PRIMARY KEY,
descripcion VARCHAR (80) NOT NULL,
marca VARCHAR(30) NOT NULL,
tipoArticulo ENUM ('A','B','C'),
precio float NOT NULL,

UNIQUE (descripcion),
CHECK (precio > 0 )
);




CREATE TABLE Cliente(
idCliente INT NOT NULL PRIMARY KEY,
razonSocial VARCHAR (40) NOT NULL,
direccion VARCHAR (50) NOT NULL
);




CREATE TABLE Deposito(
idDeposito INT NOT NULL PRIMARY KEY,
ubicacionDeposito VARCHAR (50) UNIQUE
);




CREATE TABLE Deposito_has_Articulo(
stockActual INT NOT NULL,
puntoReorden VARCHAR(50) NOT NULL
);




CREATE TABLE Empleado(
idEmple INT NOT NULL PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
apellido VARCHAR(30) NOT NULL,
direccion VARCHAR(30) NOT NULL,
codigoPostal INT NOT NULL,
fechaNacimiento DATE NOT NULL,
fechaIngreso DATE NOT NULL,
sueldoBasico FLOAT NOT NULL,
telefono INT (11) NOT NULL
);




CREATE TABLE PEDIDO(
idPedido INT NOT NULL PRIMARY KEY,
fechaPactadaEntrega DATE NOT NULL,
fechaRealEntrega DATE NOT NULL
);




CREATE TABLE Departamento(
idDepto INT NOT NULL PRIMARY KEY,
descripcion VARCHAR (50) NOT NULL UNIQUE
);




CREATE TABLE Pedido_has_Articulo(
cantidad INT NOT NULL
);








ALTER TABLE Empleado
ADD COLUMN Departamento_idDepto INT NOT NULL;

ALTER TABLE Empleado
ADD CONSTRAINT fk_Empleado_Departamento
FOREIGN KEY (Departamento_idDepto) REFERENCES Departamento(idDepto);





ALTER TABLE Empleado
ADD COLUMN Empleado_idEmpleJefe INT NOT NULL;

ALTER TABLE Empleado
ADD CONSTRAINT fk_Empleado_Empleado
FOREIGN KEY (Empleado_idEmpleJefe) REFERENCES Empleado (idEmple);




ALTER TABLE Deposito_has_Articulo
ADD COLUMN Deposito_idDeposito  INT NOT NULL;

ALTER TABLE Deposito_has_Articulo
ADD CONSTRAINT fk_Deposito_has_Articulo_Deposito
FOREIGN KEY (Deposito_idDeposito) REFERENCES Deposito (idDeposito);





ALTER TABLE Deposito_has_Articulo
ADD COLUMN Articulo_idArticulo  INT NOT NULL;

ALTER TABLE Deposito_has_Articulo
ADD CONSTRAINT fk_Deposito_has_Articulo_Articulo
FOREIGN KEY (Articulo_idArticulo) REFERENCES Deposito (idDeposito);





ALTER TABLE Pedido
ADD COLUMN Deposito_idDepositoEntrega INT NOT NULL;

ALTER TABLE Pedido
ADD CONSTRAINT fk_Pedido_Deposito
FOREIGN KEY (Deposito_idDepositoEntrega) REFERENCES Deposito(idDeposito);






ALTER TABLE Pedido
ADD COLUMN Cliente_idCliente INT NOT NULL;

ALTER TABLE Pedido
ADD CONSTRAINT fk_Pedido_Cliente
FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente);






ALTER TABLE Pedido
ADD COLUMN Empleado_idEmple INT NOT NULL;

ALTER TABLE Pedido
ADD CONSTRAINT fk_Pedido_Empleado
FOREIGN KEY (Empleado_idEmple) REFERENCES Empleado(idEmple);





ALTER TABLE Departamento
ADD COLUMN Empleado_idEmpleGerente INT NOT NULL;

ALTER TABLE Departamento
ADD CONSTRAINT fk_Departamento_Empleado
FOREIGN KEY (Empleado_idEmpleGerente) REFERENCES Empleado(idEmple);






ALTER TABLE Departamento
ADD COLUMN Departamento_idDeptoPadre INT NOT NULL;

ALTER TABLE Departamento
ADD CONSTRAINT fk_Departamento_Departamento
FOREIGN KEY (Departamento_idDeptoPadre) REFERENCES Departamento(idDepto);




ALTER TABLE Pedido_has_Articulo
ADD COLUMN Pedido_idPedido INT NOT NULL;

ALTER TABLE  Pedido_has_Articulo
ADD CONSTRAINT fk_Pedido_Pedido
FOREIGN KEY(
Pedido_idPedido) REFERENCES Pedido(idPedido);



ALTER TABLE Pedido_has_Articulo
ADD COLUMN Articulo_idArticulo INT NOT NULL;

ALTER TABLE  Pedido_has_Articulo
ADD CONSTRAINT fk_Pedido_Articulo
FOREIGN KEY(Articulo_idArticulo) REFERENCES Articulo(idArticulo);