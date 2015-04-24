-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-04-2015 a las 17:18:27
-- Versión del servidor: 5.6.21
-- Versión de PHP: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `sig`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_socio_altas`(
in id int
)
BEGIN
SELECT id,fecha,estado FROM altas WHERE id_socio=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_socio_cons`(
in criterio varchar(20),
in valor varchar(20)
)
BEGIN
case  criterio
when 'nombres'
then
 
SELECT socios.id_persona as id,`nombres`, `apellidos`, `codigo`, `cedula`, `genero`,grupo,estatus as certificacion FROM
				socios
				left join persona on persona.id_persona=socios.id_persona
				left join certificacion on certificacion.id_socio=socios.id_socio
				left join grupos on grupos.id=socios.id_grupo
	 			where  nombres like CONCAT('%', valor, '%') OR apellidos like CONCAT('%', valor, '%') order by apellidos asc;

when 'localidad'
then
SELECT socios.id_persona as id,`nombres`, `apellidos`, `codigo`, `cedula`, `genero`,grupo,estatus as certificacion FROM
				socios
				left join persona on persona.id_persona=socios.id_persona
				left join certificacion on certificacion.id_socio=socios.id_socio
				left join grupos on grupos.id=socios.id_grupo
	 			where  grupo like CONCAT('%', valor, '%') order by apellidos asc;
when 'organico'
then                
 SELECT socios.id_persona as id,`nombres`, `apellidos`, `codigo`, `cedula`, `genero`,grupo,estatus as certificacion FROM
				socios
				left join persona on persona.id_persona=socios.id_persona
				left join certificacion on certificacion.id_socio=socios.id_socio
				left join grupos on grupos.id=socios.id_grupo
				where certificacion.estatus is not null
	  order by apellidos asc;
when 'no_organico'
then               
SELECT socios.id_persona as id,`nombres`, `apellidos`, `codigo`, `cedula`, `genero`,grupo,estatus as certificacion FROM
				socios
				left join persona on persona.id_persona=socios.id_persona
				left join certificacion on certificacion.id_socio=socios.id_socio
				left join grupos on grupos.id=socios.id_grupo
                where certificacion.estatus is null
				order by apellidos asc
                ;				
				  
when ''
then
	SELECT socios.id_persona as id,`nombres`, `apellidos`, `codigo`, `cedula`, `genero`,grupo,estatus as certificacion FROM
				socios
				left join persona on persona.id_persona=socios.id_persona
				left join certificacion on certificacion.id_socio=socios.id_socio
				left join grupos on grupos.id=socios.id_grupo
	 		order by apellidos;
END case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_socio_estimacion`(
in id int
)
BEGIN
SELECT id,year,estimados,entregados FROM estimacion WHERE id_socio=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_socio_find`(
in id int
)
BEGIN
SELECT `id_socio`,`nombres`, `apellidos`, `codigo`, `cedula`,`celular`, `f_nacimiento`, `email`, `direccion`, `canton`, `provincia`, `genero`,`grupo` as poblacion FROM persona
	left join socios
	on socios.id_persona=persona.id_persona
	left join grupos
	on grupos.id=socios.id_grupo
	where socios.id_persona=id; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_socio_update`(
in in_id int,
in in_nombre varchar(20),
in in_apellido varchar(20),
in in_codigo varchar (4),
in in_cedula varchar(20),
in in_celular varchar(20),
in f_nac date,
in in_direccion varchar(50),
in in_poblacion varchar(30),
in in_canton varchar(20),
in in_provincia varchar(20),
in in_genero char(1),
in in_mail varchar(50)
)
BEGIN
UPDATE persona SET
				nombres=in_nombre,
				apellidos=in_apellido,
				cedula=in_cedula,
				codigo=in_codigo,
				celular=in_celular,
				f_nacimiento=f_nac,
				direccion=in_direccion,
				canton=in_canton,
				provincia=in_provincia,
				genero=in_genero,
                email=in_mail
			where id_persona=in_id;

SELECT id into @id from grupos where grupo like concat("%",in_poblacion,"%");            
UPDATE socios
set id_grupo=@id
			where id_persona=in_id;            
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_usuario_find`(
in userr varchar(20),
in passw varchar(20)
)
BEGIN
  SELECT * FROM usuarios WHERE user=userr 
  and pass=passw; 	 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acciones`
--

CREATE TABLE IF NOT EXISTS `acciones` (
`id` int(11) NOT NULL,
  `user` text COLLATE latin1_spanish_ci NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `accion` text COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `altas`
--

CREATE TABLE IF NOT EXISTS `altas` (
`id` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estado` text COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `analisis`
--

