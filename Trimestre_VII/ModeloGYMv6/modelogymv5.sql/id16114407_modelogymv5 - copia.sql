-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 25-09-2021 a las 03:44:38
-- Versión del servidor: 10.3.16-MariaDB
-- Versión de PHP: 7.3.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `id16114407_modelogymv5`
--
CREATE DATABASE IF NOT EXISTS `id16114407_modelogymv5` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `id16114407_modelogymv5`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria`
--

DROP TABLE IF EXISTS `auditoria`;
CREATE TABLE IF NOT EXISTS `auditoria` (
  `idAuditoria` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(30) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`idAuditoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo`
--

DROP TABLE IF EXISTS `cargo`;
CREATE TABLE IF NOT EXISTS `cargo` (
  `idCargo` int(11) NOT NULL AUTO_INCREMENT,
  `nombreCargo` varchar(30) NOT NULL,
  `descripcionCargo` text DEFAULT NULL,
  `salario` float(9,2) NOT NULL,
  PRIMARY KEY (`idCargo`),
  KEY `indexCargo` (`idCargo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cargo`
--

INSERT INTO `cargo` (`idCargo`, `nombreCargo`, `descripcionCargo`, `salario`) VALUES
(1, 'ADMINISTRADOR', 'PERSONAL MANEJO CONFIANZA', 1800000.00),
(2, 'INSTRUCTOR', 'INSTRUCTOR PILATES', 1200000.00),
(3, 'CONTADOR', 'PROFESIONAL CONTADURIA PUBLICA', 1500000.00),
(4, 'OFICIOS GENERALES', 'BACHILLER', 1000000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `idCliente` int(15) NOT NULL,
  `idPersona` int(15) DEFAULT NULL,
  PRIMARY KEY (`idCliente`),
  KEY `cliente_persona` (`idPersona`),
  KEY `indexCliente` (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

DROP TABLE IF EXISTS `empleado`;
CREATE TABLE IF NOT EXISTS `empleado` (
  `idEmpleado` int(4) NOT NULL,
  `fechaContratacion` date DEFAULT '1900-12-01',
  `idUsuario` int(11) DEFAULT NULL,
  `idCargo` int(11) DEFAULT NULL,
  PRIMARY KEY (`idEmpleado`),
  KEY `empleado_usuarios` (`idUsuario`),
  KEY `empleado_cargo` (`idCargo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factorrh`
--

DROP TABLE IF EXISTS `factorrh`;
CREATE TABLE IF NOT EXISTS `factorrh` (
  `idFactor` int(2) NOT NULL,
  `nombre` varchar(10) NOT NULL,
  PRIMARY KEY (`idFactor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

