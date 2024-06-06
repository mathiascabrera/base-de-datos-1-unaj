CREATE DATABASE IF NOT EXISTS DB;
USE DB;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Table `DB`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB`.`Departamento` (
  `idDepartamento` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Empleado_idEmpleGerente` INT NOT NULL,
  `Departamento_idDeptoPadre` INT NOT NULL,
  PRIMARY KEY (`idDepartamento`),
  INDEX `Empleado_idEmpleGerente_idx` (`Empleado_idEmpleGerente` ASC) VISIBLE,
  INDEX `Departamento_idDeptoPadre_idx` (`Departamento_idDeptoPadre` ASC) VISIBLE,
  CONSTRAINT `Empleado_idEmpleGerente`
    FOREIGN KEY (`Empleado_idEmpleGerente`)
    REFERENCES `DB`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Departamento_idDeptoPadre`
    FOREIGN KEY (`Departamento_idDeptoPadre`)
    REFERENCES `DB`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

INSERT INTO Departamento (Descripcion, Empleado_idEmpleGerente, Departamento_idDeptoPadre) VALUES ('Grande', 1, 1);
INSERT INTO Departamento (Descripcion, Empleado_idEmpleGerente, Departamento_idDeptoPadre) VALUES ('Mediano', 2, 2);
INSERT INTO Departamento (Descripcion, Empleado_idEmpleGerente, Departamento_idDeptoPadre) VALUES ('Pequeño', 3, 3);

-- -----------------------------------------------------
-- Table `DB`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB`.`Empleado` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `CodigoPostal` INT NOT NULL,
  `FechaNacimiento` DATETIME NOT NULL,
  `FechaIngreso` DATETIME NOT NULL,
  `SueldoBasico` INT NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Departamento_idDepto` INT NOT NULL,
  `Empleado_idEmpleJefe` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  INDEX `Departamento_idDepto_idx` (`Departamento_idDepto` ASC) VISIBLE,
  INDEX `Empleado_idEmpleJefe_idx` (`Empleado_idEmpleJefe` ASC) VISIBLE,
  CONSTRAINT `Departamento_idDepto`
    FOREIGN KEY (`Departamento_idDepto`)
    REFERENCES `DB`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Empleado_idEmpleJefe`
    FOREIGN KEY (`Empleado_idEmpleJefe`)
    REFERENCES `DB`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

INSERT INTO Empleado (Nombre, Apellido, Direccion, CodigoPostal, FechaNacimiento, FechaIngreso, SueldoBasico, Telefono, Departamento_idDepto, Empleado_idEmpleJefe) 
VALUES ('Federico','Casafus','Calle 31 entre 42 y 43', 4414, '2002-03-20 11:00:12', '2022-05-29 12:04:34', '23000', '1134216422', 1, 1);
INSERT INTO Empleado (Nombre, Apellido, Direccion, CodigoPostal, FechaNacimiento, FechaIngreso, SueldoBasico, Telefono, Departamento_idDepto, Empleado_idEmpleJefe) 
VALUES ('Mathias','Cabrera','Calle 21 entre 32 y 33', 1333, '2001-12-20 21:20:12', '2022-03-19 18:02:14', '23000', '1187317426', 2, 2);
INSERT INTO Empleado (Nombre, Apellido, Direccion, CodigoPostal, FechaNacimiento, FechaIngreso, SueldoBasico, Telefono, Departamento_idDepto, Empleado_idEmpleJefe) 
VALUES ('Leo','Fernandez','Calle 51 entre 10 y 11', 7231, '2003-07-21 18:10:52', '2023-01-11 14:14:34', '23000', '1166321133', 3, 3);
-- -----------------------------------------------------
-- Table `DB`.`Articulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB`.`Articulo` (
  `idArticulo` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  `tipoArticulo` VARCHAR(45) NOT NULL,
  `Precio` INT NOT NULL,
  PRIMARY KEY (`idArticulo`));

INSERT INTO Articulo (Descripcion, Marca, tipoArticulo, Precio) VALUES ('Telefono', 'Apple', 'Electronico', 60000);
INSERT INTO Articulo (Descripcion, Marca, tipoArticulo, Precio) VALUES ('Computadora', 'HP', 'Electronico', 30000);
INSERT INTO Articulo (Descripcion, Marca, tipoArticulo, Precio) VALUES ('Tablet', 'Samsung', 'Electronico', 15000);
INSERT INTO Articulo (Descripcion, Marca, tipoArticulo, Precio) VALUES ('Teclado', 'Red Dragon', 'Accesorio', 5000);
INSERT INTO Articulo (Descripcion, Marca, tipoArticulo, Precio) VALUES ('Impresora', 'EPSON', 'Electronico', 70000);

-- -----------------------------------------------------
-- Table `DB`.`Deposito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB`.`Deposito` (
  `idDeposito` INT NOT NULL AUTO_INCREMENT,
  `UbicacionDeposito` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`idDeposito`),
  UNIQUE INDEX `ubicacionDeposito_UNIQUE` (`UbicacionDeposito` ASC) VISIBLE);
  