CREATE TABLE IF NOT EXISTS `analisis` (
`id_analisis` int(11) NOT NULL,
  `id_subparcela` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `muestra` int(11) NOT NULL,
  `submuestras` int(11) NOT NULL,
  `estructura` text COLLATE latin1_spanish_ci NOT NULL,
  `grado` text COLLATE latin1_spanish_ci NOT NULL,
  `rocas` int(11) NOT NULL,
  `rocas_size` int(11) NOT NULL,
  `profundidad` int(11) NOT NULL,
  `pendiente` int(11) NOT NULL,
  `lombrices` int(11) NOT NULL,
  `densidad_aparente` float(10,2) NOT NULL,
  `observaciones` text COLLATE latin1_spanish_ci NOT NULL,
  `s_ph` float(10,2) NOT NULL,
  `s_n` float(10,2) NOT NULL,
  `s_p` float(10,2) NOT NULL,
  `s_k` float(10,2) NOT NULL,
  `s_ca` float(10,2) NOT NULL,
  `s_mg` float(10,2) NOT NULL,
  `s_mo` float(10,2) NOT NULL,
  `s_textura` text COLLATE latin1_spanish_ci NOT NULL,
  `f_n` float(10,2) NOT NULL,
  `f_p` float(10,2) NOT NULL,
  `f_k` float(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asociaciones`
--

CREATE TABLE IF NOT EXISTS `asociaciones` (
`id` int(11) NOT NULL,
  `concepto` text COLLATE latin1_spanish_ci NOT NULL,
  `valor` text COLLATE latin1_spanish_ci NOT NULL,
  `tipo` text COLLATE latin1_spanish_ci NOT NULL,
  `elemento` text COLLATE latin1_spanish_ci NOT NULL,
  `subparcela_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catas`
--

CREATE TABLE IF NOT EXISTS `catas` (
`id` int(11) NOT NULL,
  `lote` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `catador` text COLLATE latin1_spanish_ci NOT NULL,
  `tostado` int(11) NOT NULL,
  `fragancia` float(10,2) NOT NULL,
  `tipo_aroma1` text COLLATE latin1_spanish_ci NOT NULL,
  `nota_aroma` text COLLATE latin1_spanish_ci NOT NULL,
  `sabor` float(10,2) NOT NULL,
  `tipo_sabor` text COLLATE latin1_spanish_ci NOT NULL,
  `nota_sabor` text COLLATE latin1_spanish_ci NOT NULL,
  `sabor_residual` float(10,2) NOT NULL,
  `tipo_sabor_residual` text COLLATE latin1_spanish_ci NOT NULL,
  `nota_sabor_residual` text COLLATE latin1_spanish_ci NOT NULL,
  `acidez` float(10,2) NOT NULL,
  `cuerpo` float(10,2) NOT NULL,
  `uniformidad` float(10,2) NOT NULL,
  `balance` float(10,2) NOT NULL,
  `puntaje_catador` float(10,2) NOT NULL,
  `taza_limpia` float(10,2) NOT NULL,
  `dulzor` float(10,2) NOT NULL,
  `nota_catacion` text COLLATE latin1_spanish_ci NOT NULL,
  `puntuacion` float(10,2) NOT NULL,
  `d_fermento` int(11) NOT NULL,
  `d_metalico` int(11) NOT NULL,
  `d_quimico` int(11) NOT NULL,
  `d_vinagre` int(11) NOT NULL,
  `d_stinker` int(11) NOT NULL,
  `d_fenol` int(11) NOT NULL,
  `d_reposo` int(11) NOT NULL,
  `d_moho` int(11) NOT NULL,
  `d_terroso` int(11) NOT NULL,
  `d_extrano` int(11) NOT NULL,
  `d_sucio` int(11) NOT NULL,
  `d_astringente` int(11) NOT NULL,
  `d_quaquers` int(11) NOT NULL,
  `dl_cereal` int(11) NOT NULL,
  `dl_fermento` int(11) NOT NULL,
  `dl_reposo` int(11) NOT NULL,
  `dl_moho` int(11) NOT NULL,
  `dl_astringencia` int(11) NOT NULL,
  `d_general` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificacion`
--

CREATE TABLE IF NOT EXISTS `certificacion` (
`id` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `estatus` text COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentario`
--

CREATE TABLE IF NOT EXISTS `comentario` (
`id_COMENTARIO` int(11) NOT NULL,
  `Comentario` varchar(45) DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  `Id_foto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE IF NOT EXISTS `configuracion` (
`id` int(11) NOT NULL,
  `parametro` text COLLATE latin1_spanish_ci NOT NULL,
  `descripcion` text COLLATE latin1_spanish_ci NOT NULL,
  `valor` text COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `parametro`, `descripcion`, `valor`) VALUES
(1, 'extra_cata', 'puntaje mínimo de cata para poder recibir pago extra', '84.00'),
(2, 'variedades', 'lista de variedades más comunes que maneja la asociación', 'catucaí,catimoro,tipica,criollo,colombia6'),
(3, 'cultivos', 'lista de cultivos para los seleccionables', 'caña,yuca,naranja,guayaba,guaba,faike,maíz,platano,cacao,huerto,papaya,pasto'),
(4, 'animales', 'lista de producciones animales que se pueden asociar al café', 'chanchos,gallinas,cuyes,vacas,colmenas,estanque,ganado'),
(5, 'gr_muestra', 'gramos de muestra que se toman de cada lote para el análisis de bodega', '250'),
(6, 'margen_contrato', 'margen (%) que se le aplica a las estimaciones de entrega de lotes para cada socio', '20'),
(7, 'nombre_asociacion', 'Nombre de la Asociación para que salga en las fichas de impresión', 'Nombre de la Asociación');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `despachos`
--

CREATE TABLE IF NOT EXISTS `despachos` (
`id` int(11) NOT NULL,
  `lote` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cantidad` float(10,2) NOT NULL,
  `envio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `envios`
--

CREATE TABLE IF NOT EXISTS `envios` (
`id` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `destino` text COLLATE latin1_spanish_ci NOT NULL,
  `chofer` text COLLATE latin1_spanish_ci NOT NULL,
  `responsable` text COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estimacion`
--

CREATE TABLE IF NOT EXISTS `estimacion` (
`id` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `estimados` double(10,2) NOT NULL,
  `entregados` double(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fotos`
--

CREATE TABLE IF NOT EXISTS `fotos` (
`id` int(11) NOT NULL,
  `foto` text COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupos`
--

CREATE TABLE IF NOT EXISTS `grupos` (
`id` int(11) NOT NULL,
  `grupo` text COLLATE latin1_spanish_ci NOT NULL,
  `codigo_grupo` text COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `grupos`
--

INSERT INTO `grupos` (`id`, `grupo`, `codigo_grupo`) VALUES
(2, 'AGRODIN', 'AN'),
(3, 'AGUA DULCE ALTO', 'AD'),
(4, 'CANADA', 'CA'),
(5, 'CUMANDA', 'CU'),
(6, 'EL MIRADOR', 'EM'),
(7, 'EMPROAGRO', 'LM'),
(8, 'ENTIERROS', 'LE'),
(9, 'FATIMA', 'FA'),
(10, 'GUARAMISAL', 'GM'),
(11, 'IRACHI', 'IJ'),
(12, 'LA UNION', 'CP'),
(13, 'LAS ORQUIDEAS', 'LO'),
(14, 'PANECILLO', 'PC'),
(15, 'PLAYAS DE LAS PIRCAS', 'PP'),
(16, 'PROAGRO', 'VD'),
(17, 'PUCARON', 'PN'),
(18, 'SAN ANTONIO', 'SA'),
(19, 'SAN FRANCISCO', 'SF'),
(20, 'SAN JUAN', 'SJ'),
(21, 'SAN MARTIN', 'SM'),
(22, 'TAPALA', 'TN'),
(23, 'VALLERMOSO', 'VH');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lotes`
--

CREATE TABLE IF NOT EXISTS `lotes` (
`id` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `codigo_lote` text COLLATE latin1_spanish_ci NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `peso` double(10,2) NOT NULL,
  `humedad` double(10,2) NOT NULL,
  `rto_descarte` int(11) NOT NULL,
  `rto_exportable` int(11) NOT NULL,
  `defecto_negro` int(11) NOT NULL,
  `defecto_vinagre` int(11) NOT NULL,
  `defecto_decolorado` int(11) NOT NULL,
  `defecto_mordido` int(11) NOT NULL,
  `defecto_brocado` int(11) NOT NULL,
  `reposo` tinyint(1) NOT NULL,
  `moho` tinyint(1) NOT NULL,
  `fermento` tinyint(1) NOT NULL,
  `contaminado` tinyint(1) NOT NULL,
  `calidad` text COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `niveles`
--

CREATE TABLE IF NOT EXISTS `niveles` (
`id_niveles` int(11) NOT NULL,
  `nivel` varchar(45) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `niveles`
--

INSERT INTO `niveles` (`id_niveles`, `nivel`) VALUES
(1, 'admin'),
(2, 'socio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE IF NOT EXISTS `pagos` (
`id` int(11) NOT NULL,
  `lote` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `exportable` float(10,2) NOT NULL,
  `descarte` float(10,2) NOT NULL,
  `fuera` float(10,2) NOT NULL,
  `calidad` double(10,2) NOT NULL,
  `cliente` float(10,2) NOT NULL,
  `microlote` float(10,2) NOT NULL,
  `tazadorada` float(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parcelas`
--

CREATE TABLE IF NOT EXISTS `parcelas` (
`id` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `coorX` int(11) NOT NULL,
  `coorY` int(11) NOT NULL,
  `alti` int(11) NOT NULL,
  `sup_total` float(10,2) NOT NULL,
  `MOcontratada` int(11) NOT NULL,
  `MOfamiliar` int(11) NOT NULL,
  `Miembros_familia` int(11) NOT NULL,
  `riego` text COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE IF NOT EXISTS `persona` (
`id_persona` int(11) NOT NULL,
  `nombres` text,
  `apellidos` text,
  `codigo` text,
  `cedula` bigint(20) DEFAULT NULL,
  `celular` int(10) NOT NULL,
  `f_nacimiento` date DEFAULT NULL,
  `email` text,
  `direccion` text,
  `canton` text,
  `provincia` text,
  `foto` text,
  `genero` char(1) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=304 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`id_persona`, `nombres`, `apellidos`, `codigo`, `cedula`, `celular`, `f_nacimiento`, `email`, `direccion`, `canton`, `provincia`, `foto`, `genero`) VALUES
(2, 'Prueba', 'Prueba', 'ANnn', 1111111, 9999, '0000-00-00', '', 'direccion', '', '', '', 'M'),
(3, ' Manuela Bernarda', 'Cevallos Michay', 'AN04', 1900055300, 0, '1944-12-04', '', '', '', 'Zamora', '', ''),
(4, ' Angel Benigno', 'Gaona Torres', 'AN05', 1101903662, 0, '1956-04-19', '', '', '', 'Zamora', '', ''),
(5, ' Gloria Elisa', 'Guarinda Ceballos', 'AN06', 1103418503, 983520805, '1976-03-27', '', '', '', 'Zamora', '', ''),
(6, ' Cosme Gabriel', 'Merino Alvarez', 'AN09', 1103888911, 0, '1981-12-11', 'cmerino@apecap.org', '', '', 'Zamora', '', ''),
(7, ' Milton', 'Rosillo Troya', 'AN13', 1102507728, 992200071, '1966-08-26', '', '', '', 'Zamora', '', ''),
(8, ' Polidoro', 'Rosillo Troya', 'AN18', 1101976270, 0, '1960-08-13', '', '', '', 'Zamora', '', ''),
(9, ' Jose Vidal', 'Erazo Narvaez', 'AN19', 1900053875, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(10, ' Silvio', 'Diaz Zumba', 'AN21', 1900255447, 959500344, '1969-04-25', '', '', '', 'Zamora', '', ''),
(11, ' Juan Francisco', 'Robles Patino', 'AN22', 1101444469, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(12, ' Cesar Luis', 'Rosillo Troya', 'AN24', 1101976262, 0, '1957-05-15', '', '', '', 'Zamora', '', ''),
(13, ' Manecio Amable', 'Avila Rojas', 'AN25', 1900080951, 990252603, '1950-06-05', '', '', '', 'Zamora', '', ''),
(14, ' Ana Petronila', 'Alvarez Michay', 'AN28', 1900184951, 988734350, '1964-07-25', '', '', '', 'Zamora', '', ''),
(15, ' Juan Daniel', 'Alvarez Merino', 'AN29', 1900427376, 969006512, '1978-08-15', '', '', '', 'Zamora', '', ''),
(16, ' Jose Bartolo', 'Jiron Vicente', 'AN30', 1105143190, 0, '1989-07-25', '', '', '', 'Zamora', '', ''),
(17, ' Manuel', 'Pintado Cordero', 'AN31', 1103550966, 959812954, '1990-07-25', '', '', '', 'Zamora', '', ''),
(18, ' Anguisaca Zumba', 'Luis Antonio', 'AN33', 1103562250, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(19, '  Augusto Martin', 'Chuquimarca Chinchay', 'AN34', 1100839008, 994684353, '1958-12-07', '', '', '', 'Zamora', '', ''),
(20, ' Felipe Parmenio', 'Rosillo Guerrero', 'AN37', 1104570245, 0, '1987-04-22', '', '', '', 'Zamora', '', ''),
(21, ' Luis Matias', 'Erazo Riofrio', 'AN39', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(22, ' Silvio', 'Jiron Vicente', 'AN41', 1104884729, 0, '1987-01-01', '', '', '', 'Zamora', '', ''),
(23, ' Ilda', 'Ramon Juarez', 'AN42', 1101069043, 0, '1955-09-21', '', '', '', 'Zamora', '', ''),
(24, ' Nery Germania', 'Abad Jimenez', 'AN43', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(25, ' Luis Roberto', 'Gerrero Merino', 'AN44', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(26, ' Herman Segundo', 'Velez Chinchay', 'AN45', 1102733324, 0, '1966-02-06', '', '', '', 'Zamora', '', ''),
(27, ' Rodrigo', 'Ruiz Chugchilan', 'AN47', 1500902265, 0, '1988-04-19', '', '', '', 'Zamora', '', ''),
(28, ' Hermi', 'Rosales Correa', 'AN48', 1900221795, 0, '1964-06-07', '', '', '', 'Zamora', '', ''),
(29, ' Mario Francisco', 'Guerrero Troya', 'AN49', 1103191993, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(30, ' Miguel Angel', 'Torres Calle', 'AN51', 1102056882, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(31, ' Vidal Valentin', 'Alverca Zumba', 'AN52', 1103660435, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(32, ' Victoria Angelica', 'Alberca Peña', 'AD01', 1900558733, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(33, ' Efren', 'Alberca Jimenez', 'AD02', 1900092956, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(34, ' Oliveros', 'Alberca Pena', 'AD03', 1900402361, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(35, ' Manuel', 'Jimenez Jimenez', 'AD06', 1900187624, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(36, ' Domingo', 'Alvarez Pedro', 'AD07', 1900187624, 0, '1958-05-04', '', '', '', 'Zamora', '', ''),
(37, ' Jose Miguel', 'Arvarez Jimenez', 'AD09', 1900239367, 0, '1967-03-21', '', '', '', 'Zamora', '', ''),
(38, 'Geremias ', 'Alverca', 'AD11', 1900110576, 0, '1955-11-08', '', '', '', 'Zamora', '', ''),
(39, ' Anibal Arcenio', 'Diaz Zumba', 'AD14', 1900174325, 0, '1963-01-05', '', '', '', 'Zamora', '', ''),
(40, ' Darwin Marcelo', 'Diaz Jimenez', 'AD15', 1724016397, 0, '1989-01-16', '', '', '', 'Zamora', '', ''),
(41, ' Salvador', 'Cordero Jose', 'AD16', 1900255264, 0, '1968-11-28', '', '', '', 'Zamora', '', ''),
(42, ' Jose Marcos', 'Alverca Cordero', 'AD17', 1900797809, 0, '1994-03-07', '', '', '', 'Zamora', '', ''),
(43, ' Jose Marcial', 'Jimenez Pintado', 'AD18', 1101824777, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(44, ' Jose Santiago', 'Jimenez Cueva', 'AD19', 1101824777, 0, '1958-09-30', '', '', '', 'Zamora', '', ''),
(45, ' Francel Andres', 'Alverca Peña', 'AD20', 1900459908, 0, '1980-10-30', '', '', '', 'Zamora', '', ''),
(46, ' Horacio Cristobal', 'Alvarez Alvarez', 'AD21', 1900797331, 0, '1992-08-08', '', '', '', 'Zamora', '', ''),
(47, ' Aureliano', 'Tillaguango Calva', 'CA01', 1101581559, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(48, ' Instalin', 'Tamayo Castillo', 'CA06', 1900324714, 0, '1971-10-06', '', '', '', 'Zamora', '', ''),
(49, ' Miguel Angel', 'Abarca Aldaz', 'CA07', 1102831946, 0, '1969-05-25', '', '', '', 'Zamora', '', ''),
(50, ' German Enixon', 'Tillaguango Vega', 'CA08', 1900288497, 0, '1971-06-10', '', '', '', 'Zamora', '', ''),
(51, ' Carlos Marino', 'Correa Cumbicus', 'CA09', 1900322866, 0, '1976-03-26', '', '', '', 'Zamora', '', ''),
(52, ' Juan Antonio', 'Tillagungo Abad', 'CA10', 1104005168, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(53, ' Gilber Efren', 'Abarca Aldaz', 'CA11', 1103725923, 0, '1975-07-16', '', '', '', 'Zamora', '', ''),
(54, ' Jimenez Jimenez', 'Elsa Natalia', 'CA12', 1103411888, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(55, ' Jose Moises', 'Jaramillo Carrion', 'CA14', 1103481311, 0, '1973-10-26', '', '', '', 'Zamora', '', ''),
(56, ' Maria Lastenia', 'Tamayo Castillo', 'CA15', 0, 0, '1985-08-11', '', '', '', 'Zamora', '', ''),
(57, ' Nidia Esperanza', 'Tillaguango Pintado', 'CA16', 1900585504, 0, '1985-12-11', '', '', '', 'Zamora', '', ''),
(58, ' Sergio Feliciano', 'Tillaguango Pintado', 'CA17', 1900305382, 0, '1974-11-01', '', '', '', 'Zamora', '', ''),
(59, ' Jiose Luis', 'Guayanay Masache', 'CA18', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(60, ' Marcela Eloisa', 'Tillaguango Pintado', 'CA19', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(61, ' Fernando', 'Abad Jimenez', 'CU01', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(62, ' Victor Manuel', 'Calva Pintado', 'CU04', 1102927322, 0, '1987-02-20', '', '', '', 'Zamora', '', ''),
(63, ' Olivio', 'Gaona Abad', 'CU05', 1900265537, 0, '1971-12-10', '', '', '', 'Zamora', '', ''),
(64, ' Gerardo Florentino', 'Salinas Castillo', 'CU13', 1900196930, 0, '1960-10-16', '', '', '', 'Zamora', '', ''),
(65, ' Hipolito', 'Salinas Castillo', 'CU14', 1900093244, 0, '1949-08-08', '', '', '', 'Zamora', '', ''),
(66, ' Segundo Ramon', 'Salinas Castillo', 'CU15', 1900159144, 0, '1962-10-17', '', '', '', 'Zamora', '', ''),
(67, ' Josefino De Jesus', 'Suarez Bravo', 'CU17', 1103208110, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(68, ' Gaona Castillo', 'Vilma Francisca', 'CU19', 1105101149, 0, '1991-07-24', '', '', '', 'Zamora', '', ''),
(69, ' Indalecio', 'Abad Abad', 'CU20', 1104518863, 0, '1981-01-29', '', '', '', 'Zamora', '', ''),
(70, ' Segundo Aurelio', 'Calva Abad', 'CU21', 1900255355, 0, '1963-11-16', '', '', '', 'Zamora', '', ''),
(71, ' Jose Marcial', 'Abad Pintado', 'CU22', 1900324615, 0, '1973-04-15', '', '', '', 'Zamora', '', ''),
(72, ' Simon Bolivar', 'Gaona Calva', 'CU23', 1103147862, 0, '1971-10-08', '', '', '', 'Zamora', '', ''),
(73, ' Bolivar', 'Gaona Jose', 'CU24', 1103596362, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(74, ' Francisco Eleodoro', 'Salinas Gaona', 'CU25', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(75, ' Norverto', 'Requelme Campoverde', 'CU26', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(76, ' Luis Celestin', 'Salinas Gaona', 'CU27', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(77, ' Jose Miguel', 'Jimenez Abad', 'CU28', 1105637357, 0, '1991-06-12', '', '', '', 'Zamora', '', ''),
(78, ' Olivio Ramiro', 'Ortiz Salinas', 'CU29', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(79, ' Juan Oswaldo', 'Gaona Reinoso', 'CU30', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(80, ' Jose Vicente', 'Abad Troya', 'CU31', 1900315639, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(81, ' Jose Benecio', 'Tamayo Gaona', 'LM07', 1103649412, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(82, ' Dixon Francel', 'Pardo Tamayo', 'LM01', 1103924138, 0, '1980-04-23', '', '', '', 'Zamora', '', ''),
(83, ' Jose Fredy', 'Jimenez Minga', 'LM02', 1900323864, 0, '1975-01-25', '', '', '', 'Zamora', '', ''),
(84, ' Roberto', 'Tamayo Moreno', 'LM03', 1102252457, 0, '1959-05-13', '', '', '', 'Zamora', '', ''),
(85, ' Froilan Heriberto', 'Perez Pardo', 'LM04', 1900655919, 0, '1990-05-31', '', '', '', 'Zamora', '', ''),
(86, ' Agustin Camilo', 'Tamayo Jiron', 'LM05', 1104293012, 0, '1981-11-01', '', '', '', 'Zamora', '', ''),
(87, ' Lola Esperanza', 'Pardo Tamayo', 'LM06', 1900444413, 0, '1981-08-05', '', '', '', 'Zamora', '', ''),
(88, ' Manuel Francisco', 'Cordero Alverca', 'LE02', 1900323252, 0, '1975-04-07', '', '', '', 'Zamora', '', ''),
(89, ' Luz Del Carmen', 'Alverca Castillo', 'LE03', 1100497534, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(90, ' Pedro Julio', 'Escobar Vicente', 'LE04', 1101951059, 0, '1957-07-07', '', '', '', 'Zamora', '', ''),
(91, ' Cesar Manuel', 'Jimenez Giron', 'LE07', 1102652078, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(92, ' Segundo Eduardo', 'Jimenez Abad', 'LE19', 1900182724, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(93, ' Teodoro', 'Calva Guayanay', 'FA12', 1101974630, 0, '1960-09-08', '', '', '', 'Zamora', '', ''),
(94, ' Fausto', 'Calva Castillo', 'FA01', 1900239862, 0, '1969-10-03', '', '', '', 'Zamora', '', ''),
(95, ' Luis', 'Giron Jimenez', 'FA03', 1102083068, 0, '1962-08-15', '', '', '', 'Zamora', '', ''),
(96, ' Manuel Arnoldo', 'Giron Salazar', 'FA04', 1100531092, 0, '1942-12-15', '', '', '', 'Zamora', '', ''),
(97, ' Jose Ambrocio', 'Jimenez Jimenez', 'FA07', 1900055953, 0, '1934-01-08', '', '', '', 'Zamora', '', ''),
(98, ' Maria Esthela', 'Jimenez Gonzaga', 'FA08', 1900239854, 0, '1971-11-06', '', '', '', 'Zamora', '', ''),
(99, ' Gonzaga', 'Miguel Angeljimenez', 'FA09', 1900093335, 0, '1940-03-13', '', '', '', 'Zamora', '', ''),
(100, ' Onecimo', 'Jimenez Manuel', 'FA10', 1900122423, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(101, ' Angel Miguel', 'Giron Jimenez', 'FA14', 1102079418, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(102, ' Manuel Fernando', 'Jimenez Gaona', 'FA15', 1103042485, 0, '1972-04-24', '', '', '', 'Zamora', '', ''),
(103, ' Jose Cesario', 'Giron Jimenez', 'FA17', 1900098581, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(104, 'Margarita', 'Salazar', 'FA18', 1103111199, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(105, ' Jose Librando', 'Jimenez Merino', 'FA19', 1102227632, 0, '1960-12-12', '', '', '', 'Zamora', '', ''),
(106, ' Jesus Amable', 'Alberca Zumba', 'GM01', 1900194927, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(107, ' Octaviano', 'Alverca Troya', 'GM02', 1900203439, 0, '1962-05-25', '', '', '', 'Zamora', '', ''),
(108, ' Gabriel', 'Alverca Troya', 'GM03', 1900202738, 0, '1965-06-19', '', '', '', 'Zamora', '', ''),
(109, ' Marco Jose', 'Benavidez Romero', 'GM05', 1900443209, 0, '1981-11-05', '', '', '', 'Zamora', '', ''),
(110, ' Juan Jose', 'Alverca Abad', 'GM09', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(111, ' Juan Angel', 'Alejo Gonzaga', 'GM10', 1104173883, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(112, ' Julio Orlando', 'Avila Torres', 'IJ02', 1103101430, 0, '1968-02-19', '', '', '', 'Zamora', '', ''),
(113, ' Franco Efrain', 'Avila Torres', 'IJ03', 1102890397, 0, '1963-07-23', '', '', '', 'Zamora', '', ''),
(114, ' Juan Bartolo', 'Castillo Jimenez', 'IJ05', 1900092790, 0, '1954-08-24', '', '', '', 'Zamora', '', ''),
(115, ' Gonzalo', 'Castillo Jimenez', 'IJ06', 1102976576, 0, '1971-02-21', '', '', '', 'Zamora', '', ''),
(116, ' Jose Vicente', 'Calva Jimenez', 'IJ07', 1100514700, 0, '1944-12-28', '', '', '', 'Zamora', '', ''),
(117, ' Lucia Marlene', 'Calva Paccha', 'IJ09', 1103515308, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(118, ' Angel Servilio', 'Calva Paccha', 'IJ10', 1103155402, 0, '1970-07-04', '', '', '', 'Zamora', '', ''),
(119, ' Juan Ramon', 'Calva Paccha', 'IJ12', 1102659305, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(120, ' Julio Orlando', 'Calva Paccha', 'IJ13', 1103276232, 0, '1972-05-24', '', '', '', 'Zamora', '', ''),
(121, ' Juan Vicente', 'Jimenez Avila', 'IJ15', 1900054857, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(122, ' Jose Juaquin', 'Pacha Villalta', 'IJ18', 1103110621, 0, '1971-05-03', '', '', '', 'Zamora', '', ''),
(123, ' Jose Antonio', 'Reyes Merino', 'IJ19', 1714661251, 0, '1982-06-05', '', '', '', 'Zamora', '', ''),
(124, ' Vitaliano Efrain', 'Sanchez Paccha', 'IJ21', 1900201045, 0, '1966-01-27', '', '', '', 'Zamora', '', ''),
(125, ' Jose Maria', 'Sanchez Chinchay', 'IJ22', 1900054790, 0, '1943-10-01', '', '', '', 'Zamora', '', ''),
(126, ' Angel Polivio', 'Avila Torres', 'IJ24', 1708544224, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(127, ' Ronald Ivan', 'Rodriguez Lima', 'IJ31', 1104563448, 0, '1986-03-27', '', '', '', 'Zamora', '', ''),
(128, ' Rosa Esperanza', 'Abad Villalta', 'IJ32', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(129, ' Luz Maria', 'Jimenez Castillo', 'IJ34', 1104281124, 0, '1985-09-27', '', '', '', 'Zamora', '', ''),
(130, ' Vicente Polivio', 'Jimenez Castillo', 'IJ35', 1708544224, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(131, ' Rosa Del Carmen', 'Sanchez Avila', 'IJ36', 1716741507, 0, '1982-05-14', '', '', '', 'Zamora', '', ''),
(132, ' Rosela Marujita', 'Calva Paccha', 'IJ37', 1103412290, 0, '1974-08-14', '', '', '', 'Zamora', '', ''),
(133, ' Maria Carmen', 'Calva Paccha', 'IJ38', 1103844344, 0, '1981-04-14', '', '', '', 'Zamora', '', ''),
(134, ' Elvia Maruja', 'Jimenez Castillo', 'IJ39', 1900380815, 0, '1980-03-01', '', '', '', 'Zamora', '', ''),
(135, ' Felizino', 'Lima Darwin', 'IJ40', 1104037443, 0, '1982-12-26', '', '', '', 'Zamora', '', ''),
(136, ' Maria Graciela', 'Troya Paccha', 'IJ41', 1103182224, 0, '1968-01-20', '', '', '', 'Zamora', '', ''),
(137, ' Jose Bolivar', 'Malacatus Chainchay', 'IJ42', 1103576995, 0, '1966-02-17', '', '', '', 'Zamora', '', ''),
(138, ' Luis Jaime', 'Castillo Jimenez', 'IJ43', 110399819, 0, '1980-11-03', '', '', '', 'Zamora', '', ''),
(139, ' Jose Antonio', 'Armijos Patino', 'CP01', 1900199918, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(140, ' Telmo Camilo', 'Luzuriaga Maza', 'CP06', 1900465335, 0, '1982-02-17', '', '', '', 'Zamora', '', ''),
(141, ' Jorge', 'Granda Quinche', 'CP07', 1900055441, 0, '1947-06-22', '', '', '', 'Zamora', '', ''),
(142, ' Jose Efredin', 'Sanches Troya', 'CP10', 1900278795, 0, '1968-08-01', '', '', '', 'Zamora', '', ''),
(143, ' Domingo Santiago', 'Lojan Zumba', 'CP11', 1102372529, 0, '1962-05-12', '', '', '', 'Zamora', '', ''),
(144, ' Chuquiguanca Gonzaga', 'Luis Martin', 'CP18', 1102880372, 0, '1969-03-28', '', '', '', 'Zamora', '', ''),
(145, ' Jose Benito', 'Pizarro Jimenez', 'CP20', 1900200690, 0, '1965-12-06', '', '', '', 'Zamora', '', ''),
(146, ' Patricia Yolanda', 'Gaona Villalta', 'CP21', 1103513907, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(147, ' Camilo Jacobo', 'Castillo Guarnizo', 'CP22', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(148, ' Carlos Mayco', 'Reinoso Capa', 'CP24', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(149, ' Jose Benito', 'Chuquiguanca Calva', 'CP25', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(150, ' Arcelio', 'Avila Jose', 'LO01', 1900348127, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(151, 'Benito', 'Luzuriga', 'LO02', 1104640618, 0, '1986-09-01', '', '', '', 'Zamora', '', ''),
(152, ' Henry Jose', 'Romero Puzma', 'LO03', 1900258797, 0, '1968-01-10', '', '', '', 'Zamora', '', ''),
(153, ' Bayron Enrrique', 'Avila Torres', 'LO05', 1104923386, 0, '1988-07-13', '', '', '', 'Zamora', '', ''),
(154, ' Andres Marcelino', 'Cuenca Avila', 'LO06', 1103213534, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(155, ' Victor Alonzo', 'Jimenez Merino', 'LO07', 1900066067, 0, '1974-10-03', '', '', '', 'Zamora', '', ''),
(156, 'Andres ', 'Luzuriaga', 'LO08', 1900751098, 0, '1990-04-05', '', '', '', 'Zamora', '', ''),
(157, ' Gabriel', 'Garrido Ordoñez', 'LO09', 1900055516, 0, '1944-09-16', '', '', '', 'Zamora', '', ''),
(158, ' Alejandro Francisco', 'Ávila Jiménez', 'LO10', 1104625981, 0, '1985-05-17', '', '', '', 'Zamora', '', ''),
(159, ' Samuel Francisco', 'Abad Pintado', 'LO11', 1104069263, 0, '1977-05-18', '', '', '', 'Zamora', '', ''),
(160, ' Luis Alberto', 'Garrido Flores', 'LO12', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(161, ' Francisco Ramon', 'Abad Gaona', 'PC01', 1105845133, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(162, ' Hortencio', 'Abad Troya', 'PC02', 1104982739, 0, '1981-07-07', '', '', '', 'Zamora', '', ''),
(163, ' Alfredo Daniel', 'Castillo Tamay', 'PC03', 1103423917, 0, '1976-12-07', '', '', '', 'Zamora', '', ''),
(164, ' Milton Noe', 'Garcia Abad', 'PC04', 1104665722, 0, '1985-12-14', '', '', '', 'Zamora', '', ''),
(165, ' Luis Reinaldo', 'Abad Troya', 'PC05', 1900543735, 0, '1983-04-15', '', '', '', 'Zamora', '', ''),
(166, ' Abraham Eduardo', 'Castillo Avila', 'PC06', 1900601236, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(167, ' Nelson Darwin', 'Rodriguez Reinosa', 'PC07', 1900595586, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(168, ' Danilo', 'Abad Troya', 'PC10', 1104666753, 0, '1986-06-06', '', '', '', 'Zamora', '', ''),
(169, ' Elkin Abad', 'Abad Troya', 'PC11', 1900842525, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(170, ' Germania Piedad', 'Abad Troya', 'PC12', 1104887250, 0, '1984-06-21', '', '', '', 'Zamora', '', ''),
(171, ' Jose Francisco', 'Abad Troya', 'PC13', 1104925787, 0, '1988-09-20', '', '', '', 'Zamora', '', ''),
(172, ' Juan Servilio', 'Abad Troya', 'PC14', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(173, ' Crimildo', 'Abad Troya', 'PC08', 1104666746, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(174, ' Bolivar', 'Troya Manuel', 'PC09', 1102997168, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(175, ' Rosana Ecliceria', 'Jaramillo Tamay', 'VD02', 1101914875, 0, '1945-05-13', '', '', '', 'Zamora', '', ''),
(176, ' Segundo Gilberto', 'Capa Cueva', 'VD05', 1102183637, 0, '1959-09-16', '', '', '', 'Zamora', '', ''),
(177, ' Maria Cecilia', 'Arevalo Acaro', 'VD06', 1900093459, 0, '1953-12-22', '', '', '', 'Zamora', '', ''),
(178, ' Hugo Homero', 'Ramon Capa', 'VD10', 1900081090, 0, '1950-09-22', '', '', '', 'Zamora', '', ''),
(179, ' Leticia Lidia', 'Castillo Bravo', 'VD12', 1900199728, 0, '1965-03-27', '', '', '', 'Zamora', '', ''),
(180, ' Elvia Graciela', 'Iñiguez Tamay', 'VD14', 1100662459, 0, '1950-03-29', '', '', '', 'Zamora', '', ''),
(181, ' Raquel Cumanda', 'Carrion Jaramillo', 'VD16', 1103269443, 0, '1972-02-12', '', '', '', 'Zamora', '', ''),
(182, ' Luciano', 'Lojan Zumba', 'VD17', 1101864161, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(183, ' Carlos', 'Minga Sanchez', 'VD19', 1102564331, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(184, ' Ramon Castillo', 'Diomer Jovani', 'VD20', 1717738304, 0, '1982-10-22', '', '', '', 'Zamora', '', ''),
(185, ' Luisa Amada', 'Giron Guerrero', 'VD21', 1102415195, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(186, ' Ismenia', 'Herrera Monica', 'VD23', 1900550649, 0, '1985-12-01', '', '', '', 'Zamora', '', ''),
(187, ' Michael', 'Tilden Marsh', 'VD24', 1750869008, 0, '1951-11-04', '', '', '', 'Zamora', '', ''),
(188, ' Aureliano', 'Alvarez Cordero', 'PN03', 1100561305, 0, '1951-04-23', '', '', '', 'Zamora', '', ''),
(189, ' Angel', 'Alvarez Guerrero', 'PN04', 1103276596, 0, '1974-04-25', '', '', '', 'Zamora', '', ''),
(190, ' Jose Lorenzo', 'Alvarez Guerrero', 'PN05', 1900457449, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(191, ' Pedro Antonio', 'Alvarez Guerrero', 'PN06', 1103276570, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(192, ' Hermelinda', 'Guerrero Pintado', 'PN07', 1102254909, 0, '1959-10-17', '', '', '', 'Zamora', '', ''),
(193, ' Jose Esteban', 'Pintado Alvarez', 'PN09', 1102114962, 0, '1961-08-03', '', '', '', 'Zamora', '', ''),
(194, ' Santos Nolberto', 'Zumba Diaz', 'PN10', 1900211259, 0, '1965-06-06', '', '', '', 'Zamora', '', ''),
(195, ' Rosa Elvira', 'Abad Jimenez', 'PN11', 1100534526, 0, '1946-12-15', '', '', '', 'Zamora', '', 'f'),
(196, ' Jose Isrrael', 'Jimenez Guayanay', 'PN12', 701735615, 0, '1962-10-06', '', '', '', 'Zamora', '', ''),
(197, ' Teresa Dolores', 'Jimenez Anguisaca', 'PN14', 1900200989, 0, '1968-11-25', '', '', '', 'Zamora', '', ''),
(198, ' Milton Vidal', 'Guerrero Pintado', 'PN15', 1102745815, 0, '1966-01-21', '', '', '', 'Zamora', '', ''),
(199, ' Veronica Lucia', 'Jimenez Anguiazaca', 'PN16', 1103232367, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(200, '  Luis Francisco', 'Alvarez Anguisaca', 'PN18', 1104549181, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(201, ' Segundo Isaias', 'Paccha Troya', 'IJ17', 1100756954, 0, '1953-04-15', '', '', '', 'Zamora', '', ''),
(202, ' Melecio Teodomiro', 'Merino Sarango', 'IJ25', 1102316666, 0, '1968-07-16', '', '', '', 'Zamora', '', ''),
(203, ' Sergio Bolivar', 'Troya Paccha', 'IJ26', 1102716832, 0, '1964-04-18', '', '', '', 'Zamora', '', ''),
(204, ' Celiano Manuel', 'Jimenez Merino', 'IJ29', 1101591640, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(205, ' Angel Arcivar', 'Merino Sarango', 'IJ30', 1102316765, 0, '1960-02-08', '', '', '', 'Zamora', '', ''),
(206, ' Diego Jaime', 'Paccha Jimenez', 'SA03', 1900635150, 0, '1987-01-17', '', '', '', 'Zamora', '', ''),
(207, ' Silvia Vicenta', 'Giron Merino', 'SA04', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(208, ' Maria Elizabeth', 'Merino Alvarez', 'SA05', 1104446875, 0, '1987-07-07', '', '', '', 'Zamora', '', ''),
(209, ' Gloria Hermandina', 'Ontaneda Castillo', 'SF06', 1101497608, 0, '1953-04-12', '', '', '', 'Zamora', '', ''),
(210, ' Luis Antonio', 'Garcia Jimenez', 'SF08', 1101566766, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(211, ' Hector Eduardo', 'Cumbicus Jimenez', 'SF09', 1101783452, 0, '1953-08-19', '', '', '', 'Zamora', '', ''),
(212, ' Arnoldo', 'Jimenez Alvarez', 'SF12', 1101933909, 0, '1957-06-15', '', '', '', 'Zamora', '', ''),
(213, ' Cosme Efrain', 'Rosales Rosillo', 'SF15', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(214, ' Francisco Alfredo', 'Salazar Salinas', 'SF17', 1900190693, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(215, ' Jose Ildibrando', 'Gaona Villalta', 'SF20', 1900391085, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(216, ' Carlos', 'Guayanay Jimenez', 'SF21', 1900170539, 0, '1958-06-24', '', '', '', 'Zamora', '', ''),
(217, ' Juan Carlos', 'Tamayo Rosillo', 'SF22', 1103419667, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(218, ' Dalton Alexander', 'Tamayo Rosillo', 'SF28', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(219, ' Elsa Dolores', 'Soto Jaramillo', 'SF29', 1900260017, 0, '1971-11-04', '', '', '', 'Zamora', '', ''),
(220, ' Sabulon', 'Garcia Jimenez', 'SF30', 1900081140, 0, '1944-10-29', '', '', '', 'Zamora', '', ''),
(221, ' Melecio', 'Rosillo Calva', 'SF31', 1707851679, 0, '1963-04-15', '', '', '', 'Zamora', '', ''),
(222, ' Angel Dionicio', 'Garrido Jimenez', 'SF32', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(223, ' Guilo Romel', 'Herrera Encarnacion', 'SF33', 1900459312, 0, '1981-06-08', '', '', '', 'Zamora', '', ''),
(224, ' Blanca Enid', 'Herrera Encarnacion', 'SF34', 1900174838, 0, '1962-05-12', '', '', '', 'Zamora', '', ''),
(225, ' Henrry Paul', 'Avila Alvarez', 'SF35', 1104892599, 0, '1992-09-24', '', '', '', 'Zamora', '', ''),
(226, ' German Gilberto', 'Reinoso Rengel', 'SF36', 1103661912, 0, '1980-04-22', '', '', '', 'Zamora', '', ''),
(227, ' Mario Enrrique', 'Reinoso Rengel', 'SF37', 1103523369, 0, '1976-02-20', '', '', '', 'Zamora', '', ''),
(228, ' Pepe Raul', 'Rodriguez Reinoso', 'SF39', 1105433690, 0, '1990-09-22', '', '', '', 'Zamora', '', ''),
(229, ' Luis Esteban', 'Avila Rojas', 'SF44', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(230, ' Pablo Vinicio', 'Soto Chamba', 'SJ10', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(231, ' Rita Maribel', 'Salazar Minga', 'SF40', 1900723790, 0, '1991-03-05', '', '', '', 'Zamora', '', ''),
(232, ' Edghar', 'Cumbicus Salazar', 'SF41', 1900349505, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(233, ' Eduardo', 'Jiménez Ordoñez', 'SF42', 1103537443, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(234, ' Diego Agustin', 'Castillo Jiménez', 'SF43', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(235, ' Sergio David', 'Abad Jimenez', 'SF49', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(236, ' Denis Sebastian', 'Abad Mendoza', 'SF48', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(237, ' Luis Antonio', 'Jimenez Gaona', 'SF50', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(238, ' Jose Florentino', 'Avila Avila', 'SF51', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(239, ' Jose Isaias', 'Puchaicela Angamarca', 'SJ06', 1104111669, 0, '1982-09-06', '', '', '', 'Zamora', '', ''),
(240, ' Miguel Francisco', 'Abad Flores', 'SJ01', 1900150846, 0, '1956-09-27', '', '', '', 'Zamora', '', ''),
(241, ' Jaime Efrain', 'Jinenez Pintado', 'SJ02', 1900533033, 0, '1984-02-05', '', '', '', 'Zamora', '', ''),
(242, ' Edgar Patricio', 'Jimenez Pintado', 'SJ03', 1900571686, 0, '1985-06-29', '', '', '', 'Zamora', '', ''),
(243, ' Patricia Elizabeth', 'Puchaicela Angamarca', 'SJ04', 1104180706, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(244, ' Rosa Peregrina', 'Pintado Castillo', 'SJ05', 1102444310, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(245, ' Vicente', 'Abad Simon', 'SJ07', 1102252010, 0, '1957-11-25', '', '', '', 'Zamora', '', ''),
(246, ' Edgar Omar', 'Morocho Angamarca', 'SJ09', 1900547009, 0, '1983-05-24', '', '', '', 'Zamora', '', ''),
(247, ' Juan Miguel', 'Avila Ontaneda', 'SJ11', 1900651827, 0, '1988-10-17', '', '', '', 'Zamora', '', ''),
(248, ' Francisco Antonio', 'Ontaneda Pintado', 'SJ12', 1900872654, 0, '1994-03-26', '', '', '', 'Zamora', '', ''),
(249, ' Antonio', 'Abad Luis', 'SJ13', 1103727481, 0, '1970-07-26', '', '', '', 'Zamora', '', ''),
(250, ' Jose Nain', 'Lalangui Chacon', 'SJ14', 1104506462, 0, '1984-06-13', '', '', '', 'Zamora', '', ''),
(251, ' Luis', 'Jimenez Jimenez', 'SF23', 1102249909, 0, '1960-10-13', '', '', '', 'Zamora', '', ''),
(252, ' Jose Eduardo', 'Tocto Rivar', 'SF25', 1900221431, 0, '1966-11-20', '', '', '', 'Zamora', '', ''),
(253, ' Carmen Benita', 'Garrido Jimenez', 'SF26', 1103267082, 0, '1976-05-06', '', '', '', 'Zamora', '', ''),
(254, ' Angel Maria', 'Puchaicela Anguisaca', 'SF27', 1102061841, 0, '1958-07-11', '', '', '', 'Zamora', '', ''),
(255, ' Pedro Moises', 'Abad Guayanay', 'SJ15', 1900719384, 0, '2012-11-23', '', '', '', 'Zamora', '', ''),
(256, 'Orlando Benjamin', 'Tocto Tocto', 'SJ16', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(257, ' Jose Querubin', 'Calderon Pinta', 'SM02', 1708599061, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(258, ' Fabian Sebastian', 'Herrera Pinta', 'SM08', 1103370050, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(259, ' Segundo Jacinto', 'Herrera Pinta', 'SM09', 1102089131, 0, '1962-08-28', '', '', '', 'Zamora', '', ''),
(260, ' Jose Isauro', 'Herrera Pinta', 'SM10', 1714531314, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(261, 'Maximo', 'Luzuriga', 'SM11', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(262, ' Agustina Marina', 'Herrera Encarnacion', 'SM15', 1101805818, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(263, ' Adita Alexandra', 'Luzuriaga Herrera', 'SM20', 1104174451, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(264, ' Angel', 'Castillo Acaro', 'SM24', 1900567031, 0, '1984-08-02', '', '', '', 'Zamora', '', ''),
(265, ' Hector Manuel', 'Jimenez Jimenez', 'SM28', 1102120100, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(266, ' Jose', 'Tillaguango Vitaliano', 'SM29', 1400512008, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(267, ' Rolando', 'Jimenez Marco', 'SM31', 1104866998, 0, '1986-10-19', '', '', '', 'Zamora', '', ''),
(268, ' Maria Catalina', 'Garrido Jimenez', 'SM33', 1900360122, 0, '1978-04-29', '', '', '', 'Zamora', '', ''),
(269, ' Miguel Antonio', 'Herrera Pinta', 'SM35', 1103726285, 0, '1978-11-11', '', '', '', 'Zamora', '', ''),
(270, ' Juana Livia', 'Gaona Villalta', 'TN06', 1102010046, 0, '1960-06-16', '', '', '', 'Zamora', '', ''),
(271, ' Francisco De Jesus', 'Mendoza Granda', 'TN07', 1102502315, 0, '1965-09-20', '', '', '', 'Zamora', '', ''),
(272, ' Leonardo Mauricio', 'Jaramillo Mendoza', 'TN11', 1104390875, 0, '1984-01-29', '', '', '', 'Zamora', '', ''),
(273, 'Rosario', 'Paute', 'TN13', 1102181532, 0, '1961-10-21', '', '', '', 'Zamora', '', ''),
(274, ' Jose Oswaldo', 'Lanche Jara', 'TN15', 1102724059, 0, '1966-08-28', '', '', '', 'Zamora', '', ''),
(275, ' Carmen', 'Jaramillo Leon', 'TN16', 1900081454, 0, '1946-07-16', '', '', '', 'Zamora', '', ''),
(276, ' Jesus Rene', 'Mendoza Granda', 'TN17', 1109719355, 0, '1987-03-23', '', '', '', 'Zamora', '', ''),
(277, ' Pedro Antonio', 'Bastidas Paute', 'TN18', 1105104259, 0, '1989-08-20', '', '', '', 'Zamora', '', ''),
(278, '  Jimenez Jose Daniel', 'Jimenez ', 'VH03', 1100490265, 0, '1944-04-08', '', '', '', 'Zamora', '', ''),
(279, ' Jose Felix', 'Troya Gordillo', 'VH05', 1900185131, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(280, ' Paul Norlander', 'Zumba Avila', 'VH11', 1900525310, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(281, ' Ilvar Rodrigo', 'Zumba Avila', 'VH14', 1900525328, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(282, ' Claudio Edgar', 'Zumba Zumba', 'VH15', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(283, ' Santiago', 'Giron Angel', 'VH16', 1104039761, 0, '1981-11-15', '', '', '', 'Zamora', '', ''),
(284, ' Marcelo Miguel', 'Garrido Hidalgo', 'EM01', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(285, ' Rodrigo Efrain', 'Abad Jaramillo', 'EM02', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(286, ' Luis Felipe', 'Abad Flores', 'EM03', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', 'm'),
(287, ' Roberto Miguel', 'Salazar Ortiz', 'EM04', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(288, ' Oswaldo Marcelo', 'Jimenez Gonzaga', 'EM05', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(289, ' Melecio Mauricio', 'Mayo Hidalgo', 'PP01', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(290, ' Wuilman Efren', 'Mayo Hidalgo', 'PP02', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(291, ' Bolivar', 'Merino Escobar', 'PP03', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(292, ' Artimidoro', 'Merino Escobar', 'PP04', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(293, ' Carlos Napoleon', 'Mayo Hidalgo', 'PP05', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(294, ' Ilda Maria', 'Mayo Hidalgo', 'PP06', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(295, ' David Rodrigo', 'Chamba Escobar', 'PP07', 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(296, ' Jose Maria', 'Mayo Hidalgo', 'LE18', 1103170294, 0, '1972-09-01', '', '', '', 'Zamora', '', ''),
(297, ' Juan Manuel', 'Chamba Escobar', 'LE20', 1104291990, 0, '1983-04-20', '', '', '', 'Zamora', '', ''),
(298, ' Cesar Vitaliano', 'Chamba Arevalo', 'GM07', 1101800363, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(299, ' Efrain', 'Abad Marco', 'GM06', 2100329677, 0, '1979-12-06', '', '', '', 'Zamora', '', ''),
(300, 'Juan', 'Hartman Merino', 'AN55', 0, 0, '0000-00-00', '', '', 'Zamora', 'Zamora', '', 'm'),
(301, 'Gilver', 'Rosillo', 'AN53', 0, 0, '0000-00-00', '', '', 'Zamora', 'Zamora', '', 'm'),
(302, 'Harvey', 'Merino', 'AN57', 0, 0, '0000-00-00', '', '', 'Zamora', 'Zamora', '', 'm'),
(303, 'Manuel', 'Tillaguango', 'AN54', 0, 0, '0000-00-00', '', '', 'Zamora', 'Zamora', '', 'm');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socios`
--

CREATE TABLE IF NOT EXISTS `socios` (
`id_socio` int(11) NOT NULL,
  `id_grupo` int(11) DEFAULT NULL,
  `id_persona` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `socios`
--

INSERT INTO `socios` (`id_socio`, `id_grupo`, `id_persona`) VALUES
(1, 2, 2),
(2, 2, 3),
(3, 2, 4),
(4, 2, 5),
(5, 2, 6),
(6, 2, 7),
(7, 2, 8),
(8, 2, 9),
(9, 2, 10),
(10, 2, 11),
(11, 2, 12),
(12, 2, 13),
(13, 2, 14),
(14, 2, 15),
(15, 2, 16),
(16, 2, 17),
(17, 2, 18),
(18, 2, 19),
(19, 2, 20),
(20, 2, 21),
(21, 2, 22),
(22, 2, 23),
(23, 2, 24),
(24, 2, 25),
(25, 2, 26),
(26, 2, 27),
(27, 2, 28),
(28, 2, 29),
(29, 2, 30),
(30, 2, 31);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subparcelas`
--

CREATE TABLE IF NOT EXISTS `subparcelas` (
`id` int(11) NOT NULL,
  `id_parcela` int(11) NOT NULL,
  `superficie` float(10,2) NOT NULL,
  `variedad` text COLLATE latin1_spanish_ci NOT NULL,
  `variedad2` text COLLATE latin1_spanish_ci NOT NULL,
  `siembra` int(11) NOT NULL,
  `densidad` int(11) NOT NULL,
  `marco` text COLLATE latin1_spanish_ci NOT NULL,
  `hierbas` text COLLATE latin1_spanish_ci NOT NULL,
  `sombreado` text COLLATE latin1_spanish_ci NOT NULL,
  `roya` text COLLATE latin1_spanish_ci NOT NULL,
  `broca` text COLLATE latin1_spanish_ci NOT NULL,
  `ojo_pollo` text COLLATE latin1_spanish_ci NOT NULL,
  `mes_inicio_cosecha` text COLLATE latin1_spanish_ci NOT NULL,
  `duracion_cosecha` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
`id` int(11) NOT NULL,
  `user` text COLLATE latin1_spanish_ci NOT NULL,
  `pass` text COLLATE latin1_spanish_ci NOT NULL,
  `id_nivel` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `user`, `pass`, `id_nivel`, `id_persona`) VALUES
(13, 'admin', 'admin', 1, 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `acciones`
--
ALTER TABLE `acciones`
 ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `altas`
--
ALTER TABLE `altas`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_alta_SOCIO_idx` (`id_socio`);

--
-- Indices de la tabla `analisis`
--
ALTER TABLE `analisis`
 ADD PRIMARY KEY (`id_analisis`), ADD KEY `fk_subparcela_analisis_idx` (`id_subparcela`);

--
-- Indices de la tabla `asociaciones`
--
ALTER TABLE `asociaciones`
 ADD PRIMARY KEY (`id`), ADD KEY `FK_SUBPARCELA_ASOCIACION_idx` (`subparcela_id`);

--
-- Indices de la tabla `catas`
--
ALTER TABLE `catas`
 ADD PRIMARY KEY (`id`), ADD KEY `fk:CATA_LOTE_idx` (`lote`);

--
-- Indices de la tabla `certificacion`
--
ALTER TABLE `certificacion`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_:SOCIO_CERTIFICACION_idx` (`id_socio`);

--
-- Indices de la tabla `comentario`
--
ALTER TABLE `comentario`
 ADD PRIMARY KEY (`id_COMENTARIO`), ADD KEY `FK_Comentario_cuenta_idx` (`id_usuario`), ADD KEY `FK_Foto_COmentario_idx` (`Id_foto`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
 ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`);

--
-- Indices de la tabla `despachos`
--
ALTER TABLE `despachos`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_despacho_lote_idx` (`lote`), ADD KEY `FK_DESPACHO_ENVIO_idx` (`envio`);

--
-- Indices de la tabla `envios`
--
ALTER TABLE `envios`
 ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `estimacion`
--
ALTER TABLE `estimacion`
 ADD PRIMARY KEY (`id`), ADD KEY `fk:_Estimacion_socio_idx` (`id_socio`);

--
-- Indices de la tabla `fotos`
--
ALTER TABLE `fotos`
 ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `grupos`
--
ALTER TABLE `grupos`
 ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `lotes`
--
ALTER TABLE `lotes`
 ADD PRIMARY KEY (`id`), ADD KEY `id` (`id`), ADD KEY `FK_SOCIO_LOTE_idx` (`id_socio`);

--
-- Indices de la tabla `niveles`
--
ALTER TABLE `niveles`
 ADD PRIMARY KEY (`id_niveles`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
 ADD PRIMARY KEY (`id`), ADD KEY `FK_PAGO_LOTE_idx` (`lote`);

--
-- Indices de la tabla `parcelas`
--
ALTER TABLE `parcelas`
 ADD PRIMARY KEY (`id`), ADD KEY `FK_PARCELA_SOCIO_idx` (`id_socio`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
 ADD PRIMARY KEY (`id_persona`);

--
-- Indices de la tabla `socios`
--
ALTER TABLE `socios`
 ADD PRIMARY KEY (`id_socio`), ADD KEY `id_socio` (`id_socio`), ADD KEY `FK_SOCIO_GRUPO_idx` (`id_grupo`), ADD KEY `FK_PERSONA_SOCIO_idx` (`id_persona`);

--
-- Indices de la tabla `subparcelas`
--
ALTER TABLE `subparcelas`
 ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
 ADD PRIMARY KEY (`id`), ADD KEY `FK_USUARIO_SOCIO_idx` (`id_persona`), ADD KEY `fk_user_nivel` (`id_nivel`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `acciones`
--
ALTER TABLE `acciones`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `altas`
--
ALTER TABLE `altas`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `analisis`
--
ALTER TABLE `analisis`
MODIFY `id_analisis` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `asociaciones`
--
ALTER TABLE `asociaciones`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `catas`
--
ALTER TABLE `catas`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `certificacion`
--
ALTER TABLE `certificacion`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `comentario`
--
ALTER TABLE `comentario`
MODIFY `id_COMENTARIO` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `despachos`
--
ALTER TABLE `despachos`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `envios`
--
ALTER TABLE `envios`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `estimacion`
--
ALTER TABLE `estimacion`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `fotos`
--
ALTER TABLE `fotos`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `grupos`
--
ALTER TABLE `grupos`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT de la tabla `lotes`
--
ALTER TABLE `lotes`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `niveles`
--
ALTER TABLE `niveles`
MODIFY `id_niveles` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `parcelas`
--
ALTER TABLE `parcelas`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
MODIFY `id_persona` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=304;
--
-- AUTO_INCREMENT de la tabla `socios`
--
ALTER TABLE `socios`
MODIFY `id_socio` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT de la tabla `subparcelas`
--
ALTER TABLE `subparcelas`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `altas`
--
ALTER TABLE `altas`
ADD CONSTRAINT `fk_alta_SOCIO` FOREIGN KEY (`id_socio`) REFERENCES `socios` (`id_socio`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `analisis`
--
ALTER TABLE `analisis`
ADD CONSTRAINT `fk_subparcela_analisis` FOREIGN KEY (`id_subparcela`) REFERENCES `subparcelas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `asociaciones`
--
ALTER TABLE `asociaciones`
ADD CONSTRAINT `FK_SUBPARCELA_ASOCIACION` FOREIGN KEY (`subparcela_id`) REFERENCES `subparcelas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `catas`
--
ALTER TABLE `catas`
ADD CONSTRAINT `fk:CATA_LOTE` FOREIGN KEY (`lote`) REFERENCES `lotes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `certificacion`
--
ALTER TABLE `certificacion`
ADD CONSTRAINT `fk_:SOCIO_CERTIFICACION` FOREIGN KEY (`id_socio`) REFERENCES `socios` (`id_socio`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `comentario`
--
ALTER TABLE `comentario`
ADD CONSTRAINT `FK_Comentario_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `FK_Foto_COmentario` FOREIGN KEY (`Id_foto`) REFERENCES `fotos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `despachos`
--
ALTER TABLE `despachos`
ADD CONSTRAINT `FK_DESPACHO_ENVIO` FOREIGN KEY (`envio`) REFERENCES `envios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_despacho_lote` FOREIGN KEY (`lote`) REFERENCES `lotes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `estimacion`
--
ALTER TABLE `estimacion`
ADD CONSTRAINT `fk:_Estimacion_socio` FOREIGN KEY (`id_socio`) REFERENCES `socios` (`id_socio`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `lotes`
--
ALTER TABLE `lotes`
ADD CONSTRAINT `FK_SOCIO_LOTE` FOREIGN KEY (`id_socio`) REFERENCES `socios` (`id_socio`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
ADD CONSTRAINT `FK_PAGO_LOTE` FOREIGN KEY (`lote`) REFERENCES `lotes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `parcelas`
--
ALTER TABLE `parcelas`
ADD CONSTRAINT `FK_PARCELA_SOCIO` FOREIGN KEY (`id_socio`) REFERENCES `socios` (`id_socio`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `socios`
--
ALTER TABLE `socios`
ADD CONSTRAINT `FK_PERSONA_SOCIO` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `FK_SOCIO_GRUPO` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_socio_persona` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`);

--
-- Filtros para la tabla `subparcelas`
--
ALTER TABLE `subparcelas`
ADD CONSTRAINT `fk_subparcela_parcela` FOREIGN KEY (`id`) REFERENCES `parcelas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
ADD CONSTRAINT `FK_USUARIO_SOCIO` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_user_nivel` FOREIGN KEY (`id_nivel`) REFERENCES `niveles` (`id_niveles`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
