-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-05-2021 a las 07:28:06
-- Versión del servidor: 10.4.18-MariaDB
-- Versión de PHP: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `modelogymv5`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPdeleter_Datos_proveedor` (IN `del_nom` VARCHAR(35))  begin
	 delete from proveedor where nombre = del_nom;
 end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPinsertar_Datos_cliente` (IN `newcodigo_persona` INT(15), IN `newpnombre_persona` VARCHAR(20), IN `newpapellido_persona` VARCHAR(20), IN `newtelefono_persona` VARCHAR(15), IN `newemail_persona` VARCHAR(60), IN `newfecha` DATE, IN `newtipodocu_tipodocu` INT(2), IN `newgenero_genero` INT(2), IN `newcodigo_cliente` INT(4))  BEGIN
	START TRANSACTION;
	INSERT INTO persona (idPersona,primerNombre,primerApellido,telefono,email,fechaNacimiento,idTipoDocu,idGenero) 
    VALUES 
    (newcodigo_persona,newpnombre_persona,newpapellido_persona,newtelefono_persona,newemail_persona,newfecha,newtipodocu_tipodocu,newgenero_genero);
    INSERT INTO cliente (idCliente,idPersona) VALUES (newcodigo_cliente,newcodigo_persona);
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPinsertar_Datos_persona` (IN `newcodigo_persona` INT, IN `newpnombre_persona` VARCHAR(20), IN `newsnombre_persona` VARCHAR(20), IN `newpapellido_persona` VARCHAR(20), IN `newsapellido_persona` VARCHAR(20), IN `newtelefono_persona` VARCHAR(15), IN `newemail_persona` VARCHAR(60), IN `newdireccion_persona` VARCHAR(50), IN `newfechaNacimiento_persona` DATE, IN `newtipodocu_tipodocu` INT(2), IN `newgenero_genero` INT(2), IN `newgrupo_grupo` INT(4), IN `newcodigo_empleado` INT(4), IN `newfechacontratacion_empleado` DATE, IN `newcodigo_cargo` INT(11))  BEGIN
	START TRANSACTION;
	INSERT INTO persona (idPersona,primerNombre,segundoNombre,primerApellido,segundoApellido,telefono,email,direccion,fechaNacimiento,idTipoDocu,
	idGenero,idGrupo) 
    VALUES 
    (newcodigo_persona,newpnombre_persona,newsnombre_persona,newpapellido_persona,newsapellido_persona,newtelefono_persona,newemail_persona,
    newdireccion_persona,newfechaNacimiento_persona,newtipodocu_tipodocu,newgenero_genero,newgrupo_grupo);
    INSERT INTO empleado (idEmpleado,fechaContratacion)VALUES (newcodigo_empleado,newfechacontratacion_empleado);
   	INSERT INTO cargo(idCargo) VALUES(newcodigo_cargo);
  END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPinsertar_Datos_proveedor` (IN `codigo` INT(4), IN `nombre` VARCHAR(35), IN `descipcion` TEXT)  BEGIN
	    
    INSERT INTO proveedor (idProveedor,nombre,descripcion) 
    VALUES (codigo,nombre,descripcion);
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPselect_Datos_producto` ()  BEGIN
	    
    SELECT * FROM producto WHERE idProducto = 6001;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPupdate_Datos_proveedor` (IN `new_codigo` INT(4), IN `new_nombre` VARCHAR(35), IN `old_nombre` VARCHAR(35))  BEGIN

UPDATE proveedor SET idProveedor = new_codigo, nombre = new_nombre
WHERE idProveedor = new_codigo;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria`
--

CREATE TABLE `auditoria` (
  `idAuditoria` int(11) NOT NULL,
  `usuario` varchar(30) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo`
--

