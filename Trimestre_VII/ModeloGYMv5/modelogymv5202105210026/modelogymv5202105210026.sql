
CREATE DATABASE IF NOT EXISTS modelogymv5 DEFAULT CHARACTER SET utf8mb4;

USE modelogymv5;

--
-- Table structure for table `auditoria`
--
CREATE TABLE `auditoria` (
  `idAuditoria` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(30) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`idAuditoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auditoria`
--


--
-- Table structure for table `cargo`
--

CREATE TABLE `cargo` (
  `idCargo` int(11) NOT NULL AUTO_INCREMENT,
  `nombreCargo` varchar(30) NOT NULL,
  `descripcionCargo` text DEFAULT NULL,
  `salario` float(9,2) NOT NULL,
  `idEmpleado` int(4) DEFAULT NULL,
  PRIMARY KEY (`idCargo`),
  KEY `cargo_empleado` (`idEmpleado`),
  KEY `indexCargo` (`idCargo`),
  CONSTRAINT `cargo_empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

INSERT INTO `cargo` (`idCargo`, `nombreCargo`, `descripcionCargo`, `salario`, `idEmpleado`) VALUES (1,'ADMINISTRADOR','PERSONAL MANEJO CONFIANZA',1800000.00,2001),(2,'INSTRUCTOR','INSTRUCTOR PILATES',1000000.00,2002),(3,'CONTADOR','PROFESIONAL CONTADURIA PUBLICA',1500000.00,NULL);

--
-- Table structure for table `clave`
--

CREATE TABLE `clave` (
  `idClave` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(60) NOT NULL,
  `pwd` varchar(30) DEFAULT NULL,
  `idEmpleado` int(4) DEFAULT NULL,
  PRIMARY KEY (`idClave`),
  KEY `clave_empleado` (`idEmpleado`),
  KEY `indexClave` (`usuario`),
  CONSTRAINT `clave_empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`) 
  ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;


INSERT INTO `clave` (`idClave`, `usuario`, `pwd`, `idEmpleado`) VALUES 
(1,'juana@hotmail.com','pZyke2003',2001),(2,'sergio@gmail.com','Fall1234',2002);

DELIMITER ;;
CREATE trigger Audita_modifica_tabla_clave 
after update on clave for each row
insert into auditoria(usuario,descripcion,fecha)
values (user(),
concat('Se modifico el  : ', old.usuario,' Valor antiguo : ',
(old.pwd), '  Nuevo valor', (new.pwd)),now()) */;;
DELIMITER ;

DELIMITER ;;
CREATE trigger audita_actualizar_clave
	after update on clave for each row
	begin
		if (old.usuario<>new.usuario)
			then insert into  auditoria(usuario,descripcion,fecha)
			values(user(),
			concat('se modifico : ',old.usuario ,' Nuevo usuario : ',(new.usuario)), now());
		end if;
		if(old.pwd<>new.pwd)
			then insert into auditoria(usuario,descripcion,fecha)
			values(user(),
			concat('se modifico : ',old.pwd ,' Nueva clave : ',(new.pwd)), now());
	  	end if;
	end */;;
DELIMITER ;

--
-- Table structure for table `cliente`
--

CREATE TABLE `cliente` (
  `idCliente` int(15) NOT NULL,
  `idPersona` int(15) DEFAULT NULL,
  PRIMARY KEY (`idCliente`),
  KEY `cliente_persona` (`idPersona`),
  KEY `indexCliente` (`idCliente`),
  CONSTRAINT `cliente_persona` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) 
  ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `cliente` (`idCliente`, `idPersona`) VALUES (5001,1003828639),
(5003,1003828800),(5004,1003856801),(5002,1085923987);

--
-- Table structure for table `empleado`
--

CREATE TABLE `empleado` (
  `idEmpleado` int(4) NOT NULL,
  `rol` varchar(20) NOT NULL,
  `descripcionRol` text DEFAULT NULL,
  `fechaContratacion` date DEFAULT '1900-12-01',
  PRIMARY KEY (`idEmpleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `empleado` (`idEmpleado`, `rol`, `descripcionRol`, `fechaContratacion`) VALUES 
(2001,'Admin','Administra los accesos de los usuarios, sin ser root','2018-10-03'),
(2002,'BásicoNivel1','Consulta procesos los clientes','2019-12-06'),
(2003,'BásicoNivel2','Consulta datos contables y financieros','1900-12-01'),(2004,'',NULL,'2018-06-23');

DELIMITER ;;
CREATE trigger audita_actualizar_empleado
	after update on empleado for each row
	begin
		if (old.rol<>new.rol)
			then insert into  auditoria(usuario,descripcion,fecha)
			values(user(),
			concat('se modifico : ',old.rol ,' nombre : ',(new.rol)), now());
		end if;
		if(old.descripcionRol<>new.descripcionRol)
			then insert into auditoria(usuario,descripcion,fecha)
			values(user(),
			concat('se modifico : ',old.descripcionRol ,' nombre : ',(new.descripcionRol)), now());
	  	end if;
		if(old.fechaContratacion<>new.fechaContratacion)
			then insert into auditoria(usuario,descripcion,fecha)
			values (user(),
			concat('se modifico : ',old.fechaContratacion ,' nombre : ',(new.fechaContratacion)), now());
		end if;
	end */;;
DELIMITER ;

--
-- Table structure for table `factorrh`
--

CREATE TABLE `factorrh` (
  `idFactor` int(2) NOT NULL,
  `nombre` varchar(10) NOT NULL,
  PRIMARY KEY (`idFactor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



INSERT INTO `factorrh` (`idFactor`, `nombre`) VALUES (1,'POSITIVO'),(2,'NEGATIVO');

--
-- Table structure for table `factura`
--

CREATE TABLE `factura` (
  `idFactura` int(4) NOT NULL,
  `fechaFactura` date NOT NULL,
  `idCliente` int(15) NOT NULL,
  PRIMARY KEY (`idFactura`),
  KEY `factura_cliente` (`idCliente`),
  KEY `indexFactura` (`idFactura`),
  CONSTRAINT `factura_cliente` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) 
  ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `factura` (`idFactura`, `fechaFactura`, `idCliente`) VALUES (3001,'2020-09-25',5001),
(3002,'2020-08-03',5002);

--
-- Table structure for table `factura_producto`
--

CREATE TABLE `factura_producto` (
  `idFactura` int(4) NOT NULL,
  `idProducto` int(4) NOT NULL,
  KEY `idFactura` (`idFactura`),
  KEY `idProducto` (`idProducto`),
  CONSTRAINT `factura_producto_ibfk_1` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_producto_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `factura_producto` (`idFactura`, `idProducto`) VALUES (3001,6001),(3002,6002);

--
-- Table structure for table `genero`
--

CREATE TABLE `genero` (
  `idGenero` int(2) NOT NULL,
  `nombre` varchar(5) NOT NULL,
  PRIMARY KEY (`idGenero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `genero` (`idGenero`, `nombre`) VALUES (1,'M'),(2,'F'),(3,'OTRO');

--
-- Table structure for table `gruposanguineo`
--


CREATE TABLE `gruposanguineo` (
  `idGrupo` int(2) NOT NULL,
  `nombre` varchar(2) NOT NULL,
  PRIMARY KEY (`idGrupo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `gruposanguineo` (`idGrupo`, `nombre`) VALUES (10,'O'),(11,'A'),(12,'B'),(13,'AB');

--
-- Table structure for table `gruposanguineo_factorrh`
--


CREATE TABLE `gruposanguineo_factorrh` (
  `idGrupo` int(2) NOT NULL,
  `idFactor` int(2) NOT NULL,
  KEY `idGrupo` (`idGrupo`),
  KEY `idFactor` (`idFactor`),
  CONSTRAINT `gruposanguineo_factorrh_ibfk_1` FOREIGN KEY (`idGrupo`) REFERENCES `gruposanguineo` (`idGrupo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gruposanguineo_factorrh_ibfk_2` FOREIGN KEY (`idFactor`) REFERENCES `factorrh` (`idFactor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `gruposanguineo_factorrh` (`idGrupo`, `idFactor`) VALUES (10,1),(11,2),(13,1);

--
-- Table structure for table `persona`
--

CREATE TABLE `persona` (
  `idPersona` int(15) NOT NULL,
  `primerNombre` varchar(20) NOT NULL,
  `segundoNombre` varchar(20) DEFAULT NULL,
  `primerApellido` varchar(20) NOT NULL,
  `segundoApellido` varchar(20) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `idTipoDocu` int(2) NOT NULL,
  `idGenero` int(2) NOT NULL,
  `idGrupo` int(2) DEFAULT NULL,
  `idEmpleado` int(4) DEFAULT NULL,
  PRIMARY KEY (`idPersona`),
  KEY `persona_tipoDocu` (`idTipoDocu`),
  KEY `persona_genero` (`idGenero`),
  KEY `persona_grupoSanguineo` (`idGrupo`),
  KEY `persona_empleado` (`idEmpleado`),
  KEY `indexPersona` (`idPersona`),
  CONSTRAINT `persona_empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `persona_genero` FOREIGN KEY (`idGenero`) REFERENCES `genero` (`idGenero`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `persona_grupoSanguineo` FOREIGN KEY (`idGrupo`) REFERENCES `gruposanguineo` (`idGrupo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `persona_tipoDocu` FOREIGN KEY (`idTipoDocu`) REFERENCES `tipodocumento` (`idTipoDocu`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `persona` (`idPersona`, `primerNombre`, `segundoNombre`, `primerApellido`, `segundoApellido`, `telefono`, `email`, `direccion`, `fechaNacimiento`, `idTipoDocu`, `idGenero`, `idGrupo`, `idEmpleado`)
VALUES 
(1223432,'LIBARDO','ANTONIO','CASTAÑEDA','MOLINA','324657896','aunnotengo@com.co','centro','2000-02-19',1,1,13,NULL),
(1002399872,'Ana','','La Forcade','','7846532','nosebiencuales@donde.com.co','carrera 125N # 17-100','1990-10-23',2,2,11,2002),
(1003828639,'Paula','Analina','Cortez','Sepulveda','3456786','paulaanalina4562@gmail.com','Calle 45 # 5-87 Cerca algún lado','1980-10-23',4,1,NULL,NULL),
(1003828800,'JULIAN',NULL,'CASTRO',NULL,'324657896','aunnotengo@com.co',NULL,'2018-12-31',3,1,NULL,NULL),
(1003856801,'PETRONILA',NULL,'BERMUDES',NULL,'324897896','puedessereste@hotmail.co',NULL,'2014-11-19',1,2,NULL,NULL),
(1085923987,'Belinda de Josefa','Maria','Ortiz','','3245621','lamasbonita521@yahoo.es','Av. 30 de agosto, cerca al banco Bogota','1980-12-16',2,2,NULL,NULL),
(1786503863,'Roberto','De Jesus','Zapata','Montero','3285769','zariguellafeliz@nbc.com','Calle 63a #23-84','1984-05-15',1,1,10,2001);

DELIMITER ;;
CREATE trigger audita_actualizar_persona
	after update on persona for each row
	begin
		if (old.telefono<>new.telefono)
			then insert into  auditoria(usuario,descripcion,fecha)
			values(user(),
			concat('se modifico : ',old.telefono ,' Nuevo número : ',(new.telefono)), now());
		end if;
		if(old.email<>new.email)
			then insert into auditoria(usuario,descripcion,fecha)
			values(user(),
			concat('se modifico : ',old.email ,' Nuevo Email : ',(new.email)), now());
	  	end if;
	end ;;
DELIMITER ;

--
-- Table structure for table `producto`
--


CREATE TABLE `producto` (
  `idProducto` int(4) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` text NOT NULL,
  `cantidad` int(11) NOT NULL,
  `valorUnitario` decimal(9,2) NOT NULL,
  `stockMinimo` int(11) NOT NULL,
  `stockMaximo` int(11) NOT NULL,
  `idTipoProducto` int(4) DEFAULT NULL,
  PRIMARY KEY (`idProducto`),
  KEY `producto_tipoProducto` (`idTipoProducto`),
  KEY `indexProducto` (`idProducto`,`nombre`),
  CONSTRAINT `producto_tipoProducto` FOREIGN KEY (`idTipoProducto`) REFERENCES `tipoproducto` (`idTipoProducto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chequeo_stockMaximo` CHECK (`stockMaximo` >= 100),
  CONSTRAINT `chequeo_stockMinimo` CHECK (`stockMinimo` <= 10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `producto` (`idProducto`, `nombre`, `descripcion`, `cantidad`, `valorUnitario`, `stockMinimo`, `stockMaximo`, `idTipoProducto`) VALUES (6001,'CookEnergy','Lorem ipsum dolor sit amet consectetur adipisicing elit.',300,2000.00,4,101,4001),(6002,'Red Bull','Lorem ipsum dolor sit amet consectetur adipisicing elit.',205,5000.00,5,102,4001),(6003,'TNT','Lorem ipsum dolor sit amet consectetur adipisicing elit.',500,15000.00,6,103,4002),(6004,'Speed','Lorem ipsum dolor sit amet consectetur adipisicing elit.',500,2500.00,7,103,4003);

DELIMITER ;;
CREATE trigger Audita_modifica_tabla_producto 
after update on producto for each row
insert into auditoria(usuario,descripcion,fecha)
values (user(),
concat('Se modifico el precio : ', old.descripcion,' valor antiguo : ',
(old.valorUnitario), ' Nuevo valor : ', (new.valorUnitario)),now());;
DELIMITER ;

DELIMITER ;;
CREATE  trigger audita_actualizar_producto
	after update on producto for each row
	begin
		if (old.nombre<>new.nombre)
			then insert into  auditoria(usuario,descripcion,fecha)
			values(user(),
			concat('se modifico : ',old.nombre ,' Nuevo nombre : ',(new.nombre)), now());
		end if;
		if(old.descripcion<>new.descripcion)
			then insert into auditoria(usuario,descripcion,fecha)
			values(user(),
			concat('se modifico : ',old.descripcion ,' Nueva descripcion : ',(new.descripcion)), now());
	  	end if;
	  	if(old.cantidad<>new.cantidad)
			then insert into auditoria(usuario,descripcion,fecha)
			values(user(),
			concat('se modifico : ',old.cantidad ,' Nueva cantidad : ',(new.cantidad)), now());
	  	end if;
	  	if(old.valorUnitario<>new.valorUnitario)
			then insert into auditoria(usuario,descripcion,fecha)
			values(user(),
			concat('se modifico : ',old.valorUnitario ,' Nueva precio : ',(new.valorUnitario)), now());
	  	end if;
	end ;;
DELIMITER ;

--
-- Table structure for table `proveedor`
--


CREATE TABLE `proveedor` (
  `idProveedor` int(4) NOT NULL,
  `nombre` varchar(35) NOT NULL,
  `descripcion` text DEFAULT NULL,
  PRIMARY KEY (`idProveedor`),
  KEY `indexProveedor` (`idProveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `proveedor` (`idProveedor`, `nombre`, `descripcion`) VALUES
 (8001,'FIRTS NUTRITION','Lorem ipsum dolor sit amet consectetur adipisicing elit'),
 (8002,'GYMATIZE','Lorem ipsum dolor sit amet consectetur adipisicing elit'),
 (8003,'BE ONE','Lorem ipsum dolor sit amet consectetur adipisicing elit'),(8004,'SPEED',NULL);

DELIMITER ;;
CREATE trigger audita_actualizar_proveedor
	after update on proveedor for each row
	begin
		if (old.nombre<>new.nombre)
			then insert into  auditoria(usuario,descripcion,fecha)
			values(user(),
			concat('se modifico : ',old.nombre ,' Nuevo nombre : ',(new.nombre)), now());
		end if;
		if(old.descripcion<>new.descripcion)
			then insert into auditoria(usuario,descripcion,fecha)
			values(user(),
			concat('se modifico : ',old.descripcion ,' Nueva descripcion : ',(new.descripcion)), now());
	  	end if;
	end ;;
DELIMITER ;

--
-- Table structure for table `proveedor_producto`
--


CREATE TABLE `proveedor_producto` (
  `idProveedor` int(4) NOT NULL,
  `idProducto` int(4) NOT NULL,
  KEY `idProducto` (`idProducto`),
  KEY `idProveedor` (`idProveedor`),
  CONSTRAINT `proveedor_producto_ibfk_1` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `proveedor_producto_ibfk_2` FOREIGN KEY (`idProveedor`) REFERENCES `proveedor` (`idProveedor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `proveedor_producto` (`idProveedor`, `idProducto`) VALUES (8001,6001),(8002,6002),(8003,6003);

--
-- Table structure for table `tipodocumento`
--

CREATE TABLE `tipodocumento` (
  `idTipoDocu` int(2) NOT NULL,
  `nombre` varchar(5) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`idTipoDocu`),
  KEY `indexIdDocu` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `tipodocumento` (`idTipoDocu`, `nombre`, `descripcion`) VALUES 
(1,'CC','CEDULA DE CIUDADANIA'),(2,'TI','TARJETA DE IDENTIDAD'),
(3,'RUT','REGISTRO UNICO TRIBUTARIO'),(4,'CE','CEDULA DE EXTRANGERIA');

--
-- Table structure for table `tipoproducto`
--


CREATE TABLE `tipoproducto` (
  `idTipoProducto` int(4) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`idTipoProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `tipoproducto` (`idTipoProducto`, `nombre`) VALUES (4001,'BEBIDA ENERGISANTE'),
(4002,'PROTEINA'),(4003,'DULCE ENERGISANTE');

DELIMITER ;;
CREATE trigger audita_actualizar_tipo_producto
	after update on tipoproducto for each row
	begin
		if (old.nombre<>new.nombre)
			then insert into  auditoria(usuario,descripcion,fecha)
			values(user(),
			concat('se modifico : ',old.nombre ,' Nuevo nombre : ',(new.nombre)), now());
		end if;
	end ;;
DELIMITER ;

--
-- Temporary view structure for view `vistacompletacliente`
--

CREATE VIEW `vistacompletacliente` AS SELECT 
 1 AS `CODIGOCLIENTE`,
 1 AS `CEDULA`,
 1 AS `DESCRIPCION`,
 1 AS `P_NOMBRE`,
 1 AS `P_APELLIDO`,
 1 AS `DIRECCION`,
 1 AS `TELEFONO`,
 1 AS `EMAIL`;


--
-- Temporary view structure for view `vistadatoscliente`
--

CREATE VIEW `vistadatoscliente` AS SELECT 
 1 AS `idcliente`,
 1 AS `idPersona`,
 1 AS `nombre`,
 1 AS `primerNombre`,
 1 AS `segundoNombre`,
 1 AS `primerApellido`,
 1 AS `segundoApellido`,
 1 AS `direccion`,
 1 AS `telefono`,
 1 AS `email`;

--
-- Temporary view structure for view `vistadatosclienteindividual`
--

CREATE VIEW `vistadatosclienteindividual` AS SELECT 
 1 AS `CODIGOCLIENTE`,
 1 AS `CEDULA`,
 1 AS `DESCRIPCION`,
 1 AS `P_NOMBRE`,
 1 AS `P_APELLIDO`,
 1 AS `DIRECCION`,
 1 AS `TELEFONO`,
 1 AS `EMAIL`;

--
-- Temporary view structure for view `vistaempleadocargo`
--

CREATE VIEW `vistaempleadocargo` AS SELECT 
 1 AS `idEmpleado`,
 1 AS `idPersona`,
 1 AS `nombre`,
 1 AS `primerNombre`,
 1 AS `segundoNombre`,
 1 AS `primerApellido`,
 1 AS `telefono`,
 1 AS `fechaNacimiento`,
 1 AS `nombreCargo`,
 1 AS `salario`,
 1 AS `fechaContratacion`;

--
-- Temporary view structure for view `vistarolesempleado`
--

CREATE VIEW `vistarolesempleado` AS SELECT 
 1 AS `CEDULA`,
 1 AS `P_NOMBRE`,
 1 AS `S_NOMBRE`,
 1 AS `P_APELLIDO`,
 1 AS `S_APELLIDO`,
 1 AS `CARGO`,
 1 AS `rol`,
 1 AS `descripcionrol`;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPdeleter_Datos_proveedor`(in del_nom varchar(35))
begin
	 delete from proveedor where nombre = del_nom;
 end ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `SPinsertar_Datos_cliente`(
	IN newcodigo_persona INT(15),
	IN newpnombre_persona VARCHAR(20),
	IN newpapellido_persona VARCHAR(20),
	IN newtelefono_persona VARCHAR(15),
	IN newemail_persona VARCHAR(60),
	IN newfecha DATE, 
	IN newtipodocu_tipodocu INT(2),
	IN newgenero_genero INT(2),
	IN newcodigo_cliente INT(4) 
	)
BEGIN
	START TRANSACTION;
	INSERT INTO persona (idPersona,primerNombre,primerApellido,telefono,email,fechaNacimiento,idTipoDocu,idGenero) 
    VALUES 
    (newcodigo_persona,newpnombre_persona,newpapellido_persona,newtelefono_persona,newemail_persona,newfecha,newtipodocu_tipodocu,newgenero_genero);
    INSERT INTO cliente (idCliente,idPersona) VALUES (newcodigo_cliente,newcodigo_persona);
    END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPinsertar_Datos_persona`(
	IN newcodigo_persona INT,
	IN newpnombre_persona VARCHAR(20),
	IN newsnombre_persona VARCHAR(20),
	IN newpapellido_persona VARCHAR(20),
	IN newsapellido_persona VARCHAR(20),
	IN newtelefono_persona VARCHAR(15),
	IN newemail_persona VARCHAR(60),
	IN newdireccion_persona VARCHAR(50),
	IN newfechaNacimiento_persona DATE, 
	IN newtipodocu_tipodocu INT(2),
	IN newgenero_genero INT(2),
	IN newgrupo_grupo INT(4),
	IN newcodigo_empleado INT(4),
	IN newfechacontratacion_empleado DATE,
	IN newcodigo_cargo INT(11)
    )
BEGIN
	START TRANSACTION;
	INSERT INTO persona (idPersona,primerNombre,segundoNombre,primerApellido,segundoApellido,telefono,email,direccion,fechaNacimiento,idTipoDocu,
	idGenero,idGrupo) 
    VALUES 
    (newcodigo_persona,newpnombre_persona,newsnombre_persona,newpapellido_persona,newsapellido_persona,newtelefono_persona,newemail_persona,
    newdireccion_persona,newfechaNacimiento_persona,newtipodocu_tipodocu,newgenero_genero,newgrupo_grupo);
    INSERT INTO empleado (idEmpleado,fechaContratacion)VALUES (newcodigo_empleado,newfechacontratacion_empleado);
   	INSERT INTO cargo(idCargo) VALUES(newcodigo_cargo);
  END ;;
DELIMITER ;


DELIMITER ;;
CREATE PROCEDURE `SPinsertar_Datos_proveedor`(
	IN codigo INT(4),IN nombre VARCHAR(35),IN descipcion TEXT)
BEGIN
	    
    INSERT INTO proveedor (idProveedor,nombre,descripcion) 
    VALUES (codigo,nombre,descripcion);
    END ;;
DELIMITER ;


DELIMITER ;;
CREATE PROCEDURE `SPselect_Datos_producto`()
BEGIN
	    
    SELECT * FROM producto WHERE idProducto = 6001;
    END ;;
DELIMITER ;


DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPupdate_Datos_proveedor`(
IN new_codigo INT(4),
IN new_nombre VARCHAR(35),
IN old_nombre VARCHAR(35))
BEGIN

UPDATE proveedor SET idProveedor = new_codigo, nombre = new_nombre
WHERE idProveedor = new_codigo;
END ;;
DELIMITER ;


USE `modelogymv5`;

--
-- Final view structure for view `vistacompletacliente`
--

DROP VIEW IF EXISTS `vistacompletacliente`;

VIEW `vistacompletacliente` AS select `cliente`.`idCliente` AS `CODIGOCLIENTE`,`persona`.`idPersona` AS `CEDULA`,`tipodocumento`.`nombre` AS `DESCRIPCION`,`persona`.`primerNombre` AS `P_NOMBRE`,`persona`.`primerApellido` AS `P_APELLIDO`,`persona`.`direccion` AS `DIRECCION`,`persona`.`telefono` AS `TELEFONO`,`persona`.`email` AS `EMAIL` from ((`cliente` left join `persona` on(`cliente`.`idPersona` = `persona`.`idPersona`)) left join `tipodocumento` on(`persona`.`idTipoDocu` = `tipodocumento`.`idTipoDocu`)) */;

--
-- Final view structure for view `vistadatoscliente`
--

DROP VIEW IF EXISTS `vistadatoscliente`;

VIEW `vistadatoscliente` AS select `cliente`.`idCliente` AS `idcliente`,`persona`.`idPersona` AS `idPersona`,`tipodocumento`.`nombre` AS `nombre`,`persona`.`primerNombre` AS `primerNombre`,`persona`.`segundoNombre` AS `segundoNombre`,`persona`.`primerApellido` AS `primerApellido`,`persona`.`segundoApellido` AS `segundoApellido`,`persona`.`direccion` AS `direccion`,`persona`.`telefono` AS `telefono`,`persona`.`email` AS `email` from ((`cliente` left join `persona` on(`persona`.`idPersona` = `cliente`.`idPersona`)) left join `tipodocumento` on(`tipodocumento`.`idTipoDocu` = `persona`.`idTipoDocu`)) order by 2 */;

--
-- Final view structure for view `vistadatosclienteindividual`
--

DROP VIEW IF EXISTS `vistadatosclienteindividual`;

VIEW `vistadatosclienteindividual` AS select `cliente`.`idCliente` AS `CODIGOCLIENTE`,`persona`.`idPersona` AS `CEDULA`,`tipodocumento`.`nombre` AS `DESCRIPCION`,`persona`.`primerNombre` AS `P_NOMBRE`,`persona`.`primerApellido` AS `P_APELLIDO`,`persona`.`direccion` AS `DIRECCION`,`persona`.`telefono` AS `TELEFONO`,`persona`.`email` AS `EMAIL` from ((`cliente` left join `persona` on(`cliente`.`idPersona` = `persona`.`idPersona`)) left join `tipodocumento` on(`persona`.`idTipoDocu` = `tipodocumento`.`idTipoDocu`)) where `persona`.`idPersona` = 1085923987 */;

--
-- Final view structure for view `vistaempleadocargo`
--

DROP VIEW IF EXISTS `vistaempleadocargo`;

VIEW `vistaempleadocargo` AS select `empleado`.`idEmpleado` AS `idEmpleado`,`persona`.`idPersona` AS `idPersona`,`tipodocumento`.`nombre` AS `nombre`,`persona`.`primerNombre` AS `primerNombre`,`persona`.`segundoNombre` AS `segundoNombre`,`persona`.`primerApellido` AS `primerApellido`,`persona`.`telefono` AS `telefono`,`persona`.`fechaNacimiento` AS `fechaNacimiento`,`cargo`.`nombreCargo` AS `nombreCargo`,`cargo`.`salario` AS `salario`,`empleado`.`fechaContratacion` AS `fechaContratacion` from ((`cargo` left join (`empleado` left join `persona` on(`persona`.`idEmpleado` = `empleado`.`idEmpleado`)) on(`empleado`.`idEmpleado` = `cargo`.`idEmpleado`)) join `tipodocumento` on(`tipodocumento`.`idTipoDocu` = `persona`.`idTipoDocu`)) order by 3 */;

--
-- Final view structure for view `vistarolesempleado`
--

DROP VIEW IF EXISTS `vistarolesempleado`;

VIEW `vistarolesempleado` AS select `persona`.`idPersona` AS `CEDULA`,`persona`.`primerNombre` AS `P_NOMBRE`,`persona`.`segundoApellido` AS `S_NOMBRE`,`persona`.`primerApellido` AS `P_APELLIDO`,`persona`.`segundoApellido` AS `S_APELLIDO`,`cargo`.`nombreCargo` AS `CARGO`,`empleado`.`rol` AS `rol`,`empleado`.`descripcionRol` AS `descripcionrol` from ((`persona` left join `empleado` on(`persona`.`idEmpleado` = `empleado`.`idEmpleado`)) join `cargo` on(`empleado`.`idEmpleado` = `cargo`.`idEmpleado`)) */;

-- Dump completed on 2021-05-21  0:26:27