DROP TABLE IF EXISTS `factura`;
CREATE TABLE IF NOT EXISTS `factura` (
  `idFactura` int(4) NOT NULL,
  `fechaFactura` date NOT NULL,
  `idCliente` int(15) NOT NULL,
  PRIMARY KEY (`idFactura`),
  KEY `factura_cliente` (`idCliente`),
  KEY `indexFactura` (`idFactura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura_producto`
--

DROP TABLE IF EXISTS `factura_producto`;
CREATE TABLE IF NOT EXISTS `factura_producto` (
  `idFactura` int(4) NOT NULL,
  `idProducto` int(4) NOT NULL,
  KEY `idFactura` (`idFactura`),
  KEY `idProducto` (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genero`
--

DROP TABLE IF EXISTS `genero`;
CREATE TABLE IF NOT EXISTS `genero` (
  `idGenero` int(2) NOT NULL,
  `nombre` varchar(5) NOT NULL,
  PRIMARY KEY (`idGenero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gruposanguineo`
--

DROP TABLE IF EXISTS `gruposanguineo`;
CREATE TABLE IF NOT EXISTS `gruposanguineo` (
  `idGrupo` int(2) NOT NULL,
  `nombre` varchar(2) NOT NULL,
  PRIMARY KEY (`idGrupo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gruposanguineo_factorrh`
--

DROP TABLE IF EXISTS `gruposanguineo_factorrh`;
CREATE TABLE IF NOT EXISTS `gruposanguineo_factorrh` (
  `idGrupo` int(2) NOT NULL,
  `idFactor` int(2) NOT NULL,
  KEY `idGrupo` (`idGrupo`),
  KEY `idFactor` (`idFactor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

DROP TABLE IF EXISTS `persona`;
CREATE TABLE IF NOT EXISTS `persona` (
  `idPersona` int(15) NOT NULL,
  `primerNombre` varchar(20) NOT NULL,
  `segundoNombre` varchar(20) DEFAULT NULL,
  `primerApellido` varchar(20) NOT NULL,
  `segundoApellido` varchar(20) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `idTipoDocu` int(2) DEFAULT NULL,
  `idGenero` int(2) DEFAULT NULL,
  `idGrupo` int(2) DEFAULT NULL,
  `idEmpleado` int(4) DEFAULT NULL,
  PRIMARY KEY (`idPersona`),
  KEY `persona_tipoDocu` (`idTipoDocu`),
  KEY `persona_genero` (`idGenero`),
  KEY `persona_grupoSanguineo` (`idGrupo`),
  KEY `persona_empleado` (`idEmpleado`),
  KEY `indexPersona` (`idPersona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idPersona`, `primerNombre`, `segundoNombre`, `primerApellido`, `segundoApellido`, `telefono`, `email`, `direccion`, `fechaNacimiento`, `idTipoDocu`, `idGenero`, `idGrupo`, `idEmpleado`) VALUES
(12, 'Juan', 'gabriel', 'lozano', 'segundo', '55555', 'colombianito@hotmail.com', 'MEXICO', NULL, NULL, NULL, NULL, NULL),
(1234, 'walter', 'mercado', 'surita', 'capote', '1234321', 'aunnosebamos@donde.com', 'centro de madrid', NULL, NULL, NULL, NULL, NULL),
(3214, 'pepe', '', 'pepejuanis', '', '23446', 'juan@holamundo.com', 'centro de toido', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

DROP TABLE IF EXISTS `producto`;
CREATE TABLE IF NOT EXISTS `producto` (
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
  KEY `indexProducto` (`idProducto`,`nombre`)
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
CREATE TABLE IF NOT EXISTS `proveedor` (
  `idProveedor` int(4) NOT NULL,
  `nombre` varchar(35) NOT NULL,
  `descripcion` text DEFAULT NULL,
  PRIMARY KEY (`idProveedor`),
  KEY `indexProveedor` (`idProveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor_producto`
--

DROP TABLE IF EXISTS `proveedor_producto`;
CREATE TABLE IF NOT EXISTS `proveedor_producto` (
  `idProveedor` int(4) NOT NULL,
  `idProducto` int(4) NOT NULL,
  KEY `idProducto` (`idProducto`),
  KEY `idProveedor` (`idProveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

DROP TABLE IF EXISTS `rol`;
CREATE TABLE IF NOT EXISTS `rol` (
  `idRol` int(4) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`idRol`),
  KEY `rol_usuarios` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipodocumento`
--

DROP TABLE IF EXISTS `tipodocumento`;
CREATE TABLE IF NOT EXISTS `tipodocumento` (
  `idTipoDocu` int(2) NOT NULL,
  `nombre` varchar(5) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`idTipoDocu`),
  KEY `indexIdDocu` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoproducto`
--

DROP TABLE IF EXISTS `tipoproducto`;
CREATE TABLE IF NOT EXISTS `tipoproducto` (
  `idTipoProducto` int(4) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`idTipoProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  KEY `indexUsuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idUsuario`, `nombre`, `pwd`) VALUES
(1, 'magnolia@yahoo.es', '$2y$10$iVP3aZD0sKSahm/ZiWKFmeLxo/zBsJg2wyKaVmQ8Db1jACkaUN5z2'),
(2, 'Moscatel', '123'),
(3, 'paula@hotmail.com', '$2y$10$4kwx4EHMmGkHSJz0TuoSSOoUgeuFUY0foqmgizLS/.RVSWS61Qbge'),
(4, 'marian2004@gmail.com', '$2y$10$gu5uBjt/zi8wvKqD5TJymusXblCINmUL5ARj.dcc9VbVVv5BrpcSa'),
(5, 'william@yahoo.es', '$2y$10$PVA.lbCpzK8M5WLQqmaLhecV11MfNEvRos.ONmSLYVMF.pmyov8tq'),
(6, 'willy', '$2y$10$EAFWh2rPetpzIUHnnZRmqe.gTE3mrh1TKVhz4k2h7RaX0rw3MLRLS');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_persona` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_cargo` FOREIGN KEY (`idCargo`) REFERENCES `cargo` (`idCargo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `empleado_usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

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

--
-- Filtros para la tabla `rol`
--
ALTER TABLE `rol`
  ADD CONSTRAINT `rol_usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
