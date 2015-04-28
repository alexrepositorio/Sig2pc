-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-04-2015 a las 23:46:12
-- Versión del servidor: 5.6.21
-- Versión de PHP: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `sig2`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_lote_ins`(
 IN in_socio int ,
 IN in_codigo varchar(20),
 IN in_fecha date,
 IN in_peso double(10,2),
 IN in_humedad double(10,2),
 IN in_rto_descarte int,
 IN in_rto_exportable int,
 IN in_defecto_negro int,
 IN in_defecto_vinagre int,
 IN in_defecto_decolorado int,
 In in_defecto_mordido int,
 IN in_defecto_brocado int,
 IN in_reposo tinyint(1),
 IN in_moho tinyint(1),
 IN in_fermento tinyint(1),
 IN in_contaminado tinyint(1),
 IN in_calidad varchar(2)
 )
BEGIN
    
 INSERT INTO lotes (`id_socio`, `codigo_lote`, `fecha`, `peso`, `humedad`, `rto_descarte`, `rto_exportable`, `defecto_negro`, `defecto_vinagre`, `defecto_decolorado`, `defecto_mordido`, `defecto_brocado`, `reposo`, `moho`, `fermento`, `contaminado`,`calidad`) 
 VALUES (in_socio,in_codigo , in_fecha, in_peso,in_humedad , in_rto_descarte, in_rto_exportable, in_defecto_negro, in_defecto_vinagre, in_defecto_decolorado, in_defecto_mordido, in_defecto_brocado, in_reposo, in_moho, in_fermento, in_contaminado,in_calidad);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_socio_altas`(
in id int
)
BEGIN
SELECT id,fecha,estado FROM altas WHERE id_socio=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_socio_certificar`(
 IN in_id int ,
 IN in_anio date,
 IN in_estado  VARCHAR(50) 
 )
BEGIN
    
 INSERT INTO certificacion(id_socio,year,estatus)  VALUES (in_id,in_anio,in_estado);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_socio_cons`(IN `criterio` VARCHAR(20), IN `valor` VARCHAR(20))
BEGIN
case  criterio
when 'nombres'
then
 
SELECT socios.id_socio as id,`nombres`, `apellidos`, socios.codigo as codigo, `cedula`, `genero`,grupo,estatus as certificacion FROM
				socios
				left join persona on persona.id_persona=socios.id_persona
				left join certificacion on certificacion.id_socio=socios.id_socio
				left join grupos on grupos.id=socios.id_grupo
	 			where  nombres like CONCAT('%', valor, '%') OR apellidos like CONCAT('%', valor, '%')
                and  socios.id_socio is not null
                order by apellidos asc;

when 'localidad'
then
SELECT socios.id_socio as id,`nombres`, `apellidos`, socios.codigo as codigo, `cedula`, `genero`,grupo,estatus as certificacion FROM
				socios
				left join persona on persona.id_persona=socios.id_persona
				left join certificacion on certificacion.id_socio=socios.id_socio
				left join grupos on grupos.id=socios.id_grupo
	 			where  grupo like CONCAT('%', valor, '%') 
                and socios.id_socio is not null
                order by apellidos asc;
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
SELECT socios.id_socio as id,`nombres`, `apellidos`, socios.codigo as codigo, `cedula`, `genero`,grupo,estatus as certificacion FROM
				socios
				left join persona on persona.id_persona=socios.id_persona
				left join certificacion on certificacion.id_socio=socios.id_socio
				left join grupos on grupos.id=socios.id_grupo
                where certificacion.estatus is null
                and socios.id_socio is not null
				order by apellidos asc
                ;				
				  
when ''
then
	SELECT socios.id_socio as id,`nombres`, `apellidos`, socios.codigo as codigo, `cedula`, `genero`,grupo,estatus as certificacion FROM
				socios
				left join persona on persona.id_persona=socios.id_persona
				left join certificacion on certificacion.id_socio=socios.id_socio
				left join grupos on grupos.id=socios.id_grupo
                where socios.id_socio is not null
	 		order by apellidos;
END case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_socio_estimacion`(
in id int
)
BEGIN
SELECT id,year,estimados,entregados FROM estimacion WHERE id_socio=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_socio_find`(IN `id` INT)
BEGIN
SELECT `id_socio`,`nombres`, `apellidos`, socios.codigo as codigo, `cedula`,`celular`, `f_nacimiento`, `email`, `direccion`, `canton`, `provincia`, `genero`,`grupo` as poblacion FROM persona
	left join socios
	on socios.id_persona=persona.id_persona
	left join grupos
	on grupos.id=socios.id_grupo
	where socios.id_socio=id; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_socio_ins`(in in_nombre varchar(20),
in in_apellido varchar(20),
in in_codigo varchar (4),
in in_cedula varchar(20),
in in_celular varchar(20),
in f_nac date,
in in_direccion varchar(50),
in in_poblacion varchar(50),
in in_canton varchar(20),
in in_provincia varchar(20),
in in_genero char(1),
in in_mail varchar(50)
)
BEGIN
  insert into Persona(nombres,apellidos,codigo,cedula,celular,f_nacimiento,email,direccion,provincia,canton,genero) 
  values (in_nombre,in_apellido,in_codigo,in_cedula,in_celular,f_nac,in_mail,in_direccion,in_canton,
  in_provincia,in_genero);
  
  SELECT id into @id from grupos where grupo like concat("%",in_poblacion,"%");
  
  select id_persona into @persona from persona where nombres=in_nombre and apellidos=in_apellido;
  
  insert into socios(id_grupo,id_persona,codigo) values (@id,@persona,in_codigo);
  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_socio_update`(IN `in_id` INT, IN `in_nombre` VARCHAR(20), IN `in_apellido` VARCHAR(20), IN `in_codigo` VARCHAR(4), IN `in_cedula` VARCHAR(20), IN `in_celular` VARCHAR(20), IN `f_nac` DATE, IN `in_direccion` VARCHAR(50), IN `in_poblacion` VARCHAR(30), IN `in_canton` VARCHAR(20), IN `in_provincia` VARCHAR(20), IN `in_genero` CHAR(1), IN `in_mail` VARCHAR(50))
BEGIN
select id_persona into @persona from socios where socios.id_socio=in_id;
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
			where id_persona=@persona;

SELECT id into @id from grupos where grupo like concat("%",in_poblacion,"%");            
UPDATE socios
set id_grupo=@id, codigo=in_codigo 
			where id_socio=in_id; 
            
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `certificacion`
--

INSERT INTO `certificacion` (`id`, `id_socio`, `year`, `estatus`) VALUES
(1, 306, 2147483647, 'ORGANICO');

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
(6, 'EMPROAGRO', 'EM'),
(7, 'EL MIRADOR', 'LM'),
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
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `lotes`
--

