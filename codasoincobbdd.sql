
-- -----------------------------------------------------
-- Crear base de datos
-- -----------------------------------------------------
CREATE DATABASE asoinco;

-- -----------------------------------------------------
-- Table asoinco.Rol
-- -----------------------------------------------------
CREATE TABLE Rol (
  idRol INT NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (idRol))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table asoinco.Coordinador
-- -----------------------------------------------------
CREATE TABLE Coordinador (
  idCoordinador INT NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (idCoordinador),
  INDEX ind_coordinador_registrar (idCoordinador ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table asoinco.Factura
-- -----------------------------------------------------
CREATE TABLE Factura (
  idFactura INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (idFactura),
  INDEX ind_factura_coordinador (idFactura ASC),
  CONSTRAINT fk_factura_coordinador
    FOREIGN KEY (idFactura)
    REFERENCES asoinco.Coordinador (idCoordinador)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table asoinco.Proveedor
-- -----------------------------------------------------
CREATE TABLE Proveedor (
  idProveedor INT NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(45) NOT NULL,
  Nombre_empresa VARCHAR(45) NOT NULL,
  Fecha_entrega_y_hora VARCHAR(45) NOT NULL,
  Producto VARCHAR(45) NOT NULL,
  PRIMARY KEY (idProveedor),
  INDEX ind_proveedor_factura (idProveedor ASC),
  CONSTRAINT fk_proveedor_factura
    FOREIGN KEY (idProveedor)
    REFERENCES asoinco.Factura (idFactura)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table asoinco.Usuarios
-- -----------------------------------------------------
CREATE TABLE Usuarios (
  idRol INT NOT NULL AUTO_INCREMENT,
  cod_idUsuarios INT NOT NULL,
  Nombre VARCHAR(45) NOT NULL,
  Correo VARCHAR(45) NOT NULL,
  Contraseña VARCHAR(45) NOT NULL,
  Celular VARCHAR(45) NOT NULL,
  Direccion VARCHAR(45) NOT NULL,
  INDEX ind_usuarios_coordinador (cod_idUsuarios ASC),
  CONSTRAINT fk_usuarios_rol
    FOREIGN KEY (idRol)
    REFERENCES asoinco.Rol (idRol)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_usuarios_coordinador
    FOREIGN KEY (idRol)
    REFERENCES asoinco.Coordinador (idCoordinador)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table asoinco.Registrar_asistencia
-- -----------------------------------------------------
CREATE TABLE Registrar_asistencia (
  Fecha_registro INT NOT NULL AUTO_INCREMENT,
  Codigo_coordinador VARCHAR(45) NOT NULL,
  PRIMARY KEY (Fecha_registro),
  INDEX ind_registrar_usuarios (Fecha_registro ASC),
  INDEX ind_registrar_coordinador (Fecha_registro ASC),
  CONSTRAINT fk_registrar_usuarios
    FOREIGN KEY (Fecha_registro)
    REFERENCES asoinco.Usuarios (idRol)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_registrar_coordinador
    FOREIGN KEY (Fecha_registro)
    REFERENCES asoinco.Coordinador (idCoordinador)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table asoinco.Inventario
-- -----------------------------------------------------
CREATE TABLE Inventario (
  idInventario INT NOT NULL AUTO_INCREMENT,
  tipo_inventario VARCHAR(45) NOT NULL,
  fecha_hora VARCHAR(45) NOT NULL,
  cantidad_tipo_inventario VARCHAR(45) NOT NULL,
  PRIMARY KEY (idInventario),
  INDEX ind_inventario_factura (idInventario ASC),
  CONSTRAINT fk_inventario_factura
    FOREIGN KEY (idInventario)
    REFERENCES asoinco.Factura (idFactura)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table asoinco.Dotacion
-- -----------------------------------------------------
CREATE TABLE Dotacion (
  idDotacion INT NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (idDotacion),
  INDEX ind_dotacion_invetario (idDotacion ASC),
  CONSTRAINT fk_dotacion_inventario
    FOREIGN KEY (idDotacion)
    REFERENCES asoinco.Inventario (idInventario)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table asoinco.No_activos
-- -----------------------------------------------------
CREATE TABLE No_activos (
  idNo_activos INT NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(45) NOT NULL,
  Apellido VARCHAR(45) NOT NULL,
  Correo VARCHAR(45) NOT NULL,
  PRIMARY KEY (idNo_activos),
  INDEX ind_noactivos_inventario (idNo_activos ASC),
  CONSTRAINT fk_noactivos_inventario
    FOREIGN KEY (idNo_activos)
    REFERENCES asoinco.Inventario (idInventario)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table asoinco.Activos_fijos
-- -----------------------------------------------------
CREATE TABLE Activos_fijos (
  idActivos_fijos INT NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(45) NOT NULL,
  Apellido VARCHAR(45) NOT NULL,
  Correo VARCHAR(45) NOT NULL,
  PRIMARY KEY (idActivos_fijos),
  INDEX ind_activos_inventario (idActivos_fijos ASC),
  CONSTRAINT fk_activos_inventario
    FOREIGN KEY (idActivos_fijos)
    REFERENCES asoinco.Inventario (idInventario)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table asoinco.Movimiento
-- -----------------------------------------------------
CREATE TABLE Movimiento (
  idMovimiento INT NOT NULL AUTO_INCREMENT,
  Tipo_inventario VARCHAR(45) NOT NULL,
  Entrada_producto VARCHAR(45) NOT NULL,
  Salida_producto VARCHAR(45) NOT NULL,
  Fecha_hora VARCHAR(45) NOT NULL,
  Registro_diario VARCHAR(45) NOT NULL,
  Registro_mes VARCHAR(45) NOT NULL,
  Cant_tipo_inventario VARCHAR(45) NOT NULL,
  PRIMARY KEY (idMovimiento),
  INDEX ind_movimiento_inventario (idMovimiento ASC) ,
  CONSTRAINT fk_movimiento_inventario
    FOREIGN KEY (idMovimiento)
    REFERENCES asoinco.Inventario (idInventario)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table asoinco.Informes
-- -----------------------------------------------------
CREATE TABLE Informes (
  idInformes INT NOT NULL AUTO_INCREMENT,
  Registro_diario VARCHAR(45) NOT NULL,
  Registro_mes VARCHAR(45) NOT NULL,
  Tipo_inventario VARCHAR(45) NOT NULL,
  Fecha_hora VARCHAR(45) NOT NULL,
  Cant_disponible VARCHAR(45) NOT NULL,
  Cant_tipo_inventario VARCHAR(45) NOT NULL,
  PRIMARY KEY (idInformes),
  INDEX ind_informes_movimiento (idInformes ASC),
  CONSTRAINT fk_informes_movimiento
    FOREIGN KEY (idInformes)
    REFERENCES asoinco.Movimiento (idMovimiento)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