CREATE TABLE `cargo` (
  `idCargo` int(11) NOT NULL,
  `nombreCargo` varchar(30) NOT NULL,
  `descripcionCargo` text DEFAULT NULL,
  `salario` float(9,2) NOT NULL,
  `idEmpleado` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cargo`
--

INSERT INTO `cargo` (`idCargo`, `nombreCargo`, `descripcionCargo`, `salario`, `idEmpleado`) VALUES
(1, 'ADMINISTRADOR', 'PERSONAL MANEJO CONFIANZA', 1800000.00, 2001),
(2, 'INSTRUCTOR', 'INSTRUCTOR PILATES', 1000000.00, 2002),
(3, 'CONTADOR', 'PROFESIONAL CONTADURIA PUBLICA', 1500000.00, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clave`
--

CREATE TABLE `clave` (
  `idClave` int(11) NOT NULL,
  `usuario` varchar(60) NOT NULL,
  `pwd` varchar(30) DEFAULT NULL,
  `idEmpleado` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `clave`
--

INSERT INTO `clave` (`idClave`, `usuario`, `pwd`, `idEmpleado`) VALUES
(1, 'juana@hotmail.com', 'pZyke2003', 2001),
(2, 'sergio@gmail.com', 'Fall1234', 2002);

--
-- Disparadores `clave`
--
DELIMITER $$
CREATE TRIGGER `Audita_modifica_tabla_clave` AFTER UPDATE ON `clave` FOR EACH ROW insert into auditoria(usuario,descripcion,fecha)
values (user(),
concat('Se modifico el  : ', old.usuario,' Valor antiguo : ',
(old.pwd), '  Nuevo valor', (new.pwd)),now())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `audita_actualizar_clave` AFTER UPDATE ON `clave` FOR EACH ROW begin
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
	end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `idCliente` int(15) NOT NULL,
  `idPersona` int(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`idCliente`, `idPersona`) VALUES
(5001, 1003828639),
(5003, 1003828800),
(5004, 1003856801),
(5002, 1085923987);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `idEmpleado` int(4) NOT NULL,
  `rol` varchar(20) NOT NULL,
  `descripcionRol` text DEFAULT NULL,
  `fechaContratacion` date DEFAULT '1900-12-01'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`idEmpleado`, `rol`, `descripcionRol`, `fechaContratacion`) VALUES
(2001, 'Admin', 'Administra los accesos de los usuarios, sin ser root', '2018-10-03'),
(2002, 'BásicoNivel1', 'Consulta procesos los clientes', '2019-12-06'),
(2003, 'BásicoNivel2', 'Consulta datos contables y financieros', '1900-12-01'),
(2004, '', NULL, '2018-06-23');

--
-- Disparadores `empleado`
--
DELIMITER $$
CREATE TRIGGER `audita_actualizar_empleado` AFTER UPDATE ON `empleado` FOR EACH ROW begin
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
	end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factorrh`
--

CREATE TABLE `factorrh` (
  `idFactor` int(2) NOT NULL,
  `nombre` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `factorrh`
--

INSERT INTO `factorrh` (`idFactor`, `nombre`) VALUES
(1, 'POSITIVO'),
(2, 'NEGATIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `idFactura` int(4) NOT NULL,
  `fechaFactura` date NOT NULL,
  `idCliente` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`idFactura`, `fechaFactura`, `idCliente`) VALUES
(3001, '2020-09-25', 5001),
(3002, '2020-08-03', 5002);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura_producto`
--

CREATE TABLE `factura_producto` (
  `idFactura` int(4) NOT NULL,
  `idProducto` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `factura_producto`
--

INSERT INTO `factura_producto` (`idFactura`, `idProducto`) VALUES
(3001, 6001),
(3002, 6002);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genero`
--

CREATE TABLE `genero` (
  `idGenero` int(2) NOT NULL,
  `nombre` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `genero`
--

INSERT INTO `genero` (`idGenero`, `nombre`) VALUES
(1, 'M'),
(2, 'F'),
(3, 'OTRO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gruposanguineo`
--

CREATE TABLE `gruposanguineo` (
  `idGrupo` int(2) NOT NULL,
  `nombre` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `gruposanguineo`
--

INSERT INTO `gruposanguineo` (`idGrupo`, `nombre`) VALUES
(10, 'O'),
(11, 'A'),
(12, 'B'),
(13, 'AB');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gruposanguineo_factorrh`
--

CREATE TABLE `gruposanguineo_factorrh` (
  `idGrupo` int(2) NOT NULL,
  `idFactor` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `gruposanguineo_factorrh`
--

INSERT INTO `gruposanguineo_factorrh` (`idGrupo`, `idFactor`) VALUES
(10, 1),
(11, 2),
(13, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
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
  `idEmpleado` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idPersona`, `primerNombre`, `segundoNombre`, `primerApellido`, `segundoApellido`, `telefono`, `email`, `direccion`, `fechaNacimiento`, `idTipoDocu`, `idGenero`, `idGrupo`, `idEmpleado`) VALUES
(1223432, 'LIBARDO', 'ANTONIO', 'CASTAÑEDA', 'MOLINA', '324657896', 'aunnotengo@com.co', 'centro', '2000-02-19', 1, 1, 13, NULL),
(1002399872, 'Ana', '', 'La Forcade', '', '7846532', 'nosebiencuales@donde.com.co', 'carrera 125N # 17-100', '1990-10-23', 2, 2, 11, 2002),
(1003828639, 'Paula', 'Analina', 'Cortez', 'Sepulveda', '3456786', 'paulaanalina4562@gmail.com', 'Calle 45 # 5-87 Cerca algún lado', '1980-10-23', 4, 1, NULL, NULL),
(1003828800, 'JULIAN', NULL, 'CASTRO', NULL, '324657896', 'aunnotengo@com.co', NULL, '2018-12-31', 3, 1, NULL, NULL),
(1003856801, 'PETRONILA', NULL, 'BERMUDES', NULL, '324897896', 'puedessereste@hotmail.co', NULL, '2014-11-19', 1, 2, NULL, NULL),
(1085923987, 'Belinda de Josefa', 'Maria', 'Ortiz', '', '3245621', 'lamasbonita521@yahoo.es', 'Av. 30 de agosto, cerca al banco Bogota', '1980-12-16', 2, 2, NULL, NULL),
(1786503863, 'Roberto', 'De Jesus', 'Zapata', 'Montero', '3285769', 'zariguellafeliz@nbc.com', 'Calle 63a #23-84', '1984-05-15', 1, 1, 10, 2001);

--
-- Disparadores `persona`
--
DELIMITER $$
CREATE TRIGGER `audita_actualizar_persona` AFTER UPDATE ON `persona` FOR EACH ROW begin
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
	end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `idProducto` int(4) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` text NOT NULL,
  `cantidad` int(11) NOT NULL,
  `valorUnitario` decimal(9,2) NOT NULL,
  `stockMinimo` int(11) NOT NULL,
  `stockMaximo` int(11) NOT NULL,
  `idTipoProducto` int(4) DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`idProducto`, `nombre`, `descripcion`, `cantidad`, `valorUnitario`, `stockMinimo`, `stockMaximo`, `idTipoProducto`) VALUES
(6001, 'CookEnergy', 'Lorem ipsum dolor sit amet consectetur adipisicing elit.', 300, '2000.00', 4, 101, 4001),
(6002, 'Red Bull', 'Lorem ipsum dolor sit amet consectetur adipisicing elit.', 205, '5000.00', 5, 102, 4001),
(6003, 'TNT', 'Lorem ipsum dolor sit amet consectetur adipisicing elit.', 500, '15000.00', 6, 103, 4002),
(6004, 'Speed', 'Lorem ipsum dolor sit amet consectetur adipisicing elit.', 500, '2500.00', 7, 103, 4003);

--
-- Disparadores `producto`
--
DELIMITER $$
CREATE TRIGGER `Audita_modifica_tabla_producto` AFTER UPDATE ON `producto` FOR EACH ROW insert into auditoria(usuario,descripcion,fecha)
values (user(),
concat('Se modifico el precio : ', old.descripcion,' valor antiguo : ',
(old.valorUnitario), ' Nuevo valor : ', (new.valorUnitario)),now())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `audita_actualizar_producto` AFTER UPDATE ON `producto` FOR EACH ROW begin
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
	end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `idProveedor` int(4) NOT NULL,
  `nombre` varchar(35) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`idProveedor`, `nombre`, `descripcion`) VALUES
(8001, 'FIRTS NUTRITION', 'Lorem ipsum dolor sit amet consectetur adipisicing elit'),
(8002, 'GYMATIZE', 'Lorem ipsum dolor sit amet consectetur adipisicing elit'),
(8003, 'BE ONE', 'Lorem ipsum dolor sit amet consectetur adipisicing elit'),
(8004, 'SPEED', NULL);

--
-- Disparadores `proveedor`
--
DELIMITER $$
CREATE TRIGGER `audita_actualizar_proveedor` AFTER UPDATE ON `proveedor` FOR EACH ROW begin
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
	end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor_producto`
--

CREATE TABLE `proveedor_producto` (
  `idProveedor` int(4) NOT NULL,
  `idProducto` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `proveedor_producto`
--

INSERT INTO `proveedor_producto` (`idProveedor`, `idProducto`) VALUES
(8001, 6001),
(8002, 6002),
(8003, 6003);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipodocumento`
--

CREATE TABLE `tipodocumento` (
  `idTipoDocu` int(2) NOT NULL,
  `nombre` varchar(5) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipodocumento`
--

INSERT INTO `tipodocumento` (`idTipoDocu`, `nombre`, `descripcion`) VALUES
(1, 'CC', 'CEDULA DE CIUDADANIA'),
(2, 'TI', 'TARJETA DE IDENTIDAD'),
(3, 'RUT', 'REGISTRO UNICO TRIBUTARIO'),
(4, 'CE', 'CEDULA DE EXTRANGERIA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoproducto`
--

CREATE TABLE `tipoproducto` (
  `idTipoProducto` int(4) NOT NULL,
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipoproducto`
--

INSERT INTO `tipoproducto` (`idTipoProducto`, `nombre`) VALUES
(4001, 'BEBIDA ENERGISANTE'),
(4002, 'PROTEINA'),
(4003, 'DULCE ENERGISANTE');

--
-- Disparadores `tipoproducto`
--
DELIMITER $$
CREATE TRIGGER `audita_actualizar_tipo_producto` AFTER UPDATE ON `tipoproducto` FOR EACH ROW begin
		if (old.nombre<>new.nombre)
			then insert into  auditoria(usuario,descripcion,fecha)
			values(user(),
			concat('se modifico : ',old.nombre ,' Nuevo nombre : ',(new.nombre)), now());
		end if;
	end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vistacompletacliente`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vistacompletacliente` (
`CODIGOCLIENTE` int(15)
,`CEDULA` int(15)
,`DESCRIPCION` varchar(5)
,`P_NOMBRE` varchar(20)
,`P_APELLIDO` varchar(20)
,`DIRECCION` varchar(50)
,`TELEFONO` varchar(15)
,`EMAIL` varchar(60)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vistadatoscliente`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vistadatoscliente` (
`idcliente` int(15)
,`idPersona` int(15)
,`nombre` varchar(5)
,`primerNombre` varchar(20)
,`segundoNombre` varchar(20)
,`primerApellido` varchar(20)
,`segundoApellido` varchar(20)
,`direccion` varchar(50)
,`telefono` varchar(15)
,`email` varchar(60)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vistadatosclienteindividual`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vistadatosclienteindividual` (
`CODIGOCLIENTE` int(15)
,`CEDULA` int(15)
,`DESCRIPCION` varchar(5)
,`P_NOMBRE` varchar(20)
,`P_APELLIDO` varchar(20)
,`DIRECCION` varchar(50)
,`TELEFONO` varchar(15)
,`EMAIL` varchar(60)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vistaempleadocargo`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vistaempleadocargo` (
`idEmpleado` int(4)
,`idPersona` int(15)
,`nombre` varchar(5)
,`primerNombre` varchar(20)
,`segundoNombre` varchar(20)
,`primerApellido` varchar(20)
,`telefono` varchar(15)
,`fechaNacimiento` date
,`nombreCargo` varchar(30)
,`salario` float(9,2)
,`fechaContratacion` date
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vistarolesempleado`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vistarolesempleado` (
`CEDULA` int(15)
,`P_NOMBRE` varchar(20)
,`S_NOMBRE` varchar(20)
,`P_APELLIDO` varchar(20)
,`S_APELLIDO` varchar(20)
,`CARGO` varchar(30)
,`rol` varchar(20)
,`descripcionrol` text
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vistacompletacliente`
--
DROP TABLE IF EXISTS `vistacompletacliente`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vistacompletacliente`  AS SELECT `cliente`.`idCliente` AS `CODIGOCLIENTE`, `persona`.`idPersona` AS `CEDULA`, `tipodocumento`.`nombre` AS `DESCRIPCION`, `persona`.`primerNombre` AS `P_NOMBRE`, `persona`.`primerApellido` AS `P_APELLIDO`, `persona`.`direccion` AS `DIRECCION`, `persona`.`telefono` AS `TELEFONO`, `persona`.`email` AS `EMAIL` FROM ((`cliente` left join `persona` on(`cliente`.`idPersona` = `persona`.`idPersona`)) left join `tipodocumento` on(`persona`.`idTipoDocu` = `tipodocumento`.`idTipoDocu`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vistadatoscliente`
--
DROP TABLE IF EXISTS `vistadatoscliente`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vistadatoscliente`  AS SELECT `cliente`.`idCliente` AS `idcliente`, `persona`.`idPersona` AS `idPersona`, `tipodocumento`.`nombre` AS `nombre`, `persona`.`primerNombre` AS `primerNombre`, `persona`.`segundoNombre` AS `segundoNombre`, `persona`.`primerApellido` AS `primerApellido`, `persona`.`segundoApellido` AS `segundoApellido`, `persona`.`direccion` AS `direccion`, `persona`.`telefono` AS `telefono`, `persona`.`email` AS `email` FROM ((`cliente` left join `persona` on(`persona`.`idPersona` = `cliente`.`idPersona`)) left join `tipodocumento` on(`tipodocumento`.`idTipoDocu` = `persona`.`idTipoDocu`)) ORDER BY 2 ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vistadatosclienteindividual`
--
DROP TABLE IF EXISTS `vistadatosclienteindividual`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vistadatosclienteindividual`  AS SELECT `cliente`.`idCliente` AS `CODIGOCLIENTE`, `persona`.`idPersona` AS `CEDULA`, `tipodocumento`.`nombre` AS `DESCRIPCION`, `persona`.`primerNombre` AS `P_NOMBRE`, `persona`.`primerApellido` AS `P_APELLIDO`, `persona`.`direccion` AS `DIRECCION`, `persona`.`telefono` AS `TELEFONO`, `persona`.`email` AS `EMAIL` FROM ((`cliente` left join `persona` on(`cliente`.`idPersona` = `persona`.`idPersona`)) left join `tipodocumento` on(`persona`.`idTipoDocu` = `tipodocumento`.`idTipoDocu`)) WHERE `persona`.`idPersona` = 1085923987 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vistaempleadocargo`
--
DROP TABLE IF EXISTS `vistaempleadocargo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vistaempleadocargo`  AS SELECT `empleado`.`idEmpleado` AS `idEmpleado`, `persona`.`idPersona` AS `idPersona`, `tipodocumento`.`nombre` AS `nombre`, `persona`.`primerNombre` AS `primerNombre`, `persona`.`segundoNombre` AS `segundoNombre`, `persona`.`primerApellido` AS `primerApellido`, `persona`.`telefono` AS `telefono`, `persona`.`fechaNacimiento` AS `fechaNacimiento`, `cargo`.`nombreCargo` AS `nombreCargo`, `cargo`.`salario` AS `salario`, `empleado`.`fechaContratacion` AS `fechaContratacion` FROM ((`cargo` left join (`empleado` left join `persona` on(`persona`.`idEmpleado` = `empleado`.`idEmpleado`)) on(`empleado`.`idEmpleado` = `cargo`.`idEmpleado`)) join `tipodocumento` on(`tipodocumento`.`idTipoDocu` = `persona`.`idTipoDocu`)) ORDER BY 3 ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vistarolesempleado`
--
DROP TABLE IF EXISTS `vistarolesempleado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vistarolesempleado`  AS SELECT `persona`.`idPersona` AS `CEDULA`, `persona`.`primerNombre` AS `P_NOMBRE`, `persona`.`segundoApellido` AS `S_NOMBRE`, `persona`.`primerApellido` AS `P_APELLIDO`, `persona`.`segundoApellido` AS `S_APELLIDO`, `cargo`.`nombreCargo` AS `CARGO`, `empleado`.`rol` AS `rol`, `empleado`.`descripcionRol` AS `descripcionrol` FROM ((`persona` left join `empleado` on(`persona`.`idEmpleado` = `empleado`.`idEmpleado`)) join `cargo` on(`empleado`.`idEmpleado` = `cargo`.`idEmpleado`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  ADD PRIMARY KEY (`idAuditoria`);

--
-- Indices de la tabla `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`idCargo`),
  ADD KEY `cargo_empleado` (`idEmpleado`),
  ADD KEY `indexCargo` (`idCargo`);

--
-- Indices de la tabla `clave`
--
ALTER TABLE `clave`
  ADD PRIMARY KEY (`idClave`),
  ADD KEY `clave_empleado` (`idEmpleado`),
  ADD KEY `indexClave` (`usuario`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idCliente`),
  ADD KEY `cliente_persona` (`idPersona`),
  ADD KEY `indexCliente` (`idCliente`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`idEmpleado`);

--
-- Indices de la tabla `factorrh`
--
ALTER TABLE `factorrh`
  ADD PRIMARY KEY (`idFactor`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`idFactura`),
  ADD KEY `factura_cliente` (`idCliente`),
  ADD KEY `indexFactura` (`idFactura`);

--
-- Indices de la tabla `factura_producto`
--
ALTER TABLE `factura_producto`
  ADD KEY `idFactura` (`idFactura`),
  ADD KEY `idProducto` (`idProducto`);

--
-- Indices de la tabla `genero`
--
ALTER TABLE `genero`
  ADD PRIMARY KEY (`idGenero`);

--
-- Indices de la tabla `gruposanguineo`
--
ALTER TABLE `gruposanguineo`
  ADD PRIMARY KEY (`idGrupo`);

--
-- Indices de la tabla `gruposanguineo_factorrh`
--
ALTER TABLE `gruposanguineo_factorrh`
  ADD KEY `idGrupo` (`idGrupo`),
  ADD KEY `idFactor` (`idFactor`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idPersona`),
  ADD KEY `persona_tipoDocu` (`idTipoDocu`),
  ADD KEY `persona_genero` (`idGenero`),
  ADD KEY `persona_grupoSanguineo` (`idGrupo`),
  ADD KEY `persona_empleado` (`idEmpleado`),
  ADD KEY `indexPersona` (`idPersona`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `producto_tipoProducto` (`idTipoProducto`),
  ADD KEY `indexProducto` (`idProducto`,`nombre`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`idProveedor`),
  ADD KEY `indexProveedor` (`idProveedor`);

--
-- Indices de la tabla `proveedor_producto`
--
ALTER TABLE `proveedor_producto`
  ADD KEY `idProducto` (`idProducto`),
  ADD KEY `idProveedor` (`idProveedor`);

--
-- Indices de la tabla `tipodocumento`
--
ALTER TABLE `tipodocumento`
  ADD PRIMARY KEY (`idTipoDocu`),
  ADD KEY `indexIdDocu` (`nombre`);

--
-- Indices de la tabla `tipoproducto`
--
ALTER TABLE `tipoproducto`
  ADD PRIMARY KEY (`idTipoProducto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  MODIFY `idAuditoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cargo`
--
ALTER TABLE `cargo`
  MODIFY `idCargo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `clave`
--
ALTER TABLE `clave`
  MODIFY `idClave` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cargo`
--
ALTER TABLE `cargo`
  ADD CONSTRAINT `cargo_empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `clave`
--
ALTER TABLE `clave`
  ADD CONSTRAINT `clave_empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_persona` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_cliente` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `factura_producto`
--
ALTER TABLE `factura_producto`
  ADD CONSTRAINT `factura_producto_ibfk_1` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `factura_producto_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `gruposanguineo_factorrh`
--
ALTER TABLE `gruposanguineo_factorrh`
  ADD CONSTRAINT `gruposanguineo_factorrh_ibfk_1` FOREIGN KEY (`idGrupo`) REFERENCES `gruposanguineo` (`idGrupo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `gruposanguineo_factorrh_ibfk_2` FOREIGN KEY (`idFactor`) REFERENCES `factorrh` (`idFactor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `persona_genero` FOREIGN KEY (`idGenero`) REFERENCES `genero` (`idGenero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `persona_grupoSanguineo` FOREIGN KEY (`idGrupo`) REFERENCES `gruposanguineo` (`idGrupo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `persona_tipoDocu` FOREIGN KEY (`idTipoDocu`) REFERENCES `tipodocumento` (`idTipoDocu`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_tipoProducto` FOREIGN KEY (`idTipoProducto`) REFERENCES `tipoproducto` (`idTipoProducto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `proveedor_producto`
--
ALTER TABLE `proveedor_producto`
  ADD CONSTRAINT `proveedor_producto_ibfk_1` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `proveedor_producto_ibfk_2` FOREIGN KEY (`idProveedor`) REFERENCES `proveedor` (`idProveedor`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