INSERT INTO `lotes` (`id`, `id_socio`, `codigo_lote`, `fecha`, `peso`, `humedad`, `rto_descarte`, `rto_exportable`, `defecto_negro`, `defecto_vinagre`, `defecto_decolorado`, `defecto_mordido`, `defecto_brocado`, `reposo`, `moho`, `fermento`, `contaminado`, `calidad`) VALUES
(1, 93, 'APC-612', '2014-02-21 10:00:00', 2.65, 12.00, 3, 204, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(2, 297, 'APC-613', '2014-02-21 10:00:00', 3.79, 12.00, 10, 196, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(3, 108, 'APC-614', '2014-02-25 10:00:00', 0.53, 12.00, 16, 187, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(4, 35, 'APC-616', '2014-03-17 10:00:00', 1.54, 16.00, 7, 183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(5, 53, 'APC-617', '2014-04-11 10:00:00', 3.02, 12.00, 30, 174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(6, 296, 'APC-618', '2014-04-11 10:00:00', 5.49, 12.00, 25, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(7, 256, 'APC-619', '2014-04-15 10:00:00', 2.04, 23.00, 15, 161, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B'),
(8, 295, 'APC-620', '2014-04-15 10:00:00', 8.45, 19.00, 19, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(9, 294, 'APC-621', '2014-04-15 10:00:00', 5.43, 21.00, 6, 175, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(10, 196, 'APC-623', '2014-05-09 10:00:00', 0.52, 12.00, 26, 181, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(11, 108, 'APC-624', '2014-05-13 10:00:00', 3.20, 12.00, 24, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B'),
(12, 46, 'APC-625', '2014-05-23 10:00:00', 2.10, 12.00, 21, 183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(13, 87, 'APC-02', '2014-02-06 10:00:00', 5.67, 12.00, 14, 188, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(14, 87, 'APC-04', '2014-06-02 10:00:00', 2.56, 12.00, 10, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(15, 213, 'APC-05', '2014-06-02 10:00:00', 1.86, 12.00, 8, 194, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(16, 53, 'APC-06', '2014-06-02 10:00:00', 1.19, 12.00, 16, 186, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(17, 5, 'APC-08', '2014-06-02 10:00:00', 2.60, 12.00, 4, 195, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B'),
(18, 219, 'APC-09', '2014-06-03 10:00:00', 1.81, 12.00, 18, 188, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(19, 49, 'APC-07', '2014-06-02 10:00:00', 6.73, 12.00, 22, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(20, 107, 'APC-10', '2014-06-09 10:00:00', 6.80, 12.00, 37, 168, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B'),
(21, 221, 'APC-11', '2014-06-10 10:00:00', 2.10, 12.00, 20, 185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(22, 258, 'APC-12', '2014-06-11 10:00:00', 0.71, 12.00, 39, 158, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B'),
(23, 5, 'APC-14', '2014-06-11 10:00:00', 3.45, 12.00, 23, 180, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(24, 3, 'APC-15', '2014-06-11 10:00:00', 2.49, 12.00, 15, 189, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(25, 9, 'APC-16', '2014-06-12 10:00:00', 2.63, 12.00, 24, 183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(26, 67, 'APC-17', '2014-06-12 10:00:00', 5.29, 12.00, 13, 190, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(27, 58, 'APC-18', '2014-06-12 10:00:00', 2.25, 12.00, 34, 175, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(28, 290, 'APC-19', '2014-06-16 10:00:00', 1.43, 12.00, 14, 185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(29, 143, 'APC-20', '2014-06-17 10:00:00', 4.29, 12.00, 11, 198, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(30, 7, 'APC-21', '2014-06-17 10:00:00', 2.52, 12.00, 34, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(31, 267, 'APC-22', '2014-06-18 10:00:00', 1.22, 12.00, 13, 190, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(32, 267, 'APC-23', '2014-06-18 10:00:00', 0.38, 12.00, 10, 187, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(33, 86, 'APC-24', '2014-06-19 10:00:00', 4.36, 12.00, 26, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(34, 223, 'APC-25', '2014-06-20 10:00:00', 6.25, 12.00, 17, 186, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(35, 33, 'APC-26', '2014-06-20 10:00:00', 0.71, 12.00, 43, 158, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B'),
(36, 140, 'APC-27', '2014-06-20 10:00:00', 4.35, 12.00, 22, 183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(37, 16, 'APC-29', '2014-06-24 10:00:00', 0.55, 12.00, 11, 189, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(38, 201, 'APC-30', '2014-06-24 10:00:00', 0.47, 12.00, 13, 189, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(39, 5, 'APC-31', '2014-06-24 10:00:00', 1.38, 12.00, 19, 181, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(40, 122, 'APC-32', '2014-06-26 10:00:00', 1.93, 12.00, 10, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(41, 123, 'APC-33', '2014-06-26 10:00:00', 1.53, 12.00, 10, 193, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(42, 153, 'APC-34', '2014-06-26 10:00:00', 0.58, 12.00, 50, 193, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(43, 5, 'APC-35', '2014-06-26 10:00:00', 0.53, 12.00, 20, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(44, 75, 'APC-36', '2014-06-27 10:00:00', 1.21, 12.00, 9, 193, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(45, 15, 'APC-37', '2014-06-27 10:00:00', 1.05, 12.00, 42, 155, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(46, 16, 'APC-38', '2014-06-27 10:00:00', 1.09, 12.00, 31, 168, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(47, 19, 'APC-39', '2014-06-27 10:00:00', 1.47, 12.00, 14, 182, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(48, 19, 'APC-40', '2014-06-27 10:00:00', 3.00, 12.00, 12, 190, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(49, 219, 'APC-41', '2014-06-30 10:00:00', 1.64, 12.00, 17, 186, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(50, 6, 'APC-42', '2014-06-30 10:00:00', 3.55, 12.00, 10, 193, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(51, 6, 'APC-44', '2014-06-30 10:00:00', 5.15, 12.00, 11, 193, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(52, 75, 'APC-45', '2014-07-01 10:00:00', 0.56, 12.00, 15, 182, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(53, 108, 'APC-46', '2014-07-02 10:00:00', 2.59, 12.00, 29, 173, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(54, 67, 'APC-47', '2014-07-02 10:00:00', 4.76, 12.00, 45, 152, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(55, 7, 'APC-48', '2014-07-03 10:00:00', 2.79, 12.00, 34, 168, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(56, 297, 'APC-49', '2014-07-03 10:00:00', 4.10, 12.00, 23, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(57, 149, 'APC-50', '2014-07-03 10:00:00', 2.33, 12.00, 17, 187, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(58, 295, 'APC-51', '2014-07-07 10:00:00', 2.35, 12.00, 22, 174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(59, 137, 'APC-52', '2014-07-07 10:00:00', 2.48, 12.00, 29, 170, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(60, 1, 'APC-53', '2014-07-07 10:00:00', 0.84, 12.00, 24, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(61, 87, 'APC-54', '2014-07-10 10:00:00', 4.00, 12.00, 0, 181, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(62, 87, 'APC-55', '2014-07-11 01:00:00', 5.59, 12.00, 33, 169, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(63, 129, 'APC-56', '2014-07-10 10:00:00', 1.18, 12.00, 20, 181, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(64, 58, 'APC-57', '2014-07-10 10:00:00', 2.72, 12.00, 36, 166, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(65, 213, 'APC-58', '2014-07-11 10:00:00', 1.73, 12.00, 22, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(66, 74, 'APC-59', '2014-07-14 10:00:00', 3.44, 12.00, 27, 174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(67, 51, 'APC-60', '2014-07-14 10:00:00', 9.75, 12.00, 24, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(68, 59, 'APC-61', '2014-07-14 10:00:00', 4.38, 12.00, 38, 163, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(69, 49, 'APC-62', '2014-07-14 10:00:00', 15.56, 12.00, 33, 169, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(70, 12, 'APC-63', '2014-07-15 10:00:00', 1.46, 12.00, 45, 155, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(71, 192, 'APC-64', '2014-07-15 10:00:00', 1.22, 12.00, 42, 167, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B'),
(72, 107, 'APC-65', '2014-07-16 10:00:00', 1.66, 12.00, 36, 164, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B'),
(73, 249, 'APC-66', '2014-07-16 10:00:00', 5.09, 12.00, 38, 195, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(74, 153, 'APC-67', '2014-07-16 10:00:00', 1.24, 12.00, 25, 172, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(75, 90, 'APC-68', '2014-07-17 10:00:00', 6.59, 12.00, 32, 167, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(76, 90, 'APC-69', '2014-07-17 10:00:00', 0.62, 12.00, 25, 164, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'MN'),
(77, 221, 'APC-70', '2014-07-17 10:00:00', 3.67, 12.00, 32, 167, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(78, 209, 'APC-71', '2014-07-21 10:00:00', 4.00, 12.00, 32, 169, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(79, 295, 'APC-72', '2014-07-21 10:00:00', 3.59, 12.00, 23, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(80, 36, 'APC-73', '2014-07-21 10:00:00', 2.95, 12.00, 18, 182, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(81, 36, 'APC-74', '2014-07-21 10:00:00', 2.95, 12.00, 43, 163, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B'),
(82, 139, 'APC-75', '2014-07-21 10:00:00', 5.13, 12.00, 32, 168, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(83, 171, 'APC-76', '2014-07-22 10:00:00', 2.22, 12.00, 24, 174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(84, 255, 'APC-77', '2014-07-23 10:00:00', 2.09, 12.00, 29, 169, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(85, 222, 'APC-78', '2014-07-23 10:00:00', 1.68, 12.00, 27, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(86, 9, 'APC-79', '2014-07-23 10:00:00', 4.20, 12.00, 32, 170, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(87, 201, 'APC-80', '2014-07-24 10:00:00', 1.05, 12.00, 14, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(88, 108, 'APC-81', '2014-07-24 10:00:00', 4.96, 12.00, 35, 164, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(89, 146, 'APC-82', '2014-07-24 10:00:00', 1.53, 12.00, 21, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(90, 230, 'APC-83', '2014-07-24 10:00:00', 2.33, 12.00, 24, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(91, 15, 'APC-84', '2014-07-24 10:00:00', 3.83, 12.00, 39, 160, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(92, 71, 'APC85', '2014-07-25 10:00:00', 2.21, 12.00, 26, 172, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(93, 87, 'APC86', '2014-07-28 10:00:00', 9.38, 12.00, 27, 173, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(94, 87, 'APC87', '2014-07-28 20:00:00', 3.45, 12.00, 22, 180, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(95, 3, 'APC88', '2014-07-28 10:00:00', 3.89, 12.00, 24, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(96, 15, 'APC89', '2014-07-29 10:00:00', 1.15, 12.00, 38, 162, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(97, 45, 'APC90', '2014-07-29 10:00:00', 1.52, 12.00, 17, 186, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(98, 143, 'APC91', '2014-07-29 10:00:00', 7.45, 12.00, 21, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(99, 243, 'APC92', '2014-07-30 10:00:00', 1.32, 12.00, 20, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(100, 74, 'APC93', '2014-07-30 10:00:00', 2.81, 12.00, 20, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(101, 174, 'APC94', '2014-07-31 10:00:00', 2.65, 12.00, 22, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(102, 41, 'APC95', '2014-07-31 10:00:00', 1.90, 12.00, 21, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(103, 259, 'APC96', '2014-07-31 10:00:00', 1.73, 12.00, 29, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(104, 256, 'APC97', '2014-07-31 10:00:00', 2.82, 12.00, 19, 181, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(105, 105, 'APC98', '2014-08-01 10:00:00', 7.66, 12.00, 28, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(106, 105, 'APC99', '2014-08-01 10:00:00', 1.00, 12.00, 27, 170, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B'),
(107, 7, 'APC100', '2014-08-01 10:00:00', 1.27, 12.00, 27, 164, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(108, 292, 'APC-101', '2014-08-01 10:00:00', 4.70, 12.00, 19, 182, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(109, 291, 'APC102', '2014-08-01 10:00:00', 16.70, 12.00, 22, 180, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(110, 288, 'APC103', '2014-08-01 10:00:00', 5.00, 12.00, 27, 175, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(111, 287, 'APC104', '2014-08-01 10:00:00', 10.78, 12.00, 17, 185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(112, 251, 'APC-105', '2014-08-04 10:00:00', 1.22, 12.00, 22, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(113, 107, 'APC106', '2014-08-04 10:00:00', 0.94, 12.00, 26, 173, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(114, 293, 'APC107', '2014-08-04 10:00:00', 3.85, 12.00, 20, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(115, 214, 'APC108', '2014-08-04 10:00:00', 13.41, 12.00, 25, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(116, 295, 'APC109', '2014-08-04 10:00:00', 2.47, 12.00, 21, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(117, 301, 'APC110', '2014-08-04 10:00:00', 1.42, 12.00, 20, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(118, 239, 'APC111', '2014-08-04 10:00:00', 1.35, 12.00, 27, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(119, 242, 'APC112', '2014-08-04 10:00:00', 0.73, 12.00, 28, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(120, 250, 'APC113', '2014-08-04 10:00:00', 13.80, 12.00, 26, 175, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(121, 215, 'APC114', '2014-08-04 10:00:00', 1.00, 12.00, 25, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(122, 237, 'APC115', '2014-08-04 10:00:00', 0.50, 12.00, 17, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(123, 296, 'APC116', '2014-08-05 10:00:00', 5.19, 12.00, 30, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(124, 292, 'APC117', '2014-08-05 10:00:00', 0.59, 12.00, 63, 156, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(125, 296, 'APC118', '2014-08-05 10:00:00', 4.74, 12.00, 29, 173, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(126, 138, 'APC119', '2014-08-05 10:00:00', 1.46, 12.00, 17, 186, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(127, 155, 'APC120', '2014-08-05 10:00:00', 1.86, 12.00, 24, 175, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(128, 299, 'APC121', '2014-08-06 10:00:00', 3.33, 12.00, 34, 168, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(129, 32, 'APC122', '2014-08-06 10:00:00', 2.67, 12.00, 20, 181, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(130, 93, 'APC123', '2014-08-06 10:00:00', 3.13, 12.00, 11, 190, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(131, 1, 'APC124', '2014-08-06 10:00:00', 2.42, 12.00, 24, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(132, 300, 'APC125', '2014-08-06 10:00:00', 4.67, 12.00, 24, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(133, 140, 'APC126', '2014-08-07 10:00:00', 5.59, 12.00, 17, 185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(134, 122, 'APC127', '2014-08-07 10:00:00', 1.50, 12.00, 20, 181, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(135, 118, 'APC128', '2014-08-07 10:00:00', 0.80, 12.00, 16, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(136, 118, 'APC129', '2014-08-07 10:00:00', 0.74, 12.00, 21, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(137, 257, 'APC130', '2014-08-07 10:00:00', 12.46, 12.00, 29, 173, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(138, 129, 'APC131', '2014-08-07 10:00:00', 1.44, 12.00, 16, 187, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(139, 190, 'APC132', '2014-08-07 10:00:00', 0.78, 12.00, 26, 173, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(140, 201, 'APC133', '2014-08-07 10:00:00', 0.38, 12.00, 23, 174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(141, 206, 'APC134', '2014-08-07 10:00:00', 0.48, 12.00, 13, 185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(142, 36, 'APC135', '2014-08-07 10:00:00', 0.41, 12.00, 9, 180, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(143, 36, 'APC136', '2014-08-07 10:00:00', 3.73, 12.00, 29, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(144, 43, 'APC137', '2014-08-08 10:00:00', 2.09, 12.00, 23, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B'),
(145, 149, 'APC138', '2014-08-08 10:00:00', 2.75, 12.00, 22, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(146, 61, 'APC139', '2014-08-08 10:00:00', 4.54, 12.00, 23, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(147, 221, 'APC140', '2014-08-08 10:00:00', 2.62, 12.00, 27, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(148, 16, 'APC141', '2014-08-08 10:00:00', 1.35, 12.00, 16, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(149, 7, 'APC142', '2014-08-08 10:00:00', 4.12, 12.00, 25, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(150, 253, 'APC143', '2014-08-08 10:00:00', 2.28, 12.00, 23, 175, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(151, 214, 'APC144', '2014-08-08 10:00:00', 1.67, 12.00, 18, 183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(152, 221, 'APC145', '2014-08-08 10:00:00', 1.90, 12.00, 30, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(153, 298, 'APC146', '2014-08-11 10:00:00', 5.49, 12.00, 29, 174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(154, 298, 'APC147', '2014-08-11 10:00:00', 0.62, 12.00, 21, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(155, 294, 'APC-148', '2014-08-11 10:00:00', 10.38, 12.00, 24, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(156, 213, 'APC-149', '2014-08-11 10:00:00', 6.04, 12.00, 30, 173, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(157, 163, 'APC-150', '2014-08-11 10:00:00', 4.14, 12.00, 24, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(158, 63, 'APC-151', '2014-08-11 10:00:00', 2.83, 12.00, 23, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(159, 222, 'APC-152', '2014-08-11 10:00:00', 1.23, 12.00, 26, 170, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(160, 272, 'APC-153', '2014-08-12 10:00:00', 3.78, 12.00, 25, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(161, 196, 'APC-154', '2014-08-12 10:00:00', 2.16, 12.00, 24, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(162, 51, 'APC-155', '2014-08-12 10:00:00', 5.62, 12.00, 24, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(163, 122, 'APC-156', '2014-08-12 10:00:00', 1.22, 12.00, 13, 187, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(164, 19, 'APC-157', '2014-08-12 10:00:00', 2.61, 12.00, 21, 182, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(165, 9, 'APC-158', '2014-08-12 10:00:00', 5.43, 12.00, 26, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(166, 60, 'APC-159', '2014-08-13 10:00:00', 3.87, 12.00, 33, 169, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(167, 153, 'APC-160', '2014-08-13 10:00:00', 2.06, 12.00, 14, 187, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(168, 61, 'APC-161', '2014-08-14 10:00:00', 2.50, 12.00, 18, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(169, 290, 'APC-162', '2014-08-14 10:00:00', 1.57, 12.00, 10, 191, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(170, 50, 'APC-163', '2014-08-18 10:00:00', 7.12, 12.00, 12, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(171, 297, 'APC-164', '2014-08-18 10:00:00', 2.22, 12.00, 23, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A'),
(173, 306, 'APC-00001-15', '2015-04-28 05:00:00', 12.00, 12.00, 12, 12, 12, 12, 12, 12, 12, 1, 1, 0, 0, 'B');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id`, `lote`, `fecha`, `exportable`, `descarte`, `fuera`, `calidad`, `cliente`, `microlote`, `tazadorada`) VALUES
(1, 93, '2014-09-18 21:38:38', 800.00, 70.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2, 37, '2014-09-23 02:41:21', 0.00, 0.00, 100.00, 0.00, 0.00, 0.00, 0.00),
(3, 36, '2014-09-25 14:53:29', 1499.00, 190.00, 0.00, 0.00, 45.00, 250.00, 300.00);

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
) ENGINE=InnoDB AUTO_INCREMENT=298 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `parcelas`
--

INSERT INTO `parcelas` (`id`, `id_socio`, `coorX`, `coorY`, `alti`, `sup_total`, `MOcontratada`, `MOfamiliar`, `Miembros_familia`, `riego`) VALUES
(1, 1, 9482926, 707211, 1178, 2.00, 200, 3, 3, ''),
(2, 2, 0, 0, 0, 7.00, 60, 2, 2, ''),
(3, 3, 9482298, 707191, 1160, 10.00, 20, 4, 6, ''),
(4, 4, 948559, 705609, 1403, 30.00, 60, 2, 5, ''),
(5, 5, 9481777, 707891, 1024, 4.30, 0, 2, 4, ''),
(6, 6, 9482076, 706693, 1309, 4.00, 200, 2, 3, ''),
(7, 7, 9483308, 707420, 1202, 35.00, 0, 4, 4, ''),
(8, 8, 9476877, 706977, 1005, 2.00, 60, 1, 1, ''),
(9, 9, 9482230, 0, 1223, 8.36, 200, 1, 1, ''),
(10, 10, 9475143, 706177, 1463, 83.00, 30, 2, 2, ''),
(11, 11, 9482301, 706703, 1211, 6.00, 0, 0, 0, ''),
(12, 12, 9482330, 707070, 1327, 2.00, 0, 0, 0, ''),
(13, 13, 9480481, 707583, 1158, 5.00, 20, 4, 6, ''),
(14, 14, 9478885, 707581, 1022, 10.00, 0, 2, 9, ''),
(15, 15, 9483308, 707420, 1202, 3.00, 0, 2, 3, ''),
(16, 16, 9482076, 706693, 1309, 3.50, 0, 2, 12, ''),
(17, 17, 9489239, 0, 1386, 2.00, 0, 0, 0, ''),
(18, 18, 0, 0, 0, 4.00, 0, 2, 6, ''),
(19, 19, 83308, 707420, 1203, 3.00, 90, 1, 14, ''),
(20, 20, 9486817, 706972, 1005, 2.00, 30, 1, 1, ''),
(21, 21, 9483308, 707420, 1202, 2.00, 120, 4, 4, ''),
(22, 22, 9499923, 0, 1140, 3.00, 0, 0, 0, ''),
(23, 23, 0, 0, 0, 1.00, 0, 0, 0, ''),
(24, 24, 9482076, 706693, 1309, 2.00, 0, 0, 0, ''),
(25, 25, 0, 0, 0, 3.00, 0, 0, 0, ''),
(26, 26, 9476864, 706455, 1069, 2.00, 0, 0, 0, ''),
(27, 27, 9480275, 706964, 1378, 2.00, 0, 0, 0, ''),
(28, 28, 0, 0, 0, 2.00, 0, 0, 0, ''),
(29, 29, 9482298, 707191, 1160, 2.00, 0, 0, 0, ''),
(30, 30, 0, 0, 0, 1.00, 0, 0, 0, ''),
(31, 299, 0, 0, 0, 0.00, 0, 0, 0, ''),
(32, 31, 9486845, 704778, 1625, 1.00, 0, 0, 0, ''),
(33, 32, 9483849, 705221, 1521, 25.00, 20, 5, 7, ''),
(34, 33, 9484172, 704746, 1625, 2.00, 200, 1, 5, ''),
(35, 34, 9484151, 705294, 1557, 7.00, 50, 2, 2, ''),
(36, 35, 9482741, 7035125, 1611, 16.00, 30, 8, 12, ''),
(37, 36, 9483391, 703291, 1648, 2.00, 0, 1, 9, ''),
(38, 37, 9483165, 705375, 1364, 17.00, 0, 0, 0, ''),
(39, 38, 9484180, 706050, 1292, 15.00, 60, 5, 10, ''),
(40, 39, 9483968, 0, 1292, 1.50, 20, 2, 5, ''),
(41, 40, 0, 0, 0, 4.00, 0, 0, 0, ''),
(42, 41, 9483460, 0, 1603, 3.00, 60, 5, 10, ''),
(43, 42, 0, 0, 0, 10.00, 200, 4, 11, ''),
(44, 43, 0, 0, 0, 4.00, 0, 4, 4, ''),
(45, 44, 94833515, 0, 1470, 14.00, 200, 2, 4, ''),
(46, 45, 9482741, 0, 1611, 2.00, 46, 2, 3, ''),
(47, 46, 9474492, 707717, 1514, 59.00, 100, 5, 5, ''),
(48, 47, 9475898, 708752, 1206, 6.00, 50, 2, 7, ''),
(49, 48, 9475587, 707526, 1537, 12.00, 0, 0, 0, ''),
(50, 49, 9475705, 708084, 1347, 5.50, 0, 2, 6, ''),
(51, 50, 9475896, 707783, 1536, 8.00, 0, 3, 7, ''),
(52, 51, 9474492, 707717, 1514, 6.00, 60, 2, 4, ''),
(53, 52, 9475391, 707897, 1346, 3.00, 90, 2, 10, ''),
(54, 53, 9475166, 707634, 1454, 3.00, 5, 3, 6, ''),
(55, 54, 9476843, 707466, 1121, 1.00, 0, 0, 0, ''),
(56, 55, 9476587, 707465, 1204, 1.00, 0, 0, 0, ''),
(57, 56, 9476421, 707825, 1588, 1.00, 0, 0, 0, ''),
(58, 57, 9474424, 707832, 1579, 1.00, 0, 2, 3, ''),
(59, 58, 0, 0, 0, 1.00, 0, 0, 0, ''),
(60, 59, 9475563, 708119, 1333, 2.00, 0, 0, 0, ''),
(61, 60, 9485091, 717835, 1285, 5.50, 60, 5, 9, ''),
(62, 61, 9485888, 717061, 1450, 63.00, 0, 5, 13, ''),
(63, 62, 9486151, 717908, 1387, 32.00, 0, 0, 0, ''),
(64, 63, 9485490, 717582, 1382, 20.00, 0, 1, 2, ''),
(65, 64, 9486427, 717278, 1481, 150.00, 300, 6, 12, ''),
(66, 65, 9486710, 717542, 1590, 170.00, 0, 4, 11, ''),
(67, 66, 9484308, 718273, 1188, 2.50, 0, 0, 0, ''),
(68, 67, 9483582, 716952, 1162, 60.00, 0, 0, 0, ''),
(69, 68, 9485612, 717329, 1456, 2.00, 0, 1, 14, ''),
(70, 69, 9481537, 712992, 1263, 20.00, 20, 0, 1, ''),
(71, 70, 9484486, 717400, 1343, 2.00, 0, 0, 0, ''),
(72, 71, 0, 0, 0, 12.00, 0, 3, 6, ''),
(73, 72, 0, 0, 0, 1.50, 0, 1, 8, ''),
(74, 73, 0, 0, 0, 3.00, 0, 0, 0, ''),
(75, 74, 9484970, 717853, 1288, 3.00, 20, 2, 3, ''),
(76, 75, 0, 0, 0, 1.00, 0, 8, 4, ''),
(77, 76, 0, 0, 0, 2.00, 0, 0, 0, ''),
(78, 77, 9484414, 717962, 1208, 2.00, 0, 0, 0, ''),
(79, 78, 9483966, 717096, 1287, 1.50, 0, 0, 0, ''),
(80, 79, 0, 0, 0, 1.00, 0, 0, 0, ''),
(81, 80, 9492261, 726549, 1606, 1.00, 0, 0, 0, ''),
(82, 81, 9487187, 707570, 1063, 2.95, 0, 0, 0, ''),
(83, 82, 9487189, 707560, 1076, 2.00, 0, 0, 0, ''),
(84, 83, 9469942, 726732, 1492, 5.00, 0, 0, 0, ''),
(85, 84, 9487181, 707579, 1083, 2.00, 0, 0, 0, ''),
(86, 85, 9491305, 707271, 1712, 3.50, 0, 0, 0, ''),
(87, 86, 9487189, 707560, 1080, 2.00, 0, 0, 0, ''),
(88, 87, 9475836, 702662, 1589, 15.00, 0, 3, 4, ''),
(89, 88, 9475722, 702506, 1597, 15.00, 0, 1, 1, ''),
(90, 89, 9475017, 704283, 1193, 11.00, 0, 0, 0, ''),
(91, 90, 9475769, 702921, 1556, 18.00, 0, 4, 7, ''),
(92, 91, 9474695, 703067, 1406, 86.00, 100, 3, 5, ''),
(296, 294, 9473728, 702335, 1315, 50.00, 0, 4, 7, ''),
(297, 295, 9474129, 698910, 1815, 6.00, 60, 2, 8, '');

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
) ENGINE=InnoDB AUTO_INCREMENT=309 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`id_persona`, `nombres`, `apellidos`, `codigo`, `cedula`, `celular`, `f_nacimiento`, `email`, `direccion`, `canton`, `provincia`, `foto`, `genero`) VALUES
(2, ' Baltazar Francisco', 'Alvarez Michay', NULL, 1102029814, 0, '1960-01-08', '', '', '', 'Zamora', '', ''),
(3, ' Manuela Bernarda', 'Cevallos Michay', NULL, 1900055300, 0, '1944-12-04', '', '', '', 'Zamora', '', ''),
(4, ' Angel Benigno', 'Gaona Torres', NULL, 1101903662, 0, '1956-04-19', '', '', '', 'Zamora', '', ''),
(5, ' Gloria Elisa', 'Guarinda Ceballos', NULL, 1103418503, 983520805, '1976-03-27', '', '', '', 'Zamora', '', ''),
(6, ' Cosme Gabriel', 'Merino Alvarez', NULL, 1103888911, 0, '1981-12-11', 'cmerino@apecap.org', '', '', 'Zamora', '', ''),
(7, ' Milton', 'Rosillo Troya', NULL, 1102507728, 992200071, '1966-08-26', '', '', '', 'Zamora', '', ''),
(8, ' Polidoro', 'Rosillo Troya', NULL, 1101976270, 0, '1960-08-13', '', '', '', 'Zamora', '', ''),
(9, ' Jose Vidal', 'Erazo Narvaez', NULL, 1900053875, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(10, ' Silvio', 'Diaz Zumba', NULL, 1900255447, 959500344, '1969-04-25', '', '', '', 'Zamora', '', ''),
(11, ' Juan Francisco', 'Robles Patino', NULL, 1101444469, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(12, ' Cesar Luis', 'Rosillo Troya', NULL, 1101976262, 0, '1957-05-15', '', '', '', 'Zamora', '', ''),
(13, ' Manecio Amable', 'Avila Rojas', NULL, 1900080951, 990252603, '1950-06-05', '', '', '', 'Zamora', '', ''),
(14, ' Ana Petronila', 'Alvarez Michay', NULL, 1900184951, 988734350, '1964-07-25', '', '', '', 'Zamora', '', ''),
(15, ' Juan Daniel', 'Alvarez Merino', NULL, 1900427376, 969006512, '1978-08-15', '', '', '', 'Zamora', '', ''),
(16, ' Jose Bartolo', 'Jiron Vicente', NULL, 1105143190, 0, '1989-07-25', '', '', '', 'Zamora', '', ''),
(17, ' Manuel', 'Pintado Cordero', NULL, 1103550966, 959812954, '1990-07-25', '', '', '', 'Zamora', '', ''),
(18, ' Anguisaca Zumba', 'Luis Antonio', NULL, 1103562250, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(19, '  Augusto Martin', 'Chuquimarca Chinchay', NULL, 1100839008, 994684353, '1958-12-07', '', '', '', 'Zamora', '', ''),
(20, ' Felipe Parmenio', 'Rosillo Guerrero', NULL, 1104570245, 0, '1987-04-22', '', '', '', 'Zamora', '', ''),
(21, ' Luis Matias', 'Erazo Riofrio', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(22, ' Silvio', 'Jiron Vicente', NULL, 1104884729, 0, '1987-01-01', '', '', '', 'Zamora', '', ''),
(23, ' Ilda', 'Ramon Juarez', NULL, 1101069043, 0, '1955-09-21', '', '', '', 'Zamora', '', ''),
(24, ' Nery Germania', 'Abad Jimenez', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(25, ' Luis Roberto', 'Gerrero Merino', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(26, ' Herman Segundo', 'Velez Chinchay', NULL, 1102733324, 0, '1966-02-06', '', '', '', 'Zamora', '', ''),
(27, ' Rodrigo', 'Ruiz Chugchilan', NULL, 1500902265, 0, '1988-04-19', '', '', '', 'Zamora', '', ''),
(28, ' Hermi', 'Rosales Correa', NULL, 1900221795, 0, '1964-06-07', '', '', '', 'Zamora', '', ''),
(29, ' Mario Francisco', 'Guerrero Troya', NULL, 1103191993, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(30, ' Miguel Angel', 'Torres Calle', NULL, 1102056882, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(31, ' Vidal Valentin', 'Alverca Zumba', NULL, 1103660435, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(32, ' Victoria Angelica', 'Alberca Peña', NULL, 1900558733, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(33, ' Efren', 'Alberca Jimenez', NULL, 1900092956, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(34, ' Oliveros', 'Alberca Pena', NULL, 1900402361, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(35, ' Manuel', 'Jimenez Jimenez', NULL, 1900187624, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(36, ' Domingo', 'Alvarez Pedro', NULL, 1900187624, 0, '1958-05-04', '', '', '', 'Zamora', '', ''),
(37, ' Jose Miguel', 'Arvarez Jimenez', NULL, 1900239367, 0, '1967-03-21', '', '', '', 'Zamora', '', ''),
(38, 'Geremias ', 'Alverca', NULL, 1900110576, 0, '1955-11-08', '', '', '', 'Zamora', '', ''),
(39, ' Anibal Arcenio', 'Diaz Zumba', NULL, 1900174325, 0, '1963-01-05', '', '', '', 'Zamora', '', ''),
(40, ' Darwin Marcelo', 'Diaz Jimenez', NULL, 1724016397, 0, '1989-01-16', '', '', '', 'Zamora', '', ''),
(41, ' Salvador', 'Cordero Jose', NULL, 1900255264, 0, '1968-11-28', '', '', '', 'Zamora', '', ''),
(42, ' Jose Marcos', 'Alverca Cordero', NULL, 1900797809, 0, '1994-03-07', '', '', '', 'Zamora', '', ''),
(43, ' Jose Marcial', 'Jimenez Pintado', NULL, 1101824777, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(44, ' Jose Santiago', 'Jimenez Cueva', NULL, 1101824777, 0, '1958-09-30', '', '', '', 'Zamora', '', ''),
(45, ' Francel Andres', 'Alverca Peña', NULL, 1900459908, 0, '1980-10-30', '', '', '', 'Zamora', '', ''),
(46, ' Horacio Cristobal', 'Alvarez Alvarez', NULL, 1900797331, 0, '1992-08-08', '', '', '', 'Zamora', '', ''),
(47, ' Aureliano', 'Tillaguango Calva', NULL, 1101581559, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(48, ' Instalin', 'Tamayo Castillo', NULL, 1900324714, 0, '1971-10-06', '', '', '', 'Zamora', '', ''),
(49, ' Miguel Angel', 'Abarca Aldaz', NULL, 1102831946, 0, '1969-05-25', '', '', '', 'Zamora', '', ''),
(50, ' German Enixon', 'Tillaguango Vega', NULL, 1900288497, 0, '1971-06-10', '', '', '', 'Zamora', '', ''),
(51, ' Carlos Marino', 'Correa Cumbicus', NULL, 1900322866, 0, '1976-03-26', '', '', '', 'Zamora', '', ''),
(52, ' Juan Antonio', 'Tillagungo Abad', NULL, 1104005168, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(53, ' Gilber Efren', 'Abarca Aldaz', NULL, 1103725923, 0, '1975-07-16', '', '', '', 'Zamora', '', ''),
(54, ' Jimenez Jimenez', 'Elsa Natalia', NULL, 1103411888, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(55, ' Jose Moises', 'Jaramillo Carrion', NULL, 1103481311, 0, '1973-10-26', '', '', '', 'Zamora', '', ''),
(56, ' Maria Lastenia', 'Tamayo Castillo', NULL, 0, 0, '1985-08-11', '', '', '', 'Zamora', '', ''),
(57, ' Nidia Esperanza', 'Tillaguango Pintado', NULL, 1900585504, 0, '1985-12-11', '', '', '', 'Zamora', '', ''),
(58, ' Sergio Feliciano', 'Tillaguango Pintado', NULL, 1900305382, 0, '1974-11-01', '', '', '', 'Zamora', '', ''),
(59, ' Jiose Luis', 'Guayanay Masache', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(60, ' Marcela Eloisa', 'Tillaguango Pintado', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(61, ' Fernando', 'Abad Jimenez', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(62, ' Victor Manuel', 'Calva Pintado', NULL, 1102927322, 0, '1987-02-20', '', '', '', 'Zamora', '', ''),
(63, ' Olivio', 'Gaona Abad', NULL, 1900265537, 0, '1971-12-10', '', '', '', 'Zamora', '', ''),
(64, ' Gerardo Florentino', 'Salinas Castillo', NULL, 1900196930, 0, '1960-10-16', '', '', '', 'Zamora', '', ''),
(65, ' Hipolito', 'Salinas Castillo', NULL, 1900093244, 0, '1949-08-08', '', '', '', 'Zamora', '', ''),
(66, ' Segundo Ramon', 'Salinas Castillo', NULL, 1900159144, 0, '1962-10-17', '', '', '', 'Zamora', '', ''),
(67, ' Josefino De Jesus', 'Suarez Bravo', NULL, 1103208110, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(68, ' Gaona Castillo', 'Vilma Francisca', NULL, 1105101149, 0, '1991-07-24', '', '', '', 'Zamora', '', ''),
(69, ' Indalecio', 'Abad Abad', '', 1104518863, 0, '1981-01-29', '', '', '', 'Zamora', '', 'm'),
(70, ' Segundo Aurelio', 'Calva Abad', NULL, 1900255355, 0, '1963-11-16', '', '', '', 'Zamora', '', ''),
(71, ' Jose Marcial', 'Abad Pintado', NULL, 1900324615, 0, '1973-04-15', '', '', '', 'Zamora', '', ''),
(72, ' Simon Bolivar', 'Gaona Calva', NULL, 1103147862, 0, '1971-10-08', '', '', '', 'Zamora', '', ''),
(73, ' Bolivar', 'Gaona Jose', NULL, 1103596362, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(74, ' Francisco Eleodoro', 'Salinas Gaona', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(75, ' Norverto', 'Requelme Campoverde', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(76, ' Luis Celestin', 'Salinas Gaona', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(77, ' Jose Miguel', 'Jimenez Abad', NULL, 1105637357, 0, '1991-06-12', '', '', '', 'Zamora', '', ''),
(78, ' Olivio Ramiro', 'Ortiz Salinas', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(79, ' Juan Oswaldo', 'Gaona Reinoso', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(80, ' Jose Vicente', 'Abad Troya', NULL, 1900315639, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(81, ' Jose Benecio', 'Tamayo Gaona', NULL, 1103649412, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(82, ' Dixon Francel', 'Pardo Tamayo', NULL, 1103924138, 0, '1980-04-23', '', '', '', 'Zamora', '', ''),
(83, ' Jose Fredy', 'Jimenez Minga', NULL, 1900323864, 0, '1975-01-25', '', '', '', 'Zamora', '', ''),
(84, ' Roberto', 'Tamayo Moreno', NULL, 1102252457, 0, '1959-05-13', '', '', '', 'Zamora', '', ''),
(85, ' Froilan Heriberto', 'Perez Pardo', NULL, 1900655919, 0, '1990-05-31', '', '', '', 'Zamora', '', ''),
(86, ' Agustin Camilo', 'Tamayo Jiron', NULL, 1104293012, 0, '1981-11-01', '', '', '', 'Zamora', '', ''),
(87, ' Lola Esperanza', 'Pardo Tamayo', NULL, 1900444413, 0, '1981-08-05', '', '', '', 'Zamora', '', ''),
(88, ' Manuel Francisco', 'Cordero Alverca', NULL, 1900323252, 0, '1975-04-07', '', '', '', 'Zamora', '', ''),
(89, ' Luz Del Carmen', 'Alverca Castillo', NULL, 1100497534, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(90, ' Pedro Julio', 'Escobar Vicente', NULL, 1101951059, 0, '1957-07-07', '', '', '', 'Zamora', '', ''),
(91, ' Cesar Manuel', 'Jimenez Giron', NULL, 1102652078, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(92, ' Segundo Eduardo', 'Jimenez Abad', NULL, 1900182724, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(93, ' Teodoro', 'Calva Guayanay', NULL, 1101974630, 0, '1960-09-08', '', '', '', 'Zamora', '', ''),
(94, ' Fausto', 'Calva Castillo', NULL, 1900239862, 0, '1969-10-03', '', '', '', 'Zamora', '', ''),
(95, ' Luis', 'Giron Jimenez', NULL, 1102083068, 0, '1962-08-15', '', '', '', 'Zamora', '', ''),
(96, ' Manuel Arnoldo', 'Giron Salazar', NULL, 1100531092, 0, '1942-12-15', '', '', '', 'Zamora', '', ''),
(97, ' Jose Ambrocio', 'Jimenez Jimenez', NULL, 1900055953, 0, '1934-01-08', '', '', '', 'Zamora', '', ''),
(98, ' Maria Esthela', 'Jimenez Gonzaga', NULL, 1900239854, 0, '1971-11-06', '', '', '', 'Zamora', '', ''),
(99, ' Gonzaga', 'Miguel Angeljimenez', NULL, 1900093335, 0, '1940-03-13', '', '', '', 'Zamora', '', ''),
(100, ' Onecimo', 'Jimenez Manuel', NULL, 1900122423, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(101, ' Angel Miguel', 'Giron Jimenez', NULL, 1102079418, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(102, ' Manuel Fernando', 'Jimenez Gaona', NULL, 1103042485, 0, '1972-04-24', '', '', '', 'Zamora', '', ''),
(103, ' Jose Cesario', 'Giron Jimenez', NULL, 1900098581, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(104, 'Margarita', 'Salazar', NULL, 1103111199, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(105, ' Jose Librando', 'Jimenez Merino', NULL, 1102227632, 0, '1960-12-12', '', '', '', 'Zamora', '', ''),
(106, ' Jesus Amable', 'Alberca Zumba', NULL, 1900194927, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(107, ' Octaviano', 'Alverca Troya', NULL, 1900203439, 0, '1962-05-25', '', '', '', 'Zamora', '', ''),
(108, ' Gabriel', 'Alverca Troya', NULL, 1900202738, 0, '1965-06-19', '', '', '', 'Zamora', '', ''),
(109, ' Marco Jose', 'Benavidez Romero', NULL, 1900443209, 0, '1981-11-05', '', '', '', 'Zamora', '', ''),
(110, ' Juan Jose', 'Alverca Abad', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(111, ' Juan Angel', 'Alejo Gonzaga', NULL, 1104173883, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(112, ' Julio Orlando', 'Avila Torres', NULL, 1103101430, 0, '1968-02-19', '', '', '', 'Zamora', '', ''),
(113, ' Franco Efrain', 'Avila Torres', NULL, 1102890397, 0, '1963-07-23', '', '', '', 'Zamora', '', ''),
(114, ' Juan Bartolo', 'Castillo Jimenez', NULL, 1900092790, 0, '1954-08-24', '', '', '', 'Zamora', '', ''),
(115, ' Gonzalo', 'Castillo Jimenez', NULL, 1102976576, 0, '1971-02-21', '', '', '', 'Zamora', '', ''),
(116, ' Jose Vicente', 'Calva Jimenez', NULL, 1100514700, 0, '1944-12-28', '', '', '', 'Zamora', '', ''),
(117, ' Lucia Marlene', 'Calva Paccha', NULL, 1103515308, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(118, ' Angel Servilio', 'Calva Paccha', NULL, 1103155402, 0, '1970-07-04', '', '', '', 'Zamora', '', ''),
(119, ' Juan Ramon', 'Calva Paccha', NULL, 1102659305, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(120, ' Julio Orlando', 'Calva Paccha', NULL, 1103276232, 0, '1972-05-24', '', '', '', 'Zamora', '', ''),
(121, ' Juan Vicente', 'Jimenez Avila', NULL, 1900054857, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(122, ' Jose Juaquin', 'Pacha Villalta', NULL, 1103110621, 0, '1971-05-03', '', '', '', 'Zamora', '', ''),
(123, ' Jose Antonio', 'Reyes Merino', NULL, 1714661251, 0, '1982-06-05', '', '', '', 'Zamora', '', ''),
(124, ' Vitaliano Efrain', 'Sanchez Paccha', NULL, 1900201045, 0, '1966-01-27', '', '', '', 'Zamora', '', ''),
(125, ' Jose Maria', 'Sanchez Chinchay', NULL, 1900054790, 0, '1943-10-01', '', '', '', 'Zamora', '', ''),
(126, ' Angel Polivio', 'Avila Torres', NULL, 1708544224, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(127, ' Ronald Ivan', 'Rodriguez Lima', NULL, 1104563448, 0, '1986-03-27', '', '', '', 'Zamora', '', ''),
(128, ' Rosa Esperanza', 'Abad Villalta', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(129, ' Luz Maria', 'Jimenez Castillo', NULL, 1104281124, 0, '1985-09-27', '', '', '', 'Zamora', '', ''),
(130, ' Vicente Polivio', 'Jimenez Castillo', NULL, 1708544224, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(131, ' Rosa Del Carmen', 'Sanchez Avila', NULL, 1716741507, 0, '1982-05-14', '', '', '', 'Zamora', '', ''),
(132, ' Rosela Marujita', 'Calva Paccha', NULL, 1103412290, 0, '1974-08-14', '', '', '', 'Zamora', '', ''),
(133, ' Maria Carmen', 'Calva Paccha', NULL, 1103844344, 0, '1981-04-14', '', '', '', 'Zamora', '', ''),
(134, ' Elvia Maruja', 'Jimenez Castillo', NULL, 1900380815, 0, '1980-03-01', '', '', '', 'Zamora', '', ''),
(135, ' Felizino', 'Lima Darwin', NULL, 1104037443, 0, '1982-12-26', '', '', '', 'Zamora', '', ''),
(136, ' Maria Graciela', 'Troya Paccha', NULL, 1103182224, 0, '1968-01-20', '', '', '', 'Zamora', '', ''),
(137, ' Jose Bolivar', 'Malacatus Chainchay', NULL, 1103576995, 0, '1966-02-17', '', '', '', 'Zamora', '', ''),
(138, ' Luis Jaime', 'Castillo Jimenez', NULL, 110399819, 0, '1980-11-03', '', '', '', 'Zamora', '', ''),
(139, ' Jose Antonio', 'Armijos Patino', NULL, 1900199918, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(140, ' Telmo Camilo', 'Luzuriaga Maza', NULL, 1900465335, 0, '1982-02-17', '', '', '', 'Zamora', '', ''),
(141, ' Jorge', 'Granda Quinche', NULL, 1900055441, 0, '1947-06-22', '', '', '', 'Zamora', '', ''),
(142, ' Jose Efredin', 'Sanches Troya', NULL, 1900278795, 0, '1968-08-01', '', '', '', 'Zamora', '', ''),
(143, ' Domingo Santiago', 'Lojan Zumba', NULL, 1102372529, 0, '1962-05-12', '', '', '', 'Zamora', '', ''),
(144, ' Chuquiguanca Gonzaga', 'Luis Martin', NULL, 1102880372, 0, '1969-03-28', '', '', '', 'Zamora', '', ''),
(145, ' Jose Benito', 'Pizarro Jimenez', NULL, 1900200690, 0, '1965-12-06', '', '', '', 'Zamora', '', ''),
(146, ' Patricia Yolanda', 'Gaona Villalta', NULL, 1103513907, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(147, ' Camilo Jacobo', 'Castillo Guarnizo', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(148, ' Carlos Mayco', 'Reinoso Capa', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(149, ' Jose Benito', 'Chuquiguanca Calva', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(150, ' Arcelio', 'Avila Jose', NULL, 1900348127, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(151, 'Benito', 'Luzuriga', NULL, 1104640618, 0, '1986-09-01', '', '', '', 'Zamora', '', ''),
(152, ' Henry Jose', 'Romero Puzma', NULL, 1900258797, 0, '1968-01-10', '', '', '', 'Zamora', '', ''),
(153, ' Bayron Enrrique', 'Avila Torres', NULL, 1104923386, 0, '1988-07-13', '', '', '', 'Zamora', '', ''),
(154, ' Andres Marcelino', 'Cuenca Avila', NULL, 1103213534, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(155, ' Victor Alonzo', 'Jimenez Merino', NULL, 1900066067, 0, '1974-10-03', '', '', '', 'Zamora', '', ''),
(156, 'Andres ', 'Luzuriaga', NULL, 1900751098, 0, '1990-04-05', '', '', '', 'Zamora', '', ''),
(157, ' Gabriel', 'Garrido Ordoñez', NULL, 1900055516, 0, '1944-09-16', '', '', '', 'Zamora', '', ''),
(158, ' Alejandro Francisco', 'Ávila Jiménez', NULL, 1104625981, 0, '1985-05-17', '', '', '', 'Zamora', '', ''),
(159, ' Samuel Francisco', 'Abad Pintado', NULL, 1104069263, 0, '1977-05-18', '', '', '', 'Zamora', '', ''),
(160, ' Luis Alberto', 'Garrido Flores', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(161, ' Francisco Ramon', 'Abad Gaona', NULL, 1105845133, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(162, ' Hortencio', 'Abad Troya', NULL, 1104982739, 0, '1981-07-07', '', '', '', 'Zamora', '', ''),
(163, ' Alfredo Daniel', 'Castillo Tamay', NULL, 1103423917, 0, '1976-12-07', '', '', '', 'Zamora', '', ''),
(164, ' Milton Noe', 'Garcia Abad', NULL, 1104665722, 0, '1985-12-14', '', '', '', 'Zamora', '', ''),
(165, ' Luis Reinaldo', 'Abad Troya', NULL, 1900543735, 0, '1983-04-15', '', '', '', 'Zamora', '', ''),
(166, ' Abraham Eduardo', 'Castillo Avila', NULL, 1900601236, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(167, ' Nelson Darwin', 'Rodriguez Reinosa', NULL, 1900595586, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(168, ' Danilo', 'Abad Troya', NULL, 1104666753, 0, '1986-06-06', '', '', '', 'Zamora', '', ''),
(169, ' Elkin Abad', 'Abad Troya', NULL, 1900842525, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(170, ' Germania Piedad', 'Abad Troya', NULL, 1104887250, 0, '1984-06-21', '', '', '', 'Zamora', '', ''),
(171, ' Jose Francisco', 'Abad Troya', NULL, 1104925787, 0, '1988-09-20', '', '', '', 'Zamora', '', ''),
(172, ' Juan Servilio', 'Abad Troya', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(173, ' Crimildo', 'Abad Troya', NULL, 1104666746, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(174, ' Bolivar', 'Troya Manuel', NULL, 1102997168, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(175, ' Rosana Ecliceria', 'Jaramillo Tamay', NULL, 1101914875, 0, '1945-05-13', '', '', '', 'Zamora', '', ''),
(176, ' Segundo Gilberto', 'Capa Cueva', NULL, 1102183637, 0, '1959-09-16', '', '', '', 'Zamora', '', ''),
(177, ' Maria Cecilia', 'Arevalo Acaro', NULL, 1900093459, 0, '1953-12-22', '', '', '', 'Zamora', '', ''),
(178, ' Hugo Homero', 'Ramon Capa', NULL, 1900081090, 0, '1950-09-22', '', '', '', 'Zamora', '', ''),
(179, ' Leticia Lidia', 'Castillo Bravo', NULL, 1900199728, 0, '1965-03-27', '', '', '', 'Zamora', '', ''),
(180, ' Elvia Graciela', 'Iñiguez Tamay', NULL, 1100662459, 0, '1950-03-29', '', '', '', 'Zamora', '', ''),
(181, ' Raquel Cumanda', 'Carrion Jaramillo', NULL, 1103269443, 0, '1972-02-12', '', '', '', 'Zamora', '', ''),
(182, ' Luciano', 'Lojan Zumba', NULL, 1101864161, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(183, ' Carlos', 'Minga Sanchez', NULL, 1102564331, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(184, ' Ramon Castillo', 'Diomer Jovani', NULL, 1717738304, 0, '1982-10-22', '', '', '', 'Zamora', '', ''),
(185, ' Luisa Amada', 'Giron Guerrero', NULL, 1102415195, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(186, ' Ismenia', 'Herrera Monica', NULL, 1900550649, 0, '1985-12-01', '', '', '', 'Zamora', '', ''),
(187, ' Michael', 'Tilden Marsh', NULL, 1750869008, 0, '1951-11-04', '', '', '', 'Zamora', '', ''),
(188, ' Aureliano', 'Alvarez Cordero', NULL, 1100561305, 0, '1951-04-23', '', '', '', 'Zamora', '', ''),
(189, ' Angel', 'Alvarez Guerrero', NULL, 1103276596, 0, '1974-04-25', '', '', '', 'Zamora', '', ''),
(190, ' Jose Lorenzo', 'Alvarez Guerrero', NULL, 1900457449, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(191, ' Pedro Antonio', 'Alvarez Guerrero', NULL, 1103276570, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(192, ' Hermelinda', 'Guerrero Pintado', NULL, 1102254909, 0, '1959-10-17', '', '', '', 'Zamora', '', ''),
(193, ' Jose Esteban', 'Pintado Alvarez', NULL, 1102114962, 0, '1961-08-03', '', '', '', 'Zamora', '', ''),
(194, ' Santos Nolberto', 'Zumba Diaz', NULL, 1900211259, 0, '1965-06-06', '', '', '', 'Zamora', '', ''),
(195, ' Rosa Elvira', 'Abad Jimenez', NULL, 1100534526, 0, '1946-12-15', '', '', '', 'Zamora', '', 'f'),
(196, ' Jose Isrrael', 'Jimenez Guayanay', NULL, 701735615, 0, '1962-10-06', '', '', '', 'Zamora', '', ''),
(197, ' Teresa Dolores', 'Jimenez Anguisaca', NULL, 1900200989, 0, '1968-11-25', '', '', '', 'Zamora', '', ''),
(198, ' Milton Vidal', 'Guerrero Pintado', NULL, 1102745815, 0, '1966-01-21', '', '', '', 'Zamora', '', ''),
(199, ' Veronica Lucia', 'Jimenez Anguiazaca', NULL, 1103232367, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(200, '  Luis Francisco', 'Alvarez Anguisaca', NULL, 1104549181, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(201, ' Segundo Isaias', 'Paccha Troya', NULL, 1100756954, 0, '1953-04-15', '', '', '', 'Zamora', '', ''),
(202, ' Melecio Teodomiro', 'Merino Sarango', NULL, 1102316666, 0, '1968-07-16', '', '', '', 'Zamora', '', ''),
(203, ' Sergio Bolivar', 'Troya Paccha', NULL, 1102716832, 0, '1964-04-18', '', '', '', 'Zamora', '', ''),
(204, ' Celiano Manuel', 'Jimenez Merino', NULL, 1101591640, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(205, ' Angel Arcivar', 'Merino Sarango', NULL, 1102316765, 0, '1960-02-08', '', '', '', 'Zamora', '', ''),
(206, ' Diego Jaime', 'Paccha Jimenez', NULL, 1900635150, 0, '1987-01-17', '', '', '', 'Zamora', '', ''),
(207, ' Silvia Vicenta', 'Giron Merino', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(208, ' Maria Elizabeth', 'Merino Alvarez', NULL, 1104446875, 0, '1987-07-07', '', '', '', 'Zamora', '', ''),
(209, ' Gloria Hermandina', 'Ontaneda Castillo', NULL, 1101497608, 0, '1953-04-12', '', '', '', 'Zamora', '', ''),
(210, ' Luis Antonio', 'Garcia Jimenez', NULL, 1101566766, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(211, ' Hector Eduardo', 'Cumbicus Jimenez', NULL, 1101783452, 0, '1953-08-19', '', '', '', 'Zamora', '', ''),
(212, ' Arnoldo', 'Jimenez Alvarez', NULL, 1101933909, 0, '1957-06-15', '', '', '', 'Zamora', '', ''),
(213, ' Cosme Efrain', 'Rosales Rosillo', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(214, ' Francisco Alfredo', 'Salazar Salinas', NULL, 1900190693, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(215, ' Jose Ildibrando', 'Gaona Villalta', NULL, 1900391085, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(216, ' Carlos', 'Guayanay Jimenez', NULL, 1900170539, 0, '1958-06-24', '', '', '', 'Zamora', '', ''),
(217, ' Juan Carlos', 'Tamayo Rosillo', NULL, 1103419667, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(218, ' Dalton Alexander', 'Tamayo Rosillo', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(219, ' Elsa Dolores', 'Soto Jaramillo', NULL, 1900260017, 0, '1971-11-04', '', '', '', 'Zamora', '', ''),
(220, ' Sabulon', 'Garcia Jimenez', NULL, 1900081140, 0, '1944-10-29', '', '', '', 'Zamora', '', ''),
(221, ' Melecio', 'Rosillo Calva', NULL, 1707851679, 0, '1963-04-15', '', '', '', 'Zamora', '', ''),
(222, ' Angel Dionicio', 'Garrido Jimenez', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(223, ' Guilo Romel', 'Herrera Encarnacion', NULL, 1900459312, 0, '1981-06-08', '', '', '', 'Zamora', '', ''),
(224, ' Blanca Enid', 'Herrera Encarnacion', NULL, 1900174838, 0, '1962-05-12', '', '', '', 'Zamora', '', ''),
(225, ' Henrry Paul', 'Avila Alvarez', NULL, 1104892599, 0, '1992-09-24', '', '', '', 'Zamora', '', ''),
(226, ' German Gilberto', 'Reinoso Rengel', NULL, 1103661912, 0, '1980-04-22', '', '', '', 'Zamora', '', ''),
(227, ' Mario Enrrique', 'Reinoso Rengel', NULL, 1103523369, 0, '1976-02-20', '', '', '', 'Zamora', '', ''),
(228, ' Pepe Raul', 'Rodriguez Reinoso', NULL, 1105433690, 0, '1990-09-22', '', '', '', 'Zamora', '', ''),
(229, ' Luis Esteban', 'Avila Rojas', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(230, ' Pablo Vinicio', 'Soto Chamba', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(231, ' Rita Maribel', 'Salazar Minga', NULL, 1900723790, 0, '1991-03-05', '', '', '', 'Zamora', '', ''),
(232, ' Edghar', 'Cumbicus Salazar', NULL, 1900349505, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(233, ' Eduardo', 'Jiménez Ordoñez', NULL, 1103537443, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(234, ' Diego Agustin', 'Castillo Jiménez', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(235, ' Sergio David', 'Abad Jimenez', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(236, ' Denis Sebastian', 'Abad Mendoza', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(237, ' Luis Antonio', 'Jimenez Gaona', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(238, ' Jose Florentino', 'Avila Avila', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(239, ' Jose Isaias', 'Puchaicela Angamarca', NULL, 1104111669, 0, '1982-09-06', '', '', '', 'Zamora', '', ''),
(240, ' Miguel Francisco', 'Abad Flores', NULL, 1900150846, 0, '1956-09-27', '', '', '', 'Zamora', '', ''),
(241, ' Jaime Efrain', 'Jinenez Pintado', NULL, 1900533033, 0, '1984-02-05', '', '', '', 'Zamora', '', ''),
(242, ' Edgar Patricio', 'Jimenez Pintado', NULL, 1900571686, 0, '1985-06-29', '', '', '', 'Zamora', '', ''),
(243, ' Patricia Elizabeth', 'Puchaicela Angamarca', NULL, 1104180706, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(244, ' Rosa Peregrina', 'Pintado Castillo', NULL, 1102444310, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(245, ' Vicente', 'Abad Simon', NULL, 1102252010, 0, '1957-11-25', '', '', '', 'Zamora', '', ''),
(246, ' Edgar Omar', 'Morocho Angamarca', NULL, 1900547009, 0, '1983-05-24', '', '', '', 'Zamora', '', ''),
(247, ' Juan Miguel', 'Avila Ontaneda', NULL, 1900651827, 0, '1988-10-17', '', '', '', 'Zamora', '', ''),
(248, ' Francisco Antonio', 'Ontaneda Pintado', NULL, 1900872654, 0, '1994-03-26', '', '', '', 'Zamora', '', ''),
(249, ' Antonio', 'Abad Luis', NULL, 1103727481, 0, '1970-07-26', '', '', '', 'Zamora', '', ''),
(250, ' Jose Nain', 'Lalangui Chacon', NULL, 1104506462, 0, '1984-06-13', '', '', '', 'Zamora', '', ''),
(251, ' Luis', 'Jimenez Jimenez', NULL, 1102249909, 0, '1960-10-13', '', '', '', 'Zamora', '', ''),
(252, ' Jose Eduardo', 'Tocto Rivar', NULL, 1900221431, 0, '1966-11-20', '', '', '', 'Zamora', '', ''),
(253, ' Carmen Benita', 'Garrido Jimenez', NULL, 1103267082, 0, '1976-05-06', '', '', '', 'Zamora', '', ''),
(254, ' Angel Maria', 'Puchaicela Anguisaca', NULL, 1102061841, 0, '1958-07-11', '', '', '', 'Zamora', '', ''),
(255, ' Pedro Moises', 'Abad Guayanay', NULL, 1900719384, 0, '2012-11-23', '', '', '', 'Zamora', '', ''),
(256, 'Orlando Benjamin', 'Tocto Tocto', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(257, ' Jose Querubin', 'Calderon Pinta', NULL, 1708599061, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(258, ' Fabian Sebastian', 'Herrera Pinta', NULL, 1103370050, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(259, ' Segundo Jacinto', 'Herrera Pinta', NULL, 1102089131, 0, '1962-08-28', '', '', '', 'Zamora', '', ''),
(260, ' Jose Isauro', 'Herrera Pinta', NULL, 1714531314, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(261, 'Maximo', 'Luzuriga', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(262, ' Agustina Marina', 'Herrera Encarnacion', NULL, 1101805818, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(263, ' Adita Alexandra', 'Luzuriaga Herrera', NULL, 1104174451, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(264, ' Angel', 'Castillo Acaro', NULL, 1900567031, 0, '1984-08-02', '', '', '', 'Zamora', '', ''),
(265, ' Hector Manuel', 'Jimenez Jimenez', NULL, 1102120100, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(266, ' Jose', 'Tillaguango Vitaliano', NULL, 1400512008, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(267, ' Rolando', 'Jimenez Marco', NULL, 1104866998, 0, '1986-10-19', '', '', '', 'Zamora', '', ''),
(268, ' Maria Catalina', 'Garrido Jimenez', NULL, 1900360122, 0, '1978-04-29', '', '', '', 'Zamora', '', ''),
(269, ' Miguel Antonio', 'Herrera Pinta', NULL, 1103726285, 0, '1978-11-11', '', '', '', 'Zamora', '', ''),
(270, ' Juana Livia', 'Gaona Villalta', NULL, 1102010046, 0, '1960-06-16', '', '', '', 'Zamora', '', ''),
(271, ' Francisco De Jesus', 'Mendoza Granda', NULL, 1102502315, 0, '1965-09-20', '', '', '', 'Zamora', '', ''),
(272, ' Leonardo Mauricio', 'Jaramillo Mendoza', NULL, 1104390875, 0, '1984-01-29', '', '', '', 'Zamora', '', ''),
(273, 'Rosario', 'Paute', NULL, 1102181532, 0, '1961-10-21', '', '', '', 'Zamora', '', ''),
(274, ' Jose Oswaldo', 'Lanche Jara', NULL, 1102724059, 0, '1966-08-28', '', '', '', 'Zamora', '', ''),
(275, ' Carmen', 'Jaramillo Leon', NULL, 1900081454, 0, '1946-07-16', '', '', '', 'Zamora', '', ''),
(276, ' Jesus Rene', 'Mendoza Granda', NULL, 1109719355, 0, '1987-03-23', '', '', '', 'Zamora', '', ''),
(277, ' Pedro Antonio', 'Bastidas Paute', NULL, 1105104259, 0, '1989-08-20', '', '', '', 'Zamora', '', ''),
(278, '  Jimenez Jose Daniel', 'Jimenez ', NULL, 1100490265, 0, '1944-04-08', '', '', '', 'Zamora', '', ''),
(279, ' Jose Felix', 'Troya Gordillo', NULL, 1900185131, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(280, ' Paul Norlander', 'Zumba Avila', NULL, 1900525310, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(281, ' Ilvar Rodrigo', 'Zumba Avila', NULL, 1900525328, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(282, ' Claudio Edgar', 'Zumba Zumba', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(283, ' Santiago', 'Giron Angel', NULL, 1104039761, 0, '1981-11-15', '', '', '', 'Zamora', '', ''),
(284, ' Marcelo Miguel', 'Garrido Hidalgo', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(285, ' Rodrigo Efrain', 'Abad Jaramillo', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(286, ' Luis Felipe', 'Abad Flores', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', 'm'),
(287, ' Roberto Miguel', 'Salazar Ortiz', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(288, ' Oswaldo Marcelo', 'Jimenez Gonzaga', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(289, ' Melecio Mauricio', 'Mayo Hidalgo', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(290, ' Wuilman Efren', 'Mayo Hidalgo', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(291, ' Bolivar', 'Merino Escobar', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(292, ' Artimidoro', 'Merino Escobar', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(293, ' Carlos Napoleon', 'Mayo Hidalgo', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(294, ' Ilda Maria', 'Mayo Hidalgo', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(295, ' David Rodrigo', 'Chamba Escobar', NULL, 0, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(296, ' Jose Maria', 'Mayo Hidalgo', NULL, 1103170294, 0, '1972-09-01', '', '', '', 'Zamora', '', ''),
(297, ' Juan Manuel', 'Chamba Escobar', NULL, 1104291990, 0, '1983-04-20', '', '', '', 'Zamora', '', ''),
(298, ' Cesar Vitaliano', 'Chamba Arevalo', NULL, 1101800363, 0, '0000-00-00', '', '', '', 'Zamora', '', ''),
(299, ' Efrain', 'Abad Marco', NULL, 2100329677, 0, '1979-12-06', '', '', '', 'Zamora', '', ''),
(300, 'Juan', 'Hartman Merino', NULL, 0, 0, '0000-00-00', '', '', 'Zamora', 'Zamora', '', 'm'),
(301, 'Gilver', 'Rosillo', NULL, 0, 0, '0000-00-00', '', '', 'Zamora', 'Zamora', '', 'm'),
(302, 'Harvey', 'Merino', NULL, 0, 0, '0000-00-00', '', '', 'Zamora', 'Zamora', '', 'm'),
(303, 'Manuel', 'Tillaguango', NULL, 0, 0, '0000-00-00', '', '', 'Zamora', 'Zamora', '', 'm'),
(304, 'Jose', 'Cueva', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(308, 'nuevo', 'nuevo', 'EL62', 1121, 0, '2000-01-12', '', '', '', '', NULL, 'm');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socios`
--

CREATE TABLE IF NOT EXISTS `socios` (
`id_socio` int(11) NOT NULL,
  `id_grupo` int(11) DEFAULT NULL,
  `id_persona` int(11) DEFAULT NULL,
  `codigo` text COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=307 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `socios`
--

INSERT INTO `socios` (`id_socio`, `id_grupo`, `id_persona`, `codigo`) VALUES
(1, 2, 2, 'AN01'),
(2, 2, 3, 'AN04'),
(3, 2, 4, 'AN05'),
(4, 2, 5, 'AN06'),
(5, 2, 6, 'AN09'),
(6, 2, 7, 'AN13'),
(7, 2, 8, 'AN18'),
(8, 2, 9, 'AN19'),
(9, 2, 10, 'AN21'),
(10, 2, 11, 'AN22'),
(11, 2, 12, 'AN24'),
(12, 2, 13, 'AN25'),
(13, 2, 14, 'AN28'),
(14, 2, 15, 'AN29'),
(15, 2, 16, 'AN30'),
(16, 2, 17, 'AN31'),
(17, 2, 18, 'AN33'),
(18, 2, 19, 'AN34'),
(19, 2, 20, 'AN37'),
(20, 2, 21, 'AN39'),
(21, 2, 22, 'AN41'),
(22, 2, 23, 'AN42'),
(23, 2, 24, 'AN43'),
(24, 2, 25, 'AN44'),
(25, 2, 26, 'AN45'),
(26, 2, 27, 'AN47'),
(27, 2, 28, 'AN48'),
(28, 2, 29, 'AN49'),
(29, 2, 30, 'AN51'),
(30, 2, 31, 'AN52'),
(31, 3, 32, 'AD01'),
(32, 3, 33, 'AD02'),
(33, 3, 34, 'AD03'),
(34, 3, 35, 'AD06'),
(35, 3, 36, 'AD07'),
(36, 3, 37, 'AD09'),
(37, 3, 38, 'AD11'),
(38, 3, 39, 'AD14'),
(39, 3, 40, 'AD15'),
(40, 3, 41, 'AD16'),
(41, 3, 42, 'AD17'),
(42, 3, 43, 'AD18'),
(43, 3, 44, 'AD19'),
(44, 3, 45, 'AD20'),
(45, 3, 46, 'AD21'),
(46, 4, 47, 'CA01'),
(47, 4, 48, 'CA06'),
(48, 4, 49, 'CA07'),
(49, 4, 50, 'CA08'),
(50, 4, 51, 'CA09'),
(51, 4, 52, 'CA10'),
(52, 4, 53, 'CA11'),
(53, 4, 54, 'CA12'),
(54, 4, 55, 'CA14'),
(55, 4, 56, 'CA15'),
(56, 4, 57, 'CA16'),
(57, 4, 58, 'CA17'),
(58, 4, 59, 'CA18'),
(59, 4, 60, 'CA19'),
(60, 5, 61, 'CU01'),
(61, 5, 62, 'CU04'),
(62, 5, 63, 'CU05'),
(63, 5, 64, 'CU13'),
(64, 5, 65, 'CU14'),
(65, 5, 66, 'CU15'),
(66, 5, 67, 'CU17'),
(67, 5, 68, 'CU19'),
(68, 5, 69, 'CU20'),
(69, 5, 70, 'CU21'),
(70, 5, 71, 'CU22'),
(71, 5, 72, 'CU23'),
(72, 5, 73, 'CU24'),
(73, 5, 74, 'CU25'),
(74, 5, 75, 'CU26'),
(75, 5, 76, 'CU27'),
(76, 5, 77, 'CU28'),
(77, 5, 78, 'CU29'),
(78, 5, 79, 'CU30'),
(79, 5, 80, 'CU31'),
(80, 7, 81, 'LM07'),
(81, 7, 82, 'LM01'),
(82, 7, 83, 'LM02'),
(83, 7, 84, 'LM03'),
(84, 7, 85, 'LM04'),
(85, 7, 86, 'LM05'),
(86, 7, 87, 'LM06'),
(87, 8, 88, 'LE02'),
(88, 8, 89, 'LE03'),
(89, 8, 90, 'LE04'),
(90, 8, 91, 'LE07'),
(91, 8, 92, 'LE19'),
(92, 9, 93, 'FA12'),
(93, 9, 94, 'FA01'),
(94, 9, 95, 'FA03'),
(95, 9, 96, 'FA04'),
(96, 9, 97, 'FA07'),
(97, 9, 98, 'FA08'),
(98, 9, 99, 'FA09'),
(99, 9, 100, 'FA10'),
(100, 9, 101, 'FA14'),
(101, 9, 102, 'FA15'),
(102, 9, 103, 'FA17'),
(103, 9, 104, 'FA18'),
(104, 9, 105, 'FA19'),
(105, 10, 106, 'GM01'),
(106, 10, 107, 'GM02'),
(107, 10, 108, 'GM03'),
(108, 10, 109, 'GM05'),
(109, 10, 110, 'GM09'),
(110, 10, 111, 'GM10'),
(111, 11, 112, 'IJ02'),
(112, 11, 113, 'IJ03'),
(113, 11, 114, 'IJ05'),
(114, 11, 115, 'IJ06'),
(115, 11, 116, 'IJ07'),
(116, 11, 117, 'IJ09'),
(117, 11, 118, 'IJ10'),
(118, 11, 119, 'IJ12'),
(119, 11, 121, 'IJ15'),
(120, 11, 122, 'IJ18'),
(121, 11, 123, 'IJ19'),
(122, 11, 124, 'IJ21'),
(123, 11, 125, 'IJ22'),
(124, 11, 126, 'IJ24'),
(125, 11, 127, 'IJ31'),
(126, 11, 128, 'IJ32'),
(127, 11, 129, 'IJ34'),
(128, 11, 130, 'IJ35'),
(129, 11, 131, 'IJ36'),
(130, 11, 132, 'IJ37'),
(131, 11, 133, 'IJ38'),
(132, 11, 134, 'IJ39'),
(133, 11, 135, 'IJ40'),
(134, 11, 136, 'IJ41'),
(135, 11, 137, 'IJ42'),
(136, 11, 138, 'IJ43'),
(137, 12, 139, 'CP01'),
(138, 12, 140, 'CP06'),
(139, 12, 141, 'CP07'),
(140, 12, 142, 'CP10'),
(141, 12, 143, 'CP11'),
(142, 12, 144, 'CP18'),
(143, 12, 145, 'CP20'),
(144, 12, 146, 'CP21'),
(145, 12, 147, 'CP22'),
(146, 12, 148, 'CP24'),
(147, 12, 149, 'CP25'),
(148, 13, 150, 'LO01'),
(149, 13, 151, 'LO02'),
(150, 13, 152, 'LO03'),
(151, 13, 153, 'LO05'),
(152, 13, 154, 'LO06'),
(153, 13, 155, 'LO07'),
(154, 13, 156, 'LO08'),
(155, 13, 157, 'LO09'),
(156, 13, 158, 'LO10'),
(157, 13, 159, 'LO11'),
(158, 13, 160, 'LO12'),
(159, 14, 161, 'PC01'),
(160, 14, 162, 'PC02'),
(161, 14, 163, 'PC03'),
(162, 14, 164, 'PC04'),
(163, 14, 165, 'PC05'),
(164, 14, 166, 'PC06'),
(165, 14, 167, 'PC07'),
(166, 14, 168, 'PC10'),
(167, 14, 169, 'PC11'),
(168, 14, 170, 'PC12'),
(169, 14, 171, 'PC13'),
(170, 14, 172, 'PC14'),
(171, 14, 173, 'PC08'),
(172, 14, 174, 'PC09'),
(173, 16, 175, 'VD02'),
(174, 16, 176, 'VD05'),
(175, 16, 177, 'VD06'),
(176, 16, 178, 'VD10'),
(177, 16, 179, 'VD12'),
(178, 16, 180, 'VD14'),
(179, 16, 181, 'VD16'),
(180, 16, 182, 'VD17'),
(181, 16, 183, 'VD19'),
(182, 16, 184, 'VD20'),
(183, 16, 185, 'VD21'),
(184, 16, 186, 'VD23'),
(185, 16, 187, 'VD24'),
(186, 17, 188, 'PN03'),
(187, 17, 189, 'PN04'),
(188, 17, 190, 'PN05'),
(189, 17, 191, 'PN06'),
(190, 17, 192, 'PN07'),
(191, 17, 193, 'PN09'),
(192, 17, 194, 'PN10'),
(193, 17, 195, 'PN11'),
(194, 17, 196, 'PN12'),
(195, 17, 197, 'PN14'),
(196, 17, 198, 'PN15'),
(197, 17, 199, 'PN16'),
(198, 17, 200, 'PN18'),
(199, 11, 201, 'IJ17'),
(200, 11, 202, 'IJ25'),
(201, 11, 203, 'IJ26'),
(202, 11, 204, 'IJ29'),
(203, 11, 205, 'IJ30'),
(204, 18, 206, 'SA03'),
(205, 18, 207, 'SA04'),
(206, 18, 208, 'SA05'),
(207, 19, 209, 'SF06'),
(208, 19, 210, 'SF08'),
(209, 19, 211, 'SF09'),
(210, 19, 212, 'SF12'),
(211, 19, 213, 'SF15'),
(212, 19, 214, 'SF17'),
(213, 19, 215, 'SF20'),
(214, 19, 216, 'SF21'),
(215, 19, 217, 'SF22'),
(216, 19, 218, 'SF28'),
(217, 19, 219, 'SF29'),
(218, 19, 220, 'SF30'),
(219, 19, 221, 'SF31'),
(220, 19, 222, 'SF32'),
(221, 19, 223, 'SF33'),
(222, 19, 224, 'SF34'),
(223, 19, 225, 'SF35'),
(224, 19, 226, 'SF36'),
(225, 19, 227, 'SF37'),
(226, 19, 228, 'SF39'),
(227, 19, 229, 'SF44'),
(228, 20, 230, 'SJ10'),
(229, 19, 231, 'SF40'),
(230, 19, 232, 'SF41'),
(231, 19, 233, 'SF42'),
(232, 19, 234, 'SF43'),
(233, 19, 235, 'SF49'),
(234, 19, 236, 'SF48'),
(235, 19, 237, 'SF50'),
(236, 19, 238, 'SF51'),
(237, 20, 239, 'SJ06'),
(238, 20, 240, 'SJ01'),
(239, 20, 241, 'SJ02'),
(240, 20, 242, 'SJ03'),
(241, 20, 243, 'SJ04'),
(242, 20, 244, 'SJ05'),
(243, 20, 245, 'SJ07'),
(244, 20, 246, 'SJ09'),
(245, 20, 247, 'SJ11'),
(246, 20, 248, 'SJ12'),
(247, 20, 249, 'SJ13'),
(248, 20, 250, 'SJ14'),
(249, 19, 251, 'SF23'),
(250, 19, 252, 'SF25'),
(251, 19, 253, 'SF26'),
(252, 19, 254, 'SF27'),
(253, 20, 255, 'SJ15'),
(254, 20, 256, 'SJ16'),
(255, 21, 257, 'SM02'),
(256, 21, 258, 'SM08'),
(257, 21, 259, 'SM09'),
(258, 21, 260, 'SM10'),
(259, 21, 261, 'SM11'),
(260, 21, 262, 'SM15'),
(261, 21, 263, 'SM20'),
(262, 21, 264, 'SM24'),
(263, 21, 265, 'SM28'),
(264, 21, 266, 'SM29'),
(265, 21, 267, 'SM31'),
(266, 21, 268, 'SM33'),
(267, 21, 269, 'SM35'),
(268, 22, 270, 'TN06'),
(269, 22, 271, 'TN07'),
(270, 22, 272, 'TN11'),
(271, 22, 273, 'TN13'),
(272, 22, 274, 'TN15'),
(273, 22, 275, 'TN16'),
(274, 22, 276, 'TN17'),
(275, 22, 277, 'TN18'),
(276, 23, 278, 'VH03'),
(277, 23, 279, 'VH05'),
(278, 23, 280, 'VH11'),
(279, 23, 281, 'VH14'),
(280, 23, 282, 'VH15'),
(281, 23, 283, 'VH16'),
(282, 6, 284, 'EM01'),
(283, 6, 285, 'EM02'),
(284, 6, 286, 'EM03'),
(285, 6, 287, 'EM04'),
(286, 6, 288, 'EM05'),
(287, 15, 289, 'PP01'),
(288, 15, 290, 'PP02'),
(289, 15, 291, 'PP03'),
(290, 15, 292, 'PP04'),
(291, 15, 293, 'PP05'),
(292, 15, 294, 'PP06'),
(293, 15, 295, 'PP07'),
(294, 8, 296, 'LE18'),
(295, 8, 297, 'LE20'),
(296, 10, 298, 'GM07'),
(297, 10, 299, 'GM06'),
(298, 2, 300, 'AN55'),
(299, 2, 301, 'AN53'),
(300, 2, 302, 'AN57'),
(301, 2, 303, 'AN54'),
(302, 11, 120, 'IJ13'),
(306, 7, 308, 'EL62');

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
) ENGINE=InnoDB AUTO_INCREMENT=298 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `subparcelas`
--

INSERT INTO `subparcelas` (`id`, `id_parcela`, `superficie`, `variedad`, `variedad2`, `siembra`, `densidad`, `marco`, `hierbas`, `sombreado`, `roya`, `broca`, `ojo_pollo`, `mes_inicio_cosecha`, `duracion_cosecha`) VALUES
(1, 1, 2.00, '', '', 2005, 0, '', '', '', '', '', '', '', 0),
(2, 2, 4.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(3, 3, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(4, 4, 3.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(5, 5, 0.50, '', '', 2011, 0, '', '', '', '', '', '', '', 0),
(6, 6, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(7, 7, 6.00, '', '', 2009, 0, '', '', '', '', '', '', '', 0),
(8, 8, 1.50, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(9, 9, 2.00, '', '', 2008, 0, '', '', '', '', '', '', '', 0),
(10, 10, 2.00, '', '', 2009, 0, '', '', '', '', '', '', '', 0),
(11, 11, 2.00, '', '', 2005, 0, '', '', '', '', '', '', '', 0),
(12, 12, 2.00, '', '', 2005, 0, '', '', '', '', '', '', '', 0),
(13, 13, 3.50, '', '', 2009, 0, '', '', '', '', '', '', '', 0),
(14, 14, 2.00, '', '', 2008, 0, '', '', '', '', '', '', '', 0),
(15, 15, 2.00, '', '', 2009, 0, '', '', '', '', '', '', '', 0),
(16, 16, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(17, 17, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(18, 18, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(19, 19, 3.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(20, 20, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(21, 21, 2.00, '', '', 2009, 0, '', '', '', '', '', '', '', 0),
(22, 22, 3.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(23, 23, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(24, 24, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(25, 25, 1.00, '', '', 2010, 0, '', '', '', '', '', '', '', 0),
(26, 26, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(27, 27, 1.50, '', '', 2013, 0, '', '', '', '', '', '', '', 0),
(28, 28, 2.00, '', '', 2013, 0, '', '', '', '', '', '', '', 0),
(29, 29, 2.00, '', '', 2013, 0, '', '', '', '', '', '', '', 0),
(30, 30, 1.00, '', '', 2012, 0, '', '', '', '', '', '', '', 0),
(31, 31, 0.00, '', '', 0, 0, '', '', '', '', '', '', '', 0),
(32, 32, 0.50, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(33, 33, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(34, 34, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(35, 35, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(36, 36, 4.00, '', '', 2009, 0, '', '', '', '', '', '', '', 0),
(37, 37, 3.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(38, 38, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(39, 39, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(40, 40, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(41, 41, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(42, 42, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(43, 43, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(44, 44, 0.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(45, 45, 1.00, '', '', 2005, 0, '', '', '', '', '', '', '', 0),
(46, 46, 1.00, '', '', 2010, 0, '', '', '', '', '', '', '', 0),
(47, 47, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(48, 48, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(49, 49, 3.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(50, 50, 3.00, '', '', 2008, 0, '', '', '', '', '', '', '', 0),
(51, 51, 7.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(52, 52, 4.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(53, 53, 3.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(54, 54, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(55, 55, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(56, 56, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(57, 57, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(58, 58, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(59, 59, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(60, 60, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(61, 61, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(62, 62, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(63, 63, 1.50, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(64, 64, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(65, 65, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(66, 66, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(67, 67, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(68, 68, 4.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(69, 69, 2.00, '', '', 2008, 0, '', '', '', '', '', '', '', 0),
(70, 70, 1.00, '', '', 2011, 0, '', '', '', '', '', '', '', 0),
(71, 71, 2.00, '', '', 2003, 0, '', '', '', '', '', '', '', 0),
(72, 72, 3.00, '', '', 2005, 0, '', '', '', '', '', '', '', 0),
(73, 73, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(74, 74, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(75, 75, 3.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(76, 76, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(77, 77, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(78, 78, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(79, 79, 1.50, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(80, 80, 1.00, '', '', 2013, 0, '', '', '', '', '', '', '', 0),
(81, 81, 1.00, '', '', 2013, 0, '', '', '', '', '', '', '', 0),
(82, 82, 2.95, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(83, 83, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(84, 84, 1.00, '', '', 2014, 0, '', '', '', '', '', '', '', 0),
(85, 85, 2.00, '', '', 2014, 0, '', '', '', '', '', '', '', 0),
(86, 86, 3.50, '', '', 2014, 0, '', '', '', '', '', '', '', 0),
(87, 87, 1.50, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(88, 88, 3.00, '', '', 2010, 0, '', '', '', '', '', '', '', 0),
(89, 89, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(90, 90, 2.50, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(91, 91, 2.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(92, 92, 4.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(296, 296, 1.00, '', '', 1900, 0, '', '', '', '', '', '', '', 0),
(297, 297, 6.00, '', '', 2009, 0, '', '', '', '', '', '', '', 0);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `user`, `pass`, `id_nivel`, `id_persona`) VALUES
(1, 'admin', 'admin', 1, 304);

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
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
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
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=174;
--
-- AUTO_INCREMENT de la tabla `niveles`
--
ALTER TABLE `niveles`
MODIFY `id_niveles` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `parcelas`
--
ALTER TABLE `parcelas`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=298;
--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
MODIFY `id_persona` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=309;
--
-- AUTO_INCREMENT de la tabla `socios`
--
ALTER TABLE `socios`
MODIFY `id_socio` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=307;
--
-- AUTO_INCREMENT de la tabla `subparcelas`
--
ALTER TABLE `subparcelas`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=298;
--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
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
ADD CONSTRAINT `fk_CATA_LOTE` FOREIGN KEY (`lote`) REFERENCES `lotes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `certificacion`
--
ALTER TABLE `certificacion`
ADD CONSTRAINT `fk_SOCIO_CERTIFICACION` FOREIGN KEY (`id_socio`) REFERENCES `socios` (`id_socio`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
ADD CONSTRAINT `fk_Estimacion_socio` FOREIGN KEY (`id_socio`) REFERENCES `socios` (`id_socio`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