INSERT INTO Deposito (UbicacionDeposito) VALUES ('Calle 23 entre 122 y 123');
INSERT INTO Deposito (UbicacionDeposito) VALUES ('Calle 17 entre 97 y 98');
INSERT INTO Deposito (UbicacionDeposito) VALUES ('Calle 38 entre 172 y 173');

-- -----------------------------------------------------
-- Table `DB`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `RazonSocial` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`));
  
INSERT INTO Cliente (RazonSocial, Direccion) VALUES ('Grupo Electronica', 'Calle 36 entre 145 y 146');
INSERT INTO Cliente (RazonSocial, Direccion) VALUES ('Electronic Arts', 'Calle 55 entre 155 y 156');

-- -----------------------------------------------------
-- Table `DB`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `FechaPactadaEntrega` DATETIME NOT NULL,
  `FechaRealEntrega` DATETIME NOT NULL,
  `Deposito_idDepositoEntrega` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Empleado_idEmple` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `Deposito_idDepositoEntrega_idx` (`Deposito_idDepositoEntrega` ASC) VISIBLE,
  INDEX `Cliente_idCliente_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `Empleado_idEmple_idx` (`Empleado_idEmple` ASC) VISIBLE,
  CONSTRAINT `Deposito_idDepositoEntrega`
    FOREIGN KEY (`Deposito_idDepositoEntrega`)
    REFERENCES `DB`.`Deposito` (`idDeposito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Cliente_idCliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `DB`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Empleado_idEmple`
    FOREIGN KEY (`Empleado_idEmple`)
    REFERENCES `DB`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
INSERT INTO Pedido (FechaPactadaEntrega, FechaRealEntrega, Deposito_idDepositoEntrega, Cliente_idCliente, Empleado_idEmple)
VALUES ('2023-03-21', '2023-03-23', 1, 1, 3);
INSERT INTO Pedido (FechaPactadaEntrega, FechaRealEntrega, Deposito_idDepositoEntrega, Cliente_idCliente, Empleado_idEmple)
VALUES ('2023-05-12', '2023-05-13', 3, 2, 1);
INSERT INTO Pedido (FechaPactadaEntrega, FechaRealEntrega, Deposito_idDepositoEntrega, Cliente_idCliente, Empleado_idEmple)
VALUES ('2023-03-21', '2023-03-23', 2, 1, 2);

-- -----------------------------------------------------
-- Table `DB`.`Pedido_has_Articulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB`.`Pedido_has_Articulo` (
  `Cantidad` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Articulo_idArticulo` INT NOT NULL,
  INDEX `fk_Pedido_has_Articulo_Articulo1_idx` (`Articulo_idArticulo` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Articulo_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  PRIMARY KEY (`Pedido_idPedido`, `Articulo_idArticulo`),
  CONSTRAINT `fk_Pedido_has_Articulo_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `DB`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Articulo_Articulo1`
    FOREIGN KEY (`Articulo_idArticulo`)
    REFERENCES `DB`.`Articulo` (`idArticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
INSERT INTO Pedido_has_Articulo (Cantidad, Pedido_idPedido, Articulo_idArticulo) VALUES (33, 1, 3);
INSERT INTO Pedido_has_Articulo (Cantidad, Pedido_idPedido, Articulo_idArticulo) VALUES (53, 2, 1);
INSERT INTO Pedido_has_Articulo (Cantidad, Pedido_idPedido, Articulo_idArticulo) VALUES (33, 3, 5);

-- -----------------------------------------------------
-- Table `DB`.`Deposito_has_Articulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB`.`Deposito_has_Articulo` (
  `StockActual` INT NOT NULL,
  `PuntoReorden` VARCHAR(45) NOT NULL,
  `Deposito_idDeposito` INT NOT NULL,
  `Articulo_idArticulo` INT NOT NULL,
  PRIMARY KEY (`Deposito_idDeposito`, `Articulo_idArticulo`),
  INDEX `fk_Deposito_has_Articulo_Articulo1_idx` (`Articulo_idArticulo` ASC) VISIBLE,
  INDEX `fk_Deposito_has_Articulo_Deposito1_idx` (`Deposito_idDeposito` ASC) VISIBLE,
  CONSTRAINT `fk_Deposito_has_Articulo_Deposito1`
    FOREIGN KEY (`Deposito_idDeposito`)
    REFERENCES `DB`.`Deposito` (`idDeposito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Deposito_has_Articulo_Articulo1`
    FOREIGN KEY (`Articulo_idArticulo`)
    REFERENCES `DB`.`Articulo` (`idArticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
INSERT INTO Deposito_has_Articulo (StockActual, PuntoReorden, Deposito_idDeposito, Articulo_idArticulo)
VALUES (52, '50', 3, 1);
INSERT INTO Deposito_has_Articulo (StockActual, PuntoReorden, Deposito_idDeposito, Articulo_idArticulo)
VALUES (30, '40', 2, 4);
INSERT INTO Deposito_has_Articulo (StockActual, PuntoReorden, Deposito_idDeposito, Articulo_idArticulo)
VALUES (40, '60', 1, 2);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;