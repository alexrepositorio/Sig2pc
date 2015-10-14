-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-07-2015 a las 03:03:33
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_altas_cons`(
in criterio varchar(20),
in valor varchar(20)
)
BEGIN

case criterio
	when 'socio'
	then
		SELECT id,fecha,estado FROM altas WHERE id_socio=valor;
	when 'actual'
    then
		SELECT id,fecha,estado FROM altas WHERE id_socio= valor order by fecha desc limit 1;
end case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_altas_del`(
in in_id int
)
BEGIN
DELETE FROM altas WHERE id=in_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_alta_ins`(
in in_socio int(11),
in in_estado varchar(20),
in in_fecha date
)
BEGIN

INSERT INTO altas VALUES('',
				in_socio,
				in_estado,
				in_fecha);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_analisis_cons`(
in criterio varchar(20),
in in_id int
)
BEGIN
case  criterio
when 'subparcelas'
then
	SELECT * FROM analisis WHERE id_subparcela=in_id;
when 'id'
then
	SELECT * FROM analisis WHERE id_analisis=in_id;
		
when ''
then
	SELECT * FROM analisis WHERE id_subparcela in (SELECT id FROM subparcelas WHERE id_parcela=in_id);
END case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_analisis_del`(
in in_id int(11)
)
BEGIN
	delete from analisis where id_analisis=in_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_analisis_ins`(
in in_id_subparcela int(11),
in in_fecha date,
in in_muestra int(11),
in in_submuestra int(11),
in in_estructura varchar(20),
in in_grado varchar(20),
in in_rocas int(11),
in in_rocas_size  int(11),
in in_profundidad int(11),
in in_pendiente int(11),
in in_lombrices int(11),
in in_densidad_aparente float(10,2),
in in_observaciones varchar(30),
in in_s_ph float(10,2),
in in_s_n float(10,2),
in in_s_p float(10,2),
in in_s_k float(10,2),
in in_s_ca float(10,2),
in in_s_mg float(10,2),
in in_s_mo float(10,2),
in in_s_textura varchar(20),
in in_f_n float(10,2),
in in_f_p float(10,2),
in in_f_k float(10,2)
)
BEGIN
	INSERT INTO analisis VALUES('',
		in_id_subparcela, in_fecha, in_muestra ,in_submuestra , in_estructura ,
		in_grado,in_rocas,in_rocas_size,in_profundidad,in_pendiente,
		in_lombrices,in_densidad_aparente,in_observaciones,in_s_ph,in_s_n,
		in_s_p,in_s_k,in_s_ca,in_s_mg,in_s_mo,in_s_textura,in_f_n,
        in_f_p,in_f_k );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_analisis_upd`(
in in_id_subparcela int(11),
in in_fecha date,
in in_muestra int(11),
in in_submuestra int(11),
in in_estructura varchar(20),
in in_grado varchar(20),
in in_rocas int(11),
in in_rocas_size  int(11),
in in_profundidad int(11),
in in_pendiente int(11),
in in_lombrices int(11),
in in_densidad_aparente float(10,2),
in in_observaciones varchar(30),
in in_s_ph float(10,2),
in in_s_n float(10,2),
in in_s_p float(10,2),
in in_s_k float(10,2),
in in_s_ca float(10,2),
in in_s_mg float(10,2),
in in_s_mo float(10,2),
in in_s_textura varchar(20),
in in_f_n float(10,2),
in in_f_p float(10,2),
in in_f_k float(10,2),
in in_id_analisis int(11)
)
BEGIN
	UPDATE analisis SET
				id_subparcela=in_id_subparcela,
				fecha=in_fecha,
				muestra=in_muestra,
				submuestras=in_submuestra,
				estructura=in_estructura,
				grado=in_grado,
				rocas=in_rocas,
				rocas_size=in_rocas_size ,
				profundidad=in_profundidad,
				pendiente=in_pendiente,
				lombrices=in_lombrices,
				densidad_aparente=in_densidad_aparente,
				observaciones=in_observaciones,
				s_ph=in_s_ph,
				s_n=in_s_n,
				s_p=in_s_p,
				s_k=in_s_k,
				s_ca=in_s_ca,
				s_mg=in_s_mg,
				s_mo=in_s_mo,
				s_textura=in_s_textura,
				f_n=in_f_n,
				f_p=in_f_p,
				f_k=in_f_k
				WHERE id_analisis=in_id_analisis;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_asociaciones_cons`(
in criterio varchar(20),
in in_id int
)
BEGIN
	SELECT * FROM asociaciones WHERE elemento=criterio AND subparcela_id=in_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_asociaciones_del`(
in in_id int(11)


)
BEGIN
	DELETE FROM asociaciones WHERE id=in_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_asociaciones_ins`(
in in_concepto varchar(20),
in in_valor  varchar(20),
in in_tipo varchar(20),
in in_elemento varchar(20),
in in_subparcela int(11) 

)
BEGIN
	INSERT INTO asociaciones VALUES ('',in_concepto,in_valor,in_tipo,in_elemento,in_subparcela);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_cantones_cons`(
)
BEGIN
	SELECT * FROM canton;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_catas_cons`(
in criterio varchar(20),
in valor varchar(20)
)
BEGIN
case criterio
	when 'lote'
    then
		SELECT * FROM catas where lote=valor;
	when 'id'
    then
		select * from catas where id=valor;
	when ''
    then
		select * from catas;
        
end case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_catas_del`(IN `p_id` INT(11))
BEGIN
DELETE FROM `catas`
WHERE `id` = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_catas_ins`(

 IN `p_lote` INT(11), 
IN `p_fecha` TIMESTAMP, IN `p_catador` TEXT,
 IN `p_tostado` INT(11), IN `p_fragancia` FLOAT(10,2),
 IN `p_tipo_aroma1` TEXT, IN `p_nota_aroma` TEXT,
 IN `p_sabor` FLOAT(10,2), IN `p_tipo_sabor` TEXT, 
 IN `p_nota_sabor` TEXT, IN `p_sabor_residual` FLOAT(10,2), 
 IN `p_tipo_sabor_residual` TEXT, IN `p_nota_sabor_residual` TEXT, 
 IN `p_acidez` FLOAT(10,2), IN `p_cuerpo` FLOAT(10,2), 
 IN `p_uniformidad` FLOAT(10,2), IN `p_balance` FLOAT(10,2), 
 IN `p_puntaje_catador` FLOAT(10,2), IN `p_taza_limpia` FLOAT(10,2),
 IN `p_dulzor` FLOAT(10,2), IN `p_nota_catacion` TEXT,
 IN `p_puntuacion` FLOAT(10,2), IN `p_d_fermento` INT(11),
 IN `p_d_metalico` INT(11), IN `p_d_quimico` INT(11), 
 IN `p_d_vinagre` INT(11), IN `p_d_stinker` INT(11), 
 IN `p_d_fenol` INT(11), IN `p_d_reposo` INT(11),
 IN `p_d_moho` INT(11), IN `p_d_terroso` INT(11),
 IN `p_d_extrano` INT(11), IN `p_d_sucio` INT(11),
 IN `p_d_astringente` INT(11), IN `p_d_quaquers` INT(11), 
 IN `p_dl_cereal` INT(11), IN `p_dl_fermento` INT(11), 
 IN `p_dl_reposo` INT(11), IN `p_dl_moho` INT(11), 
 IN `p_dl_astringencia` INT(11), IN `p_d_general` INT(11))
BEGIN
INSERT INTO `catas`( `lote`, `fecha`, `catador`, 
`tostado`, `fragancia`, `tipo_aroma1`, `nota_aroma`, 
`sabor`, `tipo_sabor`, `nota_sabor`, `sabor_residual`, 
`tipo_sabor_residual`, `nota_sabor_residual`, `acidez`, `cuerpo`, 
`uniformidad`, `balance`, `puntaje_catador`, `taza_limpia`, 
`dulzor`, `nota_catacion`, `puntuacion`, `d_fermento`, 
`d_metalico`, `d_quimico`, `d_vinagre`, `d_stinker`, 
`d_fenol`, `d_reposo`, `d_moho`, `d_terroso`, 
`d_extrano`, `d_sucio`, `d_astringente`, `d_quaquers`, 
`dl_cereal`, `dl_fermento`, `dl_reposo`, `dl_moho`, 
`dl_astringencia`, `d_general`) 
VALUES ( p_lote, p_fecha, p_catador, 
p_tostado, p_fragancia, p_tipo_aroma1, p_nota_aroma, 
p_sabor, p_tipo_sabor, p_nota_sabor, p_sabor_residual, 
p_tipo_sabor_residual, p_nota_sabor_residual, p_acidez, p_cuerpo, 
p_uniformidad, p_balance, p_puntaje_catador, p_taza_limpia, 
p_dulzor, p_nota_catacion, p_puntuacion, p_d_fermento, 
p_d_metalico, p_d_quimico, p_d_vinagre, p_d_stinker, 
p_d_fenol, p_d_reposo, p_d_moho, p_d_terroso, 
p_d_extrano, p_d_sucio, p_d_astringente, p_d_quaquers, 
p_dl_cereal, p_dl_fermento, p_dl_reposo, p_dl_moho, 
p_dl_astringencia, p_d_general);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_catas_upd`(
IN `p_id` INT(11), IN `p_lote` INT(11), 
IN `p_fecha` DATE, IN `p_catador` TEXT, 
IN `p_tostado` INT(11), IN `p_fragancia` FLOAT(10,2),
 IN `p_tipo_aroma1` TEXT, IN `p_nota_aroma` TEXT, 
 IN `p_sabor` FLOAT(10,2), IN `p_tipo_sabor` TEXT, 
 IN `p_nota_sabor` TEXT, IN `p_sabor_residual` FLOAT(10,2),
 IN `p_tipo_sabor_residual` TEXT, IN `p_nota_sabor_residual` TEXT,
 IN `p_acidez` FLOAT(10,2), IN `p_cuerpo` FLOAT(10,2),
 IN `p_uniformidad` FLOAT(10,2), IN `p_balance` FLOAT(10,2),
 IN `p_puntaje_catador` FLOAT(10,2), IN `p_taza_limpia` FLOAT(10,2),
 IN `p_dulzor` FLOAT(10,2), IN `p_nota_catacion` TEXT, 
 IN `p_puntuacion` FLOAT(10,2), IN `p_d_fermento` INT(11), 
 IN `p_d_metalico` INT(11), IN `p_d_quimico` INT(11), 
 IN `p_d_vinagre` INT(11), IN `p_d_stinker` INT(11), 
 IN `p_d_fenol` INT(11), IN `p_d_reposo` INT(11),
 IN `p_d_moho` INT(11), IN `p_d_terroso` INT(11), 
 IN `p_d_extrano` INT(11), IN `p_d_sucio` INT(11), 
 IN `p_d_astringente` INT(11), IN `p_d_quaquers` INT(11),
 IN `p_dl_cereal` INT(11), IN `p_dl_fermento` INT(11),
 IN `p_dl_reposo` INT(11), IN `p_dl_moho` INT(11),
 IN `p_dl_astringencia` INT(11), IN `p_d_general` INT(11))
BEGIN
UPDATE `catas` 
SET `lote` = p_lote, `fecha` = p_fecha,
 `catador` = p_catador, `tostado` = p_tostado, 
`fragancia` = p_fragancia, `tipo_aroma1` = p_tipo_aroma1, 
`nota_aroma` = p_nota_aroma, `sabor` = p_sabor, 
`tipo_sabor` = p_tipo_sabor, `nota_sabor` = p_nota_sabor,
 `sabor_residual` = p_sabor_residual, `tipo_sabor_residual` = p_tipo_sabor_residual, 
`nota_sabor_residual` = p_nota_sabor_residual, `acidez` = p_acidez,
 `cuerpo` = p_cuerpo, `uniformidad` = p_uniformidad, 
`balance` = p_balance, `puntaje_catador` = p_puntaje_catador,
 `taza_limpia` = p_taza_limpia, `dulzor` = p_dulzor, 
`nota_catacion` = p_nota_catacion, `puntuacion` = p_puntuacion,
 `d_fermento` = p_d_fermento, `d_metalico` = p_d_metalico, 
`d_quimico` = p_d_quimico, `d_vinagre` = p_d_vinagre,
 `d_stinker` = p_d_stinker, `d_fenol` = p_d_fenol, 
`d_reposo` = p_d_reposo, `d_moho` = p_d_moho,
 `d_terroso` = p_d_terroso, `d_extrano` = p_d_extrano, 
`d_sucio` = p_d_sucio, `d_astringente` = p_d_astringente,
 `d_quaquers` = p_d_quaquers, `dl_cereal` = p_dl_cereal, 
`dl_fermento` = p_dl_fermento, 
`dl_reposo` = p_dl_reposo, `dl_moho` = p_dl_moho,
 `dl_astringencia` = p_dl_astringencia, 
`d_general` = p_d_general
WHERE `id` = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_certificaciones_cons`(
in criterio varchar(20),
in in_valor INT(11)
)
BEGIN
case criterio
    when 'actual'
    then
    SELECT * FROM certificacion where id_socio=in_valor order by year desc limit 1;
    when 'socio'
    then
	SELECT * FROM certificacion WHERE id_socio=in_valor;
end case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_certificaciones_del`(
in in_id INT(11)
)
BEGIN
	DELETE FROM certificacion WHERE id=in_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_configuracion_cons`(IN criterio varchar(20),
in in_valor varchar(20)


)
BEGIN
	case criterio
		when 'parametro'
		then
			SELECT valor FROM configuracion where parametro=in_valor;
		when 'id'
        then
			SELECT * FROM configuracion where id=in_valor;
        when ''
        then
			select * from configuracion;
	end case;  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_configuracion_upd`(IN in_descripcion varchar(20),
in in_valor varchar(20),
in in_id int(11)
)
BEGIN
	update configuracion set descripcion=in_descripcion,valor=in_valor 
    where id=in_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_despachos_cons`(
in criterio varchar(20),
in valor varchar(20)
)
BEGIN
case criterio
when 'lote'
then
	SELECT despachos.id as id, 
				despachos.lote as lote, 
				despachos.fecha as fecha, 
				despachos.cantidad as cantidad, 
				despachos.envio as envio,
				envios.destino as destino 
				FROM despachos 
				INNER JOIN envios ON despachos.envio=envios.id WHERE lote=valor;
when 'id'
then 
	SELECT * FROM despachos where id=valor;
when 'envio'
then
	SELECT * FROM despachos WHERE envio=valor order by fecha desc;
when 'salidas_almacen'
then
	SELECT SUM(cantidad) as salidas FROM despachos;
end case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_despachos_del`(
in in_id int(11)
 )
BEGIN
DELETE FROM despachos WHERE id=in_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_despacho_ins`(
in in_lote int(11),
in in_fecha timestamp,
in in_cantidad float(10,2),
in in_envio int(11)

 )
BEGIN
INSERT INTO despachos(lote,fecha,cantidad,envio) VALUES(in_lote,in_fecha,in_cantidad,in_envio);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_envios_con`(
IN `criterio` VARCHAR(22), IN `post` VARCHAR(22))
    NO SQL
BEGIN
case  criterio
when ''
then
	SELECT * FROM 

envios order by fecha desc;
when 'despac'
then
	SELECT * FROM despachos WHERE envio=post order by fecha desc;
when 'editar'
then
	SELECT * FROM envios WHERE id=post order by fecha desc;
when 'fecha'
then
	SELECT * FROM envios WHERE 

date_format(fecha,'%Y-%m-%d') = post order by 

fecha desc;  
when 'fecha2'
then
	SELECT DISTINCT date_format(fecha,'%Y-%m-%d') as fecha FROM envios 	ORDER BY fecha ASC;
when 'descripcion'
then
	SELECT despachos.*, grupos.* ,persona.*, catas.puntuacion, lotes.*, socios.* FROM despachos 
			LEFT JOIN catas on despachos.lote=catas.lote 
			LEFT JOIN lotes on despachos.lote=lotes.id 
			LEFT JOIN socios on lotes.id_socio=socios.id_socio
            LEFT JOIN persona on socios.id_persona= persona.id_persona
            LEFT JOIN grupos on socios.id_grupo= grupos.id
			WHERE despachos.envio=post order by despachos.fecha desc;    
END case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_envios_con_fecha`(
IN `valor` VARCHAR(20), IN `valor2` VARCHAR(20))
BEGIN
	SELECT * FROM envios 
	 WHERE fecha between CAST(valor AS DATE) and CAST(valor2 AS DATE);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_envios_ins`(IN `in_fecha` DATETIME, IN `in_destino` VARCHAR(22), IN `in_chofer` VARCHAR(22), IN `in_responsable` VARCHAR(22))
    NO SQL
BEGIN
INSERT INTO envios(fecha,destino,chofer,responsable) VALUES(in_fecha,in_destino,in_chofer,in_responsable);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_envios_upd`(IN `fec` TIMESTAMP, IN `des` VARCHAR(22), IN `cho` VARCHAR(22), IN `res` VARCHAR(22), IN `envio` INT)
    NO SQL
BEGIN
    UPDATE envios SET
    fecha=fec,
    destino=des,
    chofer=cho,
    responsable=res
    WHERE id=envio;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_estimaciones_cons`(
in criterio varchar(10),
in in_id int(11)
)
BEGIN
case  criterio
when 'actual'
then
	SELECT * FROM estimacion where id_socio=in_id order by year desc limit 1;	
when 'listado'
then 
	SELECT estimacion.*, l.pesosum FROM estimacion
	LEFT JOIN (SELECT id_socio, date_format(fecha,'%Y') as ano, SUM(peso) as pesosum FROM lotes GROUP BY id_socio, ano) l 
	on (estimacion.id_socio=l.id_socio AND estimacion.year=l.ano) ORDER BY year desc;
		
when ''
then
	SELECT * FROM estimacion WHERE id_socio=in_id;

END case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_estimaciones_del`(

in in_id int(11)
)
BEGIN
	DELETE FROM estimacion where id=in_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_estimaciones_ins`(
in in_socio INT(11),
in in_anio int(11),
in in_estimados double(10,2),
in in_entregados double(10,2)


)
BEGIN
	INSERT INTO estimacion VALUES('',
				in_socio,
				in_anio,
				in_estimados,
				entregados);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_estimaciones_upd`(
in in_entregados INT(11),
in in_id int(11)
)
BEGIN
	UPDATE estimacion SET
				entregados=in_entregados
				WHERE id=in_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_grupos_cons`(

in criterio varchar(20),
in in_id int (11)
)
BEGIN
	case criterio
		when 'lista'
        then
			SELECT DISTINCT(grupo)  FROM grupos ORDER BY grupo ASC;
		when 'id'
        then
			SELECT * FROM grupos WHERE id=in_id;
		when ''
		then
			SELECT * FROM grupos ORDER BY grupo ASC;
	end case;
        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_grupos_del`(
in in_id int (11)
)
BEGIN
	DELETE FROM grupos WHERE id=in_id;
        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_grupos_ins`(
in in_grupo varchar(20),
in in_codigo varchar(10)
)
BEGIN
	INSERT INTO grupos(grupo,codigo_grupo)  VALUES (in_grupo,in_codigo);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_grupos_upd`(
in in_grupo varchar(20),
in in_codigo varchar(10),
in in_id int(11)
)
BEGIN
	UPDATE grupos SET grupo =in_grupo,codigo_grupo = in_codigo
    	WHERE id=in_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_historial_cons`(
in criterio varchar(20),
in valor varchar(20),
in valor2 varchar(20)
)
BEGIN
	case criterio
		when ''
        then
			SELECT * FROM historial order by fecha desc;
		when 'usuario'
		then
			SELECT * FROM historial WHERE usuario = valor order by fecha desc;
		when 'fecha'
		then
			SELECT * FROM historial 
	 WHERE fecha between CAST(valor AS DATE) and CAST(valor2 AS DATE);
            
	end case;
        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_historial_ins`(IN `usuario` VARCHAR(20), IN `accion` VARCHAR(20), IN `fecha` TIMESTAMP, IN `datos` VARCHAR(100), IN `tabla` VARCHAR(20), IN `maquina` VARCHAR(20))
    NO SQL
begin
	insert into historial(usuario, accion, fecha, datos, tabla, maquina) values (usuario, accion, fecha, datos, tabla, maquina);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_lista_usuarios_con`(IN `criterio` VARCHAR(20))
BEGIN
case  criterio
when 'altas'
then
  select u.id, u.user, nivel from usuarios as u,niveles where id_nivel=id_niveles and estado='A';
  
when 'bajas'
then
  select u.id, u.user, nivel from usuarios as u,niveles where id_nivel=id_niveles and estado='B';
when 'fecha'
then
	SELECT DISTINCT date_format(fecha,'%Y-%m-%d') as fecha 
    FROM historial ORDER BY fecha ASC;
when ''
then
	SELECT user FROM usuarios ORDER BY user ASC;
END case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_lote_cons`(
IN `criterio` VARCHAR(20), 
IN `valor` VARCHAR(20), IN `valor2` VARCHAR(20))
BEGIN
	case  criterio
when 'socio'
then
	SELECT * FROM lotes 
    WHERE id_socio = valor  
    order by fecha desc;
                
when 'localidad'
then
	SELECT * FROM lotes 
	INNER JOIN socios on lotes.id_socio=socios.id_socio 
	LEFT JOIN grupos ON grupos.id=socios.id_grupo
	where  grupo like CONCAT('%', valor, '%') 
	order by fecha desc;
    
when 'organico'
then
	SELECT Lotes.*,grupos.codigo_grupo,socios.* FROM lotes 
	INNER JOIN socios on lotes.id_socio=socios.id_socio 
	LEFT JOIN grupos ON grupos.id=socios.id_grupo
    left join certificacion on certificacion.id_socio=lotes.id_socio
	WHERE certificacion.estatus is not null
	order by fecha desc;
    
when 'no_organico'
then
	SELECT lotes.*,grupos.codigo_grupo,socios.* FROM lotes 
	INNER JOIN socios on lotes.id_socio=socios.id_socio 
	LEFT JOIN grupos ON grupos.id=socios.id_grupo
    left join certificacion on certificacion.id_socio=lotes.id_socio
	WHERE certificacion.estatus is null
	order by fecha desc;

when 'fecha'
then                
	 SELECT * FROM lotes 
	 WHERE fecha between CAST(valor AS DATE) and CAST(valor2 AS DATE);
     
when 'fecha_catas'
    then
		select * from lotes WHERE calidad='A'
        AND date_format(fecha,'%d-%m-%y') =valor
        order by fecha desc;
when 'fechas'
then                
	SELECT DISTINCT date_format(fecha,'%Y-%m-%d') as fecha
    FROM lotes 
    ORDER BY fecha ASC;  
when 'lote22'
then
	Select year into @estimadoactual 
	from estimacion where id_socio=68 order by year desc limit 1;
	SELECT * FROM lotes 
    where id_socio= valor 
    and date_format(fecha,'%Y') =@estimadoactual;
when 'pendientes'    
then 
	SELECT * FROM lotes 
    WHERE codigo_lote 
    NOT IN(SELECT lote FROM pagos) order by fecha desc;
when 'id'
then
	SELECT * FROM lotes where id=valor 
    order by fecha desc;  
when 'pagos'
then 
	SELECT lotes.*, pagos.exportable FROM lotes 
	LEFT JOIN pagos on lotes.id=pagos.lote 
	WHERE lotes.id_socio=valor 
	order by lotes.fecha asc;    
when 'pago'
then 
	SELECT * FROM lotes 
	LEFT JOIN pagos on lotes.id=pagos.lote 
	WHERE lotes.id_socio=valor 
	AND date_format(lotes.fecha,'%Y') = valor2 
	order by lotes.fecha asc;
when 'id_fecha'
then
		SELECT * FROM lotes where id_socio = valor and date_format(fecha,'%Y') = valor2;
when 'v_actuales'
then
	SELECT * FROM lotes 
	WHERE calidad='A' AND id 
	NOT IN (SELECT lote FROM catas);
when 'entradas_almacen'
then
	SELECT SUM(peso) as entradas FROM lotes;
when 'codigos'
then 
	SELECT codigo_lote FROM lotes 
    WHERE date_format(fecha,'%Y') = valor
    ORDER BY codigo_lote ASC;
when ''
then
	SELECT * FROM lotes order by fecha desc;
END case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_lote_del`(
IN in_id int(11)
)
BEGIN
	DELETE FROM lotes WHERE id=in_id;
END$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_lote_upd`(
 IN in_id int(11), 
 IN in_socio int(11) ,
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
	update lotes set
	id_socio=in_socio,
	codigo_lote=in_codigo,
	fecha=in_fecha,
	peso=in_peso,
    humedad=in_humedad,
    rto_descarte=in_rto_descarte,
    rto_exportable=in_rto_exportable,
    defecto_negro=in_defecto_negro,
    defecto_vinagre=in_defecto_vinagre,
    defecto_decolorado=in_defecto_decolorado,
    defecto_mordido=in_defecto_mordido,
    defecto_brocado=in_defecto_brocado,
    reposo=in_reposo,
    moho=in_moho,
    fermento=in_fermento,
    contaminado=in_contaminado,
    calidad=in_calidad
    where id=in_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_niveles_cons`()
BEGIN
	SELECT * FROM niveles;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_pagos_cons`(IN `criterio` VARCHAR(20), IN `valor` VARCHAR(20))
BEGIN
case criterio
when 'lote'
then
		select * from pagos where lote=valor;
when 'v_actuales'
then
	SELECT * FROM lotes WHERE id NOT IN (SELECT lote FROM pagos);
when 'pago'
	then
    SELECT * FROM pagos where id=valor;
end case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_pagos_cons_datos`(IN `criterio` VARCHAR(20))
    NO SQL
BEGIN

case  criterio
	when 'socio'
	then
    
	SELECT socios.id_socio, persona.nombres, persona.apellidos, socios.codigo, count(lotes.id_socio) FROM socios 
left join lotes on socios.id_socio=lotes.id_socio 
left join persona on socios.id_persona=persona.id_persona group by socios.id_socio ORDER BY codigo ASC;
	            
	when 'grupo'
	then
    
    SELECT grupo, codigo_grupo FROM grupos ORDER BY codigo_grupo ASC;

	when 'fecha'
	then
	
    SELECT DISTINCT date_format(fecha,'%Y-%m-%d') as fecha FROM lotes ORDER BY fecha ASC;	
					                         
	END case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pagos_cons_lotes`(IN `criterio` VARCHAR(20), IN `valor` VARCHAR(20))
BEGIN

case  criterio
	when ''
	then
	SELECT * FROM lotes order by fecha desc;
    
    when 'lote'
	then
	SELECT * FROM lotes WHERE id=valor;
	            
	when 'socio'
	then
	 
	SELECT * FROM lotes WHERE id_socio = valor order by fecha desc;

	when 'localidad'
	then
    
    SELECT * FROM lotes 
    LEFT JOIN socios on lotes.id_socio=socios.id_socio
    LEFT JOIN grupos on socios.id_grupo=grupos.id 
    WHERE grupos.grupo = valor order by fecha desc;
                    
	when 'fecha'
	then
    
    SELECT * FROM lotes WHERE date_format(fecha,'%Y-%m-%d') = valor order by fecha desc;
	 
          
	when 'pendientes'
	then               
	SELECT * FROM lotes WHERE codigo_lote NOT IN(SELECT lote FROM pagos) order by fecha desc;				
    
    when 'pago'
    then
    SELECT lotes.*, pagos.exportable FROM lotes LEFT JOIN pagos on lotes.id=pagos.lote WHERE lotes.id_socio = valor;
END case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pagos_cons_nombre_socio`(IN `id` VARCHAR(20))
BEGIN

SELECT * FROM socios 
LEFT JOIN persona on socios.id_persona=persona.id_persona
LEFT JOIN grupos on socios.id_grupo=grupos.id
WHERE socios.id_socio=id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pagos_cons_pagos`(IN `criterio` VARCHAR(20), IN `valor` VARCHAR(20))
    NO SQL
BEGIN
case  criterio
	when 'lote'
	then
	SELECT * FROM pagos where lote=valor;
    
    when 'pago'
	then
    SELECT * FROM pagos where id=valor;
END case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pagos_cons_socios`()
BEGIN

SELECT socios.id_socio, persona.nombres, persona.apellidos, socios.codigo, count(lotes.id_socio) FROM socios 
left join lotes on socios.id_socio=lotes.id_socio 
left join persona on socios.id_persona=persona.id_persona group by socios.id_socio ORDER BY codigo ASC;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_pagos_del`(IN `in_pago` VARCHAR(20))
    NO SQL
DELETE FROM pagos WHERE id=in_pago$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pagos_ins`(IN `in_codigo_lote` VARCHAR(20), IN `in_fecha` DATE, IN `in_exportable` FLOAT(10,2), IN `in_descarte` FLOAT(10,2), IN `in_fuera` FLOAT(10,2), IN `in_calidad` FLOAT(10,2), IN `in_cliente` FLOAT(10,2), IN `in_microlote` FLOAT(10,2), IN `in_tazadorada` FLOAT(10,2))
    NO SQL
BEGIN

INSERT INTO pagos (`lote`,`fecha`,`exportable`,`descarte`,`fuera`,`calidad`,`cliente`,`microlote`,`tazadorada`)
VALUES (in_codigo_lote, in_fecha, in_exportable, in_descarte, in_fuera, in_calidad, in_cliente, in_microlote, in_tazadorada);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pagos_upd`(IN `in_fecha` DATE, IN `in_exportable` FLOAT(10,2), IN `in_descarte` FLOAT(10,2), IN `in_fuera` FLOAT(10,2), IN `in_calidad` FLOAT(10,2), IN `in_cliente` FLOAT(10,2), IN `in_microlote` FLOAT(10,2), IN `in_tazadorada` FLOAT(10,2), IN `in_id` INT)
    NO SQL
BEGIN

UPDATE pagos SET
    fecha = in_fecha,
    exportable = in_exportable,
    descarte = in_descarte,
    fuera = in_fuera,
    calidad = in_calidad,
    cliente = in_cliente,
    microlote = in_microlote,
    tazadorada = in_tazadorada
    WHERE id = in_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pagos_upd_calidad`(IN `in_calidad` FLOAT(10,2), IN `in_lote` INT)
    NO SQL
BEGIN
	UPDATE pagos SET calidad = in_calidad WHERE lote = in_lote;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_parcelas_cons`(IN `criterio` VARCHAR(20), IN `valor` VARCHAR(20)
)
BEGIN
case  criterio
when 'socio'
then 
SELECT parcelas.*, SUM(subparcelas.superficie) as sup_cafe FROM parcelas 
LEFT JOIN subparcelas ON parcelas.id=subparcelas.id_parcela 
WHERE parcelas.id_socio= valor GROUP BY parcelas.id;

when 'localidad'
then
SELECT parcelas.*, SUM(subparcelas.superficie) as sup_cafe, grupos.grupo as poblacion FROM parcelas 
INNER JOIN subparcelas ON parcelas.id=subparcelas.id_parcela 
INNER JOIN socios on parcelas.id_socio=socios.id_socio
left join grupos on grupos.id=socios.id_grupo
where  grupo like CONCAT('%', valor, '%') 
and socios.id_socio is not null
GROUP BY parcelas.id;

when 'organico'

then                
SELECT parcelas.*, SUM(subparcelas.superficie) as sup_cafe FROM parcelas 
LEFT JOIN subparcelas ON parcelas.id=subparcelas.id_parcela 
LEFT JOIN (SELECT id_socio, year, estatus FROM certificacion 
WHERE year=(select max(year) from certificacion i 
where i.id_socio = certificacion.id_socio)) t on parcelas.id_socio=t.id_socio 
WHERE t.estatus like concat('%','O','%') GROUP BY parcelas.id;

when 'no_organico'
then               
SELECT parcelas.*, SUM(subparcelas.superficie) as sup_cafe FROM parcelas 
LEFT JOIN subparcelas ON parcelas.id=subparcelas.id_parcela
 LEFT JOIN (SELECT id_socio, year, estatus FROM certificacion 
 WHERE year=(select max(year) from certificacion i 
 where i.id_socio = certificacion.id_socio)) t on parcelas.id_socio=t.id_socio 
WHERE t.estatus is null GROUP BY parcelas.id;
	
when 'id_socio'
then               
SELECT * FROM parcelas where id_socio=valor; 
when 'id'
then               
SELECT * FROM parcelas where id=valor;
when 'sup_total'
then               
SELECT SUM(subparcelas.superficie) as sup_cafe FROM parcelas 
    LEFT JOIN subparcelas ON parcelas.id=subparcelas.id_parcela WHERE parcelas.id=valor;
when ''
then
	SELECT parcelas.*, SUM(subparcelas.superficie) as sup_cafe FROM parcelas 
    LEFT JOIN subparcelas ON parcelas.id=subparcelas.id_parcela 
    GROUP BY parcelas.id;
END case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_parcelas_update`(
IN in_sup_total float(10,2),
IN in_coorX int(11),
IN in_coorY int(11),
IN in_alti int(11),
IN in_id_socio int(11),
IN in_MOcontratada int(11),
IN in_MOfamiliar int(11),
IN in_Miembros_familia int(11),
IN in_riego varchar(25),
IN in_id int(11)
)
BEGIN

UPDATE parcelas SET 
                sup_total=in_sup_total,
                coorX=in_coorX,
                coorY=in_coorY,
                alti=in_alti,
                id_socio=in_id_socio,
                MOcontratada=in_MOcontratada,
                MOfamiliar=in_MOfamiliar,
                Miembros_familia=in_Miembros_familia,
                riego=in_riego
                WHERE id=in_id;   
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_parcela_ins`(
in  in_socio int(11), in in_coorX int(11),in in_coorY int(11),
in in_altitud int(11),
in in_superficie float(10,2), in in_MOcontratada int(11),
in in_Mofamiliar int(11), in in_miembros_familia int(11),
in in_riego varchar(20)
)
BEGIN

INSERT INTO parcelas(id_socio,coorX,coorY,alti,sup_total,MOcontratada,
MOfamiliar,Miembros_familia,riego) VALUES 
(in_socio,in_coorX,in_coorY,in_altitud,in_superficie,
in_Mocontratada,in_Mofamiliar,in_miembros_familia,in_riego);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_personas_cons`(
IN criterio VARCHAR(20),
IN valor varchar(30)
)
BEGIN
	case criterio
		when 'mails'
		then
			SELECT email FROM persona where email=valor;
		when ''
		then
			SELECT nombres, apellidos FROM persona ORDER BY nombres ASC;
	end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_persona_ins`(
in in_nombre varchar(20),
in in_apellido varchar(20),
in in_cedula varchar(20),
in in_celular varchar(20),
in f_nac date,
in in_mail varchar(50),
in in_direccion varchar(50),
in in_foto varchar(50),
in in_genero char(1),
in in_canton varchar(20)
)
BEGIN
	select id_canton into @cantonId from canton where canton.canton=in_canton;
 
	insert into Persona(nombres,apellidos,cedula,celular,f_nacimiento,email,direccion,foto,genero,id_canton) 
	values (in_nombre,in_apellido,in_cedula,in_celular,f_nac,in_mail,in_direccion,in_foto,
	in_genero,@cantonId);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_socio_altas`(
in in_id int
)
BEGIN
SELECT id,fecha,estado FROM altas WHERE id_socio=in_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_socio_certificar`(
 IN in_id int(11) ,
 IN in_anio int(11),
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
                group by socios.id_socio
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
                group by socios.id_socio
                order by apellidos asc;
when 'organico'
then                
 SELECT socios.id_persona as id,`nombres`, `apellidos`, `codigo`, `cedula`, `genero`,grupo,estatus as certificacion FROM
				socios
				left join persona on persona.id_persona=socios.id_persona
				left join certificacion on certificacion.id_socio=socios.id_socio
				left join grupos on grupos.id=socios.id_grupo
				where certificacion.estatus is not null
                group by socios.id_socio
	  order by apellidos asc;
when 'no_organico'
then               
SELECT socios.id_persona as id,`nombres`, `apellidos`, `codigo`, `cedula`, `genero`,grupo,estatus as certificacion FROM
				socios
				left join persona on persona.id_persona=socios.id_persona
				left join certificacion on certificacion.id_socio=socios.id_socio
				left join grupos on grupos.id=socios.id_grupo
				where certificacion.estatus is null
                group by socios.id_socio
	  order by apellidos asc;
                
when 'id'
then               
SELECT `id_socio`,`nombres`, `apellidos`, socios.codigo as codigo,canton.canton as canton,provincia.provincia as provincia, `cedula`,`celular`, `f_nacimiento`, `email`, `direccion`, `foto`, `genero`,`grupo` as poblacion FROM persona
	left join socios
	on socios.id_persona=persona.id_persona
	left join grupos
	on grupos.id=socios.id_grupo
    left join canton
    on persona.id_canton=canton.id_canton
    left join provincia
    on provincia.id_provincia=canton.id_provincia
	where socios.id_socio=valor;
when 'parcelas'
then
	SELECT socios.*,persona.apellidos,persona.nombres, COUNT(parcelas.id) as parcelas FROM socios
	LEFT JOIN parcelas on socios.id_socio=parcelas.id_socio
	LEFT JOIN persona on socios.id_persona=persona.id_persona
	GROUP BY socios.codigo ORDER BY socios.codigo;  
when 'codigos'
then
    SELECT codigo from socios;
when 'lotes'
then
    SELECT socios.*,persona.apellidos,persona.nombres, COUNT(lotes.id) as lotes FROM socios
	LEFT JOIN lotes on socios.id_socio=lotes.id_socio
	LEFT JOIN persona on socios.id_persona=persona.id_persona
	GROUP BY socios.codigo ORDER BY socios.codigo; 
    
when ''
then
	SELECT socios.id_socio as id,`nombres`, `apellidos`, socios.codigo as codigo, `cedula`, `genero`,grupo,estatus as certificacion, email FROM
				socios
				left join persona on persona.id_persona=socios.id_persona
				left join certificacion on certificacion.id_socio=socios.id_socio
				left join grupos on grupos.id=socios.id_grupo
                where socios.id_socio is not null
                group by socios.id_socio
	 		order by apellidos;
END case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_socio_estimacion`(
in in_id int(11)
)
BEGIN
SELECT id,year,estimados,entregados FROM estimacion WHERE id_socio=in_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_socio_find`(IN `id` INT)
BEGIN
SELECT `id_socio`,`nombres`, `apellidos`, socios.codigo as codigo,canton.canton as canton,provincia.provincia as provincia, `cedula`,`celular`, `f_nacimiento`, `email`, `direccion`, `genero`,`grupo` as poblacion FROM persona
	left join socios
	on socios.id_persona=persona.id_persona
	left join grupos
	on grupos.id=socios.id_grupo
    left join canton
    on persona.id_canton=canton.id_canton
    left join provincia
    on provincia.id_provincia=canton.id_provincia
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
in in_genero char(1),
in in_mail varchar(50)
)
BEGIN
	select id_canton into @cantonId from canton where canton.canton=in_canton;
  insert into Persona(nombres,apellidos,cedula,celular,f_nacimiento,email,direccion,genero,id_canton) 
  values (in_nombre,in_apellido,in_cedula,in_celular,f_nac,in_mail,in_direccion,
 in_genero,@cantonId);
  
  SELECT id into @ide from grupos where grupo=in_poblacion;
  
  select id_persona into @persona from persona where nombres=in_nombre and apellidos=in_apellido;
  
  insert into socios(id_grupo,id_persona,codigo) values (@ide,@persona,in_codigo);
  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_socio_update`(
IN `in_id` INT, 
IN `in_nombre` VARCHAR(20),
 IN `in_apellido` VARCHAR(20),
 IN `in_codigo` VARCHAR(4), 
 IN `in_cedula` VARCHAR(20), 
 IN `in_celular` VARCHAR(20), 
 IN `f_nac` DATE, 
 IN `in_direccion` VARCHAR(50), 
 IN `in_poblacion` VARCHAR(30), 
 IN `in_canton` VARCHAR(20),
 IN `in_genero` CHAR(1), IN `in_mail` VARCHAR(50))
BEGIN

select id_canton into @cantonId from canton where canton.canton=in_canton;
select id_persona into @persona from socios where socios.id_socio=in_id;
UPDATE persona SET
				nombres=in_nombre,
				apellidos=in_apellido,
				cedula=in_cedula,
				celular=in_celular,
				f_nacimiento=f_nac,
				direccion=in_direccion,
				id_canton=@cantonId,
				genero=in_genero,
                email=in_mail
			where id_persona=@persona;

SELECT id into @id from grupos where grupo=in_poblacion;            
UPDATE socios
set id_grupo=@id, codigo=in_codigo 
			where id_socio=in_id; 
            
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_subparcelas_cons`(
in criterio varchar(20),
in in_id int(11)
)
BEGIN
	case criterio
		when 'parcela'
		then
			SELECT * FROM subparcelas WHERE id_parcela=in_id;
		when 'id'
		then
			SELECT * FROM subparcelas WHERE id=in_id;
    end case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_subparcelas_del`(
IN in_id int(11)

)
BEGIN
	DELETE FROM subparcelas WHERE id=in_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_subparcelas_ins`(
in in_id_parcela int(11),
in in_superficie float(10,2),
in in_variedad varchar(20),
in in_variedad2 varchar(20),
in in_siembra int(11),
in in_densidad int(11),
in in_marco varchar(20),
in in_hierbas varchar(20),
in in_sombreado varchar(20),
in in_roya varchar(29),
in in_broca varchar(20),
in in_ojo_pollo varchar(20),
in in_mes_cosecha varchar(20),
in in_duracion_cosecha varchar(20)

)
BEGIN
	INSERT INTO subparcelas VALUES ('',
    in_id_parcela,
 in_superficie ,
 in_variedad ,
 in_variedad2 ,
in_siembra ,
 in_densidad ,
in_marco ,
in_hierbas ,
in_sombreado,
in_roya,
in_broca,
in_ojo_pollo,
in_mes_cosecha,
in_duracion_cosecha 
   );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_subparcelas_upd`(
in in_id_parcela int(11),
in in_superficie float(10,2),
in in_variedad varchar(20),
in in_variedad2 varchar(20),
in in_siembra int(11),
in in_densidad int(11),
in in_marco varchar(20),
in in_hierbas varchar(20),
in in_sombreado varchar(20),
in in_roya varchar(29),
in in_broca varchar(20),
in in_ojo_pollo varchar(20),
in in_mes_cosecha varchar(20),
in in_duracion_cosecha varchar(20),
in in_id int(11)
)
BEGIN
	UPDATE subparcelas SET 
                id_parcela=in_id_parcela,
                superficie=in_superficie,
                variedad=in_variedad,
                variedad2=in_variedad2,
                siembra=in_siembra,
                densidad=in_densidad,
                marco=in_marco,
                hierbas=in_hierbas,
                sombreado=in_sombreado,
                roya=in_roya,
                broca=in_broca ,
                ojo_pollo=in_ojo_pollo,
                mes_inicio_cosecha=in_mes_cosecha,
                duracion_cosecha=in_duracion_cosecha
                WHERE id=in_id; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_users_del`(in criterio int, IN `operacion` VARCHAR(20))
BEGIN
case  operacion
when 'altas'
then
	UPDATE usuarios SET estado='A' WHERE  id=criterio;
when 'bajas'
then
	UPDATE usuarios SET estado='B' WHERE  id=criterio;
END case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_user_update`(
IN `in_id` INT, 
IN `in_cuenta` VARCHAR(20), 
IN `in_contra` VARCHAR(20),
IN `in_nivel` VARCHAR(10)
)
BEGIN
	select id_niveles into @nivelId from niveles where niveles.nivel=in_nivel;
    UPDATE usuarios SET
				user=in_cuenta,
				pass=in_contra,
				id_nivel=@nivelId
	where id=in_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_usuarios_ins`(
in in_usuario varchar(20),
in in_contra varchar (10),
in in_nivel varchar(20),
in in_persona varchar(20)
)
BEGIN
	select id_niveles into @nivelId from niveles where niveles.nivel=in_nivel;
	
    insert into usuarios(user,pass,id_nivel,estado) 
	values (in_usuario,in_contra,@nivelId,'A');
 
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
) ENGINE=InnoDB AUTO_INCREMENT=712 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `acciones`
--

INSERT INTO `acciones` (`id`, `user`, `fecha`, `accion`) VALUES
(1, 'admin', '2014-06-04 05:24:47', 'UPDATE despachos SET\r\n				fecha=2014-06-03 19:15:52,\r\n				cantidad=3,\r\n				envio=4\r\n				WHERE id=6'),
(2, 'admin', '2014-06-04 05:24:55', 'UPDATE despachos SET\r\n				fecha=2014-06-03 19:15:52,\r\n				cantidad=3.00,\r\n				envio=2\r\n				WHERE id=6'),
(3, 'admin', '2014-06-04 05:25:28', 'UPDATE despachos SET\r\n				fecha=2014-06-03 12:20:40,\r\n				cantidad=1.5,\r\n				envio=3\r\n				WHERE id=5'),
(4, 'admin', '2014-06-04 05:25:45', 'UPDATE despachos SET\r\n				fecha=2014-06-03 12:20:40,\r\n				cantidad=2,\r\n				envio=3\r\n				WHERE id=5'),
(5, 'admin', '2014-06-04 05:26:15', 'INSERT INTO despachos VALUES(,\r\n				APC-00016-14,\r\n				2014-06-03 19:26:11,\r\n				8,\r\n				1)'),
(6, 'admin', '2014-06-04 05:26:27', 'UPDATE despachos SET\r\n				fecha=2014-06-03 12:20:40,\r\n				cantidad=1.5,\r\n				envio=3\r\n				WHERE id=5'),
(7, 'admin', '2014-06-04 14:38:26', 'UPDATE pagos SET \r\n				calidad=87 \r\n				WHERE lote=APC-00001-14'),
(8, 'admin', '2014-06-04 14:38:56', 'DELETE FROM pagos WHERE id=5'),
(9, 'admin', '2014-06-04 14:39:42', 'DELETE FROM catas WHERE lote=APC-00001-14'),
(10, 'user', '2014-06-04 14:40:14', 'INSERT INTO pagos VALUES (,\r\n				APC-00001-14,\r\n				2014-06-04 04:40:08,\r\n				234,\r\n				123,\r\n				0)'),
(11, 'admin', '2014-06-04 14:42:08', 'INSERT INTO catas VALUES (,\r\n				APC-00001-14,\r\n				2014-06-04 04:41:14,\r\n				,\r\n				5.75,\r\n				9,\r\n				Floral,\r\n				,\r\n				9.25,\r\n				Floral,\r\n				,\r\n				7.5,\r\n				Refrescante,\r\n				,\r\n				8.75,\r\n				8.75,\r\n				9,\r\n				9.75,\r\n				8.25,\r\n				9.75,\r\n				9,\r\n				,\r\n				88,\r\n				0,\r\n				1,				\r\n				0,\r\n				0,				\r\n				0,\r\n				1,				\r\n				0,\r\n				0,				\r\n				0,\r\n				0,				\r\n				0,\r\n				0,				\r\n				0,\r\n				0,				\r\n				0,\r\n				1,				\r\n				0,\r\n				1				\r\n				)'),
(12, 'user', '2014-06-04 14:42:34', 'UPDATE pagos SET \r\n				calidad=87 \r\n				WHERE lote=APC-00001-14'),
(13, 'admin', '2014-06-04 14:47:28', 'INSERT INTO usuarios VALUES(,\r\n				bodega,\r\n				bodega,\r\n				6410,\r\n				3)'),
(14, 'admin', '2014-06-04 14:47:42', 'INSERT INTO usuarios VALUES(,\r\n				cata,\r\n				cata,\r\n				3953,\r\n				5)'),
(15, 'admin', '2014-06-04 18:03:31', 'UPDATE pagos SET \r\n				fecha=2014-06-02 17:13:20,\r\n				exportable=500.00,\r\n				descarte=265.00,\r\n				calidad=56.00 \r\n				WHERE lote=APC-00006-14'),
(16, 'admin', '2014-06-04 18:08:01', 'UPDATE pagos SET \r\n				fecha=2014-06-04 04:40:08,\r\n				exportable=234.00,\r\n				descarte=123.00,\r\n				calidad= \r\n				WHERE lote=APC-00001-14'),
(17, 'admin', '2014-06-05 20:05:00', 'UPDATE socios SET \r\n				nombres= Jose Isaias,\r\n				apellidos=Puchaicela Angamarca,\r\n				cedula=1104111669,\r\n				celular=,\r\n				f_nacimiento=1982-09-06,\r\n				email=,\r\n				direccion=,\r\n				poblacion=SAN JUAN,\r\n				canton=,\r\n				codigo=SJ06,\r\n				provincia=, \r\n				genero= \r\n			where id_socio=239'),
(18, 'admin', '2014-06-05 20:11:44', 'INSERT INTO altas VALUES(,\r\n				CU20,\r\n				2014-06-05 10:11:41,\r\n				baja)'),
(19, 'admin', '2014-06-05 20:12:39', 'DELETE FROM altas WHERE id=301'),
(20, 'admin', '2014-06-05 20:17:05', 'INSERT INTO altas VALUES(,\r\n				CU20,\r\n				2014-06-05 10:17:02,\r\n				salida)'),
(21, 'admin', '2014-06-05 22:00:56', 'UPDATE socios SET \r\n				nombres= Indalecio,\r\n				apellidos=Abad Abad,\r\n				cedula=1104518863,\r\n				celular=,\r\n				f_nacimiento=1981-01-29,\r\n				direccion=,\r\n				poblacion=CUMANDA,\r\n				canton=,\r\n				codigo=CU20,\r\n				provincia=Zamora, \r\n				genero= \r\n			where id_socio=69'),
(22, 'admin', '2014-06-05 22:02:27', 'UPDATE socios SET \r\n				nombres= Indalecio,\r\n				apellidos=Abad Abad,\r\n				cedula=1104518863,\r\n				celular=,\r\n				f_nacimiento=1981-01-29,\r\n				direccion=,\r\n				poblacion=CUMANDA,\r\n				canton=,\r\n				codigo=CU20,\r\n				provincia=Zamora, \r\n				genero= \r\n			where id_socio=69'),
(23, 'admin', '2014-06-05 22:23:14', 'UPDATE lotes SET \r\n				id_socio=6,\r\n				codigo_lote=APC-00015-14,\r\n				fecha=2014-05-27 18:49:50,\r\n				peso=1.50,\r\n				humedad=12.00,\r\n				rto_pilado=85,\r\n				rto_exportable=80,\r\n				defecto_negro=56,\r\n				defecto_vinagre=45,\r\n				defecto_decolorado=12,\r\n				defecto_mordido=24,\r\n				defecto_brocado=15,\r\n				reposo=1,\r\n				moho=0,\r\n				fermento=0,\r\n				contaminado=1,\r\n				calidad=A,\r\n				apto_cata=1\r\n			where id=16'),
(24, 'admin', '2014-06-05 22:25:32', 'INSERT INTO lotes VALUES (,\r\n				32,\r\n				APC-00018-14,\r\n				2014-06-05 12:25:11,\r\n				34,\r\n				12,\r\n				34,\r\n				56,\r\n				0,\r\n				5,\r\n				0,\r\n				0,\r\n				5,\r\n				0,\r\n				1,\r\n				0,\r\n				1,\r\n				A,\r\n				0)'),
(25, 'admin', '2014-08-25 04:55:22', 'UPDATE catas SET\r\n				fecha =2014-06-03 19:08:11,\r\n				catador =yo mismo,\r\n				tostado =4,\r\n				fragancia =9.25,\r\n				tipo_aroma1 =Floral,Caramelo,\r\n				nota_aroma =hola ,\r\n				sabor =9.5,\r\n				tipo_sabor =Vainilla,\r\n				nota_sabor =holass,\r\n				sabor_residual =9.75,\r\n				tipo_sabor_residual =Refrescante,\r\n				nota_sabor_residual =fgsdfg,\r\n				acidez =9.25,\r\n				cuerpo =8.5,\r\n				uniformidad =9.75,\r\n				balance =10,\r\n				puntaje_catador =8,\r\n				taza_limpia =9.5,\r\n				dulzor =9.75,\r\n				nota_catacion =asdfsdf,\r\n				puntuacion =91.25,\r\n				d_fermento=1,\r\n				d_metalico=1,				\r\n				d_quimico=0,\r\n				d_vinagre=0,				\r\n				d_stinker=0,\r\n				d_fenol=0,				\r\n				d_reposo=0,\r\n				d_moho=0,				\r\n				d_terroso=1,\r\n				d_extrano=0,				\r\n				d_sucio=0,\r\n				d_astringente=0,				\r\n				dl_cereal=0,\r\n				dl_fermento=0,				\r\n				dl_reposo=1,\r\n				dl_moho=1,				\r\n				dl_astringencia=0,\r\n				d_general=2				\r\n				\r\n				WHERE lote=APC-00017-14'),
(26, 'admin', '2014-08-25 05:00:52', 'UPDATE catas SET\r\n				fecha =2014-06-03 19:08:11,\r\n				catador =yo mismo,\r\n				tostado =4,\r\n				fragancia =9.25,\r\n				tipo_aroma1 =Floral,Caramelo,\r\n				nota_aroma =hola ,\r\n				sabor =9.5,\r\n				tipo_sabor =Herbal,Picante,Chocolate dulce,Vainilla,\r\n				nota_sabor =holass,\r\n				sabor_residual =9.75,\r\n				tipo_sabor_residual =Refrescante,\r\n				nota_sabor_residual =fgsdfg,\r\n				acidez =9.25,\r\n				cuerpo =8.5,\r\n				uniformidad =9.75,\r\n				balance =10,\r\n				puntaje_catador =8,\r\n				taza_limpia =9.5,\r\n				dulzor =9.75,\r\n				nota_catacion =asdfsdf,\r\n				puntuacion =91.25,\r\n				d_fermento=1,\r\n				d_metalico=1,				\r\n				d_quimico=0,\r\n				d_vinagre=0,				\r\n				d_stinker=0,\r\n				d_fenol=0,				\r\n				d_reposo=0,\r\n				d_moho=0,				\r\n				d_terroso=1,\r\n				d_extrano=0,				\r\n				d_sucio=0,\r\n				d_astringente=0,				\r\n				dl_cereal=0,\r\n				dl_fermento=0,				\r\n				dl_reposo=1,\r\n				dl_moho=1,				\r\n				dl_astringencia=0,\r\n				d_general=2				\r\n				\r\n				WHERE lote=APC-00017-14'),
(27, 'admin', '2014-08-25 05:02:24', 'UPDATE catas SET\r\n				fecha =2014-06-03 19:08:11,\r\n				catador =yo mismo,\r\n				tostado =4,\r\n				fragancia =9.25,\r\n				tipo_aroma1 =Floral,Caramelo,\r\n				nota_aroma =hola ,\r\n				sabor =9.5,\r\n				tipo_sabor =Herbal,Picante,Chocolate dulce,Vainilla,\r\n				nota_sabor =holass,\r\n				sabor_residual =9.75,\r\n				tipo_sabor_residual =Refrescante,Delicado,Duro,Astringente,\r\n				nota_sabor_residual =fgsdfg,\r\n				acidez =9.25,\r\n				cuerpo =8.5,\r\n				uniformidad =9.75,\r\n				balance =10,\r\n				puntaje_catador =8,\r\n				taza_limpia =9.5,\r\n				dulzor =9.75,\r\n				nota_catacion =asdfsdf,\r\n				puntuacion =91.25,\r\n				d_fermento=1,\r\n				d_metalico=1,				\r\n				d_quimico=0,\r\n				d_vinagre=0,				\r\n				d_stinker=0,\r\n				d_fenol=0,				\r\n				d_reposo=0,\r\n				d_moho=0,				\r\n				d_terroso=1,\r\n				d_extrano=0,				\r\n				d_sucio=0,\r\n				d_astringente=0,				\r\n				dl_cereal=0,\r\n				dl_fermento=0,				\r\n				dl_reposo=1,\r\n				dl_moho=1,				\r\n				dl_astringencia=0,\r\n				d_general=2				\r\n				\r\n				WHERE lote=APC-00017-14'),
(28, 'admin', '2014-08-25 05:03:01', 'UPDATE catas SET\r\n				fecha =2014-06-03 19:08:11,\r\n				catador =yo mismo,\r\n				tostado =4,\r\n				fragancia =9.25,\r\n				tipo_aroma1 =Floral,Caramelo,\r\n				nota_aroma =hola ,\r\n				sabor =9.5,\r\n				tipo_sabor =Herbal,Picante,Chocolate dulce,Vainilla,\r\n				nota_sabor =holass,\r\n				sabor_residual =9.75,\r\n				tipo_sabor_residual =Refrescante,Delicado,Duro,Astringente,\r\n				nota_sabor_residual =fgsdfg,\r\n				acidez =9.25,\r\n				cuerpo =8.5,\r\n				uniformidad =9.75,\r\n				balance =10,\r\n				puntaje_catador =8,\r\n				taza_limpia =9.5,\r\n				dulzor =9.75,\r\n				nota_catacion =asdfsdf,\r\n				puntuacion =91.25,\r\n				d_fermento=1,\r\n				d_metalico=1,				\r\n				d_quimico=0,\r\n				d_vinagre=0,				\r\n				d_stinker=0,\r\n				d_fenol=0,				\r\n				d_reposo=0,\r\n				d_moho=0,				\r\n				d_terroso=1,\r\n				d_extrano=0,				\r\n				d_sucio=0,\r\n				d_astringente=0,				\r\n				dl_cereal=0,\r\n				dl_fermento=0,				\r\n				dl_reposo=1,\r\n				dl_moho=1,				\r\n				dl_astringencia=0,\r\n				d_general=2				\r\n				\r\n				WHERE lote=APC-00017-14'),
(29, 'admin', '2014-08-25 05:07:34', 'UPDATE catas SET\r\n				fecha =2014-06-03 19:08:11,\r\n				catador =yo mismo,\r\n				tostado =4,\r\n				fragancia =9.25,\r\n				tipo_aroma1 =Floral,Caramelo,\r\n				nota_aroma =hola ,\r\n				sabor =9.5,\r\n				tipo_sabor =Herbal,Picante,Chocolate dulce,Vainilla,Madera,Resinoso,\r\n				nota_sabor =holass,\r\n				sabor_residual =9.75,\r\n				tipo_sabor_residual =Refrescante,Delicado,Duro,Astringente,\r\n				nota_sabor_residual =fgsdfg,\r\n				acidez =9.25,\r\n				cuerpo =8.5,\r\n				uniformidad =9.75,\r\n				balance =10,\r\n				puntaje_catador =8,\r\n				taza_limpia =9.5,\r\n				dulzor =9.75,\r\n				nota_catacion =asdfsdf,\r\n				puntuacion =91.25,\r\n				d_fermento=1,\r\n				d_metalico=1,				\r\n				d_quimico=0,\r\n				d_vinagre=0,				\r\n				d_stinker=0,\r\n				d_fenol=0,				\r\n				d_reposo=0,\r\n				d_moho=0,				\r\n				d_terroso=1,\r\n				d_extrano=0,				\r\n				d_sucio=0,\r\n				d_astringente=0,				\r\n				dl_cereal=0,\r\n				dl_fermento=0,				\r\n				dl_reposo=1,\r\n				dl_moho=1,				\r\n				dl_astringencia=0,\r\n				d_general=2				\r\n				\r\n				WHERE lote=APC-00017-14'),
(30, 'admin', '2014-08-25 05:37:53', 'UPDATE catas SET\r\n				fecha =2014-06-04 04:41:14,\r\n				catador =,\r\n				tostado =6,\r\n				fragancia =9,\r\n				tipo_aroma1 =Floral,\r\n				nota_aroma =,\r\n				sabor =9.25,\r\n				tipo_sabor =Floral,\r\n				nota_sabor =,\r\n				sabor_residual =7.5,\r\n				tipo_sabor_residual =Refrescante,\r\n				nota_sabor_residual =,\r\n				acidez =8.75,\r\n				cuerpo =8.75,\r\n				uniformidad =9,\r\n				balance =9.75,\r\n				puntaje_catador =8.25,\r\n				taza_limpia =9.75,\r\n				dulzor =9,\r\n				nota_catacion =,\r\n				puntuacion =88,\r\n				d_fermento=0,\r\n				d_metalico=1,				\r\n				d_quimico=0,\r\n				d_vinagre=0,				\r\n				d_stinker=0,\r\n				d_fenol=1,				\r\n				d_reposo=0,\r\n				d_moho=0,				\r\n				d_terroso=0,\r\n				d_extrano=0,				\r\n				d_sucio=0,\r\n				d_astringente=0,				\r\n				dl_cereal=0,\r\n				dl_fermento=0,				\r\n				dl_reposo=0,\r\n				dl_moho=1,				\r\n				dl_astringencia=0,\r\n				d_general=1				\r\n				\r\n				WHERE lote=APC-00001-14'),
(31, 'admin', '2014-08-25 05:38:33', 'UPDATE catas SET\r\n				fecha =2014-06-04 04:41:14,\r\n				catador =,\r\n				tostado =6,\r\n				fragancia =9,\r\n				tipo_aroma1 =Floral,\r\n				nota_aroma =,\r\n				sabor =9.25,\r\n				tipo_sabor =Floral,\r\n				nota_sabor =,\r\n				sabor_residual =7.5,\r\n				tipo_sabor_residual =Refrescante,\r\n				nota_sabor_residual =,\r\n				acidez =8.75,\r\n				cuerpo =8.75,\r\n				uniformidad =9,\r\n				balance =9.75,\r\n				puntaje_catador =8.25,\r\n				taza_limpia =9.75,\r\n				dulzor =9,\r\n				nota_catacion =,\r\n				puntuacion =88,\r\n				d_fermento=0,\r\n				d_metalico=1,				\r\n				d_quimico=0,\r\n				d_vinagre=0,				\r\n				d_stinker=0,\r\n				d_fenol=1,				\r\n				d_reposo=0,\r\n				d_moho=0,				\r\n				d_terroso=0,\r\n				d_extrano=0,				\r\n				d_sucio=0,\r\n				d_astringente=0,				\r\n				d_quaquers=3,				\r\n				dl_cereal=0,\r\n				dl_fermento=0,				\r\n				dl_reposo=0,\r\n				dl_moho=1,				\r\n				dl_astringencia=0,\r\n				d_general=1				\r\n				\r\n				WHERE lote=APC-00001-14'),
(32, 'admin', '2014-08-25 05:44:01', 'UPDATE catas SET\r\n				fecha =2014-06-03 19:08:11,\r\n				catador =yo mismo,\r\n				tostado =4,\r\n				fragancia =9.25,\r\n				tipo_aroma1 =Floral,Caramelo,\r\n				nota_aroma =hola ,\r\n				sabor =9.5,\r\n				tipo_sabor =Herbal,\r\n				nota_sabor =holass,\r\n				sabor_residual =9.75,\r\n				tipo_sabor_residual =Refrescante,Delicado,Duro,Astringente,\r\n				nota_sabor_residual =fgsdfg,\r\n				acidez =9.25,\r\n				cuerpo =8.5,\r\n				uniformidad =9.75,\r\n				balance =10,\r\n				puntaje_catador =8,\r\n				taza_limpia =9.5,\r\n				dulzor =9.75,\r\n				nota_catacion =asdfsdf,\r\n				puntuacion =91.25,\r\n				d_fermento=1,\r\n				d_metalico=1,				\r\n				d_quimico=0,\r\n				d_vinagre=0,				\r\n				d_stinker=0,\r\n				d_fenol=0,				\r\n				d_reposo=0,\r\n				d_moho=0,				\r\n				d_terroso=1,\r\n				d_extrano=0,				\r\n				d_sucio=0,\r\n				d_astringente=0,				\r\n				d_quaquers=0,				\r\n				dl_cereal=0,\r\n				dl_fermento=0,				\r\n				dl_reposo=1,\r\n				dl_moho=1,				\r\n				dl_astringencia=0,\r\n				d_general=2				\r\n				\r\n				WHERE lote=APC-00017-14'),
(33, 'admin', '2014-08-27 19:28:12', 'INSERT INTO lotes VALUES (,\r\n				33,\r\n				APC-00019-14,\r\n				2014-08-27 09:27:33,\r\n				3.5,\r\n				10,\r\n				25,\r\n				180,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				A,\r\n				)'),
(34, 'admin', '2014-08-27 20:06:31', 'UPDATE lotes SET \r\n				id_socio=33,\r\n				codigo_lote=APC-00019-14,\r\n				fecha=2014-08-27 09:27:33,\r\n				peso=3.50,\r\n				humedad=10.00,\r\n				rto_descarte=,\r\n				rto_exportable=180,\r\n				defecto_negro=0,\r\n				defecto_vinagre=0,\r\n				defecto_decolorado=0,\r\n				defecto_mordido=0,\r\n				defecto_brocado=0,\r\n				reposo=0,\r\n				moho=0,\r\n				fermento=0,\r\n				contaminado=0,\r\n				calidad=A\r\n				\r\n			where id=20'),
(35, 'admin', '2014-08-27 20:07:08', 'UPDATE lotes SET \r\n				id_socio=33,\r\n				codigo_lote=APC-00019-14,\r\n				fecha=2014-08-27 09:27:33,\r\n				peso=3.50,\r\n				humedad=10.00,\r\n				rto_descarte=,\r\n				rto_exportable=180,\r\n				defecto_negro=0,\r\n				defecto_vinagre=0,\r\n				defecto_decolorado=0,\r\n				defecto_mordido=0,\r\n				defecto_brocado=0,\r\n				reposo=0,\r\n				moho=0,\r\n				fermento=0,\r\n				contaminado=0,\r\n				calidad=A\r\n				\r\n			where id=20'),
(36, 'admin', '2014-08-27 20:07:52', 'UPDATE lotes SET \r\n				id_socio=33,\r\n				codigo_lote=APC-00019-14,\r\n				fecha=2014-08-27 09:27:33,\r\n				peso=3.50,\r\n				humedad=10.00,\r\n				rto_descarte=25,\r\n				rto_exportable=180,\r\n				defecto_negro=0,\r\n				defecto_vinagre=0,\r\n				defecto_decolorado=0,\r\n				defecto_mordido=0,\r\n				defecto_brocado=0,\r\n				reposo=0,\r\n				moho=0,\r\n				fermento=0,\r\n				contaminado=0,\r\n				calidad=A\r\n				\r\n			where id=20'),
(37, 'admin', '2014-08-27 20:08:06', 'UPDATE lotes SET \r\n				id_socio=33,\r\n				codigo_lote=APC-00019-14,\r\n				fecha=2014-08-27 09:27:33,\r\n				peso=3.50,\r\n				humedad=10.00,\r\n				rto_descarte=30,\r\n				rto_exportable=180,\r\n				defecto_negro=0,\r\n				defecto_vinagre=0,\r\n				defecto_decolorado=0,\r\n				defecto_mordido=0,\r\n				defecto_brocado=0,\r\n				reposo=0,\r\n				moho=0,\r\n				fermento=0,\r\n				contaminado=0,\r\n				calidad=A\r\n				\r\n			where id=20'),
(38, 'admin', '2014-08-27 20:36:55', 'INSERT INTO pagos VALUES (,\r\n				APC-00019-14,\r\n				2014-08-27 10:36:48,\r\n				543,\r\n				34,\r\n				0)'),
(39, 'admin', '2014-08-27 20:37:16', 'UPDATE pagos SET \r\n				fecha=2014-08-27 10:36:48,\r\n				exportable=543.00,\r\n				descarte=100,\r\n				calidad=0 \r\n				WHERE lote=APC-00019-14'),
(40, 'admin', '2014-09-09 20:17:40', 'UPDATE catas SET\r\n				fecha =2014-06-03 19:08:11,\r\n				catador =yo mismo,\r\n				tostado =4,\r\n				fragancia =9.25,\r\n				tipo_aroma1 =Floral,Caramelo,\r\n				nota_aroma =hola ,\r\n				sabor =9.5,\r\n				tipo_sabor =Herbal,\r\n				nota_sabor =holass,\r\n				sabor_residual =9.75,\r\n				tipo_sabor_residual =Refrescante,Delicado,Duro,Astringente,\r\n				nota_sabor_residual =fgsdfg,\r\n				acidez =9.25,\r\n				cuerpo =8.5,\r\n				uniformidad =9.75,\r\n				balance =10,\r\n				puntaje_catador =8,\r\n				taza_limpia =9.5,\r\n				dulzor =9.75,\r\n				nota_catacion =asdfsdf,\r\n				puntuacion =91.25,\r\n				d_fermento=1,\r\n				d_metalico=1,				\r\n				d_quimico=0,\r\n				d_vinagre=0,				\r\n				d_stinker=0,\r\n				d_fenol=0,				\r\n				d_reposo=0,\r\n				d_moho=0,				\r\n				d_terroso=1,\r\n				d_extrano=0,				\r\n				d_sucio=0,\r\n				d_astringente=0,				\r\n				d_quaquers=0,				\r\n				dl_cereal=0,\r\n				dl_fermento=0,				\r\n				dl_reposo=1,\r\n				dl_moho=1,				\r\n				dl_astringencia=0,\r\n				d_general=2				\r\n				\r\n				WHERE lote=APC-00017-14'),
(41, 'admin', '2014-09-09 20:55:41', 'UPDATE pagos SET \r\n						fecha=2014-08-27 10:36:48,\r\n						exportable=543.00,\r\n						descarte=100.00,\r\n						calidad=0, \r\n						cliente=25 \r\n						tazadorada=0.00 \r\n						WHERE lote=APC-00019-14'),
(42, 'admin', '2014-09-09 20:56:28', 'UPDATE pagos SET \r\n						fecha=2014-08-27 10:36:48,\r\n						exportable=543.00,\r\n						descarte=100.00,\r\n						calidad=0, \r\n						cliente=25 \r\n						tazadorada=0.00 \r\n						WHERE lote=APC-00019-14'),
(43, 'admin', '2014-09-09 20:57:05', 'UPDATE pagos SET \r\n						fecha=2014-08-27 10:36:48,\r\n						exportable=543.00,\r\n						descarte=100.00,\r\n						calidad=0, \r\n						cliente=25,\r\n						tazadorada=0.00 \r\n						WHERE lote=APC-00019-14'),
(44, 'admin', '2014-09-09 20:57:15', 'UPDATE pagos SET \r\n						fecha=2014-08-27 10:36:48,\r\n						exportable=543.00,\r\n						descarte=100.00,\r\n						calidad=0, \r\n						cliente=25.00,\r\n						tazadorada=15.23 \r\n						WHERE lote=APC-00019-14'),
(45, 'admin', '2014-09-16 02:47:04', 'UPDATE catas SET\r\n				fecha =2014-06-01 12:09:45,\r\n				catador =yo mismo,\r\n				tostado =6,\r\n				fragancia =7.75,\r\n				tipo_aroma1 =Floral,\r\n				nota_aroma =hola que tal,\r\n				sabor =10,\r\n				tipo_sabor =Chocolate dulce,\r\n				nota_sabor =genial!!!,\r\n				sabor_residual =10,\r\n				tipo_sabor_residual =Dulce,\r\n				nota_sabor_residual =asombroso!!,\r\n				acidez =9,\r\n				cuerpo =6,\r\n				uniformidad =8,\r\n				balance =8,\r\n				puntaje_catador =9,\r\n				taza_limpia =6.75,\r\n				dulzor =9,\r\n				nota_catacion =guau!!,\r\n				puntuacion =83.5,\r\n				d_fermento=0,\r\n				d_metalico=0,				\r\n				d_quimico=0,\r\n				d_vinagre=0,				\r\n				d_stinker=0,\r\n				d_fenol=0,				\r\n				d_reposo=0,\r\n				d_moho=0,				\r\n				d_terroso=0,\r\n				d_extrano=0,				\r\n				d_sucio=0,\r\n				d_astringente=0,				\r\n				d_quaquers=2,				\r\n				dl_cereal=0,\r\n				dl_fermento=0,				\r\n				dl_reposo=0,\r\n				dl_moho=0,				\r\n				dl_astringencia=0,\r\n				d_general=0				\r\n				\r\n				WHERE lote=APC-00015-14'),
(46, 'admin', '2014-09-16 06:22:46', 'UPDATE catas SET\r\n				fecha =2014-06-01 12:09:45,\r\n				catador =yo mismo,\r\n				tostado =6,\r\n				fragancia =7.5,\r\n				tipo_aroma1 =Floral,\r\n				nota_aroma =hola que tal,\r\n				sabor =7.75,\r\n				tipo_sabor =Chocolate dulce,\r\n				nota_sabor =genial!!!,\r\n				sabor_residual =10,\r\n				tipo_sabor_residual =Dulce,\r\n				nota_sabor_residual =asombroso!!,\r\n				acidez =9,\r\n				cuerpo =6,\r\n				uniformidad =8,\r\n				balance =8,\r\n				puntaje_catador =9,\r\n				taza_limpia =6.75,\r\n				dulzor =9,\r\n				nota_catacion =guau!!,\r\n				puntuacion =81,\r\n				d_fermento=0,\r\n				d_metalico=0,				\r\n				d_quimico=0,\r\n				d_vinagre=0,				\r\n				d_stinker=0,\r\n				d_fenol=0,				\r\n				d_reposo=0,\r\n				d_moho=0,				\r\n				d_terroso=0,\r\n				d_extrano=0,				\r\n				d_sucio=0,\r\n				d_astringente=0,				\r\n				d_quaquers=2,				\r\n				dl_cereal=0,\r\n				dl_fermento=0,				\r\n				dl_reposo=0,\r\n				dl_moho=0,				\r\n				dl_astringencia=0,\r\n				d_general=0				\r\n				\r\n				WHERE lote=APC-00015-14'),
(47, 'admin', '2014-09-17 02:17:11', 'INSERT INTO lotes VALUES (,\r\n				EM02,\r\n				APC-00020-14,\r\n				2014-09-16 16:16:40,\r\n				22,\r\n				13,\r\n				45,\r\n				200,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				1,\r\n				1,\r\n				0,\r\n				A\r\n				)'),
(48, 'admin', '2014-09-17 02:19:54', 'INSERT INTO lotes VALUES (,\r\n				AN04,\r\n				APC-00020-14,\r\n				2014-09-16 16:19:37,\r\n				55,\r\n				12,\r\n				30,\r\n				180,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				MN\r\n				)'),
(49, 'admin', '2014-09-17 02:34:48', 'UPDATE lotes SET \r\n				id_socio=AN04,\r\n				codigo_lote=APC-00020-14,\r\n				fecha=2014-09-16 16:19:37,\r\n				peso=100,\r\n				humedad=12.00,\r\n				rto_descarte=30,\r\n				rto_exportable=180,\r\n				defecto_negro=0,\r\n				defecto_vinagre=0,\r\n				defecto_decolorado=0,\r\n				defecto_mordido=0,\r\n				defecto_brocado=0,\r\n				reposo=0,\r\n				moho=0,\r\n				fermento=0,\r\n				contaminado=0,\r\n				calidad=MN\r\n				\r\n			where id=22'),
(50, 'admin', '2014-09-17 02:35:28', 'UPDATE lotes SET \r\n				id_socio=AN04,\r\n				codigo_lote=APC-00020-14,\r\n				fecha=2014-09-16 16:19:37,\r\n				peso=100.00,\r\n				humedad=12.00,\r\n				rto_descarte=30,\r\n				rto_exportable=180,\r\n				defecto_negro=0,\r\n				defecto_vinagre=0,\r\n				defecto_decolorado=0,\r\n				defecto_mordido=0,\r\n				defecto_brocado=0,\r\n				reposo=0,\r\n				moho=0,\r\n				fermento=0,\r\n				contaminado=0,\r\n				calidad=A\r\n				\r\n			where id=22'),
(51, 'admin', '2014-09-17 03:23:32', 'INSERT INTO socios VALUES(,\r\n				Juan,\r\n				Hartman Merino,\r\n				AN53,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				AGRODIN,\r\n				Zamora,\r\n				Zamora,\r\n				,masculino)'),
(52, 'admin', '2014-09-17 03:23:49', 'UPDATE socios SET \r\n				nombres=Juan,\r\n				apellidos=Hartman Merino,\r\n				cedula=0,\r\n				celular=,\r\n				f_nacimiento=0000-00-00,\r\n				direccion=,\r\n				poblacion=AGRODIN,\r\n				canton=Zamora,\r\n				codigo=AN55,\r\n				provincia=Zamora, \r\n				genero=masculino \r\n			where id_socio=300'),
(53, 'admin', '2014-09-17 03:24:58', 'INSERT INTO certificacion VALUES(,\r\n				AN55,\r\n				2014,\r\n				O)'),
(54, 'admin', '2014-09-17 03:25:19', 'INSERT INTO altas VALUES(,\r\n				AN55,\r\n				2014-09-16 17:25:13,\r\n				ingreso)'),
(55, 'admin', '2014-09-17 03:25:37', 'INSERT INTO estimacion VALUES(,\r\n				AN55,\r\n				2014,\r\n				15,\r\n				)'),
(56, 'admin', '2014-09-17 03:28:39', 'INSERT INTO socios VALUES(,\r\n				Gilver,\r\n				Rosillo,\r\n				AN56,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				AGRODIN,\r\n				Zamora,\r\n				Zamora,\r\n				,masculino)'),
(57, 'admin', '2014-09-17 03:28:55', 'UPDATE socios SET \r\n				nombres=Gilver,\r\n				apellidos=Rosillo,\r\n				cedula=0,\r\n				celular=,\r\n				f_nacimiento=0000-00-00,\r\n				direccion=,\r\n				poblacion=AGRODIN,\r\n				canton=Zamora,\r\n				codigo=AN53,\r\n				provincia=Zamora, \r\n				genero=masculino \r\n			where id_socio=301'),
(58, 'admin', '2014-09-17 03:31:20', 'INSERT INTO socios VALUES(,\r\n				Harvey,\r\n				Merino,\r\n				AN56,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				AGRODIN,\r\n				Zamora,\r\n				Zamora,\r\n				,masculino)'),
(59, 'admin', '2014-09-17 03:31:38', 'UPDATE socios SET \r\n				nombres=Harvey,\r\n				apellidos=Merino,\r\n				cedula=0,\r\n				celular=,\r\n				f_nacimiento=0000-00-00,\r\n				direccion=,\r\n				poblacion=AGRODIN,\r\n				canton=Zamora,\r\n				codigo=AN57,\r\n				provincia=Zamora, \r\n				genero=masculino \r\n			where id_socio=302'),
(60, 'admin', '2014-09-17 03:31:51', 'INSERT INTO altas VALUES(,\r\n				AN57,\r\n				2014-09-16 17:31:49,\r\n				ingreso)'),
(61, 'admin', '2014-09-17 03:32:02', 'INSERT INTO estimacion VALUES(,\r\n				AN57,\r\n				2014,\r\n				13,\r\n				)'),
(62, 'admin', '2014-09-17 03:32:18', 'INSERT INTO certificacion VALUES(,\r\n				AN57,\r\n				2014,\r\n				O)'),
(63, 'admin', '2014-09-17 03:33:48', 'INSERT INTO socios VALUES(,\r\n				Manuel,\r\n				Tillaguango,\r\n				AN58,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				AGRODIN,\r\n				Zamora,\r\n				Zamora,\r\n				,masculino)'),
(64, 'admin', '2014-09-17 03:34:07', 'UPDATE socios SET \r\n				nombres=Manuel,\r\n				apellidos=Tillaguango,\r\n				cedula=0,\r\n				celular=,\r\n				f_nacimiento=0000-00-00,\r\n				direccion=,\r\n				poblacion=AGRODIN,\r\n				canton=Zamora,\r\n				codigo=AN54,\r\n				provincia=Zamora, \r\n				genero=masculino \r\n			where id_socio=303'),
(65, 'admin', '2014-09-17 03:34:15', 'INSERT INTO certificacion VALUES(,\r\n				AN54,\r\n				2014,\r\n				O)'),
(66, 'admin', '2014-09-17 03:34:27', 'INSERT INTO estimacion VALUES(,\r\n				AN54,\r\n				2014,\r\n				13,\r\n				)'),
(67, 'admin', '2014-09-17 03:34:38', 'INSERT INTO altas VALUES(,\r\n				AN54,\r\n				2014-09-16 17:34:36,\r\n				ingreso)'),
(68, 'admin', '2014-09-17 04:16:52', 'INSERT INTO catas VALUES (,\r\n				APC-153,\r\n				2014-09-16 18:15:07,\r\n				juanito,\r\n				5.75,\r\n				8.5,\r\n				Frutal,Caramelo,Vainilla,\r\n				,\r\n				9.5,\r\n				Chocolate amargo,Articulado,\r\n				,\r\n				6.75,\r\n				Limpio,Dulce,\r\n				,\r\n				9,\r\n				7,\r\n				8.25,\r\n				7.75,\r\n				9.25,\r\n				7,\r\n				8.75,\r\n				,\r\n				79.75,\r\n				0,\r\n				1,				\r\n				1,\r\n				0,				\r\n				0,\r\n				0,				\r\n				0,\r\n				0,				\r\n				0,\r\n				0,				\r\n				0,\r\n				0,				\r\n				4,				\r\n				0,\r\n				0,				\r\n				0,\r\n				1,				\r\n				1,\r\n				2				\r\n				)'),
(69, 'admin', '2014-09-17 04:24:14', 'UPDATE catas SET\r\n				fecha =2014-09-16 18:15:07,\r\n				catador =juanito,\r\n				tostado =6,\r\n				fragancia =8.5,\r\n				tipo_aroma1 =Frutal,Caramelo,Vainilla,\r\n				nota_aroma =,\r\n				sabor =9.5,\r\n				tipo_sabor =Chocolate amargo,Articulado,\r\n				nota_sabor =,\r\n				sabor_residual =6.75,\r\n				tipo_sabor_residual =Limpio,Dulce,\r\n				nota_sabor_residual =,\r\n				acidez =9,\r\n				cuerpo =8.5,\r\n				uniformidad =9.5,\r\n				balance =7.75,\r\n				puntaje_catador =9.25,\r\n				taza_limpia =7,\r\n				dulzor =8.75,\r\n				nota_catacion =,\r\n				puntuacion =82.5,\r\n				d_fermento=0,\r\n				d_metalico=1,				\r\n				d_quimico=1,\r\n				d_vinagre=0,				\r\n				d_stinker=0,\r\n				d_fenol=0,				\r\n				d_reposo=0,\r\n				d_moho=0,				\r\n				d_terroso=0,\r\n				d_extrano=0,				\r\n				d_sucio=0,\r\n				d_astringente=0,				\r\n				d_quaquers=4,				\r\n				dl_cereal=0,\r\n				dl_fermento=0,				\r\n				dl_reposo=0,\r\n				dl_moho=1,				\r\n				dl_astringencia=1,\r\n				d_general=2				\r\n				\r\n				WHERE lote=APC-153'),
(70, 'admin', '2014-09-17 04:24:30', 'UPDATE catas SET\r\n				fecha =2014-09-16 18:15:07,\r\n				catador =juanito,\r\n				tostado =6,\r\n				fragancia =8.5,\r\n				tipo_aroma1 =Frutal,Caramelo,Vainilla,\r\n				nota_aroma =,\r\n				sabor =9.5,\r\n				tipo_sabor =Chocolate amargo,Articulado,\r\n				nota_sabor =,\r\n				sabor_residual =6.75,\r\n				tipo_sabor_residual =Limpio,Dulce,\r\n				nota_sabor_residual =,\r\n				acidez =9,\r\n				cuerpo =8.5,\r\n				uniformidad =9.5,\r\n				balance =8.75,\r\n				puntaje_catador =9.25,\r\n				taza_limpia =9.5,\r\n				dulzor =8.75,\r\n				nota_catacion =,\r\n				puntuacion =86,\r\n				d_fermento=0,\r\n				d_metalico=1,				\r\n				d_quimico=1,\r\n				d_vinagre=0,				\r\n				d_stinker=0,\r\n				d_fenol=0,				\r\n				d_reposo=0,\r\n				d_moho=0,				\r\n				d_terroso=0,\r\n				d_extrano=0,				\r\n				d_sucio=0,\r\n				d_astringente=0,				\r\n				d_quaquers=4,				\r\n				dl_cereal=0,\r\n				dl_fermento=0,				\r\n				dl_reposo=0,\r\n				dl_moho=1,				\r\n				dl_astringencia=1,\r\n				d_general=2				\r\n				\r\n				WHERE lote=APC-153'),
(71, 'admin', '2014-09-17 20:40:30', 'INSERT INTO socios VALUES(,\r\n				Francisco,\r\n				Montero García,\r\n				SF52,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				SAN FRANCISCO,\r\n				,\r\n				,\r\n				,masculino)'),
(72, 'admin', '2014-09-18 21:38:57', 'INSERT INTO pagos VALUES (,\r\n				APC86,\r\n				2014-09-18 11:38:38,\r\n				800,\r\n				70,\r\n				50,\r\n				,\r\n				,\r\n				)'),
(73, 'admin', '2014-09-18 21:39:23', 'UPDATE pagos SET \r\n						fecha=2014-09-18 11:38:38,\r\n						exportable=800.00,\r\n						descarte=70.00,\r\n						calidad=0, \r\n						cliente=0.00,\r\n						microlote=0.00,\r\n						tazadorada=0.00 \r\n						WHERE lote=APC86'),
(74, 'admin', '2014-09-22 21:34:14', 'INSERT INTO lotes VALUES (,\r\n				SF52,\r\n				APC-00626-14,\r\n				2014-09-22 11:33:56,\r\n				50,\r\n				12,\r\n				35,\r\n				180,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				A\r\n				)'),
(75, 'admin', '2014-09-22 22:45:01', 'INSERT INTO certificacion VALUES(,\r\n				SF52,\r\n				2014,\r\n				O)'),
(76, 'admin', '2014-09-22 22:48:59', 'INSERT INTO estimacion VALUES(,\r\n				SF52,\r\n				2014,\r\n				15,\r\n				)'),
(77, 'admin', '2014-09-22 22:49:09', 'INSERT INTO altas VALUES(,\r\n				SF52,\r\n				2014-09-22 12:49:06,\r\n				ingreso)'),
(78, 'admin', '2014-09-22 22:49:42', 'INSERT INTO lotes VALUES (,\r\n				SF52,\r\n				APC-00626-14,\r\n				2014-09-22 12:49:19,\r\n				8,\r\n				12,\r\n				20,\r\n				200,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				A\r\n				)'),
(79, 'admin', '2014-09-22 22:52:09', 'INSERT INTO lotes VALUES (,\r\n				SF52,\r\n				APC-00627-14,\r\n				2014-09-22 12:51:44,\r\n				5,\r\n				12,\r\n				20,\r\n				200,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				A\r\n				)'),
(80, 'admin', '2014-09-22 22:53:36', 'INSERT INTO lotes VALUES (,\r\n				SF52,\r\n				APC-00628-14,\r\n				2014-09-22 12:53:10,\r\n				5,\r\n				12,\r\n				20,\r\n				200,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				A\r\n				)'),
(81, 'admin', '2014-09-22 22:57:44', 'INSERT INTO lotes VALUES (,\r\n				SF52,\r\n				APC-00629-14,\r\n				2014-09-22 12:57:21,\r\n				5,\r\n				12,\r\n				20,\r\n				200,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				0,\r\n				A\r\n				)'),
(82, 'admin', '2014-09-23 02:41:31', 'INSERT INTO pagos VALUES (,\r\n				APC-00629-14,\r\n				2014-09-22 16:41:21,\r\n				0,\r\n				0,\r\n				100,\r\n				0,\r\n				,\r\n				,\r\n				)'),
(83, 'admin', '2014-09-23 02:44:27', 'INSERT INTO pagos VALUES (,\r\n				APC-00627-14,\r\n				2014-09-22 16:44:01,\r\n				1499,\r\n				90,\r\n				0,\r\n				0,\r\n				45,\r\n				30,\r\n				)'),
(84, 'admin', '2014-09-25 04:18:49', 'INSERT INTO despachos VALUES(,\r\n				APC-00629-14,\r\n				2014-09-24 18:18:41,\r\n				2,\r\n				1)'),
(85, 'admin', '2014-09-25 04:19:28', 'INSERT INTO despachos VALUES(,\r\n				APC-00629-14,\r\n				2014-09-24 18:19:22,\r\n				1.93,\r\n				2)'),
(86, 'admin', '2014-09-25 04:57:19', 'INSERT INTO despachos VALUES(,\r\n				APC-163,\r\n				2014-09-24 18:57:14,\r\n				4,\r\n				3)'),
(87, 'admin', '2014-09-25 06:18:54', 'UPDATE estimacion SET\r\n				entregados=3.07\r\n				WHERE id=1017'),
(88, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=2.67,\r\n							WHERE id=931'),
(89, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=0.71,\r\n							WHERE id=932'),
(90, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=1.54,\r\n							WHERE id=934'),
(91, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=10.04,\r\n							WHERE id=935'),
(92, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=1.90,\r\n							WHERE id=940'),
(93, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=2.09,\r\n							WHERE id=942'),
(94, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=1.52,\r\n							WHERE id=944'),
(95, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=3.26,\r\n							WHERE id=899'),
(96, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=6.38,\r\n							WHERE id=901'),
(97, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=7.96,\r\n							WHERE id=903'),
(98, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=8.70,\r\n							WHERE id=904'),
(99, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=10.70,\r\n							WHERE id=905'),
(100, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=12.26,\r\n							WHERE id=907'),
(101, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=1.46,\r\n							WHERE id=910'),
(102, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=6.03,\r\n							WHERE id=913'),
(103, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=2.99,\r\n							WHERE id=914'),
(104, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=7.08,\r\n							WHERE id=917'),
(105, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=3.33,\r\n							WHERE id=929'),
(106, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=1.42,\r\n							WHERE id=1200'),
(107, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=5.49,\r\n							WHERE id=1198'),
(108, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=4.67,\r\n							WHERE id=1199'),
(109, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=2.10,\r\n							WHERE id=945'),
(110, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=22.29,\r\n							WHERE id=948'),
(111, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=7.12,\r\n							WHERE id=949'),
(112, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=15.37,\r\n							WHERE id=950'),
(113, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=4.21,\r\n							WHERE id=952'),
(114, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=4.97,\r\n							WHERE id=957'),
(115, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=4.38,\r\n							WHERE id=958'),
(116, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=2.48,\r\n							WHERE id=1037'),
(117, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=1.46,\r\n							WHERE id=1038'),
(118, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=5.13,\r\n							WHERE id=1039'),
(119, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=9.94,\r\n							WHERE id=1040'),
(120, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=11.74,\r\n							WHERE id=1043'),
(121, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=1.53,\r\n							WHERE id=1046'),
(122, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=3.87,\r\n							WHERE id=959'),
(123, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=7.04,\r\n							WHERE id=960'),
(124, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=2.83,\r\n							WHERE id=962'),
(125, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=10.05,\r\n							WHERE id=966'),
(126, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=2.21,\r\n							WHERE id=970'),
(127, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=6.25,\r\n							WHERE id=973'),
(128, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=1.77,\r\n							WHERE id=974'),
(129, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=5.78,\r\n							WHERE id=992'),
(130, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=8.66,\r\n							WHERE id=1004'),
(131, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=9.40,\r\n							WHERE id=1006'),
(132, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=11.28,\r\n							WHERE id=1007'),
(133, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=14.85,\r\n							WHERE id=1197'),
(134, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=10.68,\r\n							WHERE id=1196'),
(135, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=3.07,\r\n							WHERE id=1017'),
(136, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=4.65,\r\n							WHERE id=1022'),
(137, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=0.62,\r\n							WHERE id=1100'),
(138, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=1.90,\r\n							WHERE id=1101'),
(139, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=2.62,\r\n							WHERE id=1029'),
(140, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=30.65,\r\n							WHERE id=986'),
(141, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=7.21,\r\n							WHERE id=989'),
(142, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=15.81,\r\n							WHERE id=1194'),
(143, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=16.86,\r\n							WHERE id=1195'),
(144, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=4.36,\r\n							WHERE id=985'),
(145, 'admin', '2014-09-25 09:37:56', 'UPDATE estimacion SET\r\n							entregados=5.08,\r\n							WHERE id=1049'),
(146, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=3.88,\r\n							WHERE id=1053'),
(147, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=1.86,\r\n							WHERE id=1055'),
(148, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=4.14,\r\n							WHERE id=1063'),
(149, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=2.22,\r\n							WHERE id=1071'),
(150, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=0.78,\r\n							WHERE id=1090'),
(151, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=1.22,\r\n							WHERE id=1092'),
(152, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=2.68,\r\n							WHERE id=1096'),
(153, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=10.78,\r\n							WHERE id=1187'),
(154, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=5.00,\r\n							WHERE id=1188'),
(155, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=3.00,\r\n							WHERE id=1190'),
(156, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=16.70,\r\n							WHERE id=1191'),
(157, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=5.29,\r\n							WHERE id=1192'),
(158, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=3.85,\r\n							WHERE id=1193'),
(159, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=0.48,\r\n							WHERE id=1106'),
(160, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=4.00,\r\n							WHERE id=1109'),
(161, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=9.63,\r\n							WHERE id=1113'),
(162, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=15.08,\r\n							WHERE id=1114'),
(163, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=1.00,\r\n							WHERE id=1115'),
(164, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=5.09,\r\n							WHERE id=1149'),
(165, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=13.80,\r\n							WHERE id=1150'),
(166, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=1.22,\r\n							WHERE id=1151'),
(167, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=3.45,\r\n							WHERE id=1119'),
(168, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=10.29,\r\n							WHERE id=1121'),
(169, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=2.91,\r\n							WHERE id=1122'),
(170, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=6.25,\r\n							WHERE id=1123'),
(171, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=2.33,\r\n							WHERE id=1130'),
(172, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=23.00,\r\n							WHERE id=1201'),
(173, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=1.35,\r\n							WHERE id=1139'),
(174, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=0.73,\r\n							WHERE id=1142'),
(175, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=0.50,\r\n							WHERE id=1137'),
(176, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=1.32,\r\n							WHERE id=1143'),
(177, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=2.28,\r\n							WHERE id=1153'),
(178, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=2.09,\r\n							WHERE id=1155'),
(179, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=4.86,\r\n							WHERE id=1156'),
(180, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=12.46,\r\n							WHERE id=1157'),
(181, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=0.71,\r\n							WHERE id=1158'),
(182, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=1.73,\r\n							WHERE id=1159'),
(183, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=1.60,\r\n							WHERE id=1167'),
(184, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=3.78,\r\n							WHERE id=1172'),
(185, 'admin', '2014-09-25 09:37:57', 'UPDATE estimacion SET\r\n							entregados=2.65,\r\n							WHERE id=1074'),
(186, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=2.67,\r\n							WHERE id=931'),
(187, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=0.71,\r\n							WHERE id=932'),
(188, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=1.54,\r\n							WHERE id=934'),
(189, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=10.04,\r\n							WHERE id=935'),
(190, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=1.90,\r\n							WHERE id=940'),
(191, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=2.09,\r\n							WHERE id=942'),
(192, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=1.52,\r\n							WHERE id=944'),
(193, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=3.26,\r\n							WHERE id=899'),
(194, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=6.38,\r\n							WHERE id=901'),
(195, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=7.96,\r\n							WHERE id=903'),
(196, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=8.70,\r\n							WHERE id=904'),
(197, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=10.70,\r\n							WHERE id=905'),
(198, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=12.26,\r\n							WHERE id=907'),
(199, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=1.46,\r\n							WHERE id=910'),
(200, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=6.03,\r\n							WHERE id=913'),
(201, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=2.99,\r\n							WHERE id=914'),
(202, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=7.08,\r\n							WHERE id=917'),
(203, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=3.33,\r\n							WHERE id=929'),
(204, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=1.42,\r\n							WHERE id=1200'),
(205, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=5.49,\r\n							WHERE id=1198'),
(206, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=4.67,\r\n							WHERE id=1199'),
(207, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=2.10,\r\n							WHERE id=945'),
(208, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=22.29,\r\n							WHERE id=948'),
(209, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=7.12,\r\n							WHERE id=949'),
(210, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=15.37,\r\n							WHERE id=950'),
(211, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=4.21,\r\n							WHERE id=952'),
(212, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=4.97,\r\n							WHERE id=957'),
(213, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=4.38,\r\n							WHERE id=958'),
(214, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=2.48,\r\n							WHERE id=1037'),
(215, 'admin', '2014-09-25 09:39:35', 'UPDATE estimacion SET\r\n							entregados=1.46,\r\n							WHERE id=1038'),
(216, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=5.13,\r\n							WHERE id=1039'),
(217, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=9.94,\r\n							WHERE id=1040'),
(218, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=11.74,\r\n							WHERE id=1043'),
(219, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=1.53,\r\n							WHERE id=1046'),
(220, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=3.87,\r\n							WHERE id=959'),
(221, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=7.04,\r\n							WHERE id=960'),
(222, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=2.83,\r\n							WHERE id=962'),
(223, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=10.05,\r\n							WHERE id=966'),
(224, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=2.21,\r\n							WHERE id=970'),
(225, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=6.25,\r\n							WHERE id=973'),
(226, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=1.77,\r\n							WHERE id=974'),
(227, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=5.78,\r\n							WHERE id=992'),
(228, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=8.66,\r\n							WHERE id=1004'),
(229, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=9.40,\r\n							WHERE id=1006'),
(230, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=11.28,\r\n							WHERE id=1007'),
(231, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=14.85,\r\n							WHERE id=1197'),
(232, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=10.68,\r\n							WHERE id=1196'),
(233, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=3.07,\r\n							WHERE id=1017'),
(234, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=4.65,\r\n							WHERE id=1022'),
(235, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=0.62,\r\n							WHERE id=1100'),
(236, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=1.90,\r\n							WHERE id=1101'),
(237, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=2.62,\r\n							WHERE id=1029'),
(238, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=30.65,\r\n							WHERE id=986'),
(239, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=7.21,\r\n							WHERE id=989'),
(240, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=15.81,\r\n							WHERE id=1194'),
(241, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=16.86,\r\n							WHERE id=1195'),
(242, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=4.36,\r\n							WHERE id=985'),
(243, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=5.08,\r\n							WHERE id=1049'),
(244, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=3.88,\r\n							WHERE id=1053'),
(245, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=1.86,\r\n							WHERE id=1055'),
(246, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=4.14,\r\n							WHERE id=1063'),
(247, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=2.22,\r\n							WHERE id=1071'),
(248, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=0.78,\r\n							WHERE id=1090'),
(249, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=1.22,\r\n							WHERE id=1092'),
(250, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=2.68,\r\n							WHERE id=1096'),
(251, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=10.78,\r\n							WHERE id=1187'),
(252, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=5.00,\r\n							WHERE id=1188'),
(253, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=3.00,\r\n							WHERE id=1190'),
(254, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=16.70,\r\n							WHERE id=1191');
INSERT INTO `acciones` (`id`, `user`, `fecha`, `accion`) VALUES
(255, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=5.29,\r\n							WHERE id=1192'),
(256, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=3.85,\r\n							WHERE id=1193'),
(257, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=0.48,\r\n							WHERE id=1106'),
(258, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=4.00,\r\n							WHERE id=1109'),
(259, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=9.63,\r\n							WHERE id=1113'),
(260, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=15.08,\r\n							WHERE id=1114'),
(261, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=1.00,\r\n							WHERE id=1115'),
(262, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=5.09,\r\n							WHERE id=1149'),
(263, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=13.80,\r\n							WHERE id=1150'),
(264, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=1.22,\r\n							WHERE id=1151'),
(265, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=3.45,\r\n							WHERE id=1119'),
(266, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=10.29,\r\n							WHERE id=1121'),
(267, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=2.91,\r\n							WHERE id=1122'),
(268, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=6.25,\r\n							WHERE id=1123'),
(269, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=2.33,\r\n							WHERE id=1130'),
(270, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=23.00,\r\n							WHERE id=1201'),
(271, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=1.35,\r\n							WHERE id=1139'),
(272, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=0.73,\r\n							WHERE id=1142'),
(273, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=0.50,\r\n							WHERE id=1137'),
(274, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=1.32,\r\n							WHERE id=1143'),
(275, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=2.28,\r\n							WHERE id=1153'),
(276, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=2.09,\r\n							WHERE id=1155'),
(277, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=4.86,\r\n							WHERE id=1156'),
(278, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=12.46,\r\n							WHERE id=1157'),
(279, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=0.71,\r\n							WHERE id=1158'),
(280, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=1.73,\r\n							WHERE id=1159'),
(281, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=1.60,\r\n							WHERE id=1167'),
(282, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=3.78,\r\n							WHERE id=1172'),
(283, 'admin', '2014-09-25 09:39:36', 'UPDATE estimacion SET\r\n							entregados=2.65,\r\n							WHERE id=1074'),
(284, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=2.67,\r\n							WHERE id=931'),
(285, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=0.71,\r\n							WHERE id=932'),
(286, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=1.54,\r\n							WHERE id=934'),
(287, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=10.04,\r\n							WHERE id=935'),
(288, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=1.90,\r\n							WHERE id=940'),
(289, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=2.09,\r\n							WHERE id=942'),
(290, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=1.52,\r\n							WHERE id=944'),
(291, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=3.26,\r\n							WHERE id=899'),
(292, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=6.38,\r\n							WHERE id=901'),
(293, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=7.96,\r\n							WHERE id=903'),
(294, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=8.70,\r\n							WHERE id=904'),
(295, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=10.70,\r\n							WHERE id=905'),
(296, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=12.26,\r\n							WHERE id=907'),
(297, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=1.46,\r\n							WHERE id=910'),
(298, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=6.03,\r\n							WHERE id=913'),
(299, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=2.99,\r\n							WHERE id=914'),
(300, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=7.08,\r\n							WHERE id=917'),
(301, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=3.33,\r\n							WHERE id=929'),
(302, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=1.42,\r\n							WHERE id=1200'),
(303, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=5.49,\r\n							WHERE id=1198'),
(304, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=4.67,\r\n							WHERE id=1199'),
(305, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=2.10,\r\n							WHERE id=945'),
(306, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=22.29,\r\n							WHERE id=948'),
(307, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=7.12,\r\n							WHERE id=949'),
(308, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=15.37,\r\n							WHERE id=950'),
(309, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=4.21,\r\n							WHERE id=952'),
(310, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=4.97,\r\n							WHERE id=957'),
(311, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=4.38,\r\n							WHERE id=958'),
(312, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=2.48,\r\n							WHERE id=1037'),
(313, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=1.46,\r\n							WHERE id=1038'),
(314, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=5.13,\r\n							WHERE id=1039'),
(315, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=9.94,\r\n							WHERE id=1040'),
(316, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=11.74,\r\n							WHERE id=1043'),
(317, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=1.53,\r\n							WHERE id=1046'),
(318, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=3.87,\r\n							WHERE id=959'),
(319, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=7.04,\r\n							WHERE id=960'),
(320, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=2.83,\r\n							WHERE id=962'),
(321, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=10.05,\r\n							WHERE id=966'),
(322, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=2.21,\r\n							WHERE id=970'),
(323, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=6.25,\r\n							WHERE id=973'),
(324, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=1.77,\r\n							WHERE id=974'),
(325, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=5.78,\r\n							WHERE id=992'),
(326, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=8.66,\r\n							WHERE id=1004'),
(327, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=9.40,\r\n							WHERE id=1006'),
(328, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=11.28,\r\n							WHERE id=1007'),
(329, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=14.85,\r\n							WHERE id=1197'),
(330, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=10.68,\r\n							WHERE id=1196'),
(331, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=3.07,\r\n							WHERE id=1017'),
(332, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=4.65,\r\n							WHERE id=1022'),
(333, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=0.62,\r\n							WHERE id=1100'),
(334, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=1.90,\r\n							WHERE id=1101'),
(335, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=2.62,\r\n							WHERE id=1029'),
(336, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=30.65,\r\n							WHERE id=986'),
(337, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=7.21,\r\n							WHERE id=989'),
(338, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=15.81,\r\n							WHERE id=1194'),
(339, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=16.86,\r\n							WHERE id=1195'),
(340, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=4.36,\r\n							WHERE id=985'),
(341, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=5.08,\r\n							WHERE id=1049'),
(342, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=3.88,\r\n							WHERE id=1053'),
(343, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=1.86,\r\n							WHERE id=1055'),
(344, 'admin', '2014-09-25 09:40:32', 'UPDATE estimacion SET\r\n							entregados=4.14,\r\n							WHERE id=1063'),
(345, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=2.22,\r\n							WHERE id=1071'),
(346, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=0.78,\r\n							WHERE id=1090'),
(347, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=1.22,\r\n							WHERE id=1092'),
(348, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=2.68,\r\n							WHERE id=1096'),
(349, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=10.78,\r\n							WHERE id=1187'),
(350, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=5.00,\r\n							WHERE id=1188'),
(351, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=3.00,\r\n							WHERE id=1190'),
(352, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=16.70,\r\n							WHERE id=1191'),
(353, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=5.29,\r\n							WHERE id=1192'),
(354, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=3.85,\r\n							WHERE id=1193'),
(355, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=0.48,\r\n							WHERE id=1106'),
(356, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=4.00,\r\n							WHERE id=1109'),
(357, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=9.63,\r\n							WHERE id=1113'),
(358, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=15.08,\r\n							WHERE id=1114'),
(359, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=1.00,\r\n							WHERE id=1115'),
(360, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=5.09,\r\n							WHERE id=1149'),
(361, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=13.80,\r\n							WHERE id=1150'),
(362, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=1.22,\r\n							WHERE id=1151'),
(363, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=3.45,\r\n							WHERE id=1119'),
(364, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=10.29,\r\n							WHERE id=1121'),
(365, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=2.91,\r\n							WHERE id=1122'),
(366, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=6.25,\r\n							WHERE id=1123'),
(367, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=2.33,\r\n							WHERE id=1130'),
(368, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=23.00,\r\n							WHERE id=1201'),
(369, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=1.35,\r\n							WHERE id=1139'),
(370, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=0.73,\r\n							WHERE id=1142'),
(371, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=0.50,\r\n							WHERE id=1137'),
(372, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=1.32,\r\n							WHERE id=1143'),
(373, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=2.28,\r\n							WHERE id=1153'),
(374, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=2.09,\r\n							WHERE id=1155'),
(375, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=4.86,\r\n							WHERE id=1156'),
(376, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=12.46,\r\n							WHERE id=1157'),
(377, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=0.71,\r\n							WHERE id=1158'),
(378, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=1.73,\r\n							WHERE id=1159'),
(379, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=1.60,\r\n							WHERE id=1167'),
(380, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=3.78,\r\n							WHERE id=1172'),
(381, 'admin', '2014-09-25 09:40:33', 'UPDATE estimacion SET\r\n							entregados=2.65,\r\n							WHERE id=1074'),
(382, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=2.67\r\n							WHERE id=931'),
(383, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=0.71\r\n							WHERE id=932'),
(384, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=1.54\r\n							WHERE id=934'),
(385, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=10.04\r\n							WHERE id=935'),
(386, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=1.90\r\n							WHERE id=940'),
(387, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=2.09\r\n							WHERE id=942'),
(388, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=1.52\r\n							WHERE id=944'),
(389, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=3.26\r\n							WHERE id=899'),
(390, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=6.38\r\n							WHERE id=901'),
(391, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=7.96\r\n							WHERE id=903'),
(392, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=8.70\r\n							WHERE id=904'),
(393, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=10.70\r\n							WHERE id=905'),
(394, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=12.26\r\n							WHERE id=907'),
(395, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=1.46\r\n							WHERE id=910'),
(396, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=6.03\r\n							WHERE id=913'),
(397, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=2.99\r\n							WHERE id=914'),
(398, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=7.08\r\n							WHERE id=917'),
(399, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=3.33\r\n							WHERE id=929'),
(400, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=1.42\r\n							WHERE id=1200'),
(401, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=5.49\r\n							WHERE id=1198'),
(402, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=4.67\r\n							WHERE id=1199'),
(403, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=2.10\r\n							WHERE id=945'),
(404, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=22.29\r\n							WHERE id=948'),
(405, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=7.12\r\n							WHERE id=949'),
(406, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=15.37\r\n							WHERE id=950'),
(407, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=4.21\r\n							WHERE id=952'),
(408, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=4.97\r\n							WHERE id=957'),
(409, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=4.38\r\n							WHERE id=958'),
(410, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=2.48\r\n							WHERE id=1037'),
(411, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=1.46\r\n							WHERE id=1038'),
(412, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=5.13\r\n							WHERE id=1039'),
(413, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=9.94\r\n							WHERE id=1040'),
(414, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=11.74\r\n							WHERE id=1043'),
(415, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=1.53\r\n							WHERE id=1046'),
(416, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=3.87\r\n							WHERE id=959'),
(417, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=7.04\r\n							WHERE id=960'),
(418, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=2.83\r\n							WHERE id=962'),
(419, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=10.05\r\n							WHERE id=966'),
(420, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=2.21\r\n							WHERE id=970'),
(421, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=6.25\r\n							WHERE id=973'),
(422, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=1.77\r\n							WHERE id=974'),
(423, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=5.78\r\n							WHERE id=992'),
(424, 'admin', '2014-09-25 09:44:23', 'UPDATE estimacion SET\r\n							entregados=8.66\r\n							WHERE id=1004'),
(425, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=9.40\r\n							WHERE id=1006'),
(426, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=11.28\r\n							WHERE id=1007'),
(427, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=14.85\r\n							WHERE id=1197'),
(428, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=10.68\r\n							WHERE id=1196'),
(429, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=3.07\r\n							WHERE id=1017'),
(430, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=4.65\r\n							WHERE id=1022'),
(431, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=0.62\r\n							WHERE id=1100'),
(432, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=1.90\r\n							WHERE id=1101'),
(433, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=2.62\r\n							WHERE id=1029'),
(434, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=30.65\r\n							WHERE id=986'),
(435, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=7.21\r\n							WHERE id=989'),
(436, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=15.81\r\n							WHERE id=1194'),
(437, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=16.86\r\n							WHERE id=1195'),
(438, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=4.36\r\n							WHERE id=985'),
(439, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=5.08\r\n							WHERE id=1049'),
(440, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=3.88\r\n							WHERE id=1053'),
(441, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=1.86\r\n							WHERE id=1055'),
(442, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=4.14\r\n							WHERE id=1063'),
(443, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=2.22\r\n							WHERE id=1071'),
(444, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=0.78\r\n							WHERE id=1090'),
(445, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=1.22\r\n							WHERE id=1092'),
(446, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=2.68\r\n							WHERE id=1096'),
(447, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=10.78\r\n							WHERE id=1187'),
(448, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=5.00\r\n							WHERE id=1188'),
(449, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=3.00\r\n							WHERE id=1190'),
(450, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=16.70\r\n							WHERE id=1191'),
(451, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=5.29\r\n							WHERE id=1192'),
(452, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=3.85\r\n							WHERE id=1193'),
(453, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=0.48\r\n							WHERE id=1106'),
(454, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=4.00\r\n							WHERE id=1109'),
(455, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=9.63\r\n							WHERE id=1113'),
(456, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=15.08\r\n							WHERE id=1114'),
(457, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=1.00\r\n							WHERE id=1115'),
(458, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=5.09\r\n							WHERE id=1149'),
(459, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=13.80\r\n							WHERE id=1150'),
(460, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=1.22\r\n							WHERE id=1151'),
(461, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=3.45\r\n							WHERE id=1119'),
(462, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=10.29\r\n							WHERE id=1121'),
(463, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=2.91\r\n							WHERE id=1122'),
(464, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=6.25\r\n							WHERE id=1123'),
(465, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=2.33\r\n							WHERE id=1130'),
(466, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=23.00\r\n							WHERE id=1201'),
(467, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=1.35\r\n							WHERE id=1139'),
(468, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=0.73\r\n							WHERE id=1142'),
(469, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=0.50\r\n							WHERE id=1137'),
(470, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=1.32\r\n							WHERE id=1143'),
(471, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=2.28\r\n							WHERE id=1153'),
(472, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=2.09\r\n							WHERE id=1155'),
(473, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=4.86\r\n							WHERE id=1156'),
(474, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=12.46\r\n							WHERE id=1157'),
(475, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=0.71\r\n							WHERE id=1158'),
(476, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=1.73\r\n							WHERE id=1159'),
(477, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=1.60\r\n							WHERE id=1167'),
(478, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=3.78\r\n							WHERE id=1172'),
(479, 'admin', '2014-09-25 09:44:24', 'UPDATE estimacion SET\r\n							entregados=2.65\r\n							WHERE id=1074'),
(480, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=2.67\r\n							WHERE id=931'),
(481, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=0.71\r\n							WHERE id=932'),
(482, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=1.54\r\n							WHERE id=934'),
(483, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=10.04\r\n							WHERE id=935'),
(484, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=1.90\r\n							WHERE id=940'),
(485, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=2.09\r\n							WHERE id=942'),
(486, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=1.52\r\n							WHERE id=944'),
(487, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=3.26\r\n							WHERE id=899'),
(488, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=6.38\r\n							WHERE id=901'),
(489, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=7.96\r\n							WHERE id=903'),
(490, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=8.70\r\n							WHERE id=904'),
(491, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=10.70\r\n							WHERE id=905'),
(492, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=12.26\r\n							WHERE id=907'),
(493, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=1.46\r\n							WHERE id=910'),
(494, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=6.03\r\n							WHERE id=913'),
(495, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=2.99\r\n							WHERE id=914'),
(496, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=7.08\r\n							WHERE id=917'),
(497, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=3.33\r\n							WHERE id=929'),
(498, 'admin', '2014-09-25 09:44:36', 'UPDATE estimacion SET\r\n							entregados=1.42\r\n							WHERE id=1200'),
(499, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=5.49\r\n							WHERE id=1198'),
(500, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=4.67\r\n							WHERE id=1199'),
(501, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=2.10\r\n							WHERE id=945'),
(502, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=22.29\r\n							WHERE id=948'),
(503, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=7.12\r\n							WHERE id=949'),
(504, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=15.37\r\n							WHERE id=950'),
(505, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=4.21\r\n							WHERE id=952'),
(506, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=4.97\r\n							WHERE id=957'),
(507, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=4.38\r\n							WHERE id=958'),
(508, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=2.48\r\n							WHERE id=1037'),
(509, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=1.46\r\n							WHERE id=1038'),
(510, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=5.13\r\n							WHERE id=1039'),
(511, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=9.94\r\n							WHERE id=1040'),
(512, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=11.74\r\n							WHERE id=1043'),
(513, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=1.53\r\n							WHERE id=1046'),
(514, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=3.87\r\n							WHERE id=959'),
(515, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=7.04\r\n							WHERE id=960'),
(516, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=2.83\r\n							WHERE id=962'),
(517, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=10.05\r\n							WHERE id=966'),
(518, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=2.21\r\n							WHERE id=970'),
(519, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=6.25\r\n							WHERE id=973'),
(520, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=1.77\r\n							WHERE id=974'),
(521, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=5.78\r\n							WHERE id=992'),
(522, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=8.66\r\n							WHERE id=1004'),
(523, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=9.40\r\n							WHERE id=1006'),
(524, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=11.28\r\n							WHERE id=1007'),
(525, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=14.85\r\n							WHERE id=1197'),
(526, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=10.68\r\n							WHERE id=1196'),
(527, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=3.07\r\n							WHERE id=1017'),
(528, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=4.65\r\n							WHERE id=1022'),
(529, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=0.62\r\n							WHERE id=1100'),
(530, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=1.90\r\n							WHERE id=1101'),
(531, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=2.62\r\n							WHERE id=1029'),
(532, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=30.65\r\n							WHERE id=986'),
(533, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=7.21\r\n							WHERE id=989'),
(534, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=15.81\r\n							WHERE id=1194'),
(535, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=16.86\r\n							WHERE id=1195'),
(536, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=4.36\r\n							WHERE id=985'),
(537, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=5.08\r\n							WHERE id=1049'),
(538, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=3.88\r\n							WHERE id=1053'),
(539, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=1.86\r\n							WHERE id=1055'),
(540, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=4.14\r\n							WHERE id=1063'),
(541, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=2.22\r\n							WHERE id=1071'),
(542, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=0.78\r\n							WHERE id=1090'),
(543, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=1.22\r\n							WHERE id=1092'),
(544, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=2.68\r\n							WHERE id=1096'),
(545, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=10.78\r\n							WHERE id=1187'),
(546, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=5.00\r\n							WHERE id=1188'),
(547, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=3.00\r\n							WHERE id=1190'),
(548, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=16.70\r\n							WHERE id=1191'),
(549, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=5.29\r\n							WHERE id=1192'),
(550, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=3.85\r\n							WHERE id=1193'),
(551, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=0.48\r\n							WHERE id=1106'),
(552, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=4.00\r\n							WHERE id=1109'),
(553, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=9.63\r\n							WHERE id=1113'),
(554, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=15.08\r\n							WHERE id=1114'),
(555, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=1.00\r\n							WHERE id=1115'),
(556, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=5.09\r\n							WHERE id=1149'),
(557, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=13.80\r\n							WHERE id=1150'),
(558, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=1.22\r\n							WHERE id=1151'),
(559, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=3.45\r\n							WHERE id=1119'),
(560, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=10.29\r\n							WHERE id=1121'),
(561, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=2.91\r\n							WHERE id=1122'),
(562, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=6.25\r\n							WHERE id=1123'),
(563, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=2.33\r\n							WHERE id=1130'),
(564, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=23.00\r\n							WHERE id=1201'),
(565, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=1.35\r\n							WHERE id=1139'),
(566, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=0.73\r\n							WHERE id=1142'),
(567, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=0.50\r\n							WHERE id=1137'),
(568, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=1.32\r\n							WHERE id=1143'),
(569, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=2.28\r\n							WHERE id=1153'),
(570, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=2.09\r\n							WHERE id=1155'),
(571, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=4.86\r\n							WHERE id=1156'),
(572, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=12.46\r\n							WHERE id=1157'),
(573, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=0.71\r\n							WHERE id=1158'),
(574, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=1.73\r\n							WHERE id=1159'),
(575, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=1.60\r\n							WHERE id=1167'),
(576, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=3.78\r\n							WHERE id=1172'),
(577, 'admin', '2014-09-25 09:44:37', 'UPDATE estimacion SET\r\n							entregados=2.65\r\n							WHERE id=1074'),
(578, 'admin', '2014-09-25 14:52:55', 'UPDATE pagos SET \r\n				fecha=2014-09-25 04:52:44,\r\n				exportable=1499.00,\r\n				descarte=190.00,\r\n				fuera=0,\r\n				calidad=0,\r\n				cliente=45.00,\r\n				microlote=30.00,\r\n				tazadorada=0.00\r\n				WHERE id=3'),
(579, 'admin', '2014-09-25 14:53:16', 'UPDATE pagos SET \r\n				fecha=2014-09-25 04:53:10,\r\n				exportable=1499.00,\r\n				descarte=190.00,\r\n				fuera=0,\r\n				calidad=0,\r\n				cliente=45.00,\r\n				microlote=50.00,\r\n				tazadorada=0.00\r\n				WHERE id=3'),
(580, 'admin', '2014-09-25 14:53:37', 'UPDATE pagos SET \r\n				fecha=2014-09-25 04:53:29,\r\n				exportable=1499.00,\r\n				descarte=190.00,\r\n				fuera=0,\r\n				calidad=0,\r\n				cliente=45.00,\r\n				microlote=250.00,\r\n				tazadorada=300\r\n				WHERE id=3'),
(581, 'admin', '2014-09-26 05:49:17', 'UPDATE despachos SET\r\n				fecha=2014-09-24 18:18:41,\r\n				cantidad=2.5,\r\n				envio=1\r\n				WHERE id=1'),
(582, 'admin', '2014-09-28 05:31:15', 'INSERT INTO usuarios VALUES(,\r\n				Fran,\r\n				fran,\r\n				8410,\r\n				2)'),
(583, 'admin', '2014-09-28 20:10:43', 'INSERT INTO catas VALUES (,\r\n				APC-00628-14,\r\n				2014-09-28 10:09:18,\r\n				Catador,\r\n				5.5,\r\n				9.25,\r\n				Herbal,Vainilla,Neutral,\r\n				,\r\n				8.25,\r\n				Caramelo,Chocolate dulce,\r\n				,\r\n				9,\r\n				Refrescante,Dulce,\r\n				,\r\n				9.5,\r\n				9,\r\n				8.75,\r\n				9,\r\n				9,\r\n				8.25,\r\n				8.75,\r\n				,\r\n				88.75,\r\n				0,\r\n				0,				\r\n				0,\r\n				0,				\r\n				0,\r\n				0,				\r\n				0,\r\n				0,				\r\n				0,\r\n				0,				\r\n				0,\r\n				0,				\r\n				0,				\r\n				0,\r\n				0,				\r\n				0,\r\n				0,				\r\n				0,\r\n				0				\r\n				)'),
(584, 'admin', '2014-09-28 20:11:11', 'UPDATE catas SET\r\n				fecha =2014-09-28 10:09:18,\r\n				catador =Catador,\r\n				tostado =6,\r\n				fragancia =9.25,\r\n				tipo_aroma1 =Herbal,Vainilla,Neutral,\r\n				nota_aroma =,\r\n				sabor =8,\r\n				tipo_sabor =Caramelo,Chocolate dulce,\r\n				nota_sabor =,\r\n				sabor_residual =8.25,\r\n				tipo_sabor_residual =Refrescante,Dulce,\r\n				nota_sabor_residual =,\r\n				acidez =9.5,\r\n				cuerpo =8,\r\n				uniformidad =8.75,\r\n				balance =9,\r\n				puntaje_catador =9,\r\n				taza_limpia =8.25,\r\n				dulzor =8.75,\r\n				nota_catacion =,\r\n				puntuacion =86.75,\r\n				d_fermento=0,\r\n				d_metalico=0,				\r\n				d_quimico=0,\r\n				d_vinagre=0,				\r\n				d_stinker=0,\r\n				d_fenol=0,				\r\n				d_reposo=0,\r\n				d_moho=0,				\r\n				d_terroso=0,\r\n				d_extrano=0,				\r\n				d_sucio=0,\r\n				d_astringente=0,				\r\n				d_quaquers=0,				\r\n				dl_cereal=0,\r\n				dl_fermento=0,				\r\n				dl_reposo=0,\r\n				dl_moho=0,				\r\n				dl_astringencia=0,\r\n				d_general=0				\r\n				\r\n				WHERE lote=APC-00628-14'),
(585, 'admin', '2014-09-28 20:11:24', 'UPDATE catas SET\r\n				fecha =2014-09-28 10:09:18,\r\n				catador =Catador,\r\n				tostado =6,\r\n				fragancia =9.25,\r\n				tipo_aroma1 =Herbal,Vainilla,Neutral,\r\n				nota_aroma =,\r\n				sabor =8,\r\n				tipo_sabor =Caramelo,Chocolate dulce,\r\n				nota_sabor =,\r\n				sabor_residual =8.25,\r\n				tipo_sabor_residual =Refrescante,Dulce,\r\n				nota_sabor_residual =,\r\n				acidez =9.5,\r\n				cuerpo =8,\r\n				uniformidad =8.75,\r\n				balance =8,\r\n				puntaje_catador =9,\r\n				taza_limpia =8.25,\r\n				dulzor =8.75,\r\n				nota_catacion =,\r\n				puntuacion =85.75,\r\n				d_fermento=0,\r\n				d_metalico=0,				\r\n				d_quimico=0,\r\n				d_vinagre=0,				\r\n				d_stinker=0,\r\n				d_fenol=0,				\r\n				d_reposo=0,\r\n				d_moho=0,				\r\n				d_terroso=0,\r\n				d_extrano=0,				\r\n				d_sucio=0,\r\n				d_astringente=0,				\r\n				d_quaquers=0,				\r\n				dl_cereal=0,\r\n				dl_fermento=0,				\r\n				dl_reposo=0,\r\n				dl_moho=0,				\r\n				dl_astringencia=0,\r\n				d_general=0				\r\n				\r\n				WHERE lote=APC-00628-14'),
(586, 'admin', '2014-09-28 20:11:38', 'UPDATE catas SET\r\n				fecha =2014-09-28 10:09:18,\r\n				catador =Catador,\r\n				tostado =6,\r\n				fragancia =8.75,\r\n				tipo_aroma1 =Herbal,Vainilla,Neutral,\r\n				nota_aroma =,\r\n				sabor =8,\r\n				tipo_sabor =Caramelo,Chocolate dulce,\r\n				nota_sabor =,\r\n				sabor_residual =8.25,\r\n				tipo_sabor_residual =Refrescante,Dulce,\r\n				nota_sabor_residual =,\r\n				acidez =9.5,\r\n				cuerpo =8,\r\n				uniformidad =8.75,\r\n				balance =8,\r\n				puntaje_catador =9,\r\n				taza_limpia =8.25,\r\n				dulzor =8.75,\r\n				nota_catacion =,\r\n				puntuacion =85.25,\r\n				d_fermento=0,\r\n				d_metalico=0,				\r\n				d_quimico=0,\r\n				d_vinagre=0,				\r\n				d_stinker=0,\r\n				d_fenol=0,				\r\n				d_reposo=0,\r\n				d_moho=0,				\r\n				d_terroso=0,\r\n				d_extrano=0,				\r\n				d_sucio=0,\r\n				d_astringente=0,				\r\n				d_quaquers=0,				\r\n				dl_cereal=0,\r\n				dl_fermento=0,				\r\n				dl_reposo=0,\r\n				dl_moho=0,				\r\n				dl_astringencia=0,\r\n				d_general=0				\r\n				\r\n				WHERE lote=APC-00628-14'),
(587, 'admin', '2014-09-28 23:02:07', 'INSERT INTO despachos VALUES(,\r\n				APC-163,\r\n				2014-09-28 13:01:57,\r\n				3.12,\r\n				2)'),
(588, 'admin', '2014-09-28 23:02:39', 'INSERT INTO despachos VALUES(,\r\n				APC-00629-14,\r\n				2014-09-28 13:02:33,\r\n				0.57,\r\n				3)'),
(589, 'admin', '2014-09-28 23:03:28', 'INSERT INTO despachos VALUES(,\r\n				APC-00626-14,\r\n				2014-09-28 13:03:20,\r\n				4.5,\r\n				2)'),
(590, 'admin', '2014-09-29 07:30:25', 'UPDATE configuracion SET \r\n				valor=85\r\n				WHERE id=1'),
(591, 'admin', '2014-09-29 07:30:36', 'UPDATE configuracion SET \r\n				valor=85.00\r\n				WHERE id=1'),
(592, 'admin', '2014-09-29 07:40:05', 'UPDATE configuracion SET \r\n				valor=84\r\n				WHERE id=1'),
(593, 'admin', '2014-09-30 03:15:19', 'UPDATE subparcelas SET \r\n				id_parcela=1,\r\n				superficie=0.50,\r\n				variedad=catucaí,\r\n				variedad2=catucaí,\r\n				siembra=0,\r\n				densidad=0,\r\n				marco=Regular,\r\n				hierbas=Limpio,\r\n				sombreado=Poco,\r\n				roya=0,\r\n				broca=0,\r\n				ojo_pollo=0,\r\n				mes_inicio_cosecha=julio,\r\n				duracion_cosecha=0\r\n				WHERE id=1'),
(594, 'admin', '2014-09-30 03:15:33', 'UPDATE subparcelas SET \r\n				id_parcela=1,\r\n				superficie=0.50,\r\n				variedad=catucaí,\r\n				variedad2=catucaí,\r\n				siembra=0,\r\n				densidad=0,\r\n				marco=Regular,\r\n				hierbas=Medio,\r\n				sombreado=Medio,\r\n				roya=0,\r\n				broca=0,\r\n				ojo_pollo=0,\r\n				mes_inicio_cosecha=julio,\r\n				duracion_cosecha=0\r\n				WHERE id=1'),
(595, 'admin', '2014-09-30 03:15:59', 'UPDATE subparcelas SET \r\n				id_parcela=1,\r\n				superficie=0.50,\r\n				variedad=catucaí,\r\n				variedad2=criollo,\r\n				siembra=0,\r\n				densidad=0,\r\n				marco=Regular,\r\n				hierbas=Limpio,\r\n				sombreado=Poco,\r\n				roya=0,\r\n				broca=0,\r\n				ojo_pollo=0,\r\n				mes_inicio_cosecha=julio,\r\n				duracion_cosecha=0\r\n				WHERE id=1'),
(596, 'admin', '2014-09-30 03:16:51', 'UPDATE subparcelas SET \r\n				id_parcela=1,\r\n				superficie=3,\r\n				variedad=tipica,\r\n				variedad2=colombia6,\r\n				siembra=1945,\r\n				densidad=1500,\r\n				marco=Medio,\r\n				hierbas=Medio,\r\n				sombreado=Poco,\r\n				roya=75,\r\n				broca=0,\r\n				ojo_pollo=0,\r\n				mes_inicio_cosecha=agosto,\r\n				duracion_cosecha=1\r\n				WHERE id=2'),
(597, 'admin', '2014-09-30 03:33:11', 'UPDATE subparcelas SET \r\n				id_parcela=1,\r\n				superficie=0.50,\r\n				variedad=catucaí,\r\n				variedad2=criollo,\r\n				siembra=0,\r\n				densidad=0,\r\n				marco=Regular,\r\n				hierbas=Limpio,\r\n				sombreado=Poco,\r\n				roya=0,\r\n				broca=0,\r\n				ojo_pollo=0,\r\n				mes_inicio_cosecha=julio,\r\n				duracion_cosecha=0\r\n				WHERE id=1'),
(598, 'admin', '2014-09-30 03:37:22', 'UPDATE parcelas SET \r\n				sup_total=2.00,\r\n				coorX=234234,\r\n				coorY=234234,\r\n				alti=2345,\r\n				id_socio=SF52,\r\n				MOcontratada=,\r\n				MOfamiliar=,\r\n				miembros_familia=,\r\n				riego=Goteo\r\n				WHERE id=1'),
(599, 'admin', '2014-09-30 03:40:16', 'UPDATE parcelas SET \r\n				sup_total=2.00,\r\n				coorX=234234,\r\n				coorY=234234,\r\n				alti=2345,\r\n				id_socio=SF52,\r\n				MOcontratada=5,\r\n				MOfamiliar=2,\r\n				miembros_familia=2,\r\n				riego=Aspersión\r\n				WHERE id=1'),
(600, 'admin', '2014-09-30 03:41:31', 'UPDATE parcelas SET \r\n				sup_total=2.00,\r\n				coorX=234234,\r\n				coorY=234234,\r\n				alti=2345,\r\n				id_socio=SF52,\r\n				MOcontratada=5,\r\n				MOfamiliar=2,\r\n				Miembros_familia=2,\r\n				riego=Gravedad\r\n				WHERE id=1'),
(601, 'admin', '2014-09-30 03:53:46', 'INSERT INTO parcelas VALUES (,SF52,34534666,254234534,1432,\r\n				12,4,3,3,\r\n				Aspersión)'),
(602, 'admin', '2014-09-30 04:08:38', 'INSERT INTO subparcelas VALUES (,\r\n				2,\r\n				1.45,\r\n				tipica,\r\n				criollo,\r\n				1974,\r\n				1500,\r\n				Medio,\r\n				Medio,\r\n				Medio,\r\n				50,\r\n				25,\r\n				25,\r\n				Agosto,\r\n				3)'),
(603, 'admin', '2014-09-30 04:15:26', 'INSERT INTO subparcelas VALUES (,\r\n				2,\r\n				5,\r\n				criollo,\r\n				catimoro,\r\n				2006,\r\n				2000,\r\n				Regular,\r\n				Limpio,\r\n				Medio,\r\n				0,\r\n				0,\r\n				0,\r\n				agosto,\r\n				4)'),
(604, 'admin', '2014-09-30 04:19:01', 'INSERT INTO subparcelas VALUES (,\r\n				2,\r\n				4,\r\n				catucaí,\r\n				catucaí,\r\n				,\r\n				,\r\n				Regular,\r\n				Limpio,\r\n				Poco,\r\n				0,\r\n				0,\r\n				0,\r\n				,\r\n				)'),
(605, 'admin', '2014-09-30 04:20:13', 'INSERT INTO subparcelas VALUES (,\r\n				2,\r\n				10,\r\n				catucaí,\r\n				catucaí,\r\n				,\r\n				,\r\n				Regular,\r\n				Limpio,\r\n				Poco,\r\n				0,\r\n				0,\r\n				0,\r\n				,\r\n				)'),
(606, 'admin', '2014-09-30 04:28:46', 'DELETE FROM parcelas WHERE id=1'),
(607, 'admin', '2014-09-30 04:28:46', 'DELETE FROM subparcelas WHERE id_parcela=1'),
(608, 'admin', '2014-09-30 04:34:50', ''),
(609, 'admin', '2014-09-30 04:35:17', ''),
(610, 'admin', '2014-09-30 04:35:41', 'DELETE FROM subparcelas WHERE id=2'),
(611, 'admin', '2014-09-30 04:36:36', 'DELETE FROM subparcelas WHERE id=2'),
(612, 'admin', '2014-09-30 04:37:50', 'DELETE FROM subparcelas WHERE id=2'),
(613, 'admin', '2014-09-30 04:39:05', 'UPDATE subparcelas SET \r\n				id_parcela=2,\r\n				superficie=5.00,\r\n				variedad=criollo,\r\n				variedad2=catimoro,\r\n				siembra=2006,\r\n				densidad=2000,\r\n				marco=Regular,\r\n				hierbas=Limpio,\r\n				sombreado=Medio,\r\n				roya=75,\r\n				broca=0,\r\n				ojo_pollo=0,\r\n				mes_inicio_cosecha=agosto,\r\n				duracion_cosecha=4\r\n				WHERE id=4'),
(614, 'admin', '2014-09-30 04:39:45', 'DELETE FROM subparcelas WHERE id=2'),
(615, 'admin', '2014-09-30 04:42:25', 'DELETE FROM subparcelas WHERE id=2'),
(616, 'admin', '2014-09-30 04:42:43', 'DELETE FROM subparcelas WHERE id=2'),
(617, 'admin', '2014-09-30 04:43:33', 'DELETE FROM subparcelas WHERE id=4'),
(618, 'admin', '2014-09-30 04:45:18', 'INSERT INTO parcelas VALUES (,AN05,34533434,234566,1673,\r\n				25,4,5,6,\r\n				Gravedad)'),
(619, 'admin', '2014-09-30 04:45:53', 'INSERT INTO subparcelas VALUES (,\r\n				3,\r\n				6,\r\n				criollo,\r\n				catimoro,\r\n				2002,\r\n				1233,\r\n				Medio,\r\n				Medio,\r\n				Medio,\r\n				50,\r\n				50,\r\n				0,\r\n				Octubre,\r\n				3)'),
(620, 'admin', '2014-09-30 04:48:35', 'INSERT INTO subparcelas VALUES (,\r\n				2,\r\n				3,\r\n				tipica,\r\n				criollo,\r\n				2005,\r\n				1500,\r\n				Regular,\r\n				Limpio,\r\n				Poco,\r\n				0,\r\n				0,\r\n				0,\r\n				julio,\r\n				3)'),
(621, 'admin', '2014-09-30 04:49:11', 'INSERT INTO subparcelas VALUES (,\r\n				2,\r\n				5,\r\n				tipica,\r\n				catimoro,\r\n				1996,\r\n				1500,\r\n				Medio,\r\n				Medio,\r\n				Medio,\r\n				0,\r\n				0,\r\n				0,\r\n				julio,\r\n				3)'),
(622, 'admin', '2014-09-30 05:49:12', ''),
(623, 'admin', '2014-09-30 05:49:42', 'INSERT INTO asociaciones VALUES (,caña,\r\n												 bajo,\r\n												 cultivos,\r\n												 parcela,\r\n												 3)'),
(624, 'admin', '2014-09-30 05:50:13', 'INSERT INTO asociaciones VALUES (,cítrico,\r\n												 medio,\r\n												 cultivos,\r\n												 parcela,\r\n												 3)'),
(625, 'admin', '2014-09-30 05:50:31', 'INSERT INTO asociaciones VALUES (,caña,\r\n												 bajo,\r\n												 cultivos,\r\n												 parcela,\r\n												 3)'),
(626, 'admin', '2014-09-30 05:51:01', 'INSERT INTO asociaciones VALUES (,chanchos,\r\n												 medio,\r\n												 animales,\r\n												 parcela,\r\n												 3)'),
(627, 'admin', '2014-09-30 05:51:07', 'INSERT INTO asociaciones VALUES (,caña,\r\n												 medio,\r\n												 cultivos,\r\n												 parcela,\r\n												 3)'),
(628, 'admin', '2014-09-30 18:42:51', 'DELETE FROM asociaciones WHERE id=4'),
(629, 'admin', '2014-09-30 18:43:24', 'INSERT INTO asociaciones VALUES (,cuyes,\r\n												 bajo,\r\n												 animales,\r\n												 parcela,\r\n												 3)'),
(630, 'admin', '2014-09-30 18:43:30', 'INSERT INTO asociaciones VALUES (,gallinas,\r\n												 medio,\r\n												 animales,\r\n												 parcela,\r\n												 3)'),
(631, 'admin', '2014-09-30 18:43:36', 'DELETE FROM asociaciones WHERE id=6'),
(632, 'admin', '2014-09-30 18:44:05', 'DELETE FROM asociaciones WHERE id=6'),
(633, 'admin', '2014-09-30 18:45:34', 'DELETE FROM asociaciones WHERE id=6'),
(634, 'admin', '2014-09-30 18:52:04', 'DELETE FROM asociaciones WHERE id=6'),
(635, 'admin', '2014-09-30 18:52:24', 'DELETE FROM asociaciones WHERE id=6'),
(636, 'admin', '2014-09-30 18:53:00', 'DELETE FROM asociaciones WHERE id=6'),
(637, 'admin', '2014-09-30 18:53:23', 'DELETE FROM asociaciones WHERE id=6'),
(638, 'admin', '2014-09-30 18:54:24', 'DELETE FROM asociaciones WHERE id=6'),
(639, 'admin', '2014-09-30 18:54:45', 'DELETE FROM asociaciones WHERE id=7');
INSERT INTO `acciones` (`id`, `user`, `fecha`, `accion`) VALUES
(640, 'admin', '2014-09-30 18:54:48', 'INSERT INTO asociaciones VALUES (,cuyes,\r\n												 bajo,\r\n												 animales,\r\n												 parcela,\r\n												 3)'),
(641, 'admin', '2014-09-30 18:55:34', 'INSERT INTO asociaciones VALUES (,vacas,\r\n												 bajo,\r\n												 animales,\r\n												 parcela,\r\n												 3)'),
(642, 'admin', '2014-09-30 18:55:41', 'INSERT INTO asociaciones VALUES (,faike,\r\n												 bajo,\r\n												 cultivo,\r\n												 parcela,\r\n												 3)'),
(643, 'admin', '2014-09-30 18:55:46', 'DELETE FROM asociaciones WHERE id=5'),
(644, 'admin', '2014-09-30 18:55:50', 'DELETE FROM asociaciones WHERE id=9'),
(645, 'admin', '2014-09-30 18:55:57', 'DELETE FROM asociaciones WHERE id=3'),
(646, 'admin', '2014-09-30 18:55:59', 'DELETE FROM asociaciones WHERE id=2'),
(647, 'admin', '2014-09-30 19:05:45', 'UPDATE configuracion SET \r\n				valor=chanchos,gallinas,cuyes,vacas\r\n				WHERE id=4'),
(648, 'admin', '2014-09-30 19:34:10', 'DELETE FROM asociaciones WHERE id=8'),
(649, 'admin', '2014-09-30 19:38:54', 'INSERT INTO asociaciones VALUES (,gallinas,\r\n												 bajo,\r\n												 animales,\r\n												 parcela,\r\n												 3)'),
(650, 'admin', '2014-09-30 20:07:23', 'INSERT INTO asociaciones VALUES (,guayaba,\r\n												 bajo,\r\n												 cultivo,\r\n												 subparcela,\r\n												 7)'),
(651, 'admin', '2014-09-30 20:07:29', 'INSERT INTO asociaciones VALUES (,faike,\r\n												 bajo,\r\n												 cultivo,\r\n												 subparcela,\r\n												 7)'),
(652, 'admin', '2014-09-30 20:07:33', 'DELETE FROM asociaciones WHERE id=13'),
(653, 'admin', '2014-09-30 20:12:20', 'INSERT INTO asociaciones VALUES (,guayaba,\r\n												 medio,\r\n												 cultivo,\r\n												 subparcela,\r\n												 8)'),
(654, 'admin', '2014-09-30 20:15:10', 'INSERT INTO asociaciones VALUES (,faike,\r\n												 medio,\r\n												 cultivo,\r\n												 subparcela,\r\n												 9)'),
(655, 'admin', '2014-09-30 20:15:16', 'INSERT INTO asociaciones VALUES (,guineo,\r\n												 bajo,\r\n												 cultivo,\r\n												 subparcela,\r\n												 9)'),
(656, 'admin', '2014-09-30 20:23:35', 'INSERT INTO asociaciones VALUES (,guayaba,\r\n												 medio,\r\n												 cultivo,\r\n												 parcela,\r\n												 2)'),
(657, 'admin', '2014-09-30 20:23:38', 'INSERT INTO asociaciones VALUES (,faike,\r\n												 bajo,\r\n												 cultivo,\r\n												 parcela,\r\n												 2)'),
(658, 'admin', '2014-09-30 20:23:41', 'INSERT INTO asociaciones VALUES (,guineo,\r\n												 bajo,\r\n												 cultivo,\r\n												 parcela,\r\n												 2)'),
(659, 'admin', '2014-09-30 20:23:44', 'INSERT INTO asociaciones VALUES (,gallinas,\r\n												 bajo,\r\n												 animales,\r\n												 parcela,\r\n												 2)'),
(660, 'admin', '2014-09-30 20:23:47', 'INSERT INTO asociaciones VALUES (,cuyes,\r\n												 bajo,\r\n												 animales,\r\n												 parcela,\r\n												 2)'),
(661, 'admin', '2014-09-30 20:25:51', 'INSERT INTO asociaciones VALUES (,cítrico,\r\n												 bajo,\r\n												 cultivo,\r\n												 subparcela,\r\n												 8)'),
(662, 'admin', '2014-09-30 20:25:55', 'INSERT INTO asociaciones VALUES (,maíz,\r\n												 bajo,\r\n												 cultivo,\r\n												 subparcela,\r\n												 8)'),
(663, 'admin', '2014-09-30 22:40:27', 'UPDATE configuracion SET \r\n				valor=caña,yuca,naranja,guayaba,guaba,faike,maíz,platano,cacao,huerto,papaya,pasto\r\n				WHERE id=3'),
(664, 'admin', '2014-09-30 22:40:51', 'UPDATE configuracion SET \r\n				valor=chanchos,gallinas,cuyes,vacas,colmenas,estanque,ganado\r\n				WHERE id=4'),
(665, 'admin', '2014-10-01 04:04:31', 'UPDATE lotes SET \r\n				id_socio=SF52,\r\n				codigo_lote=APC-00628-14,\r\n				fecha=2014-09-22 12:53:10,\r\n				peso=6.00,\r\n				humedad=12.00,\r\n				rto_descarte=20,\r\n				rto_exportable=200,\r\n				defecto_negro=0,\r\n				defecto_vinagre=0,\r\n				defecto_decolorado=0,\r\n				defecto_mordido=0,\r\n				defecto_brocado=0,\r\n				reposo=0,\r\n				moho=0,\r\n				fermento=0,\r\n				contaminado=0,\r\n				calidad=A\r\n				\r\n			where id=175'),
(666, 'admin', '2014-10-01 05:13:45', 'UPDATE configuracion SET \r\n				valor=Nombre de la Asociación\r\n				WHERE id=7'),
(667, 'admin', '2014-10-28 05:57:06', 'INSERT INTO analisis VALUES (,\r\n				13,\r\n				2,\r\n				3,\r\n				sub-angular,\r\n				moderado,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				franco,\r\n				,\r\n				,\r\n				)'),
(668, 'admin', '2014-10-28 06:01:06', 'INSERT INTO analisis VALUES (,\r\n				13,\r\n				4,\r\n				3,\r\n				sub-angular,\r\n				moderado,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				1,\r\n				33,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				limoso,\r\n				,\r\n				,\r\n				)'),
(669, 'admin', '2014-10-28 06:05:25', 'INSERT INTO analisis VALUES (,\r\n				13,\r\n				2014-10-27,\r\n				5,\r\n				44,\r\n				granular,\r\n				fuerte,\r\n				34,\r\n				,\r\n				,\r\n				34,\r\n				0,\r\n				65,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				arcilloso,\r\n				,\r\n				,\r\n				)'),
(670, 'admin', '2014-10-28 09:24:49', 'DELETE FROM analisis WHERE id_analisis=3'),
(671, 'admin', '2014-10-28 09:39:26', 'INSERT INTO analisis VALUES (,\r\n				13,\r\n				2014-10-27,\r\n				3,\r\n				2,\r\n				granular,\r\n				moderado,\r\n				33,\r\n				44,\r\n				55,\r\n				23,\r\n				1,\r\n				23,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				limoso,\r\n				,\r\n				,\r\n				)'),
(672, 'admin', '2014-10-28 09:41:37', 'UPDATE analisis SET\r\n				id_subparcela=13,\r\n				fecha=2014-10-27,\r\n				muestra=3,\r\n				submuestras=2,\r\n				estructura=granular,\r\n				grado=moderado,\r\n				rocas=33,\r\n				rocas_size=44,\r\n				profundidad=55,\r\n				pendiente=23,\r\n				lombrices=1,\r\n				densidad_aparente=23.00,\r\n				observaciones=,\r\n				s_ph=0.00,\r\n				s_n=0.00,\r\n				s_p=0.00,\r\n				s_k=0.00,\r\n				s_mo=0.00,\r\n				s_textura=limoso,\r\n				f_n=0.00,\r\n				f_p=0.00,\r\n				f_k=0.00\r\n				\r\n				WHERE id_analisis='),
(673, 'admin', '2014-10-28 09:43:21', 'UPDATE analisis SET\r\n				id_subparcela=13,\r\n				fecha=2014-10-27,\r\n				muestra=3,\r\n				submuestras=2,\r\n				estructura=granular,\r\n				grado=moderado,\r\n				rocas=33,\r\n				rocas_size=44,\r\n				profundidad=55,\r\n				pendiente=23,\r\n				lombrices=1,\r\n				densidad_aparente=23.00,\r\n				observaciones=,\r\n				s_ph=0.00,\r\n				s_n=0.00,\r\n				s_p=0.00,\r\n				s_k=0.00,\r\n				s_mo=0.00,\r\n				s_textura=limoso,\r\n				f_n=0.00,\r\n				f_p=0.00,\r\n				f_k=0.00\r\n				\r\n				WHERE id_analisis=4'),
(674, 'admin', '2014-10-28 09:44:15', 'UPDATE analisis SET\r\n				id_subparcela=13,\r\n				fecha=2014-10-27,\r\n				muestra=3,\r\n				submuestras=2,\r\n				estructura=granular,\r\n				grado=moderado,\r\n				rocas=33,\r\n				rocas_size=44,\r\n				profundidad=55,\r\n				pendiente=23,\r\n				lombrices=1,\r\n				densidad_aparente=23.00,\r\n				observaciones=,\r\n				s_ph=0.00,\r\n				s_n=0.00,\r\n				s_p=0.00,\r\n				s_k=0.00,\r\n				s_mo=0.00,\r\n				s_textura=franco,\r\n				f_n=0.00,\r\n				f_p=0.00,\r\n				f_k=0.00\r\n				\r\n				WHERE id_analisis=4'),
(675, 'admin', '2014-10-28 09:45:01', 'UPDATE analisis SET\r\n				id_subparcela=13,\r\n				fecha=2014-10-27,\r\n				muestra=3,\r\n				submuestras=2,\r\n				estructura=angular,\r\n				grado=moderado,\r\n				rocas=33,\r\n				rocas_size=44,\r\n				profundidad=55,\r\n				pendiente=23,\r\n				lombrices=1,\r\n				densidad_aparente=23.00,\r\n				observaciones=,\r\n				s_ph=0.00,\r\n				s_n=0.00,\r\n				s_p=0.00,\r\n				s_k=0.00,\r\n				s_mo=0.00,\r\n				s_textura=franco,\r\n				f_n=0.00,\r\n				f_p=0.00,\r\n				f_k=0.00\r\n				\r\n				WHERE id_analisis=4'),
(676, 'admin', '2014-10-28 09:45:15', 'UPDATE analisis SET\r\n				id_subparcela=13,\r\n				fecha=2014-10-27,\r\n				muestra=3,\r\n				submuestras=2,\r\n				estructura=granular,\r\n				grado=fuerte,\r\n				rocas=33,\r\n				rocas_size=44,\r\n				profundidad=55,\r\n				pendiente=23,\r\n				lombrices=1,\r\n				densidad_aparente=23.00,\r\n				observaciones=,\r\n				s_ph=0.00,\r\n				s_n=0.00,\r\n				s_p=0.00,\r\n				s_k=0.00,\r\n				s_mo=0.00,\r\n				s_textura=franco,\r\n				f_n=0.00,\r\n				f_p=0.00,\r\n				f_k=0.00\r\n				\r\n				WHERE id_analisis=4'),
(677, 'admin', '2014-10-28 09:45:26', 'UPDATE analisis SET\r\n				id_subparcela=13,\r\n				fecha=2014-10-27,\r\n				muestra=3,\r\n				submuestras=2,\r\n				estructura=granular,\r\n				grado=fuerte,\r\n				rocas=33,\r\n				rocas_size=44,\r\n				profundidad=55,\r\n				pendiente=23,\r\n				lombrices=0,\r\n				densidad_aparente=23.00,\r\n				observaciones=,\r\n				s_ph=0.00,\r\n				s_n=0.00,\r\n				s_p=0.00,\r\n				s_k=0.00,\r\n				s_mo=0.00,\r\n				s_textura=franco,\r\n				f_n=0.00,\r\n				f_p=0.00,\r\n				f_k=0.00\r\n				\r\n				WHERE id_analisis=4'),
(678, 'admin', '2014-10-28 10:08:24', 'DELETE FROM analisis WHERE id_analisis=4'),
(679, 'admin', '2014-10-28 22:02:54', 'INSERT INTO asociaciones VALUES (,yuca,\r\n												 medio,\r\n												 cultivo,\r\n												 subparcela,\r\n												 1)'),
(680, 'admin', '2014-10-28 22:03:07', 'DELETE FROM asociaciones WHERE id=708'),
(681, 'admin', '2014-10-28 22:03:14', 'INSERT INTO asociaciones VALUES (,cacao,\r\n												 alto,\r\n												 cultivo,\r\n												 subparcela,\r\n												 1)'),
(682, 'admin', '2014-10-28 22:03:17', 'DELETE FROM asociaciones WHERE id=709'),
(683, 'admin', '2014-10-29 05:14:18', 'INSERT INTO grupos VALUES(,\r\n				nuevo,\r\n				NV)'),
(684, 'admin', '2014-10-29 05:44:00', 'DELETE FROM grupos WHERE id=24'),
(685, 'admin', '2014-10-29 05:57:24', 'INSERT INTO grupos VALUES(,\r\n				nuevo,\r\n				NV)'),
(686, 'admin', '2014-10-29 05:57:28', 'DELETE FROM grupos WHERE id=25'),
(687, 'admin', '2014-10-29 06:29:26', 'INSERT INTO socios VALUES(,\r\n				Francisco,\r\n				García,\r\n				1,\r\n				,\r\n				,\r\n				,\r\n				franjmontero@gmail.com,\r\n				C/ Carmen de Burgos 3, 4J,\r\n				AGRODIN,\r\n				,\r\n				,\r\n				,)'),
(688, 'admin', '2014-10-29 06:31:09', 'INSERT INTO socios VALUES(,\r\n				Francisco,\r\n				García,\r\n				01,\r\n				,\r\n				,\r\n				,\r\n				franjmontero@gmail.com,\r\n				C/ Carmen de Burgos 3, 4J,\r\n				,\r\n				l,\r\n				,\r\n				,)'),
(689, 'admin', '2014-10-29 06:32:35', 'INSERT INTO socios VALUES(,\r\n				Francisco,\r\n				García,\r\n				1,\r\n				,\r\n				,\r\n				,\r\n				franjmontero@gmail.com,\r\n				C/ Carmen de Burgos 3, 4J,\r\n				FATIMA,\r\n				,\r\n				,\r\n				,)'),
(690, 'admin', '2014-10-29 06:36:39', 'INSERT INTO socios VALUES(,\r\n				Francisco,\r\n				García,\r\n				1,\r\n				,\r\n				,\r\n				,\r\n				franjmontero@gmail.com,\r\n				C/ Carmen de Burgos 3, 4J,\r\n				EMPROAGRO,\r\n				,\r\n				,\r\n				,masculino)'),
(691, 'admin', '2014-10-29 06:37:40', 'INSERT INTO socios VALUES(,\r\n				Francisco,\r\n				García,\r\n				LM8,\r\n				,\r\n				,\r\n				,\r\n				franjmontero@gmail.com,\r\n				C/ Carmen de Burgos 3, 4J,\r\n				EMPROAGRO,\r\n				,\r\n				,\r\n				,masculino)'),
(692, 'admin', '2014-10-29 06:41:40', 'INSERT INTO socios VALUES(,\r\n				Francisco,\r\n				García,\r\n				LE20,\r\n				,\r\n				,\r\n				,\r\n				franjmontero@gmail.com,\r\n				C/ Carmen de Burgos 3, 4J,\r\n				ENTIERROS,\r\n				,\r\n				,\r\n				,masculino)'),
(693, 'admin', '2014-10-30 22:03:52', 'INSERT INTO analisis VALUES (,\r\n				1,\r\n				2014-10-30,\r\n				55,\r\n				44,\r\n				granular,\r\n				moderado,\r\n				55,\r\n				,\r\n				,\r\n				,\r\n				0,\r\n				14.2,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				,\r\n				15.6,\r\n				45.9,\r\n				,\r\n				franco,\r\n				,\r\n				,\r\n				)'),
(694, 'admin', '2014-10-30 22:06:08', 'UPDATE analisis SET\r\n				id_subparcela=1,\r\n				fecha=2014-10-30,\r\n				muestra=55,\r\n				submuestras=44,\r\n				estructura=granular,\r\n				grado=moderado,\r\n				rocas=55,\r\n				rocas_size=0,\r\n				profundidad=0,\r\n				pendiente=0,\r\n				lombrices=0,\r\n				densidad_aparente=14.20,\r\n				observaciones=,\r\n				s_ph=0.00,\r\n				s_n=0.00,\r\n				s_p=0.00,\r\n				s_k=80.2,\r\n				s_ca=,\r\n				s_mg=,\r\n				s_mo=0.00,\r\n				s_textura=franco,\r\n				f_n=0.00,\r\n				f_p=0.00,\r\n				f_k=0.00\r\n				\r\n				WHERE id_analisis=1'),
(695, 'admin', '2014-10-30 22:07:12', 'UPDATE analisis SET\r\n				id_subparcela=1,\r\n				fecha=2014-10-30,\r\n				muestra=55,\r\n				submuestras=44,\r\n				estructura=granular,\r\n				grado=moderado,\r\n				rocas=55,\r\n				rocas_size=0,\r\n				profundidad=0,\r\n				pendiente=0,\r\n				lombrices=0,\r\n				densidad_aparente=14.20,\r\n				observaciones=,\r\n				s_ph=0.00,\r\n				s_n=0.00,\r\n				s_p=0.00,\r\n				s_k=65.9,\r\n				s_ca=45.7,\r\n				s_mg=34.9,\r\n				s_mo=0.00,\r\n				s_textura=franco,\r\n				f_n=0.00,\r\n				f_p=0.00,\r\n				f_k=567\r\n				\r\n				WHERE id_analisis=1'),
(696, 'admin', '2014-10-30 22:07:24', 'UPDATE analisis SET\r\n				id_subparcela=1,\r\n				fecha=2014-10-30,\r\n				muestra=55,\r\n				submuestras=44,\r\n				estructura=granular,\r\n				grado=moderado,\r\n				rocas=55,\r\n				rocas_size=0,\r\n				profundidad=0,\r\n				pendiente=0,\r\n				lombrices=1,\r\n				densidad_aparente=14.20,\r\n				observaciones=,\r\n				s_ph=0.00,\r\n				s_n=0.00,\r\n				s_p=0.00,\r\n				s_k=65.90,\r\n				s_ca=45.70,\r\n				s_mg=34.90,\r\n				s_mo=0.00,\r\n				s_textura=franco,\r\n				f_n=0.00,\r\n				f_p=0.00,\r\n				f_k=567.00\r\n				\r\n				WHERE id_analisis=1'),
(697, 'admin', '2014-10-30 22:12:00', 'DELETE FROM analisis WHERE id_analisis=1'),
(698, 'admin', '2014-12-12 23:51:21', 'DELETE FROM lotes WHERE id=176'),
(699, 'admin', '2014-12-12 23:51:52', 'DELETE FROM lotes WHERE id=175'),
(700, 'admin', '2014-12-12 23:52:02', 'DELETE FROM lotes WHERE id=174'),
(701, 'admin', '2014-12-12 23:52:09', 'DELETE FROM lotes WHERE id=173'),
(702, 'admin', '2015-01-12 02:38:24', 'INSERT INTO analisis VALUES (,\r\n				1,\r\n				2015-01-11,\r\n				2,\r\n				2,\r\n				angular,\r\n				débil,\r\n				25,\r\n				10,\r\n				25,\r\n				30,\r\n				1,\r\n				25,\r\n				,\r\n				5.5,\r\n				12.2,\r\n				15.2,\r\n				15.6,\r\n				45.2,\r\n				25,\r\n				25,\r\n				arcilloso,\r\n				25,\r\n				50,\r\n				124)'),
(703, 'admin', '2015-01-12 02:47:02', 'INSERT INTO analisis VALUES (,\r\n				12,\r\n				2015-01-11,\r\n				3,\r\n				4,\r\n				granular,\r\n				débil,\r\n				44,\r\n				44,\r\n				44,\r\n				44,\r\n				0,\r\n				44,\r\n				,\r\n				44,\r\n				44,\r\n				44,\r\n				44,\r\n				4,\r\n				44,\r\n				44,\r\n				arenoso,\r\n				44,\r\n				44,\r\n				44)'),
(704, 'admin', '2015-01-29 02:55:01', 'INSERT INTO despachos VALUES(,\r\n				APC-164,\r\n				2015-01-28 16:54:43,\r\n				1,\r\n				4)'),
(705, 'admin', '2015-03-19 02:14:37', 'INSERT INTO usuarios VALUES(,\r\n				jose,\r\n				jose,\r\n				9115,\r\n				1)'),
(706, '', '2015-06-29 01:35:27', 'insercion'),
(707, '', '2015-06-29 01:35:32', 'insercion'),
(708, '', '2015-06-29 01:35:53', 'insercion'),
(709, '', '2015-06-29 01:35:54', 'insercion'),
(710, '', '2015-06-29 01:36:06', 'insercion'),
(711, '', '2015-06-29 01:36:08', 'insercion');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `altas`
--

CREATE TABLE IF NOT EXISTS `altas` (
`id` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estado` text COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `altas`
--

INSERT INTO `altas` (`id`, `id_socio`, `fecha`, `estado`) VALUES
(2, 31, '2014-06-05 20:15:38', 'ingreso'),
(3, 32, '2014-06-05 20:15:38', 'ingreso'),
(4, 33, '2014-06-05 20:15:38', 'ingreso'),
(5, 34, '2014-06-05 20:15:38', 'ingreso'),
(6, 35, '2014-06-05 20:15:38', 'ingreso'),
(7, 36, '2014-06-05 20:15:38', 'ingreso'),
(8, 37, '2014-06-05 20:15:38', 'ingreso'),
(9, 38, '2014-06-05 20:15:38', 'ingreso'),
(10, 39, '2014-06-05 20:15:38', 'ingreso'),
(11, 40, '2014-06-05 20:15:38', 'ingreso'),
(12, 41, '2014-06-05 20:15:38', 'ingreso'),
(13, 42, '2014-06-05 20:15:38', 'ingreso'),
(14, 43, '2014-06-05 20:15:38', 'ingreso'),
(15, 44, '2014-06-05 20:15:38', 'ingreso'),
(16, 45, '2014-06-05 20:15:38', 'ingreso'),
(17, 23, '2014-06-05 20:15:38', 'ingreso'),
(18, 299, '2014-06-05 20:15:38', 'ingreso'),
(19, 1, '2014-06-05 20:15:38', 'ingreso'),
(20, 2, '2014-06-05 20:15:38', 'ingreso'),
(21, 3, '2014-06-05 20:15:38', 'ingreso'),
(22, 4, '2014-06-05 20:15:38', 'ingreso'),
(23, 5, '2014-06-05 20:15:38', 'ingreso'),
(24, 6, '2014-06-05 20:15:38', 'ingreso'),
(25, 7, '2014-06-05 20:15:38', 'ingreso'),
(26, 8, '2014-06-05 20:15:38', 'ingreso'),
(27, 9, '2014-06-05 20:15:38', 'ingreso'),
(28, 10, '2014-06-05 20:15:38', 'ingreso'),
(29, 11, '2014-06-05 20:15:38', 'ingreso'),
(30, 12, '2014-06-05 20:15:38', 'ingreso'),
(31, 13, '2014-06-05 20:15:38', 'ingreso'),
(32, 14, '2014-06-05 20:15:38', 'ingreso'),
(33, 15, '2014-06-05 20:15:38', 'ingreso'),
(34, 16, '2014-06-05 20:15:38', 'ingreso'),
(35, 17, '2014-06-05 20:15:38', 'ingreso'),
(36, 18, '2014-06-05 20:15:38', 'ingreso'),
(37, 19, '2014-06-05 20:15:38', 'ingreso'),
(38, 20, '2014-06-05 20:15:38', 'ingreso'),
(39, 21, '2014-06-05 20:15:38', 'ingreso'),
(40, 22, '2014-06-05 20:15:38', 'ingreso'),
(41, 24, '2014-06-05 20:15:38', 'ingreso'),
(42, 25, '2014-06-05 20:15:38', 'ingreso'),
(43, 26, '2014-06-05 20:15:38', 'ingreso'),
(44, 27, '2014-06-05 20:15:38', 'ingreso'),
(45, 28, '2014-06-05 20:15:38', 'ingreso'),
(46, 29, '2014-06-05 20:15:38', 'ingreso'),
(47, 30, '2014-06-05 20:15:38', 'ingreso'),
(50, 68, '0000-00-00 00:00:00', '2000'),
(51, 68, '0000-00-00 00:00:00', '2000');

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
) ENGINE=InnoDB AUTO_INCREMENT=758 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `asociaciones`
--

INSERT INTO `asociaciones` (`id`, `concepto`, `valor`, `tipo`, `elemento`, `subparcela_id`) VALUES
(1, 'cacao', '', 'cultivo', 'parcela', 3),
(2, 'cacao', '', 'cultivo', 'parcela', 4),
(3, 'cacao', '', 'cultivo', 'parcela', 5),
(4, 'cacao', '', 'cultivo', 'parcela', 8),
(5, 'cacao', '', 'cultivo', 'parcela', 13),
(6, 'cacao', '', 'cultivo', 'parcela', 14),
(7, 'cacao', '', 'cultivo', 'parcela', 20),
(8, 'cacao', '', 'cultivo', 'parcela', 37),
(9, 'cacao', '', 'cultivo', 'parcela', 47),
(10, 'cacao', '', 'cultivo', 'parcela', 48),
(11, 'cacao', '', 'cultivo', 'parcela', 52),
(12, 'cacao', '', 'cultivo', 'parcela', 64),
(13, 'cacao', '', 'cultivo', 'parcela', 69),
(14, 'cacao', '', 'cultivo', 'parcela', 70),
(15, 'cacao', '', 'cultivo', 'parcela', 72),
(16, 'cacao', '', 'cultivo', 'parcela', 73),
(17, 'cacao', '', 'cultivo', 'parcela', 75),
(37, 'cacao', '', 'cultivo', 'parcela', 296),
(38, 'colmenas', '', 'animales', 'parcela', 5),
(39, 'colmenas', '', 'animales', 'parcela', 8),
(40, 'colmenas', '', 'animales', 'parcela', 20),
(41, 'colmenas', '', 'animales', 'parcela', 34),
(42, 'colmenas', '', 'animales', 'parcela', 48),
(53, 'estanque', '', 'animales', 'parcela', 5),
(54, 'estanque', '', 'animales', 'parcela', 8),
(55, 'estanque', '', 'animales', 'parcela', 19),
(56, 'estanque', '', 'animales', 'parcela', 33),
(57, 'estanque', '', 'animales', 'parcela', 37),
(58, 'estanque', '', 'animales', 'parcela', 43),
(59, 'estanque', '', 'animales', 'parcela', 61),
(60, 'estanque', '', 'animales', 'parcela', 64),
(61, 'estanque', '', 'animales', 'parcela', 66),
(62, 'estanque', '', 'animales', 'parcela', 92),
(85, 'ganado', '', 'animales', 'parcela', 3),
(86, 'ganado', '', 'animales', 'parcela', 5),
(87, 'ganado', '', 'animales', 'parcela', 9),
(88, 'ganado', '', 'animales', 'parcela', 10),
(89, 'ganado', '', 'animales', 'parcela', 13),
(90, 'ganado', '', 'animales', 'parcela', 18),
(91, 'ganado', '', 'animales', 'parcela', 33),
(92, 'ganado', '', 'animales', 'parcela', 34),
(93, 'ganado', '', 'animales', 'parcela', 36),
(94, 'ganado', '', 'animales', 'parcela', 37),
(95, 'ganado', '', 'animales', 'parcela', 39),
(96, 'ganado', '', 'animales', 'parcela', 42),
(97, 'ganado', '', 'animales', 'parcela', 43),
(98, 'ganado', '', 'animales', 'parcela', 45),
(99, 'ganado', '', 'animales', 'parcela', 46),
(100, 'ganado', '', 'animales', 'parcela', 47),
(101, 'ganado', '', 'animales', 'parcela', 51),
(102, 'ganado', '', 'animales', 'parcela', 65),
(103, 'ganado', '', 'animales', 'parcela', 66),
(104, 'ganado', '', 'animales', 'parcela', 73),
(105, 'ganado', '', 'animales', 'parcela', 75),
(106, 'ganado', '', 'animales', 'parcela', 89),
(107, 'ganado', '', 'animales', 'parcela', 91),
(108, 'ganado', '', 'animales', 'parcela', 92),
(186, 'ganado', '', 'animales', 'parcela', 296),
(187, 'ganado', '', 'animales', 'parcela', 297),
(190, 'guayaba', '', 'cultivo', 'parcela', 3),
(191, 'guayaba', '', 'cultivo', 'parcela', 4),
(192, 'guayaba', '', 'cultivo', 'parcela', 13),
(193, 'guayaba', '', 'cultivo', 'parcela', 33),
(194, 'guayaba', '', 'cultivo', 'parcela', 35),
(195, 'guayaba', '', 'cultivo', 'parcela', 39),
(196, 'guayaba', '', 'cultivo', 'parcela', 43),
(197, 'guayaba', '', 'cultivo', 'parcela', 44),
(198, 'guayaba', '', 'cultivo', 'parcela', 45),
(199, 'guayaba', '', 'cultivo', 'parcela', 48),
(200, 'guayaba', '', 'cultivo', 'parcela', 50),
(201, 'guayaba', '', 'cultivo', 'parcela', 52),
(202, 'guayaba', '', 'cultivo', 'parcela', 62),
(203, 'guayaba', '', 'cultivo', 'parcela', 64),
(204, 'guayaba', '', 'cultivo', 'parcela', 66),
(205, 'guayaba', '', 'cultivo', 'parcela', 88),
(206, 'guayaba', '', 'cultivo', 'parcela', 91),
(207, 'guayaba', '', 'cultivo', 'parcela', 92),
(247, 'guayaba', '', 'cultivo', 'parcela', 296),
(248, 'huerto', '', 'cultivo', 'parcela', 3),
(249, 'huerto', '', 'cultivo', 'parcela', 4),
(250, 'huerto', '', 'cultivo', 'parcela', 7),
(251, 'huerto', '', 'cultivo', 'parcela', 8),
(252, 'huerto', '', 'cultivo', 'parcela', 15),
(253, 'huerto', '', 'cultivo', 'parcela', 16),
(254, 'huerto', '', 'cultivo', 'parcela', 21),
(255, 'huerto', '', 'cultivo', 'parcela', 33),
(256, 'huerto', '', 'cultivo', 'parcela', 35),
(257, 'huerto', '', 'cultivo', 'parcela', 37),
(258, 'huerto', '', 'cultivo', 'parcela', 39),
(259, 'huerto', '', 'cultivo', 'parcela', 40),
(260, 'huerto', '', 'cultivo', 'parcela', 42),
(261, 'huerto', '', 'cultivo', 'parcela', 44),
(262, 'huerto', '', 'cultivo', 'parcela', 45),
(263, 'huerto', '', 'cultivo', 'parcela', 46),
(264, 'huerto', '', 'cultivo', 'parcela', 48),
(265, 'huerto', '', 'cultivo', 'parcela', 50),
(266, 'huerto', '', 'cultivo', 'parcela', 51),
(267, 'huerto', '', 'cultivo', 'parcela', 52),
(268, 'huerto', '', 'cultivo', 'parcela', 53),
(269, 'huerto', '', 'cultivo', 'parcela', 61),
(270, 'huerto', '', 'cultivo', 'parcela', 69),
(271, 'huerto', '', 'cultivo', 'parcela', 73),
(272, 'huerto', '', 'cultivo', 'parcela', 88),
(273, 'huerto', '', 'cultivo', 'parcela', 92),
(322, 'huerto', '', 'cultivo', 'parcela', 297),
(324, 'naranja', '', 'cultivo', 'parcela', 1),
(325, 'naranja', '', 'cultivo', 'parcela', 3),
(326, 'naranja', '', 'cultivo', 'parcela', 4),
(327, 'naranja', '', 'cultivo', 'parcela', 8),
(328, 'naranja', '', 'cultivo', 'parcela', 18),
(329, 'naranja', '', 'cultivo', 'parcela', 19),
(330, 'naranja', '', 'cultivo', 'parcela', 35),
(331, 'naranja', '', 'cultivo', 'parcela', 44),
(332, 'naranja', '', 'cultivo', 'parcela', 46),
(333, 'naranja', '', 'cultivo', 'parcela', 47),
(334, 'naranja', '', 'cultivo', 'parcela', 48),
(335, 'naranja', '', 'cultivo', 'parcela', 50),
(336, 'naranja', '', 'cultivo', 'parcela', 51),
(337, 'naranja', '', 'cultivo', 'parcela', 52),
(338, 'naranja', '', 'cultivo', 'parcela', 54),
(339, 'naranja', '', 'cultivo', 'parcela', 64),
(340, 'naranja', '', 'cultivo', 'parcela', 70),
(341, 'naranja', '', 'cultivo', 'parcela', 72),
(342, 'naranja', '', 'cultivo', 'parcela', 73),
(343, 'naranja', '', 'cultivo', 'parcela', 75),
(401, 'naranja', '', 'cultivo', 'parcela', 296),
(402, 'papaya', '', 'cultivo', 'parcela', 7),
(403, 'papaya', '', 'cultivo', 'parcela', 8),
(404, 'papaya', '', 'cultivo', 'parcela', 14),
(405, 'papaya', '', 'cultivo', 'parcela', 16),
(406, 'papaya', '', 'cultivo', 'parcela', 18),
(407, 'papaya', '', 'cultivo', 'parcela', 39),
(408, 'papaya', '', 'cultivo', 'parcela', 42),
(409, 'papaya', '', 'cultivo', 'parcela', 48),
(410, 'papaya', '', 'cultivo', 'parcela', 50),
(411, 'papaya', '', 'cultivo', 'parcela', 53),
(412, 'papaya', '', 'cultivo', 'parcela', 54),
(413, 'papaya', '', 'cultivo', 'parcela', 70),
(414, 'papaya', '', 'cultivo', 'parcela', 73),
(441, 'papaya', '', 'cultivo', 'parcela', 296),
(442, 'pasto', '', 'cultivo', 'parcela', 3),
(443, 'pasto', '', 'cultivo', 'parcela', 4),
(444, 'pasto', '', 'cultivo', 'parcela', 5),
(445, 'pasto', '', 'cultivo', 'parcela', 9),
(446, 'pasto', '', 'cultivo', 'parcela', 10),
(447, 'pasto', '', 'cultivo', 'parcela', 13),
(448, 'pasto', '', 'cultivo', 'parcela', 18),
(449, 'pasto', '', 'cultivo', 'parcela', 33),
(450, 'pasto', '', 'cultivo', 'parcela', 35),
(451, 'pasto', '', 'cultivo', 'parcela', 36),
(452, 'pasto', '', 'cultivo', 'parcela', 39),
(453, 'pasto', '', 'cultivo', 'parcela', 42),
(454, 'pasto', '', 'cultivo', 'parcela', 43),
(455, 'pasto', '', 'cultivo', 'parcela', 44),
(456, 'pasto', '', 'cultivo', 'parcela', 45),
(457, 'pasto', '', 'cultivo', 'parcela', 47),
(458, 'pasto', '', 'cultivo', 'parcela', 51),
(459, 'pasto', '', 'cultivo', 'parcela', 54),
(460, 'pasto', '', 'cultivo', 'parcela', 65),
(461, 'pasto', '', 'cultivo', 'parcela', 66),
(462, 'pasto', '', 'cultivo', 'parcela', 70),
(463, 'pasto', '', 'cultivo', 'parcela', 73),
(464, 'pasto', '', 'cultivo', 'parcela', 75),
(465, 'pasto', '', 'cultivo', 'parcela', 89),
(466, 'pasto', '', 'cultivo', 'parcela', 91),
(467, 'pasto', '', 'cultivo', 'parcela', 92),
(545, 'pasto', '', 'cultivo', 'parcela', 296),
(547, 'platano', '', 'cultivo', 'parcela', 1),
(548, 'platano', '', 'cultivo', 'parcela', 2),
(549, 'platano', '', 'cultivo', 'parcela', 3),
(550, 'platano', '', 'cultivo', 'parcela', 7),
(551, 'platano', '', 'cultivo', 'parcela', 8),
(552, 'platano', '', 'cultivo', 'parcela', 9),
(553, 'platano', '', 'cultivo', 'parcela', 10),
(554, 'platano', '', 'cultivo', 'parcela', 13),
(555, 'platano', '', 'cultivo', 'parcela', 14),
(556, 'platano', '', 'cultivo', 'parcela', 15),
(557, 'platano', '', 'cultivo', 'parcela', 16),
(558, 'platano', '', 'cultivo', 'parcela', 18),
(559, 'platano', '', 'cultivo', 'parcela', 19),
(560, 'platano', '', 'cultivo', 'parcela', 20),
(561, 'platano', '', 'cultivo', 'parcela', 21),
(562, 'platano', '', 'cultivo', 'parcela', 33),
(563, 'platano', '', 'cultivo', 'parcela', 35),
(564, 'platano', '', 'cultivo', 'parcela', 36),
(565, 'platano', '', 'cultivo', 'parcela', 37),
(566, 'platano', '', 'cultivo', 'parcela', 39),
(567, 'platano', '', 'cultivo', 'parcela', 40),
(568, 'platano', '', 'cultivo', 'parcela', 42),
(569, 'platano', '', 'cultivo', 'parcela', 43),
(570, 'platano', '', 'cultivo', 'parcela', 44),
(571, 'platano', '', 'cultivo', 'parcela', 45),
(572, 'platano', '', 'cultivo', 'parcela', 46),
(573, 'platano', '', 'cultivo', 'parcela', 47),
(574, 'platano', '', 'cultivo', 'parcela', 48),
(575, 'platano', '', 'cultivo', 'parcela', 50),
(576, 'platano', '', 'cultivo', 'parcela', 51),
(577, 'platano', '', 'cultivo', 'parcela', 52),
(578, 'platano', '', 'cultivo', 'parcela', 53),
(579, 'platano', '', 'cultivo', 'parcela', 54),
(580, 'platano', '', 'cultivo', 'parcela', 58),
(581, 'platano', '', 'cultivo', 'parcela', 61),
(582, 'platano', '', 'cultivo', 'parcela', 62),
(583, 'platano', '', 'cultivo', 'parcela', 64),
(584, 'platano', '', 'cultivo', 'parcela', 65),
(585, 'platano', '', 'cultivo', 'parcela', 66),
(586, 'platano', '', 'cultivo', 'parcela', 70),
(587, 'platano', '', 'cultivo', 'parcela', 72),
(588, 'platano', '', 'cultivo', 'parcela', 73),
(589, 'platano', '', 'cultivo', 'parcela', 75),
(590, 'platano', '', 'cultivo', 'parcela', 88),
(591, 'platano', '', 'cultivo', 'parcela', 89),
(592, 'platano', '', 'cultivo', 'parcela', 92),
(705, 'platano', '', 'cultivo', 'parcela', 296),
(709, 'gallinas', 'bajo', 'animales', 'parcela', 1),
(718, 'caï¿½a', 'medio', 'cultivo', 'subparcela', 1),
(723, 'guaba', 'medio', '', 'subparcela', 1),
(740, 'CaÃ±a', 'medio', 'Cultivo', 'subparcela', 69),
(743, 'Yuca', 'bajo', 'Cultivo', 'parcela', 69),
(748, 'Gallinas', 'medio', 'Animales', 'parcela', 69),
(751, 'Platano', 'alto', 'cultivo', 'subparcela', 1),
(752, 'Papaya', 'bajo', 'cultivo', 'subparcela', 301),
(753, 'Naranja', 'medio', 'cultivo', 'subparcela', 304),
(754, 'Guaba', 'alto', 'cultivo', 'subparcela', 304),
(755, 'Vacas', 'medio', 'animales', 'parcela', 1),
(756, 'Yuca', 'medio', 'cultivo', 'parcela', 1),
(757, 'Cuyes', 'medio', 'animales', 'parcela', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `canton`
--

CREATE TABLE IF NOT EXISTS `canton` (
`id_canton` int(11) NOT NULL,
  `canton` varchar(45) DEFAULT NULL,
  `id_provincia` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `canton`
--

INSERT INTO `canton` (`id_canton`, `canton`, `id_provincia`) VALUES
(1, 'Zamora', 1),
(2, 'Centinela del Condor', 1),
(3, 'Chinchipe', 1),
(4, 'El Pangui', 1),
(5, 'Nangaritza', 1),
(6, 'Palanga', 1),
(7, 'Paquisha', 1),
(8, 'Yacuambi', 1),
(9, 'Yantzaza', 1),
(10, 'Alamor', 2),
(11, 'Catamayo', 2),
(12, 'Celica', 2),
(13, 'Chaguarpamba', 2),
(14, 'Espíndola', 2),
(15, 'Gonzanamá', 2),
(16, 'Loja', 2),
(17, 'Macará', 2),
(18, 'Olmedo', 2),
(19, 'Paltas', 2),
(20, 'Pindal', 2),
(21, 'Puyango', 2),
(22, 'Quilanga', 2),
(23, 'Saraguro', 2),
(24, 'Sozoranga', 2),
(25, 'Zapotillo', 2),
(26, 'Chordeleg', 3),
(27, 'Cuenca', 3),
(28, 'El Pan', 3),
(29, 'Girón', 3),
(30, 'Guachapala', 3),
(31, 'Gualaceo', 3),
(32, 'Nabón', 3),
(33, 'Oña', 3),
(34, 'Paute', 3),
(35, 'Ponce Enriquez', 3),
(36, 'Pucará', 3),
(37, 'San Fernando', 3),
(38, 'Santa Isabel', 3),
(39, 'Sevilla de Oro', 3),
(40, 'Sígsig', 3),
(41, 'Caluma', 4),
(42, 'Chillanes', 4),
(43, 'Chimbo', 4),
(44, 'Echeandía', 4),
(45, 'Guaranda', 4),
(46, 'Las Naves', 4),
(47, 'San Miguel', 4),
(48, 'Azoguez', 5),
(49, 'Biblián', 5),
(50, 'Cañar', 5),
(51, 'Déleg', 5),
(52, 'El Tambo', 5),
(53, 'La Troncal', 5),
(54, 'Suscal', 5),
(55, 'Bolívar', 6),
(56, 'Espejo', 6),
(57, 'Mira', 6),
(58, 'Montúfar', 6),
(59, 'San Pedro de Huaca', 6),
(60, 'Tulcán', 6),
(61, 'Alausí', 7),
(62, 'Chambo', 7),
(63, 'Chunchi', 7),
(64, 'Colta', 7),
(65, 'Cumandá', 7),
(66, 'Guamote', 7),
(67, 'Guano', 7),
(68, 'Pallatanga', 7),
(69, 'Peine', 7),
(70, 'Riobamba', 7),
(71, 'La Maná', 8),
(72, 'Latacunga', 8),
(73, 'Pangua', 8),
(74, 'Pujilí', 8),
(75, 'Salcedo', 8),
(76, 'Saquisilí', 8),
(77, 'Sigchos', 8),
(78, 'Arenilla', 9),
(79, 'Atahualpa', 9),
(80, 'Balsas', 9),
(81, 'Chilla', 9),
(82, 'El Guabo', 9),
(83, 'Huaquillas', 9),
(84, 'Las Lajas', 9),
(85, 'Machala', 9),
(86, 'Marcabelí', 9),
(87, 'Pasaje', 9),
(88, 'Piñas', 9),
(89, 'Portovelo', 9),
(90, 'Santa Rosa', 9),
(91, 'Zaruma', 9),
(92, 'Esmeraldas', 10),
(93, 'Eloy Alfaro', 10),
(94, 'Muisne', 10),
(95, 'Quinindé', 10),
(96, 'San Lorenzo', 10),
(97, 'Atacames', 10),
(98, 'Río Verde', 10),
(99, 'Isabela', 11),
(100, 'San Cristóbal', 11),
(101, 'Santa Cruz', 11),
(102, 'Guayaquil', 12),
(103, 'Alfredo Baquerizo Moreno', 12),
(104, 'Balao', 12),
(105, 'Balzar', 12),
(106, 'Colimes', 12),
(107, 'Daule', 12),
(108, 'El Empalme', 12),
(109, 'El Triunfo', 12),
(110, 'Durán', 12),
(111, 'General Antonio Elizalde', 12),
(112, 'Playas', 12),
(113, 'Isidro Ayora', 12),
(114, 'Lomas de Sargentillo', 12),
(115, 'Marcelino Maridueña', 12),
(116, 'Milagro', 12),
(117, 'Naranjal', 12),
(118, 'Naranjito', 12),
(119, 'Nobol', 12),
(120, 'Palestina', 12),
(121, 'Pedro Carbo', 12),
(122, 'Salitre', 12),
(123, 'Samborondón', 12),
(124, 'Santa Lucía', 12),
(125, 'Simón Bolívar', 12),
(126, 'Yaguachi', 12),
(127, 'Antonio Ante', 13),
(128, 'Cotacachi', 13),
(129, 'Ibarra', 13),
(130, 'Otavalo', 13),
(131, 'Pimampiro', 13),
(132, 'San Miguel de Urcuquí', 13),
(133, 'Baba', 14),
(134, 'Babahoyo', 14),
(135, 'Buena Fe', 14),
(136, 'Mocache', 14),
(137, 'Montalvo', 14),
(138, 'Palenque', 14),
(139, 'Publoviejo', 14),
(140, 'Quevedo', 14),
(141, 'Quinsaloma', 14),
(142, 'Urdaneta', 14),
(143, 'Valencia', 14),
(144, 'Ventanas', 14),
(145, 'Vinces', 14),
(146, 'Bolívar', 15),
(147, 'Chone', 15),
(148, 'El Carmen', 15),
(149, 'Flavio Alfaro', 15),
(150, 'Jama', 15),
(151, 'Jaramijó', 15),
(152, 'Jipijapa', 15),
(153, 'Junín', 15),
(154, 'Manta', 15),
(155, 'Montecristi', 15),
(156, 'Olmedo', 15),
(157, 'Paján', 15),
(158, 'Pedernales', 15),
(159, 'Pichincha', 15),
(160, 'Portoviejo', 15),
(161, 'Puerto López', 15),
(162, 'Rocafuerte', 15),
(163, 'San Vicente', 15),
(164, 'Santa Ana', 15),
(165, 'Sucre', 15),
(166, 'Tosagua', 15),
(167, 'Veinticuatro de mayo', 15),
(168, 'Gualaquiza', 16),
(169, 'Huamboya', 16),
(170, 'Limón Indanza', 16),
(171, 'Logroño', 16),
(172, 'Morona', 16),
(173, 'Pablo Sexto', 16),
(174, 'Palora', 16),
(175, 'San Juan Bosco', 16),
(176, 'Santiago', 16),
(177, 'Sucúa', 16),
(178, 'Taisha', 16),
(179, 'Tiwintza', 16),
(180, 'Archidona', 17),
(181, 'Carlos Julio Arosemena Tola', 17),
(182, 'El Chaco', 17),
(183, 'Quijos', 17),
(184, 'Tena', 17),
(185, 'Aguarico', 18),
(186, 'Orellana', 18),
(187, 'La Joya de los Sachas', 18),
(188, 'Loreto', 18),
(189, 'Arajuno', 19),
(190, 'Mera', 19),
(191, 'Pastaza', 19),
(192, 'Santa Clara', 19),
(193, 'Cayambe', 20),
(194, 'Mejía', 20),
(195, 'Pedro Moncayo', 20),
(196, 'Pedro Vicente Maldonado', 20),
(197, 'Puerto Quito', 20),
(198, 'Quito', 20),
(199, 'Rumiñahui', 20),
(200, 'San Miguel de los Bancos', 20),
(201, 'La Libertad', 21),
(202, 'Salina', 21),
(203, 'Santa Elena', 21),
(204, 'Santo Domingo', 22),
(205, 'La Concordia', 22),
(206, 'Cascales', 23),
(207, 'Cuyabeno', 23),
(208, 'Gonzalo Pizarro', 23),
(209, 'Lago Agrio', 23),
(210, 'Putumayo', 23),
(211, 'Shushufindi', 23),
(212, 'Sucumbíos', 23),
(213, 'Ambato', 24),
(214, 'Baños', 24),
(215, 'Cevallos', 24),
(216, 'Mocha', 24),
(217, 'Patate', 24),
(218, 'Pelileo', 24),
(219, 'Píllaro', 24),
(220, 'Quero', 24),
(221, 'Tisaleo', 24);

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
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `catas`
--

INSERT INTO `catas` (`id`, `lote`, `fecha`, `catador`, `tostado`, `fragancia`, `tipo_aroma1`, `nota_aroma`, `sabor`, `tipo_sabor`, `nota_sabor`, `sabor_residual`, `tipo_sabor_residual`, `nota_sabor_residual`, `acidez`, `cuerpo`, `uniformidad`, `balance`, `puntaje_catador`, `taza_limpia`, `dulzor`, `nota_catacion`, `puntuacion`, `d_fermento`, `d_metalico`, `d_quimico`, `d_vinagre`, `d_stinker`, `d_fenol`, `d_reposo`, `d_moho`, `d_terroso`, `d_extrano`, `d_sucio`, `d_astringente`, `d_quaquers`, `dl_cereal`, `dl_fermento`, `dl_reposo`, `dl_moho`, `dl_astringencia`, `d_general`) VALUES
(1, 131, '2014-08-06 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 87.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 28, '2014-06-24 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 86.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 39, '2014-06-24 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 86.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 44, '2014-06-27 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 86.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(5, 52, '2014-07-01 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 86.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 93, '2014-07-28 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 86.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 169, '2014-08-14 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 86.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(8, 112, '2014-08-04 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 85.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(9, 120, '2014-08-04 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 85.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10, 125, '2014-08-05 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 85.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11, 46, '2014-06-27 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 85.25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(12, 15, '2014-06-02 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 85.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(13, 34, '2014-06-20 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 85.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(14, 40, '2014-06-26 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 85.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(15, 41, '2014-06-26 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 85.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(16, 50, '2014-06-30 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 85.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(17, 55, '2014-07-03 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 85.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(18, 95, '2014-07-28 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 85.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(19, 111, '2014-08-01 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 85.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20, 123, '2014-08-05 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 85.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(21, 162, '2014-08-12 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(22, 53, '2014-07-02 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(23, 60, '2014-07-07 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(24, 85, '2014-07-23 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(25, 97, '2014-07-29 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(26, 117, '2014-08-04 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(27, 119, '2014-08-04 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(28, 133, '2014-08-07 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(29, 134, '2014-08-07 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(30, 135, '2014-08-07 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(31, 137, '2014-08-07 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(32, 142, '2014-08-07 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(33, 161, '2014-08-12 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(34, 165, '2014-08-12 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(36, 67, '2014-07-14 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(37, 74, '2014-07-16 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(38, 13, '2014-02-06 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(39, 33, '2014-06-11 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40, 24, '2014-06-11 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41, 31, '2014-06-18 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(42, 42, '2014-06-19 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(43, 37, '2014-06-24 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(44, 42, '2014-06-26 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45, 49, '2014-06-30 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(46, 51, '2014-06-30 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(47, 63, '2014-07-10 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(48, 65, '2014-07-11 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(49, 73, '2014-07-16 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(50, 79, '2014-07-21 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(51, 80, '2014-07-21 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(52, 99, '2014-07-30 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(53, 100, '2014-07-30 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(54, 101, '2014-07-31 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(55, 102, '2014-07-31 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(56, 104, '2014-07-31 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(57, 107, '2014-08-01 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58, 108, '2014-08-01 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(59, 109, '2014-08-01 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(60, 113, '2014-08-04 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(61, 118, '2014-08-04 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(62, 122, '2014-08-04 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(63, 126, '2014-08-05 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(64, 127, '2014-08-05 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(65, 129, '2014-08-06 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(66, 130, '2014-08-06 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(67, 132, '2014-08-06 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(68, 136, '2014-08-07 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(69, 138, '2014-08-07 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(70, 147, '2014-08-08 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(71, 149, '2014-08-08 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(72, 157, '2014-08-11 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(73, 163, '2014-08-12 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(74, 166, '2014-08-13 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(75, 167, '2014-08-13 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(76, 171, '2014-08-18 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 84.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(77, 48, '2014-06-27 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(78, 57, '2014-07-03 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(79, 59, '2014-07-07 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(80, 62, '2014-07-10 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(81, 64, '2014-07-10 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(82, 66, '2014-07-14 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(83, 69, '2014-07-14 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(84, 77, '2014-07-17 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(85, 84, '2014-07-23 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(86, 87, '2014-07-24 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(87, 89, '2014-07-24 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(88, 90, '2014-07-24 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(89, 92, '2014-07-25 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(90, 94, '2014-07-28 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(91, 103, '2014-07-31 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(92, 114, '2014-08-04 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(93, 121, '2014-08-04 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(94, 140, '2014-08-07 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(95, 143, '2014-08-07 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(96, 152, '2014-08-08 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(97, 164, '2014-08-12 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(98, 168, '2014-08-14 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(99, 47, '2014-06-27 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(100, 56, '2014-07-03 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(101, 88, '2014-07-24 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(102, 105, '2014-08-01 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'FERMENTO', 83.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(103, 110, '2014-08-01 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'FERMENTO', 83.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(104, 128, '2014-08-06 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(105, 151, '2014-08-08 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(106, 14, '2014-06-02 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(107, 18, '2014-06-03 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(108, 27, '2014-06-02 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(109, 21, '2014-06-10 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(110, 26, '2014-06-12 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(111, 27, '2014-06-12 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(112, 29, '2014-06-17 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(113, 30, '2014-06-17 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(114, 36, '2014-06-20 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(115, 54, '2014-07-02 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(116, 75, '2014-07-17 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(117, 78, '2014-07-21 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(118, 96, '2014-07-29 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 83.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(119, 70, '2014-07-15 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 82.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(120, 83, '2014-07-22 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 82.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(121, 150, '2014-08-08 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 82.25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(122, 159, '2014-08-11 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 82.25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(123, 45, '2014-06-27 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 82.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(124, 86, '2014-07-23 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 82.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(125, 91, '2014-07-24 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 82.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(126, 98, '2014-07-29 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'FERMENTO', 82.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(127, 115, '2014-08-04 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'hongos', 82.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(128, 154, '2014-08-11 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 82.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(129, 156, '2014-08-11 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 82.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(130, 61, '2014-07-10 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 81.75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(131, 124, '2014-08-05 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 81.50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(132, 16, '2014-06-02 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 81.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(133, 25, '2014-06-12 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 81.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(134, 58, '2014-07-07 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 81.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(135, 68, '2014-07-14 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 81.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(136, 82, '2014-07-21 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 81.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(137, 116, '2014-08-04 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 'FERMENTO', 81.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(138, 139, '2014-08-07 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 81.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(139, 141, '2014-08-07 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 81.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(140, 153, '2014-08-11 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 81.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(141, 158, '2014-08-11 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 81.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(142, 148, '2014-08-08 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 80.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(143, 28, '2014-06-16 10:00:00', '', 0, 0.00, '', '', 0.00, '', '', 0.00, '', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 77.00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(144, 160, '2014-09-17 04:15:07', 'juanito', 6, 8.50, 'Frutal,Caramelo,Vainilla', '', 9.50, 'Chocolate amargo,Articulado', '', 6.75, 'Limpio,Dulce', '', 9.00, 8.50, 9.50, 8.75, 9.25, 9.50, 8.75, '', 86.00, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 1, 1, 2),
(145, 23, '2014-09-28 20:09:18', 'Catador', 6, 8.75, 'Herbal,Vainilla,Neutral', '', 8.00, 'Caramelo,Chocolate dulce', '', 8.25, 'Refrescante,Dulce', '', 9.50, 8.00, 8.75, 8.00, 9.00, 8.25, 8.75, '', 85.25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificacion`
--

CREATE TABLE IF NOT EXISTS `certificacion` (
`id` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `estatus` text COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=350 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `certificacion`
--

INSERT INTO `certificacion` (`id`, `id_socio`, `year`, `estatus`) VALUES
(2, 1, 2009, 'BO'),
(3, 2, 2009, 'BO'),
(4, 3, 2009, 'BO'),
(5, 4, 2009, 'BO'),
(6, 5, 2009, 'BO'),
(7, 6, 2009, 'BO'),
(8, 7, 2009, 'BO'),
(9, 8, 2009, 'BO'),
(10, 9, 2009, 'BO'),
(11, 10, 2009, 'BO'),
(12, 11, 2009, 'BO'),
(13, 12, 2009, 'BO'),
(14, 13, 2009, 'BO'),
(15, 14, 2009, 'BO'),
(16, 15, 2009, ''),
(17, 16, 2009, 'BO'),
(18, 17, 2009, ''),
(19, 18, 2009, ''),
(20, 19, 2009, ''),
(21, 20, 2009, ''),
(22, 21, 2009, ''),
(23, 22, 2009, ''),
(24, 23, 2009, ''),
(25, 24, 2009, ''),
(26, 25, 2009, ''),
(27, 26, 2009, ''),
(28, 27, 2009, ''),
(29, 28, 2009, ''),
(30, 29, 2009, ''),
(31, 30, 2009, ''),
(32, 299, 2009, ''),
(301, 1, 2010, 'BO'),
(302, 2, 2010, 'BO'),
(303, 3, 2010, 'BO'),
(304, 4, 2010, 'BO'),
(305, 5, 2010, 'BO'),
(306, 6, 2010, 'BO'),
(307, 7, 2010, 'BO'),
(308, 8, 2010, 'BO'),
(309, 9, 2010, 'BO'),
(310, 10, 2010, 'BO'),
(311, 11, 2010, 'BO'),
(312, 12, 2010, 'BO'),
(313, 13, 2010, 'BO'),
(314, 14, 2010, 'BO'),
(315, 15, 2010, ''),
(316, 16, 2010, ''),
(317, 17, 2010, ''),
(318, 18, 2010, 'BO'),
(319, 19, 2010, 'BO'),
(320, 20, 2010, ''),
(321, 21, 2010, ''),
(322, 22, 2010, ''),
(323, 23, 2010, ''),
(324, 24, 2010, ''),
(325, 25, 2010, ''),
(326, 26, 2010, ''),
(327, 27, 2010, ''),
(328, 28, 2010, ''),
(329, 29, 2010, ''),
(330, 30, 2010, ''),
(331, 299, 2010, ''),
(342, 238, 2000, 'T1'),
(345, 284, 2000, 'T1'),
(346, 284, 2000, 'T1'),
(347, 284, 2000, 'T1'),
(348, 68, 2000, 'T1'),
(349, 307, 2000, 'T1');

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
(1, 'extra_cata', 'puntaje mÃ­nimo de ', '84.00'),
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `despachos`
--

INSERT INTO `despachos` (`id`, `lote`, `fecha`, `cantidad`, `envio`) VALUES
(0, 170, '2015-07-12 08:39:54', 1.00, 4),
(1, 37, '2014-09-25 04:18:41', 2.50, 1),
(2, 37, '2014-09-25 04:19:22', 1.93, 2),
(4, 170, '2014-09-28 23:01:57', 3.12, 2),
(5, 37, '2014-09-28 23:02:33', 0.57, 3),
(6, 35, '2014-09-28 23:03:20', 4.50, 2),
(7, 171, '2015-01-29 02:54:43', 1.00, 4),
(8, 170, '2015-07-13 23:21:30', 2.00, 4),
(9, 170, '2015-07-14 07:52:31', 0.20, 4);

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `envios`
--

INSERT INTO `envios` (`id`, `fecha`, `destino`, `chofer`, `responsable`) VALUES
(0, '0000-00-00 00:00:00', 'loja', 'Manolo', 'Manolo'),
(1, '2014-06-03 20:15:22', 'FAPECAFES', 'manolo', 'cosmel'),
(2, '2014-06-04 20:30:26', 'ZAMORA', 'Juanitosss', 'Manolo'),
(3, '2014-06-03 22:19:54', 'Loja', 'Albertito', 'Manolo'),
(4, '2014-06-07 05:15:17', 'Quito', 'Manolo', 'Juanito'),
(5, '2015-07-14 05:00:00', 'Loja', 'Manolo', 'Juanito');

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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `estimacion`
--

INSERT INTO `estimacion` (`id`, `id_socio`, `year`, `estimados`, `entregados`) VALUES
(2, 1, 2011, 0.00, 2.00),
(4, 3, 2011, 0.00, 0.00),
(5, 4, 2011, 0.00, 54.00),
(6, 5, 2011, 0.00, 16.00),
(7, 6, 2011, 0.00, 13.00),
(8, 7, 2011, 0.00, 120.00),
(9, 8, 2011, 0.00, 35.00),
(10, 9, 2011, 0.00, 59.00),
(11, 10, 2011, 0.00, 10.00),
(12, 11, 2011, 0.00, 31.00),
(13, 12, 2011, 0.00, 18.00),
(14, 13, 2011, 0.00, 0.00),
(15, 14, 2011, 0.00, 29.00),
(16, 15, 2011, 0.00, 21.00),
(17, 16, 2011, 0.00, 5.00),
(18, 17, 2011, 0.00, 3.00),
(19, 18, 2011, 0.00, 3.00),
(20, 19, 2011, 0.00, 38.00),
(21, 20, 2011, 0.00, 0.00),
(22, 21, 2011, 0.00, 0.00),
(23, 22, 2011, 0.00, 0.00),
(24, 23, 2011, 0.00, 0.00),
(25, 24, 2011, 0.00, 0.00),
(26, 25, 2011, 0.00, 0.00),
(27, 26, 2011, 0.00, 0.00),
(28, 27, 2011, 0.00, 0.00),
(29, 28, 2011, 0.00, 0.00),
(30, 29, 2011, 0.00, 0.00),
(31, 30, 2011, 0.00, 0.00),
(32, 299, 2011, 0.00, 0.00),
(33, 284, 2010, 500.00, 0.00),
(34, 68, 2010, 100.00, 0.00);

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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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
(23, 'VALLERMOSO', 'VH'),
(24, 'NUEVO', '01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial`
--

CREATE TABLE IF NOT EXISTS `historial` (
`id_historial` int(11) NOT NULL,
  `usuario` varchar(25) NOT NULL,
  `accion` varchar(25) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datos` varchar(100) NOT NULL,
  `tabla` varchar(20) NOT NULL,
  `maquina` varchar(30) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `historial`
--

INSERT INTO `historial` (`id_historial`, `usuario`, `accion`, `fecha`, `datos`, `tabla`, `maquina`) VALUES
(0, 'admin', 'INSERCIÃ“N', '2015-07-12 03:16:12', '', 'certificaciones', 'blackburn'),
(1, 'jos', 'insercion', '2015-07-05 10:00:00', 'dasd as as asscassac sa sa a', 'ENVIOS', 'josepc'),
(2, 'admin', 'INSERCION', '2015-07-08 10:50:03', 'sss', 'ENVIOS', 'sss'),
(3, 'admin', 'INSERCION', '2015-07-08 10:59:35', 'call SP_envios_ins(\r\n			 2015-07-08 00:58:59 ,\r\n			 aa ,\r\n			 vv ,\r\n			 sdad )', 'ENVIOS', 'sss'),
(4, 'admin', 'INSERCION', '2015-07-08 11:06:50', 'call SP_envios_ins(\r\n			 2015-07-08 01:06:45 ,\r\n			 final ,\r\n			 final ,\r\n			 final )', 'ENVIOS', 'JoseLuis_Pc'),
(5, 'admin', 'EDICION', '2015-07-08 11:11:46', 'call SP_envios_con( editar , 20 )', 'ENVIOS', 'JoseLuis_Pc'),
(6, 'admin', 'EDICION', '2015-07-08 11:11:54', 'call SP_envios_con( editar , 20 )', 'ENVIOS', 'JoseLuis_Pc'),
(7, 'admin', 'EDICION', '2015-07-08 11:13:16', 'call SP_envios_upd(\r\n			 2015-07-08 01:06:45 ,\r\n			 final ,\r\n			 final ,\r\n			 final ,\r\n			 20 )', 'ENVIOS', 'JoseLuis_Pc'),
(8, 'admin', 'EDICION', '2015-07-08 11:20:41', 'call SP_envios_upd(\r\n			 2015-07-08 01:06:45 ,\r\n			 finala ,\r\n			 final ,\r\n			 final ,\r\n			 20 )', 'ENVIOS', 'JoseLuis_Pc'),
(9, 'admin', 'EDICION', '2015-07-08 11:22:05', 'call SP_envios_upd(\r\n			 2015-07-08 01:06:45 ,\r\n			 comienzo ,\r\n			 final ,\r\n			 final ,\r\n			 20 )', 'ENVIOS', 'JoseLuis_Pc'),
(10, 'admin', '', '2015-07-08 23:19:04', 'call SP_socio_update(68,  Indalecio , Abad Abad , AG63 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , ', '', 'blackburn'),
(11, 'admin', '', '2015-07-08 23:20:18', 'call SP_socio_update(68,  Indalecio , Abad Abad , AG64 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , ', '', 'blackburn'),
(12, 'admin', '', '2015-07-08 23:21:49', 'call SP_socio_update(68,  Indalecio , Abad Abad , AG65 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , ', '', 'blackburn'),
(13, 'admin', '', '2015-07-08 23:23:13', 'call SP_socio_update(68,  Indalecio , Abad Abad , AG66 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , ', '', 'blackburn'),
(14, 'admin', '', '2015-07-08 23:23:25', 'call SP_socio_update(68,  Indalecio , Abad Abad , AG67 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , ', '', 'blackburn'),
(15, 'admin', '', '2015-07-08 23:24:45', 'call SP_socio_update(68,  Indalecio , Abad Abad , AG68 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , ', '', 'blackburn'),
(16, 'admin', '', '2015-07-08 23:26:41', 'call SP_socio_update(68,  Indalecio , Abad Abad , AG69 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , ', '', 'blackburn'),
(17, 'admin', '', '2015-07-08 23:28:40', 'call SP_socio_update(68,  Indalecio , Abad Abad , AG70 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , ', '', 'blackburn'),
(18, 'admin', '', '2015-07-08 23:30:12', 'call SP_socio_update(68,  Indalecio , Abad Abad , AG71 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , ', '', 'blackburn'),
(19, 'admin', '', '2015-07-08 23:31:00', 'call SP_socio_update(68,  Indalecio , Abad Abad , AG72 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , ', '', 'blackburn'),
(20, 'admin', '', '2015-07-08 23:33:03', 'call SP_socio_update(68,  Indalecio , Abad Abad , AG73 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , ', '', 'blackburn'),
(21, 'admin', 'EDICION', '2015-07-08 23:35:55', 'call SP_socio_update(68,  Indalecio , Abad Abad , AG74 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , ', 'socios', 'blackburn'),
(22, 'admin', 'INSERCIÓN', '2015-07-12 03:40:27', 'call SP_socio_certificar( 68 , 2000 , T1 )', 'certificaciones', 'blackburn'),
(23, 'admin', 'BORRADO', '2015-07-12 03:43:22', 'call SP_certificaciones_del( 351 )', 'certificaciones', 'blackburn'),
(24, 'admin', 'INSERCIÃ“N', '2015-07-12 03:50:45', 'call SP_socio_certificar( 68 , 2000 , T1 )', 'certificaciones', 'blackburn'),
(25, 'admin', 'BORRADO', '2015-07-12 03:58:16', 'call SP_certificaciones_del( 352 )', 'certificaciones', 'blackburn'),
(26, 'admin', 'INSERCIÃ“N', '2015-07-12 04:00:13', 'call SP_socio_certificar( 68 , 2000 , T1 )', 'certificaciones', 'blackburn'),
(27, 'admin', 'BORRADO', '2015-07-12 04:00:19', 'call SP_certificaciones_del( 353 )', 'certificaciones', 'blackburn'),
(28, 'admin', 'EDICION', '2015-07-12 04:37:23', 'call SP_socio_update(68,  Indalecio , Abad Abad , AG75 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , ', 'socios', 'blackburn'),
(29, 'admin', 'EDICION', '2015-07-12 04:40:50', 'call SP_socio_update(68,  Indalecio , Abad Abad , AG76 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , ', 'socios', 'blackburn'),
(30, 'admin', 'EDICION', '2015-07-12 04:41:16', 'call SP_socio_update(68, Indalecio1 , Abad Abad , AG77 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , ', 'socios', 'blackburn'),
(31, 'admin', 'EDICION', '2015-07-12 04:41:26', 'call SP_socio_update(68, Indalecio , Abad Abad , AG78 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , L', 'socios', 'blackburn'),
(32, 'admin', 'EDICION', '2015-07-12 04:41:57', 'call SP_socio_update(68, 12 , Abad Abad , AG79 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , Loja , M', 'socios', 'blackburn'),
(33, 'admin', 'EDICION', '2015-07-12 04:42:08', 'call SP_socio_update(68, Indalecio , Abad Abad , AG80 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , L', 'socios', 'blackburn'),
(34, 'admin', 'INSERCIÃ“N', '2015-07-12 04:42:22', 'call SP_socio_certificar( 68 , 2000 , O )', 'certificaciones', 'blackburn'),
(35, 'admin', 'BORRADO', '2015-07-12 04:42:36', 'call SP_certificaciones_del( 354 )', 'certificaciones', 'blackburn'),
(36, 'admin', 'INSERCIÃ“N', '2015-07-12 04:43:30', 'call sp_alta_ins( 68 , Ingreso , 2015-07-11 );', 'altas', 'blackburn'),
(37, 'admin', 'BORRADO', '2015-07-12 04:43:42', 'call SP_altas_del( 0 )', 'altas', 'blackburn'),
(38, 'admin', 'INSERCIÃ“N', '2015-07-12 04:43:47', 'call sp_alta_ins( 68 , Ingreso , 2015-07-11 );', 'altas', 'blackburn'),
(39, 'admin', 'BORRADO', '2015-07-12 04:46:38', 'call SP_altas_del( 0 )', 'altas', 'blackburn'),
(40, 'admin', 'INSERCIÃ“N', '2015-07-12 04:48:56', 'call SP_estimaciones_ins( 68 , 2015 , 100 , 0 )', 'configuraciones', 'blackburn'),
(41, 'admin', 'BORRADO', '2015-07-12 04:49:08', 'call SP_estimaciones_del( 0 )', 'configuraciones', 'blackburn'),
(42, 'admin', 'EDICION', '2015-07-12 04:49:25', 'call SP_socio_update(68, Indalecio , Abad Abad , AG81 , 1104518863 , 0 , 1981-01-29 ,  , AGRODIN , L', 'socios', 'blackburn'),
(43, 'admin', 'INSERCIÃ“N', '2015-07-12 04:58:43', 'call SP_asociaciones_ins( CaÃ±a , bajo , Subparcela , 69 , Cultivo )', 'asociaciones', 'blackburn'),
(44, 'admin', 'INSERCIÃ“N', '2015-07-12 04:58:49', 'call SP_asociaciones_ins( Guaba , bajo , Subparcela , 69 , Cultivo )', 'asociaciones', 'blackburn'),
(45, 'admin', 'INSERCIÃ“N', '2015-07-12 04:59:54', 'call SP_asociaciones_ins( Yuca , bajo , Subparcela , 69 , Cultivo )', 'asociaciones', 'blackburn'),
(46, 'admin', 'INSERCIÃ“N', '2015-07-12 05:00:43', 'call SP_asociaciones_ins( Yuca , bajo , Subparcela , 69 , Cultivo )', 'asociaciones', 'blackburn'),
(47, 'admin', 'INSERCIÃ“N', '2015-07-12 05:00:47', 'call SP_asociaciones_ins( Yuca , bajo , Subparcela , 69 , Cultivo )', 'asociaciones', 'blackburn'),
(48, 'admin', 'INSERCIÃ“N', '2015-07-12 05:07:13', 'call SP_asociaciones_ins( CaÃ±a , medio , Cultivo , subparcela , 69 )', 'asociaciones', 'blackburn'),
(49, 'admin', 'INSERCIÃ“N', '2015-07-12 05:17:31', 'call SP_asociaciones_ins( Naranja , alto , Cultivo , subparcela , 69 )', 'asociaciones', 'blackburn'),
(50, 'admin', 'INSERCIÃ“N', '2015-07-12 05:17:54', 'call SP_asociaciones_ins( Naranja , alto , Cultivo , subparcela , 69 )', 'asociaciones', 'blackburn'),
(51, 'admin', 'BORRADO', '2015-07-12 05:17:57', 'call SP_asociaciones_del( 742 )', 'asociaciones', 'blackburn'),
(52, 'admin', 'BORRADO', '2015-07-12 05:18:01', 'call SP_asociaciones_del( 741 )', 'asociaciones', 'blackburn'),
(53, 'admin', 'EDICION', '2015-07-12 05:18:10', 'UPDATE subparcelas SET \r\n                id_parcela= 69 ,\r\n                superficie= 2.00 ,\r\n     ', 'subparcelas', 'blackburn'),
(54, 'admin', 'INSERCIÃ“N', '2015-07-12 05:21:48', 'call SP_asociaciones_ins( Yuca , bajo , Cultivo , parcela , 69 )', 'asociaciones', 'blackburn'),
(55, 'admin', 'INSERCIÃ“N', '2015-07-12 05:22:19', 'call SP_asociaciones_ins( Yuca , bajo , Cultivo , parcela , 69 )', 'asociaciones', 'blackburn'),
(56, 'admin', 'INSERCIÃ“N', '2015-07-12 05:22:50', 'call SP_asociaciones_ins( Yuca , bajo , Cultivo , parcela , 69 )', 'asociaciones', 'blackburn'),
(57, 'admin', 'BORRADO', '2015-07-12 05:22:56', 'call SP_asociaciones_del( 745 )', 'asociaciones', 'blackburn'),
(58, 'admin', 'BORRADO', '2015-07-12 05:22:59', 'call SP_asociaciones_del( 744 )', 'asociaciones', 'blackburn'),
(59, 'admin', 'INSERCIÃ“N', '2015-07-12 05:23:20', 'call SP_asociaciones_ins( Gallinas , medio , Animales , parcela , 69 )', 'asociaciones', 'blackburn'),
(60, 'admin', 'INSERCIÃ“N', '2015-07-12 05:23:49', 'call SP_asociaciones_ins( Gallinas , medio , Animales , parcela , 69 )', 'asociaciones', 'blackburn'),
(61, 'admin', 'BORRADO', '2015-07-12 05:23:54', 'call SP_asociaciones_del( 747 )', 'asociaciones', 'blackburn'),
(62, 'admin', 'BORRADO', '2015-07-12 05:23:56', 'call SP_asociaciones_del( 746 )', 'asociaciones', 'blackburn'),
(63, 'admin', 'INSERCIÃ“N', '2015-07-12 05:24:01', 'call SP_asociaciones_ins( Gallinas , medio , Animales , parcela , 69 )', 'asociaciones', 'blackburn'),
(64, 'admin', 'BORRADO', '2015-07-12 05:24:19', 'call SP_asociaciones_del( 746 )', 'asociaciones', 'blackburn'),
(65, 'admin', 'INSERCIÃ“N', '2015-07-12 05:31:09', 'call SP_asociaciones_ins( CaÃ±a , medio , cultivo , parcela , 1 )', 'asociaciones', 'blackburn'),
(66, 'admin', 'BORRADO', '2015-07-12 05:31:12', 'call SP_asociaciones_del( 749 )', 'asociaciones', 'blackburn'),
(67, 'admin', 'INSERCIÃ“N', '2015-07-12 05:31:18', 'call SP_asociaciones_ins( Cuyes , medio , animales , parcela , 1 )', 'asociaciones', 'blackburn'),
(68, 'admin', 'BORRADO', '2015-07-12 05:31:20', 'call SP_asociaciones_del( 750 )', 'asociaciones', 'blackburn'),
(69, 'admin', 'EDICION', '2015-07-12 05:31:26', 'call SP_parcelas_update( 2.00 , 9482926 , 707211 , 1178 , 58 , 200 ,\r\n         4 , 3 , Goteo , 1 )', 'parcelas', 'blackburn'),
(70, 'admin', 'BORRADO', '2015-07-12 05:32:34', 'call SP_asociaciones_del( 711 )', 'asociaciones', 'blackburn'),
(71, 'admin', 'BORRADO', '2015-07-12 05:32:37', 'call SP_asociaciones_del( 710 )', 'asociaciones', 'blackburn'),
(72, 'admin', 'BORRADO', '2015-07-12 05:32:39', 'call SP_asociaciones_del( 712 )', 'asociaciones', 'blackburn'),
(73, 'admin', 'BORRADO', '2015-07-12 05:32:42', 'call SP_asociaciones_del( 724 )', 'asociaciones', 'blackburn'),
(74, 'admin', 'BORRADO', '2015-07-12 05:32:45', 'call SP_asociaciones_del( 727 )', 'asociaciones', 'blackburn'),
(75, 'admin', 'BORRADO', '2015-07-12 05:32:47', 'call SP_asociaciones_del( 729 )', 'asociaciones', 'blackburn'),
(76, 'admin', 'BORRADO', '2015-07-12 05:32:49', 'call SP_asociaciones_del( 726 )', 'asociaciones', 'blackburn'),
(77, 'admin', 'BORRADO', '2015-07-12 05:32:51', 'call SP_asociaciones_del( 725 )', 'asociaciones', 'blackburn'),
(78, 'admin', 'BORRADO', '2015-07-12 05:32:53', 'call SP_asociaciones_del( 719 )', 'asociaciones', 'blackburn'),
(79, 'admin', 'BORRADO', '2015-07-12 05:32:55', 'call SP_asociaciones_del( 731 )', 'asociaciones', 'blackburn'),
(80, 'admin', 'BORRADO', '2015-07-12 05:32:57', 'call SP_asociaciones_del( 717 )', 'asociaciones', 'blackburn'),
(81, 'admin', 'BORRADO', '2015-07-12 05:32:59', 'call SP_asociaciones_del( 714 )', 'asociaciones', 'blackburn'),
(82, 'admin', 'BORRADO', '2015-07-12 05:33:02', 'call SP_asociaciones_del( 730 )', 'asociaciones', 'blackburn'),
(83, 'admin', 'INSERCIÃ“N', '2015-07-12 05:33:07', 'call SP_asociaciones_ins( Platano , alto , cultivo , subparcela , 1 )', 'asociaciones', 'blackburn'),
(84, 'admin', 'EDICION', '2015-07-12 05:33:14', 'UPDATE subparcelas SET \r\n                id_parcela= 1 ,\r\n                superficie= 2.00 ,\r\n      ', 'subparcelas', 'blackburn'),
(85, 'admin', 'INSERCIÃ“N', '2015-07-12 05:33:42', 'INSERT INTO subparcelas VALUES (  ,\r\n                 1 ,\r\n                 20 ,\r\n                 c', 'subparcelas', 'blackburn'),
(86, 'admin', 'EDICION', '2015-07-12 05:39:57', 'call SP_subparcelas_del( 302 )', 'subparcelas', 'blackburn'),
(87, 'admin', 'INSERCIÃ“N', '2015-07-12 05:41:07', 'call SP_asociaciones_ins( Papaya , bajo , cultivo , subparcela , 301 )', 'asociaciones', 'blackburn'),
(88, 'admin', 'EDICION', '2015-07-12 05:41:19', 'UPDATE subparcelas SET \r\n                id_parcela= 1 ,\r\n                superficie= 20.00 ,\r\n     ', 'subparcelas', 'blackburn'),
(89, 'admin', 'INSERCIÃ“N', '2015-07-12 05:51:22', 'CALL SP_subparcelas_ins( 1 , 20 , catucaÃ­ , catucaÃ­ ,\r\n          , 20 , Regular , Limpio , Poco , ', 'subparcelas', 'blackburn'),
(90, 'admin', 'EDICION', '2015-07-12 05:51:36', 'call SP_subparcelas_del( 303 )', 'subparcelas', 'blackburn'),
(91, 'admin', 'EDICION', '2015-07-12 05:55:43', 'CALL SP_subparcelas_upd( 1 , 20.00 , catucaÃ­ , catucaÃ­ ,\r\n         0 , 20 , Medio , Medio , Medio ', 'subparcelas', 'blackburn'),
(92, 'admin', 'EDICION', '2015-07-12 05:55:58', 'CALL SP_subparcelas_upd( 1 , 2.00 , catimoro , catucaÃ­ ,\r\n         2005 , 0 , Regular , Limpio , Po', 'subparcelas', 'blackburn'),
(93, 'admin', 'INSERCIÃ“N', '2015-07-12 06:19:15', 'call SP_parcela_ins(31,1,1,1\r\n        ,2.05,1,1,1, AspersiÃ³n )', 'parcelas', 'blackburn'),
(94, 'admin', 'INSERCIÃ“N', '2015-07-12 06:21:30', 'call SP_parcela_ins(31,1,1,1\r\n        ,1,1,1,1, AspersiÃ³n )', 'parcelas', 'blackburn'),
(95, 'admin', 'INSERCIÃ“N', '2015-07-12 06:23:25', 'call SP_parcela_ins(31,1,1,1\r\n        ,1,1,1,1, AspersiÃ³n )', 'parcelas', 'blackburn'),
(96, 'admin', 'INSERCIÃ“N', '2015-07-12 06:24:15', 'call SP_parcela_ins(31,1,1,1\r\n        ,1,1,1,1, AspersiÃ³n )', 'parcelas', 'blackburn'),
(97, 'admin', 'INSERCIÃ“N', '2015-07-12 06:25:23', 'call SP_parcela_ins(31,1,1,1\r\n        ,1,1,1,1, AspersiÃ³n )', 'parcelas', 'blackburn'),
(98, 'admin', 'INSERCIÃ“N', '2015-07-12 06:26:12', 'call SP_parcela_ins(31,1,1,1\r\n        ,1,1,1,1, AspersiÃ³n )', 'parcelas', 'blackburn'),
(99, 'admin', 'INSERCIÃ“N', '2015-07-12 06:26:59', 'call SP_parcela_ins(31,1,1,1\r\n        ,1,1,1,1, AspersiÃ³n )', 'parcelas', 'blackburn'),
(100, 'admin', 'INSERCIÃ“N', '2015-07-12 07:20:15', 'CALL SP_lote_ins( 68 , APC-00001-15 , 2015-07-12 02:19:37 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 0 , ', 'lotes', 'blackburn'),
(101, 'admin', 'EDICION', '2015-07-12 07:44:27', 'CALL SP_lote_upd( 184 , 68 , APC-00001-15 , 2000-01-01 , 1.00 , 1.00 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 0', 'lotes', 'blackburn'),
(102, 'admin', 'EDICION', '2015-07-12 07:44:42', 'CALL SP_lote_upd( 184 , 68 , APC-00001-15 ,  , 1.00 , 1.00 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 0 , 0 , 1 ,', 'lotes', 'blackburn'),
(103, 'admin', 'EDICION', '2015-07-12 07:44:54', 'CALL SP_lote_upd( 184 , 68 , APC-00001-15 ,  , 1.00 , 1.00 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 0 , 0 , 0 ,', 'lotes', 'blackburn'),
(104, 'admin', 'EDICION', '2015-07-12 07:47:25', 'CALL SP_lote_upd( 184 , 68 , APC-00001-15 ,  , 1.00 , 1.00 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 0 , 0 , 0 ,', 'lotes', 'blackburn'),
(105, 'admin', 'BORRADO', '2015-07-12 07:47:33', 'CALL SP_lote_del( 184 )', 'lotes', 'blackburn'),
(106, 'admin', 'EDICION', '2015-07-12 07:51:02', 'CALL SP_catas_upd( 35 , 170 , 2014-08-18 00:00:00 ,  , 0 , 5 ,\r\n		  ,  , 5 ,  ,  , 5 ,		\r\n		  ,  , 5', 'catas', 'blackburn'),
(107, 'admin', 'EDICION', '2015-07-12 08:19:03', 'CALL SP_catas_del( 35 )', 'catas', 'blackburn'),
(108, 'admin', 'INSERCIÃ“N', '2015-07-12 08:34:20', 'CALL SP_catas_ins( 170 , 2015-07-12 03:33:41 , uno , 0 , 5 ,\r\n		  ,  , 5 ,  ,  , 5 ,\r\n		  ,  , 5 , 5', 'catas', 'blackburn'),
(109, 'admin', 'EDICION', '2015-07-12 08:34:31', 'CALL SP_catas_del( 146 )', 'catas', 'blackburn'),
(110, 'admin', 'INSERCIÃ“N', '2015-07-12 08:34:41', 'CALL SP_catas_ins( 170 , 2015-07-12 03:34:37 ,  , 0 , 5 ,\r\n		  ,  , 5 ,  ,  , 5 ,\r\n		  ,  , 5 , 5 , ', 'catas', 'blackburn'),
(111, 'admin', 'EDICION', '2015-07-12 08:35:34', 'CALL SP_catas_del( 147 )', 'catas', 'blackburn'),
(112, 'admin', 'INSERCIÃ“N', '2015-07-12 08:35:50', 'CALL SP_catas_ins( 170 , 2015-07-12 03:35:41 ,  , 0 , 5 ,\r\n		 Chocolate amargo ,  , 5 , Vinoso ,  , ', 'catas', 'blackburn'),
(113, 'admin', 'EDICION', '2015-07-12 08:36:28', 'CALL SP_catas_upd( 148 , 170 , 2015-07-12 03:35:41 ,  , 0 , 5 ,\r\n		 Chocolate amargo ,  , 5 , Vinoso', 'catas', 'blackburn'),
(114, 'admin', 'BORRADO', '2015-07-12 08:38:07', 'call SP_despachos_del( 3 )', 'despachos', 'blackburn'),
(115, 'admin', 'BORRADO', '2015-07-12 08:38:33', 'call SP_despachos_del( 3 )', 'despachos', 'blackburn'),
(116, 'admin', 'INSERCIÃ“N', '2015-07-12 08:39:58', 'call SP_despacho_ins( 170 , 2015-07-12 03:39:54 , 1 , 4 )', 'despachos', 'blackburn'),
(117, 'admin', 'EDICION', '2015-07-12 08:43:43', 'call SP_envios_upd(\r\n			2014-06-07 00:15:17,\r\n			Quito1,\r\n			Manolo,\r\n			Juanito,\r\n			4)', 'envios', 'blackburn'),
(118, 'admin', 'EDICION', '2015-07-12 08:43:51', 'call SP_envios_upd(\r\n			2014-06-07 00:15:17,\r\n			Quito,\r\n			Manolo,\r\n			Juanito,\r\n			4)', 'envios', 'blackburn'),
(119, 'admin', 'INSERCIÃ“N', '2015-07-12 08:44:57', 'call SP_envios_ins(\r\n			,\r\n			loja,\r\n			Manolo,\r\n			Manolo)', 'envios', 'blackburn'),
(120, 'admin', 'INSERCIÃ“N', '2015-07-12 08:48:31', '', 'persona', 'blackburn'),
(121, 'admin', 'INSERCIÃ“N', '2015-07-12 08:49:07', 'call SP_usuarios_ins( alex , 1234 , administrador ,  )', 'usuarios', 'blackburn'),
(122, 'admin', 'BORRADO', '2015-07-12 08:49:14', 'call SP_users_del( 8 , bajas )', 'usuarios', 'blackburn'),
(123, 'admin', 'BORRADO', '2015-07-12 08:49:23', 'call SP_users_del( 8 , altas )', 'usuarios', 'blackburn'),
(124, 'admin', 'EDICION', '2015-07-12 08:49:40', 'call SP_user_update(8, alex2 , 1234 , contador )', 'usuarios', 'blackburn'),
(125, 'admin', 'BORRADO', '2015-07-12 08:49:46', 'call SP_users_del( 8 , bajas )', 'usuarios', 'blackburn'),
(126, 'admin', 'EDICION', '2015-07-12 08:52:45', 'CALL SP_configuracion_upd( puntaje mÃ­nimo de  , 84.00 , 1 )', 'estimaciones', 'blackburn'),
(127, 'admin', 'INSERCIÃ“N', '2015-07-12 08:53:19', 'call SP_socio_certificar( 68 , 2000 , T1 )', 'certificaciones', 'blackburn'),
(128, 'admin', 'BORRADO', '2015-07-12 08:53:39', 'call SP_certificaciones_del( 355 )', 'certificaciones', 'blackburn'),
(129, 'admin', 'EDICION', '2015-07-12 09:02:36', '', 'grupos', 'blackburn'),
(130, 'admin', 'EDICION', '2015-07-12 09:04:04', 'call SP_grupos_upd( AGRODIN , AN , 2 )', 'grupos', 'blackburn'),
(131, 'admin', 'INSERCIÃ“N', '2015-07-12 21:22:24', 'CALL SP_analisis_ins( 1 , 2015-07-12 , 1 , 1 , angular ,\r\n    	 dÃ©bil , 1 , 1 , 1 , 1 ,\r\n    	 0 , ', 'analisis', 'blackburn'),
(132, 'admin', 'INSERCIÃ“N', '2015-07-12 21:41:23', 'call SP_analisis_upd( 1 , 2015-07-12 , 1 , 1 , angular ,\r\n         dÃ©bil , 1 , 1 , 1 , 1 ,\r\n       ', 'analisis', 'blackburn'),
(133, 'admin', 'BORRADO', '2015-07-12 21:45:31', 'call SP_analisis_del( 6 )', 'analisis', 'blackburn'),
(134, 'admin', 'INSERCIÃ“N', '2015-07-12 21:46:26', 'CALL SP_analisis_ins( 1 , 2015-07-12 , 1 , 1 , angular ,\r\n    	 dÃ©bil , 1 , 1 , 1 , 1 ,\r\n    	 0 , ', 'analisis', 'blackburn'),
(135, 'admin', 'BORRADO', '2015-07-12 21:46:38', 'call SP_analisis_del( 7 )', 'analisis', 'blackburn'),
(136, 'admin', 'EDICION', '2015-07-12 21:49:22', 'call SP_subparcelas_del( 301 )', 'subparcelas', 'blackburn'),
(137, 'admin', 'INSERCIÃ“N', '2015-07-12 21:49:55', 'CALL SP_subparcelas_ins( 1 , 20 , catucaÃ­ , catucaÃ­ ,\r\n         2000-01-12 , 20 , Regular , Limpio', 'subparcelas', 'blackburn'),
(138, 'admin', 'INSERCIÃ“N', '2015-07-12 21:50:07', 'call SP_asociaciones_ins( Naranja , medio , cultivo , subparcela , 304 )', 'asociaciones', 'blackburn'),
(139, 'admin', 'INSERCIÃ“N', '2015-07-12 21:50:14', 'call SP_asociaciones_ins( Guaba , alto , cultivo , subparcela , 304 )', 'asociaciones', 'blackburn'),
(140, 'admin', 'INSERCIÃ“N', '2015-07-12 21:50:24', 'call SP_asociaciones_ins( Vacas , medio , animales , parcela , 1 )', 'asociaciones', 'blackburn'),
(141, 'admin', 'EDICION', '2015-07-12 21:50:32', 'call SP_parcelas_update( 3 , 9482926 , 707211 , 1178 , 58 , 200 ,\r\n         4 , 3 , Goteo , 1 )', 'parcelas', 'blackburn'),
(142, 'admin', 'INSERCIÃ“N', '2015-07-13 23:04:08', 'call SP_socio_certificar( 68 , 2000 , T1 )', 'certificaciones', 'blackburn'),
(143, 'admin', 'INSERCIÃ“N', '2015-07-13 23:07:24', 'call SP_grupos_ins( NUEVO , 01 )', 'grupos', 'blackburn'),
(144, 'admin', 'INSERCIÃ“N', '2015-07-13 23:15:04', 'call SP_socio_ins( nuevo1 , nuevo1 , AG82 , 11231 , 029877 , 1995-01-12 , calle , AGUA DULCE ALTO , ', 'socios', 'blackburn'),
(145, 'admin', 'INSERCIÃ“N', '2015-07-13 23:15:24', 'call SP_socio_certificar( 307 , 2000 , T1 )', 'certificaciones', 'blackburn'),
(146, 'admin', 'INSERCIÃ“N', '2015-07-13 23:16:05', 'call SP_asociaciones_ins( Yuca , medio , cultivo , parcela , 1 )', 'asociaciones', 'blackburn'),
(147, 'admin', 'INSERCIÃ“N', '2015-07-13 23:16:13', 'call SP_asociaciones_ins( Cuyes , medio , animales , parcela , 1 )', 'asociaciones', 'blackburn'),
(148, 'admin', 'EDICION', '2015-07-13 23:16:26', 'call SP_parcelas_update( 3.00 , 9482926 , 707211 , 1178 , 58 , 200 ,\r\n         5 , 3 , Goteo , 1 )', 'parcelas', 'blackburn'),
(149, 'admin', 'EDICION', '2015-07-13 23:20:03', 'CALL SP_catas_del( 148 )', 'catas', 'blackburn'),
(150, 'admin', 'INSERCIÃ“N', '2015-07-13 23:21:31', 'call SP_despacho_ins( 170 , 2015-07-13 18:21:30 , 2 , 4 )', 'despachos', 'blackburn'),
(151, 'admin', 'EDICION', '2015-07-14 06:50:59', 'call SP_parcelas_update( 3.00 , 9482926 , 707211 , 1178 , 58 , 200 ,\r\n         5 , 3 , Goteo , 1 )', 'parcelas', 'blackburn'),
(152, 'admin', 'INSERCIÃ“N', '2015-07-14 07:52:38', 'call SP_despacho_ins( 170 , 2015-07-14 02:52:31 , 0.2 , 4 )', 'despachos', 'blackburn'),
(153, 'admin', 'INSERCIÃ“N', '2015-07-14 07:58:12', 'call SP_envios_ins(\r\n			2015-07-14,\r\n			Loja,\r\n			Manolo,\r\n			Juanito)', 'envios', 'blackburn');

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
  `calidad` text COLLATE latin1_spanish_ci NOT NULL,
  `rto_pilado` int(11) DEFAULT '0',
  `apto_cata` int(1) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=172 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `lotes`
--

INSERT INTO `lotes` (`id`, `id_socio`, `codigo_lote`, `fecha`, `peso`, `humedad`, `rto_descarte`, `rto_exportable`, `defecto_negro`, `defecto_vinagre`, `defecto_decolorado`, `defecto_mordido`, `defecto_brocado`, `reposo`, `moho`, `fermento`, `contaminado`, `calidad`, `rto_pilado`, `apto_cata`) VALUES
(1, 93, 'APC-612', '2014-02-21 10:00:00', 2.65, 12.00, 3, 204, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(2, 297, 'APC-613', '2014-02-21 10:00:00', 3.79, 12.00, 10, 196, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(3, 108, 'APC-614', '2014-02-25 10:00:00', 0.53, 12.00, 16, 187, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(4, 35, 'APC-616', '2014-03-17 10:00:00', 1.54, 16.00, 7, 183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(5, 53, 'APC-617', '2014-04-11 10:00:00', 3.02, 12.00, 30, 174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(6, 296, 'APC-618', '2014-04-11 10:00:00', 5.49, 12.00, 25, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(7, 256, 'APC-619', '2014-04-15 10:00:00', 2.04, 23.00, 15, 161, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B', NULL, NULL),
(8, 295, 'APC-620', '2014-04-15 10:00:00', 8.45, 19.00, 19, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(9, 294, 'APC-621', '2014-04-15 10:00:00', 5.43, 21.00, 6, 175, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(10, 196, 'APC-623', '2014-05-09 10:00:00', 0.52, 12.00, 26, 181, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(11, 108, 'APC-624', '2014-05-13 10:00:00', 3.20, 12.00, 24, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B', NULL, NULL),
(12, 46, 'APC-625', '2014-05-23 10:00:00', 2.10, 12.00, 21, 183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(13, 87, 'APC-02', '2014-02-06 10:00:00', 5.67, 12.00, 14, 188, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(14, 87, 'APC-04', '2014-06-02 10:00:00', 2.56, 12.00, 10, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(15, 213, 'APC-05', '2014-06-02 10:00:00', 1.86, 12.00, 8, 194, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(16, 53, 'APC-06', '2014-06-02 10:00:00', 1.19, 12.00, 16, 186, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(17, 5, 'APC-08', '2014-06-02 10:00:00', 2.60, 12.00, 4, 195, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B', NULL, NULL),
(18, 219, 'APC-09', '2014-06-03 10:00:00', 1.81, 12.00, 18, 188, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(19, 49, 'APC-07', '2014-06-02 10:00:00', 6.73, 12.00, 22, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(20, 107, 'APC-10', '2014-06-09 10:00:00', 6.80, 12.00, 37, 168, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B', NULL, NULL),
(21, 221, 'APC-11', '2014-06-10 10:00:00', 2.10, 12.00, 20, 185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(22, 258, 'APC-12', '2014-06-11 10:00:00', 0.71, 12.00, 39, 158, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B', NULL, NULL),
(23, 5, 'APC-14', '2014-06-11 10:00:00', 3.45, 12.00, 23, 180, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(24, 3, 'APC-15', '2014-06-11 10:00:00', 2.49, 12.00, 15, 189, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(25, 9, 'APC-16', '2014-06-12 10:00:00', 2.63, 12.00, 24, 183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(26, 67, 'APC-17', '2014-06-12 10:00:00', 5.29, 12.00, 13, 190, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(27, 58, 'APC-18', '2014-06-12 10:00:00', 2.25, 12.00, 34, 175, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(28, 290, 'APC-19', '2014-06-16 10:00:00', 1.43, 12.00, 14, 185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(29, 143, 'APC-20', '2014-06-17 10:00:00', 4.29, 12.00, 11, 198, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(30, 7, 'APC-21', '2014-06-17 10:00:00', 2.52, 12.00, 34, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(31, 267, 'APC-22', '2014-06-18 10:00:00', 1.22, 12.00, 13, 190, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(32, 267, 'APC-23', '2014-06-18 10:00:00', 0.38, 12.00, 10, 187, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(33, 86, 'APC-24', '2014-06-19 10:00:00', 4.36, 12.00, 26, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(34, 223, 'APC-25', '2014-06-20 10:00:00', 6.25, 12.00, 17, 186, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(35, 33, 'APC-26', '2014-06-20 10:00:00', 0.71, 12.00, 43, 158, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B', NULL, NULL),
(36, 140, 'APC-27', '2014-06-20 10:00:00', 4.35, 12.00, 22, 183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(37, 16, 'APC-29', '2014-06-24 10:00:00', 0.55, 12.00, 11, 189, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(38, 201, 'APC-30', '2014-06-24 10:00:00', 0.47, 12.00, 13, 189, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(39, 5, 'APC-31', '2014-06-24 10:00:00', 1.38, 12.00, 19, 181, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(40, 122, 'APC-32', '2014-06-26 10:00:00', 1.93, 12.00, 10, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(41, 123, 'APC-33', '2014-06-26 10:00:00', 1.53, 12.00, 10, 193, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(42, 153, 'APC-34', '2014-06-26 10:00:00', 0.58, 12.00, 50, 193, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(43, 5, 'APC-35', '2014-06-26 10:00:00', 0.53, 12.00, 20, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(44, 75, 'APC-36', '2014-06-27 10:00:00', 1.21, 12.00, 9, 193, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(45, 15, 'APC-37', '2014-06-27 10:00:00', 1.05, 12.00, 42, 155, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(46, 16, 'APC-38', '2014-06-27 10:00:00', 1.09, 12.00, 31, 168, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(47, 19, 'APC-39', '2014-06-27 10:00:00', 1.47, 12.00, 14, 182, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(48, 19, 'APC-40', '2014-06-27 10:00:00', 3.00, 12.00, 12, 190, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(49, 219, 'APC-41', '2014-06-30 10:00:00', 1.64, 12.00, 17, 186, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(50, 6, 'APC-42', '2014-06-30 10:00:00', 3.55, 12.00, 10, 193, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(51, 6, 'APC-44', '2014-06-30 10:00:00', 5.15, 12.00, 11, 193, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(52, 75, 'APC-45', '2014-07-01 10:00:00', 0.56, 12.00, 15, 182, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(53, 108, 'APC-46', '2014-07-02 10:00:00', 2.59, 12.00, 29, 173, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(54, 67, 'APC-47', '2014-07-02 10:00:00', 4.76, 12.00, 45, 152, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(55, 7, 'APC-48', '2014-07-03 10:00:00', 2.79, 12.00, 34, 168, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(56, 297, 'APC-49', '2014-07-03 10:00:00', 4.10, 12.00, 23, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(57, 149, 'APC-50', '2014-07-03 10:00:00', 2.33, 12.00, 17, 187, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(58, 295, 'APC-51', '2014-07-07 10:00:00', 2.35, 12.00, 22, 174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(59, 137, 'APC-52', '2014-07-07 10:00:00', 2.48, 12.00, 29, 170, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(60, 1, 'APC-53', '2014-07-07 10:00:00', 0.84, 12.00, 24, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(61, 87, 'APC-54', '2014-07-10 10:00:00', 4.00, 12.00, 0, 181, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(62, 87, 'APC-55', '2014-07-11 01:00:00', 5.59, 12.00, 33, 169, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(63, 129, 'APC-56', '2014-07-10 10:00:00', 1.18, 12.00, 20, 181, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(64, 58, 'APC-57', '2014-07-10 10:00:00', 2.72, 12.00, 36, 166, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(65, 213, 'APC-58', '2014-07-11 10:00:00', 1.73, 12.00, 22, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(66, 74, 'APC-59', '2014-07-14 10:00:00', 3.44, 12.00, 27, 174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(67, 51, 'APC-60', '2014-07-14 10:00:00', 9.75, 12.00, 24, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(68, 59, 'APC-61', '2014-07-14 10:00:00', 4.38, 12.00, 38, 163, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(69, 49, 'APC-62', '2014-07-14 10:00:00', 15.56, 12.00, 33, 169, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(70, 12, 'APC-63', '2014-07-15 10:00:00', 1.46, 12.00, 45, 155, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(71, 192, 'APC-64', '2014-07-15 10:00:00', 1.22, 12.00, 42, 167, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B', NULL, NULL),
(72, 107, 'APC-65', '2014-07-16 10:00:00', 1.66, 12.00, 36, 164, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B', NULL, NULL),
(73, 249, 'APC-66', '2014-07-16 10:00:00', 5.09, 12.00, 38, 195, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(74, 153, 'APC-67', '2014-07-16 10:00:00', 1.24, 12.00, 25, 172, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(75, 90, 'APC-68', '2014-07-17 10:00:00', 6.59, 12.00, 32, 167, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(76, 90, 'APC-69', '2014-07-17 10:00:00', 0.62, 12.00, 25, 164, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'MN', NULL, NULL),
(77, 221, 'APC-70', '2014-07-17 10:00:00', 3.67, 12.00, 32, 167, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(78, 209, 'APC-71', '2014-07-21 10:00:00', 4.00, 12.00, 32, 169, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(79, 295, 'APC-72', '2014-07-21 10:00:00', 3.59, 12.00, 23, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(80, 36, 'APC-73', '2014-07-21 10:00:00', 2.95, 12.00, 18, 182, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(81, 36, 'APC-74', '2014-07-21 10:00:00', 2.95, 12.00, 43, 163, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B', NULL, NULL),
(82, 139, 'APC-75', '2014-07-21 10:00:00', 5.13, 12.00, 32, 168, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(83, 171, 'APC-76', '2014-07-22 10:00:00', 2.22, 12.00, 24, 174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(84, 255, 'APC-77', '2014-07-23 10:00:00', 2.09, 12.00, 29, 169, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(85, 222, 'APC-78', '2014-07-23 10:00:00', 1.68, 12.00, 27, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(86, 9, 'APC-79', '2014-07-23 10:00:00', 4.20, 12.00, 32, 170, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(87, 201, 'APC-80', '2014-07-24 10:00:00', 1.05, 12.00, 14, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(88, 108, 'APC-81', '2014-07-24 10:00:00', 4.96, 12.00, 35, 164, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(89, 146, 'APC-82', '2014-07-24 10:00:00', 1.53, 12.00, 21, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(90, 230, 'APC-83', '2014-07-24 10:00:00', 2.33, 12.00, 24, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(91, 15, 'APC-84', '2014-07-24 10:00:00', 3.83, 12.00, 39, 160, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(92, 71, 'APC85', '2014-07-25 10:00:00', 2.21, 12.00, 26, 172, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(93, 87, 'APC86', '2014-07-28 10:00:00', 9.38, 12.00, 27, 173, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(94, 87, 'APC87', '2014-07-28 20:00:00', 3.45, 12.00, 22, 180, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(95, 3, 'APC88', '2014-07-28 10:00:00', 3.89, 12.00, 24, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(96, 15, 'APC89', '2014-07-29 10:00:00', 1.15, 12.00, 38, 162, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(97, 45, 'APC90', '2014-07-29 10:00:00', 1.52, 12.00, 17, 186, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(98, 143, 'APC91', '2014-07-29 10:00:00', 7.45, 12.00, 21, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(99, 243, 'APC92', '2014-07-30 10:00:00', 1.32, 12.00, 20, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(100, 74, 'APC93', '2014-07-30 10:00:00', 2.81, 12.00, 20, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(101, 174, 'APC94', '2014-07-31 10:00:00', 2.65, 12.00, 22, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(102, 41, 'APC95', '2014-07-31 10:00:00', 1.90, 12.00, 21, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(103, 259, 'APC96', '2014-07-31 10:00:00', 1.73, 12.00, 29, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(104, 256, 'APC97', '2014-07-31 10:00:00', 2.82, 12.00, 19, 181, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(105, 105, 'APC98', '2014-08-01 10:00:00', 7.66, 12.00, 28, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(106, 105, 'APC99', '2014-08-01 10:00:00', 1.00, 12.00, 27, 170, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B', NULL, NULL),
(107, 7, 'APC100', '2014-08-01 10:00:00', 1.27, 12.00, 27, 164, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(108, 292, 'APC-101', '2014-08-01 10:00:00', 4.70, 12.00, 19, 182, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(109, 291, 'APC102', '2014-08-01 10:00:00', 16.70, 12.00, 22, 180, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(110, 288, 'APC103', '2014-08-01 10:00:00', 5.00, 12.00, 27, 175, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(111, 287, 'APC104', '2014-08-01 10:00:00', 10.78, 12.00, 17, 185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(112, 251, 'APC-105', '2014-08-04 10:00:00', 1.22, 12.00, 22, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(113, 107, 'APC106', '2014-08-04 10:00:00', 0.94, 12.00, 26, 173, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(114, 293, 'APC107', '2014-08-04 10:00:00', 3.85, 12.00, 20, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(115, 214, 'APC108', '2014-08-04 10:00:00', 13.41, 12.00, 25, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(116, 295, 'APC109', '2014-08-04 10:00:00', 2.47, 12.00, 21, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(117, 301, 'APC110', '2014-08-04 10:00:00', 1.42, 12.00, 20, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(118, 239, 'APC111', '2014-08-04 10:00:00', 1.35, 12.00, 27, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(119, 242, 'APC112', '2014-08-04 10:00:00', 0.73, 12.00, 28, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(120, 250, 'APC113', '2014-08-04 10:00:00', 13.80, 12.00, 26, 175, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(121, 215, 'APC114', '2014-08-04 10:00:00', 1.00, 12.00, 25, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(122, 237, 'APC115', '2014-08-04 10:00:00', 0.50, 12.00, 17, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(123, 296, 'APC116', '2014-08-05 10:00:00', 5.19, 12.00, 30, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(124, 292, 'APC117', '2014-08-05 10:00:00', 0.59, 12.00, 63, 156, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(125, 296, 'APC118', '2014-08-05 10:00:00', 4.74, 12.00, 29, 173, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(126, 138, 'APC119', '2014-08-05 10:00:00', 1.46, 12.00, 17, 186, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(127, 155, 'APC120', '2014-08-05 10:00:00', 1.86, 12.00, 24, 175, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(128, 299, 'APC121', '2014-08-06 10:00:00', 3.33, 12.00, 34, 168, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(129, 32, 'APC122', '2014-08-06 10:00:00', 2.67, 12.00, 20, 181, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(130, 93, 'APC123', '2014-08-06 10:00:00', 3.13, 12.00, 11, 190, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(131, 1, 'APC124', '2014-08-06 10:00:00', 2.42, 12.00, 24, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(132, 300, 'APC125', '2014-08-06 10:00:00', 4.67, 12.00, 24, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(133, 140, 'APC126', '2014-08-07 10:00:00', 5.59, 12.00, 17, 185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(134, 122, 'APC127', '2014-08-07 10:00:00', 1.50, 12.00, 20, 181, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(135, 118, 'APC128', '2014-08-07 10:00:00', 0.80, 12.00, 16, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(136, 118, 'APC129', '2014-08-07 10:00:00', 0.74, 12.00, 21, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(137, 257, 'APC130', '2014-08-07 10:00:00', 12.46, 12.00, 29, 173, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(138, 129, 'APC131', '2014-08-07 10:00:00', 1.44, 12.00, 16, 187, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(139, 190, 'APC132', '2014-08-07 10:00:00', 0.78, 12.00, 26, 173, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(140, 201, 'APC133', '2014-08-07 10:00:00', 0.38, 12.00, 23, 174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(141, 206, 'APC134', '2014-08-07 10:00:00', 0.48, 12.00, 13, 185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(142, 36, 'APC135', '2014-08-07 10:00:00', 0.41, 12.00, 9, 180, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(143, 36, 'APC136', '2014-08-07 10:00:00', 3.73, 12.00, 29, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(144, 43, 'APC137', '2014-08-08 10:00:00', 2.09, 12.00, 23, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'B', NULL, NULL),
(145, 149, 'APC138', '2014-08-08 10:00:00', 2.75, 12.00, 22, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(146, 61, 'APC139', '2014-08-08 10:00:00', 4.54, 12.00, 23, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(147, 221, 'APC140', '2014-08-08 10:00:00', 2.62, 12.00, 27, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(148, 16, 'APC141', '2014-08-08 10:00:00', 1.35, 12.00, 16, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(149, 7, 'APC142', '2014-08-08 10:00:00', 4.12, 12.00, 25, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(150, 253, 'APC143', '2014-08-08 10:00:00', 2.28, 12.00, 23, 175, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(151, 214, 'APC144', '2014-08-08 10:00:00', 1.67, 12.00, 18, 183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(152, 221, 'APC145', '2014-08-08 10:00:00', 1.90, 12.00, 30, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(153, 298, 'APC146', '2014-08-11 10:00:00', 5.49, 12.00, 29, 174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(154, 298, 'APC147', '2014-08-11 10:00:00', 0.62, 12.00, 21, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(155, 294, 'APC-148', '2014-08-11 10:00:00', 10.38, 12.00, 24, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(156, 213, 'APC-149', '2014-08-11 10:00:00', 6.04, 12.00, 30, 173, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(157, 163, 'APC-150', '2014-08-11 10:00:00', 4.14, 12.00, 24, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(158, 63, 'APC-151', '2014-08-11 10:00:00', 2.83, 12.00, 23, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(159, 222, 'APC-152', '2014-08-11 10:00:00', 1.23, 12.00, 26, 170, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(160, 272, 'APC-153', '2014-08-12 10:00:00', 3.78, 12.00, 25, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(161, 196, 'APC-154', '2014-08-12 10:00:00', 2.16, 12.00, 24, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(162, 51, 'APC-155', '2014-08-12 10:00:00', 5.62, 12.00, 24, 178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(163, 122, 'APC-156', '2014-08-12 10:00:00', 1.22, 12.00, 13, 187, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(164, 19, 'APC-157', '2014-08-12 10:00:00', 2.61, 12.00, 21, 182, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(165, 9, 'APC-158', '2014-08-12 10:00:00', 5.43, 12.00, 26, 177, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(166, 60, 'APC-159', '2014-08-13 10:00:00', 3.87, 12.00, 33, 169, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(167, 153, 'APC-160', '2014-08-13 10:00:00', 2.06, 12.00, 14, 187, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(168, 61, 'APC-161', '2014-08-14 10:00:00', 2.50, 12.00, 18, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(169, 290, 'APC-162', '2014-08-14 10:00:00', 1.57, 12.00, 10, 191, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(170, 50, 'APC-163', '2014-08-18 10:00:00', 7.12, 12.00, 12, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL),
(171, 297, 'APC-164', '2014-08-18 10:00:00', 2.22, 12.00, 23, 179, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'A', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `niveles`
--

CREATE TABLE IF NOT EXISTS `niveles` (
`id_niveles` int(11) NOT NULL,
  `nivel` varchar(45) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `niveles`
--

INSERT INTO `niveles` (`id_niveles`, `nivel`) VALUES
(1, 'administrador'),
(2, 'contador'),
(3, 'bodeguero'),
(4, 'catador'),
(5, 'socio');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id`, `lote`, `fecha`, `exportable`, `descarte`, `fuera`, `calidad`, `cliente`, `microlote`, `tazadorada`) VALUES
(1, 93, '2014-09-18 21:38:38', 800.00, 70.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2, 37, '2014-09-23 02:41:21', 0.00, 0.00, 100.00, 0.00, 0.00, 0.00, 0.00),
(3, 36, '2014-09-25 14:53:29', 1499.00, 190.00, 0.00, 0.00, 45.00, 250.00, 300.00),
(5, 171, '2015-07-10 05:00:00', 0.00, 0.00, 10.00, 0.00, 20.00, 30.00, 40.00),
(6, 168, '2015-07-10 05:00:00', 0.00, 0.00, 15.00, 0.00, 22.00, 23.00, 24.00),
(7, 4, '2015-07-12 05:00:00', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00);

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
(1, 58, 9482926, 707211, 1178, 3.00, 200, 5, 3, 'Goteo'),
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
  `cedula` bigint(20) DEFAULT NULL,
  `celular` int(10) NOT NULL,
  `f_nacimiento` date DEFAULT NULL,
  `email` text,
  `direccion` text,
  `foto` text,
  `genero` char(1) DEFAULT NULL,
  `id_canton` int(10) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=318 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`id_persona`, `nombres`, `apellidos`, `cedula`, `celular`, `f_nacimiento`, `email`, `direccion`, `foto`, `genero`, `id_canton`) VALUES
(2, ' Baltazar Francisco', 'Alvarez Michay', 1102029814, 0, '1960-01-08', '', '', '', '', 1),
(3, ' Manuela Bernarda', 'Cevallos Michay', 1900055300, 0, '1944-12-04', '', '', '', '', 1),
(4, ' Angel Benigno', 'Gaona Torres', 1101903662, 0, '1956-04-19', '', '', '', '', 1),
(5, ' Gloria Elisa', 'Guarinda Ceballos', 1103418503, 983520805, '1976-03-27', '', '', '', '', 1),
(6, ' Cosme Gabriel', 'Merino Alvarez', 1103888911, 0, '1981-12-11', 'cmerino@apecap.org', '', '', '', 1),
(7, ' Milton', 'Rosillo Troya', 1102507728, 992200071, '1966-08-26', '', '', '', '', 1),
(8, ' Polidoro', 'Rosillo Troya', 1101976270, 0, '1960-08-13', '', '', '', '', 1),
(9, ' Jose Vidal', 'Erazo Narvaez', 1900053875, 0, '0000-00-00', '', '', '', '', 1),
(10, ' Silvio', 'Diaz Zumba', 1900255447, 959500344, '1969-04-25', '', '', '', '', 1),
(11, ' Juan Francisco', 'Robles Patino', 1101444469, 0, '0000-00-00', '', '', '', '', 1),
(12, ' Cesar Luis', 'Rosillo Troya', 1101976262, 0, '1957-05-15', '', '', '', '', 1),
(13, ' Manecio Amable', 'Avila Rojas', 1900080951, 990252603, '1950-06-05', '', '', '', '', 1),
(14, ' Ana Petronila', 'Alvarez Michay', 1900184951, 988734350, '1964-07-25', '', '', '', '', 1),
(15, ' Juan Daniel', 'Alvarez Merino', 1900427376, 969006512, '1978-08-15', '', '', '', '', 1),
(16, ' Jose Bartolo', 'Jiron Vicente', 1105143190, 0, '1989-07-25', '', '', '', '', 1),
(17, ' Manuel', 'Pintado Cordero', 1103550966, 959812954, '1990-07-25', '', '', '', '', 1),
(18, ' Anguisaca Zumba', 'Luis Antonio', 1103562250, 0, '0000-00-00', '', '', '', '', 1),
(19, '  Augusto Martin', 'Chuquimarca Chinchay', 1100839008, 994684353, '1958-12-07', '', '', '', '', 1),
(20, ' Felipe Parmenio', 'Rosillo Guerrero', 1104570245, 0, '1987-04-22', '', '', '', '', 1),
(21, ' Luis Matias', 'Erazo Riofrio', 0, 0, '0000-00-00', '', '', '', '', 1),
(22, ' Silvio', 'Jiron Vicente', 1104884729, 0, '1987-01-01', '', '', '', '', 1),
(23, ' Ilda', 'Ramon Juarez', 1101069043, 0, '1955-09-21', '', '', '', '', 1),
(24, ' Nery Germania', 'Abad Jimenez', 0, 0, '0000-00-00', '', '', '', '', 1),
(25, ' Luis Roberto', 'Gerrero Merino', 0, 0, '0000-00-00', '', '', '', '', 1),
(26, ' Herman Segundo', 'Velez Chinchay', 1102733324, 0, '1966-02-06', '', '', '', '', 1),
(27, ' Rodrigo', 'Ruiz Chugchilan', 1500902265, 0, '1988-04-19', '', '', '', '', 1),
(28, ' Hermi', 'Rosales Correa', 1900221795, 0, '1964-06-07', '', '', '', '', 1),
(29, ' Mario Francisco', 'Guerrero Troya', 1103191993, 0, '0000-00-00', '', '', '', '', 1),
(30, ' Miguel Angel', 'Torres Calle', 1102056882, 0, '0000-00-00', '', '', '', '', 1),
(31, ' Vidal Valentin', 'Alverca Zumba', 1103660435, 0, '0000-00-00', '', '', '', '', 1),
(32, ' Victoria Angelica', 'Alberca Peña', 1900558733, 0, '0000-00-00', '', '', '', '', 1),
(33, ' Efren', 'Alberca Jimenez', 1900092956, 0, '0000-00-00', '', '', '', '', 1),
(34, ' Oliveros', 'Alberca Pena', 1900402361, 0, '0000-00-00', '', '', '', '', 1),
(35, ' Manuel', 'Jimenez Jimenez', 1900187624, 0, '0000-00-00', '', '', '', '', 1),
(36, ' Domingo', 'Alvarez Pedro', 1900187624, 0, '1958-05-04', '', '', '', '', 1),
(37, ' Jose Miguel', 'Arvarez Jimenez', 1900239367, 0, '1967-03-21', '', '', '', '', 1),
(38, 'Geremias ', 'Alverca', 1900110576, 0, '1955-11-08', '', '', '', '', 1),
(39, ' Anibal Arcenio', 'Diaz Zumba', 1900174325, 0, '1963-01-05', '', '', '', '', 1),
(40, ' Darwin Marcelo', 'Diaz Jimenez', 1724016397, 0, '1989-01-16', '', '', '', '', 1),
(41, ' Salvador', 'Cordero Jose', 1900255264, 0, '1968-11-28', '', '', '', '', 1),
(42, ' Jose Marcos', 'Alverca Cordero', 1900797809, 0, '1994-03-07', '', '', '', '', 1),
(43, ' Jose Marcial', 'Jimenez Pintado', 1101824777, 0, '0000-00-00', '', '', '', '', 1),
(44, ' Jose Santiago', 'Jimenez Cueva', 1101824777, 0, '1958-09-30', '', '', '', '', 1),
(45, ' Francel Andres', 'Alverca Peña', 1900459908, 0, '1980-10-30', '', '', '', '', 1),
(46, ' Horacio Cristobal', 'Alvarez Alvarez', 1900797331, 0, '1992-08-08', '', '', '', '', 1),
(47, ' Aureliano', 'Tillaguango Calva', 1101581559, 0, '0000-00-00', '', '', '', '', 1),
(48, ' Instalin', 'Tamayo Castillo', 1900324714, 0, '1971-10-06', '', '', '', '', 1),
(49, ' Miguel Angel', 'Abarca Aldaz', 1102831946, 0, '1969-05-25', '', '', '', '', 1),
(50, ' German Enixon', 'Tillaguango Vega', 1900288497, 0, '1971-06-10', '', '', '', '', 1),
(51, ' Carlos Marino', 'Correa Cumbicus', 1900322866, 0, '1976-03-26', '', '', '', '', 1),
(52, ' Juan Antonio', 'Tillagungo Abad', 1104005168, 0, '0000-00-00', '', '', '', '', 1),
(53, ' Gilber Efren', 'Abarca Aldaz', 1103725923, 0, '1975-07-16', '', '', '', '', 1),
(54, ' Jimenez Jimenez', 'Elsa Natalia', 1103411888, 0, '0000-00-00', '', '', '', '', 1),
(55, ' Jose Moises', 'Jaramillo Carrion', 1103481311, 0, '1973-10-26', '', '', '', '', 1),
(56, ' Maria Lastenia', 'Tamayo Castillo', 0, 0, '1985-08-11', '', '', '', '', 1),
(57, ' Nidia Esperanza', 'Tillaguango Pintado', 1900585504, 0, '1985-12-11', '', '', '', '', 1),
(58, ' Sergio Feliciano', 'Tillaguango Pintado', 1900305382, 0, '1974-11-01', '', '', '', '', 1),
(59, ' Jiose Luis', 'Guayanay Masache', 0, 0, '0000-00-00', '', '', '', '', 1),
(60, ' Marcela Eloisa', 'Tillaguango Pintado', 0, 0, '0000-00-00', '', '', '', '', 1),
(61, ' Fernando', 'Abad Jimenez', 0, 0, '0000-00-00', '', '', '', '', 1),
(62, ' Victor Manuel', 'Calva Pintado', 1102927322, 0, '1987-02-20', '', '', '', '', 1),
(63, ' Olivio', 'Gaona Abad', 1900265537, 0, '1971-12-10', '', '', '', '', 1),
(64, ' Gerardo Florentino', 'Salinas Castillo', 1900196930, 0, '1960-10-16', '', '', '', '', 1),
(65, ' Hipolito', 'Salinas Castillo', 1900093244, 0, '1949-08-08', '', '', '', '', 1),
(66, ' Segundo Ramon', 'Salinas Castillo', 1900159144, 0, '1962-10-17', '', '', '', '', 1),
(67, ' Josefino De Jesus', 'Suarez Bravo', 1103208110, 0, '0000-00-00', '', '', '', '', 1),
(68, ' Gaona Castillo', 'Vilma Francisca', 1105101149, 0, '1991-07-24', '', '', '', '', 1),
(69, 'Indalecio', 'Abad Abad', 1104518863, 0, '1981-01-29', '', '', '', 'M', 16),
(70, ' Segundo Aurelio', 'Calva Abad', 1900255355, 0, '1963-11-16', '', '', '', '', 1),
(71, ' Jose Marcial', 'Abad Pintado', 1900324615, 0, '1973-04-15', '', '', '', '', 1),
(72, ' Simon Bolivar', 'Gaona Calva', 1103147862, 0, '1971-10-08', '', '', '', '', 1),
(73, ' Bolivar', 'Gaona Jose', 1103596362, 0, '0000-00-00', '', '', '', '', 1),
(74, ' Francisco Eleodoro', 'Salinas Gaona', 0, 0, '0000-00-00', '', '', '', '', 1),
(75, ' Norverto', 'Requelme Campoverde', 0, 0, '0000-00-00', '', '', '', '', 1),
(76, ' Luis Celestin', 'Salinas Gaona', 0, 0, '0000-00-00', '', '', '', '', 1),
(77, ' Jose Miguel', 'Jimenez Abad', 1105637357, 0, '1991-06-12', '', '', '', '', 1),
(78, ' Olivio Ramiro', 'Ortiz Salinas', 0, 0, '0000-00-00', '', '', '', '', 1),
(79, ' Juan Oswaldo', 'Gaona Reinoso', 0, 0, '0000-00-00', '', '', '', '', 1),
(80, ' Jose Vicente', 'Abad Troya', 1900315639, 0, '0000-00-00', '', '', '', '', 1),
(81, ' Jose Benecio', 'Tamayo Gaona', 1103649412, 0, '0000-00-00', '', '', '', '', 1),
(82, ' Dixon Francel', 'Pardo Tamayo', 1103924138, 0, '1980-04-23', '', '', '', '', 1),
(83, ' Jose Fredy', 'Jimenez Minga', 1900323864, 0, '1975-01-25', '', '', '', '', 1),
(84, ' Roberto', 'Tamayo Moreno', 1102252457, 0, '1959-05-13', '', '', '', '', 1),
(85, ' Froilan Heriberto', 'Perez Pardo', 1900655919, 0, '1990-05-31', '', '', '', '', 1),
(86, ' Agustin Camilo', 'Tamayo Jiron', 1104293012, 0, '1981-11-01', '', '', '', '', 1),
(87, ' Lola Esperanza', 'Pardo Tamayo', 1900444413, 0, '1981-08-05', '', '', '', '', 1),
(88, ' Manuel Francisco', 'Cordero Alverca', 1900323252, 0, '1975-04-07', '', '', '', '', 1),
(89, ' Luz Del Carmen', 'Alverca Castillo', 1100497534, 0, '0000-00-00', '', '', '', '', 1),
(90, ' Pedro Julio', 'Escobar Vicente', 1101951059, 0, '1957-07-07', '', '', '', '', 1),
(91, ' Cesar Manuel', 'Jimenez Giron', 1102652078, 0, '0000-00-00', '', '', '', '', 1),
(92, ' Segundo Eduardo', 'Jimenez Abad', 1900182724, 0, '0000-00-00', '', '', '', '', 1),
(93, ' Teodoro', 'Calva Guayanay', 1101974630, 0, '1960-09-08', '', '', '', '', 1),
(94, ' Fausto', 'Calva Castillo', 1900239862, 0, '1969-10-03', '', '', '', '', 1),
(95, ' Luis', 'Giron Jimenez', 1102083068, 0, '1962-08-15', '', '', '', '', 1),
(96, ' Manuel Arnoldo', 'Giron Salazar', 1100531092, 0, '1942-12-15', '', '', '', '', 1),
(97, ' Jose Ambrocio', 'Jimenez Jimenez', 1900055953, 0, '1934-01-08', '', '', '', '', 1),
(98, ' Maria Esthela', 'Jimenez Gonzaga', 1900239854, 0, '1971-11-06', '', '', '', '', 1),
(99, ' Gonzaga', 'Miguel Angeljimenez', 1900093335, 0, '1940-03-13', '', '', '', '', 1),
(100, ' Onecimo', 'Jimenez Manuel', 1900122423, 0, '0000-00-00', '', '', '', '', 1),
(101, ' Angel Miguel', 'Giron Jimenez', 1102079418, 0, '0000-00-00', '', '', '', '', 1),
(102, ' Manuel Fernando', 'Jimenez Gaona', 1103042485, 0, '1972-04-24', '', '', '', '', 1),
(103, ' Jose Cesario', 'Giron Jimenez', 1900098581, 0, '0000-00-00', '', '', '', '', 1),
(104, 'Margarita', 'Salazar', 1103111199, 0, '0000-00-00', '', '', '', '', 1),
(105, ' Jose Librando', 'Jimenez Merino', 1102227632, 0, '1960-12-12', '', '', '', '', 1),
(106, ' Jesus Amable', 'Alberca Zumba', 1900194927, 0, '0000-00-00', '', '', '', '', 1),
(107, ' Octaviano', 'Alverca Troya', 1900203439, 0, '1962-05-25', '', '', '', '', 1),
(108, ' Gabriel', 'Alverca Troya', 1900202738, 0, '1965-06-19', '', '', '', '', 1),
(109, ' Marco Jose', 'Benavidez Romero', 1900443209, 0, '1981-11-05', '', '', '', '', 1),
(110, ' Juan Jose', 'Alverca Abad', 0, 0, '0000-00-00', '', '', '', '', 1),
(111, ' Juan Angel', 'Alejo Gonzaga', 1104173883, 0, '0000-00-00', '', '', '', '', 1),
(112, ' Julio Orlando', 'Avila Torres', 1103101430, 0, '1968-02-19', '', '', '', '', 1),
(113, ' Franco Efrain', 'Avila Torres', 1102890397, 0, '1963-07-23', '', '', '', '', 1),
(114, ' Juan Bartolo', 'Castillo Jimenez', 1900092790, 0, '1954-08-24', '', '', '', '', 1),
(115, ' Gonzalo', 'Castillo Jimenez', 1102976576, 0, '1971-02-21', '', '', '', '', 1),
(116, ' Jose Vicente', 'Calva Jimenez', 1100514700, 0, '1944-12-28', '', '', '', '', 1),
(117, ' Lucia Marlene', 'Calva Paccha', 1103515308, 0, '0000-00-00', '', '', '', '', 1),
(118, ' Angel Servilio', 'Calva Paccha', 1103155402, 0, '1970-07-04', '', '', '', '', 1),
(119, ' Juan Ramon', 'Calva Paccha', 1102659305, 0, '0000-00-00', '', '', '', '', 1),
(120, ' Julio Orlando', 'Calva Paccha', 1103276232, 0, '1972-05-24', '', '', '', '', 1),
(121, ' Juan Vicente', 'Jimenez Avila', 1900054857, 0, '0000-00-00', '', '', '', '', 1),
(122, ' Jose Juaquin', 'Pacha Villalta', 1103110621, 0, '1971-05-03', '', '', '', '', 1),
(123, ' Jose Antonio', 'Reyes Merino', 1714661251, 0, '1982-06-05', '', '', '', '', 1),
(124, ' Vitaliano Efrain', 'Sanchez Paccha', 1900201045, 0, '1966-01-27', '', '', '', '', 1),
(125, ' Jose Maria', 'Sanchez Chinchay', 1900054790, 0, '1943-10-01', '', '', '', '', 1),
(126, ' Angel Polivio', 'Avila Torres', 1708544224, 0, '0000-00-00', '', '', '', '', 1),
(127, ' Ronald Ivan', 'Rodriguez Lima', 1104563448, 0, '1986-03-27', '', '', '', '', 1),
(128, ' Rosa Esperanza', 'Abad Villalta', 0, 0, '0000-00-00', '', '', '', '', 1),
(129, ' Luz Maria', 'Jimenez Castillo', 1104281124, 0, '1985-09-27', '', '', '', '', 1),
(130, ' Vicente Polivio', 'Jimenez Castillo', 1708544224, 0, '0000-00-00', '', '', '', '', 1),
(131, ' Rosa Del Carmen', 'Sanchez Avila', 1716741507, 0, '1982-05-14', '', '', '', '', 1),
(132, ' Rosela Marujita', 'Calva Paccha', 1103412290, 0, '1974-08-14', '', '', '', '', 1),
(133, ' Maria Carmen', 'Calva Paccha', 1103844344, 0, '1981-04-14', '', '', '', '', 1),
(134, ' Elvia Maruja', 'Jimenez Castillo', 1900380815, 0, '1980-03-01', '', '', '', '', 1),
(135, ' Felizino', 'Lima Darwin', 1104037443, 0, '1982-12-26', '', '', '', '', 1),
(136, ' Maria Graciela', 'Troya Paccha', 1103182224, 0, '1968-01-20', '', '', '', '', 1),
(137, ' Jose Bolivar', 'Malacatus Chainchay', 1103576995, 0, '1966-02-17', '', '', '', '', 1),
(138, ' Luis Jaime', 'Castillo Jimenez', 110399819, 0, '1980-11-03', '', '', '', '', 1),
(139, ' Jose Antonio', 'Armijos Patino', 1900199918, 0, '0000-00-00', '', '', '', '', 1),
(140, ' Telmo Camilo', 'Luzuriaga Maza', 1900465335, 0, '1982-02-17', '', '', '', '', 1),
(141, ' Jorge', 'Granda Quinche', 1900055441, 0, '1947-06-22', '', '', '', '', 1),
(142, ' Jose Efredin', 'Sanches Troya', 1900278795, 0, '1968-08-01', '', '', '', '', 1),
(143, ' Domingo Santiago', 'Lojan Zumba', 1102372529, 0, '1962-05-12', '', '', '', '', 1),
(144, ' Chuquiguanca Gonzaga', 'Luis Martin', 1102880372, 0, '1969-03-28', '', '', '', '', 1),
(145, ' Jose Benito', 'Pizarro Jimenez', 1900200690, 0, '1965-12-06', '', '', '', '', 1),
(146, ' Patricia Yolanda', 'Gaona Villalta', 1103513907, 0, '0000-00-00', '', '', '', '', 1),
(147, ' Camilo Jacobo', 'Castillo Guarnizo', 0, 0, '0000-00-00', '', '', '', '', 1),
(148, ' Carlos Mayco', 'Reinoso Capa', 0, 0, '0000-00-00', '', '', '', '', 1),
(149, ' Jose Benito', 'Chuquiguanca Calva', 0, 0, '0000-00-00', '', '', '', '', 1),
(150, ' Arcelio', 'Avila Jose', 1900348127, 0, '0000-00-00', '', '', '', '', 1),
(151, 'Benito', 'Luzuriga', 1104640618, 0, '1986-09-01', '', '', '', '', 1),
(152, ' Henry Jose', 'Romero Puzma', 1900258797, 0, '1968-01-10', '', '', '', '', 1),
(153, ' Bayron Enrrique', 'Avila Torres', 1104923386, 0, '1988-07-13', '', '', '', '', 1),
(154, ' Andres Marcelino', 'Cuenca Avila', 1103213534, 0, '0000-00-00', '', '', '', '', 1),
(155, ' Victor Alonzo', 'Jimenez Merino', 1900066067, 0, '1974-10-03', '', '', '', '', 1),
(156, 'Andres ', 'Luzuriaga', 1900751098, 0, '1990-04-05', '', '', '', '', 1),
(157, ' Gabriel', 'Garrido Ordoñez', 1900055516, 0, '1944-09-16', '', '', '', '', 1),
(158, ' Alejandro Francisco', 'Ávila Jiménez', 1104625981, 0, '1985-05-17', '', '', '', '', 1),
(159, ' Samuel Francisco', 'Abad Pintado', 1104069263, 0, '1977-05-18', '', '', '', '', 1),
(160, ' Luis Alberto', 'Garrido Flores', 0, 0, '0000-00-00', '', '', '', '', 1),
(161, ' Francisco Ramon', 'Abad Gaona', 1105845133, 0, '0000-00-00', '', '', '', '', 1),
(162, ' Hortencio', 'Abad Troya', 1104982739, 0, '1981-07-07', '', '', '', '', 1),
(163, ' Alfredo Daniel', 'Castillo Tamay', 1103423917, 0, '1976-12-07', '', '', '', '', 1),
(164, ' Milton Noe', 'Garcia Abad', 1104665722, 0, '1985-12-14', '', '', '', '', 1),
(165, ' Luis Reinaldo', 'Abad Troya', 1900543735, 0, '1983-04-15', '', '', '', '', 1),
(166, ' Abraham Eduardo', 'Castillo Avila', 1900601236, 0, '0000-00-00', '', '', '', '', 1),
(167, ' Nelson Darwin', 'Rodriguez Reinosa', 1900595586, 0, '0000-00-00', '', '', '', '', 1),
(168, ' Danilo', 'Abad Troya', 1104666753, 0, '1986-06-06', '', '', '', '', 1),
(169, ' Elkin Abad', 'Abad Troya', 1900842525, 0, '0000-00-00', '', '', '', '', 1),
(170, ' Germania Piedad', 'Abad Troya', 1104887250, 0, '1984-06-21', '', '', '', '', 1),
(171, ' Jose Francisco', 'Abad Troya', 1104925787, 0, '1988-09-20', '', '', '', '', 1),
(172, ' Juan Servilio', 'Abad Troya', 0, 0, '0000-00-00', '', '', '', '', 1),
(173, ' Crimildo', 'Abad Troya', 1104666746, 0, '0000-00-00', '', '', '', '', 1),
(174, ' Bolivar', 'Troya Manuel', 1102997168, 0, '0000-00-00', '', '', '', '', 1),
(175, ' Rosana Ecliceria', 'Jaramillo Tamay', 1101914875, 0, '1945-05-13', '', '', '', '', 1),
(176, ' Segundo Gilberto', 'Capa Cueva', 1102183637, 0, '1959-09-16', '', '', '', '', 1),
(177, ' Maria Cecilia', 'Arevalo Acaro', 1900093459, 0, '1953-12-22', '', '', '', '', 1),
(178, ' Hugo Homero', 'Ramon Capa', 1900081090, 0, '1950-09-22', '', '', '', '', 1),
(179, ' Leticia Lidia', 'Castillo Bravo', 1900199728, 0, '1965-03-27', '', '', '', '', 1),
(180, ' Elvia Graciela', 'Iñiguez Tamay', 1100662459, 0, '1950-03-29', '', '', '', '', 1),
(181, ' Raquel Cumanda', 'Carrion Jaramillo', 1103269443, 0, '1972-02-12', '', '', '', '', 1),
(182, ' Luciano', 'Lojan Zumba', 1101864161, 0, '0000-00-00', '', '', '', '', 1),
(183, ' Carlos', 'Minga Sanchez', 1102564331, 0, '0000-00-00', '', '', '', '', 1),
(184, ' Ramon Castillo', 'Diomer Jovani', 1717738304, 0, '1982-10-22', '', '', '', '', 1),
(185, ' Luisa Amada', 'Giron Guerrero', 1102415195, 0, '0000-00-00', '', '', '', '', 1),
(186, ' Ismenia', 'Herrera Monica', 1900550649, 0, '1985-12-01', '', '', '', '', 1),
(187, ' Michael', 'Tilden Marsh', 1750869008, 0, '1951-11-04', '', '', '', '', 1),
(188, ' Aureliano', 'Alvarez Cordero', 1100561305, 0, '1951-04-23', '', '', '', '', 1),
(189, ' Angel', 'Alvarez Guerrero', 1103276596, 0, '1974-04-25', '', '', '', '', 1),
(190, ' Jose Lorenzo', 'Alvarez Guerrero', 1900457449, 0, '0000-00-00', '', '', '', '', 1),
(191, ' Pedro Antonio', 'Alvarez Guerrero', 1103276570, 0, '0000-00-00', '', '', '', '', 1),
(192, ' Hermelinda', 'Guerrero Pintado', 1102254909, 0, '1959-10-17', '', '', '', '', 1),
(193, ' Jose Esteban', 'Pintado Alvarez', 1102114962, 0, '1961-08-03', '', '', '', '', 1),
(194, ' Santos Nolberto', 'Zumba Diaz', 1900211259, 0, '1965-06-06', '', '', '', '', 1),
(195, ' Rosa Elvira', 'Abad Jimenez', 1100534526, 0, '1946-12-15', '', '', '', 'f', 1),
(196, ' Jose Isrrael', 'Jimenez Guayanay', 701735615, 0, '1962-10-06', '', '', '', '', 1),
(197, ' Teresa Dolores', 'Jimenez Anguisaca', 1900200989, 0, '1968-11-25', '', '', '', '', 1),
(198, ' Milton Vidal', 'Guerrero Pintado', 1102745815, 0, '1966-01-21', '', '', '', '', 1),
(199, ' Veronica Lucia', 'Jimenez Anguiazaca', 1103232367, 0, '0000-00-00', '', '', '', '', 1),
(200, '  Luis Francisco', 'Alvarez Anguisaca', 1104549181, 0, '0000-00-00', '', '', '', '', 1),
(201, ' Segundo Isaias', 'Paccha Troya', 1100756954, 0, '1953-04-15', '', '', '', '', 1),
(202, ' Melecio Teodomiro', 'Merino Sarango', 1102316666, 0, '1968-07-16', '', '', '', '', 1),
(203, ' Sergio Bolivar', 'Troya Paccha', 1102716832, 0, '1964-04-18', '', '', '', '', 1),
(204, ' Celiano Manuel', 'Jimenez Merino', 1101591640, 0, '0000-00-00', '', '', '', '', 1),
(205, ' Angel Arcivar', 'Merino Sarango', 1102316765, 0, '1960-02-08', '', '', '', '', 1),
(206, ' Diego Jaime', 'Paccha Jimenez', 1900635150, 0, '1987-01-17', '', '', '', '', 1),
(207, ' Silvia Vicenta', 'Giron Merino', 0, 0, '0000-00-00', '', '', '', '', 1),
(208, ' Maria Elizabeth', 'Merino Alvarez', 1104446875, 0, '1987-07-07', '', '', '', '', 1),
(209, ' Gloria Hermandina', 'Ontaneda Castillo', 1101497608, 0, '1953-04-12', '', '', '', '', 1),
(210, ' Luis Antonio', 'Garcia Jimenez', 1101566766, 0, '0000-00-00', '', '', '', '', 1),
(211, ' Hector Eduardo', 'Cumbicus Jimenez', 1101783452, 0, '1953-08-19', '', '', '', '', 1),
(212, ' Arnoldo', 'Jimenez Alvarez', 1101933909, 0, '1957-06-15', '', '', '', '', 1),
(213, ' Cosme Efrain', 'Rosales Rosillo', 0, 0, '0000-00-00', '', '', '', '', 1),
(214, ' Francisco Alfredo', 'Salazar Salinas', 1900190693, 0, '0000-00-00', '', '', '', '', 1),
(215, ' Jose Ildibrando', 'Gaona Villalta', 1900391085, 0, '0000-00-00', '', '', '', '', 1),
(216, ' Carlos', 'Guayanay Jimenez', 1900170539, 0, '1958-06-24', '', '', '', '', 1),
(217, ' Juan Carlos', 'Tamayo Rosillo', 1103419667, 0, '0000-00-00', '', '', '', '', 1),
(218, ' Dalton Alexander', 'Tamayo Rosillo', 0, 0, '0000-00-00', '', '', '', '', 1),
(219, ' Elsa Dolores', 'Soto Jaramillo', 1900260017, 0, '1971-11-04', '', '', '', '', 1),
(220, ' Sabulon', 'Garcia Jimenez', 1900081140, 0, '1944-10-29', '', '', '', '', 1),
(221, ' Melecio', 'Rosillo Calva', 1707851679, 0, '1963-04-15', '', '', '', '', 1),
(222, ' Angel Dionicio', 'Garrido Jimenez', 0, 0, '0000-00-00', '', '', '', '', 1),
(223, ' Guilo Romel', 'Herrera Encarnacion', 1900459312, 0, '1981-06-08', '', '', '', '', 1),
(224, ' Blanca Enid', 'Herrera Encarnacion', 1900174838, 0, '1962-05-12', '', '', '', '', 1),
(225, ' Henrry Paul', 'Avila Alvarez', 1104892599, 0, '1992-09-24', '', '', '', '', 1),
(226, ' German Gilberto', 'Reinoso Rengel', 1103661912, 0, '1980-04-22', '', '', '', '', 1),
(227, ' Mario Enrrique', 'Reinoso Rengel', 1103523369, 0, '1976-02-20', '', '', '', '', 1),
(228, ' Pepe Raul', 'Rodriguez Reinoso', 1105433690, 0, '1990-09-22', '', '', '', '', 1),
(229, ' Luis Esteban', 'Avila Rojas', 0, 0, '0000-00-00', '', '', '', '', 1),
(230, ' Pablo Vinicio', 'Soto Chamba', 0, 0, '0000-00-00', '', '', '', '', 1),
(231, ' Rita Maribel', 'Salazar Minga', 1900723790, 0, '1991-03-05', '', '', '', '', 1),
(232, ' Edghar', 'Cumbicus Salazar', 1900349505, 0, '0000-00-00', '', '', '', '', 1),
(233, ' Eduardo', 'Jiménez Ordoñez', 1103537443, 0, '0000-00-00', '', '', '', '', 1),
(234, ' Diego Agustin', 'Castillo Jiménez', 0, 0, '0000-00-00', '', '', '', '', 1),
(235, ' Sergio David', 'Abad Jimenez', 0, 0, '0000-00-00', '', '', '', '', 1),
(236, ' Denis Sebastian', 'Abad Mendoza', 0, 0, '0000-00-00', '', '', '', '', 1),
(237, ' Luis Antonio', 'Jimenez Gaona', 0, 0, '0000-00-00', '', '', '', '', 1),
(238, ' Jose Florentino', 'Avila Avila', 0, 0, '0000-00-00', '', '', '', '', 1),
(239, ' Jose Isaias', 'Puchaicela Angamarca', 1104111669, 0, '1982-09-06', '', '', '', '', 1),
(240, ' Miguel Francisco', 'Abad Flores', 1900150846, 0, '1956-09-27', '', '', '', '', 1),
(241, ' Jaime Efrain', 'Jinenez Pintado', 1900533033, 0, '1984-02-05', '', '', '', '', 1),
(242, ' Edgar Patricio', 'Jimenez Pintado', 1900571686, 0, '1985-06-29', '', '', '', '', 1),
(243, ' Patricia Elizabeth', 'Puchaicela Angamarca', 1104180706, 0, '0000-00-00', '', '', '', '', 1),
(244, ' Rosa Peregrina', 'Pintado Castillo', 1102444310, 0, '0000-00-00', '', '', '', '', 1),
(245, ' Vicente', 'Abad Simon', 1102252010, 0, '1957-11-25', '', '', '', '', 1),
(246, ' Edgar Omar', 'Morocho Angamarca', 1900547009, 0, '1983-05-24', '', '', '', '', 1),
(247, ' Juan Miguel', 'Avila Ontaneda', 1900651827, 0, '1988-10-17', '', '', '', '', 1),
(248, ' Francisco Antonio', 'Ontaneda Pintado', 1900872654, 0, '1994-03-26', '', '', '', '', 1),
(249, ' Antonio', 'Abad Luis', 1103727481, 0, '1970-07-26', '', '', '', '', 1),
(250, ' Jose Nain', 'Lalangui Chacon', 1104506462, 0, '1984-06-13', '', '', '', '', 1),
(251, ' Luis', 'Jimenez Jimenez', 1102249909, 0, '1960-10-13', '', '', '', '', 1),
(252, ' Jose Eduardo', 'Tocto Rivar', 1900221431, 0, '1966-11-20', '', '', '', '', 1),
(253, ' Carmen Benita', 'Garrido Jimenez', 1103267082, 0, '1976-05-06', '', '', '', '', 1),
(254, ' Angel Maria', 'Puchaicela Anguisaca', 1102061841, 0, '1958-07-11', '', '', '', '', 1),
(255, ' Pedro Moises', 'Abad Guayanay', 1900719384, 0, '2012-11-23', '', '', '', '', 1),
(256, 'Orlando Benjamin', 'Tocto Tocto', 0, 0, '0000-00-00', '', '', '', '', 1),
(257, ' Jose Querubin', 'Calderon Pinta', 1708599061, 0, '0000-00-00', '', '', '', '', 1),
(258, ' Fabian Sebastian', 'Herrera Pinta', 1103370050, 0, '0000-00-00', '', '', '', '', 1),
(259, ' Segundo Jacinto', 'Herrera Pinta', 1102089131, 0, '1962-08-28', '', '', '', '', 1),
(260, ' Jose Isauro', 'Herrera Pinta', 1714531314, 0, '0000-00-00', '', '', '', '', 1),
(261, 'Maximo', 'Luzuriga', 0, 0, '0000-00-00', '', '', '', '', 1),
(262, ' Agustina Marina', 'Herrera Encarnacion', 1101805818, 0, '0000-00-00', '', '', '', '', 1),
(263, ' Adita Alexandra', 'Luzuriaga Herrera', 1104174451, 0, '0000-00-00', '', '', '', '', 1),
(264, ' Angel', 'Castillo Acaro', 1900567031, 0, '1984-08-02', '', '', '', '', 1),
(265, ' Hector Manuel', 'Jimenez Jimenez', 1102120100, 0, '0000-00-00', '', '', '', '', 1),
(266, ' Jose', 'Tillaguango Vitaliano', 1400512008, 0, '0000-00-00', '', '', '', '', 1),
(267, ' Rolando', 'Jimenez Marco', 1104866998, 0, '1986-10-19', '', '', '', '', 1),
(268, ' Maria Catalina', 'Garrido Jimenez', 1900360122, 0, '1978-04-29', '', '', '', '', 1),
(269, ' Miguel Antonio', 'Herrera Pinta', 1103726285, 0, '1978-11-11', '', '', '', '', 1),
(270, ' Juana Livia', 'Gaona Villalta', 1102010046, 0, '1960-06-16', '', '', '', '', 1),
(271, ' Francisco De Jesus', 'Mendoza Granda', 1102502315, 0, '1965-09-20', '', '', '', '', 1),
(272, ' Leonardo Mauricio', 'Jaramillo Mendoza', 1104390875, 0, '1984-01-29', '', '', '', '', 1),
(273, 'Rosario', 'Paute', 1102181532, 0, '1961-10-21', '', '', '', '', 1),
(274, ' Jose Oswaldo', 'Lanche Jara', 1102724059, 0, '1966-08-28', '', '', '', '', 1),
(275, ' Carmen', 'Jaramillo Leon', 1900081454, 0, '1946-07-16', '', '', '', '', 1),
(276, ' Jesus Rene', 'Mendoza Granda', 1109719355, 0, '1987-03-23', '', '', '', '', 1),
(277, ' Pedro Antonio', 'Bastidas Paute', 1105104259, 0, '1989-08-20', '', '', '', '', 1),
(278, '  Jimenez Jose Daniel', 'Jimenez ', 1100490265, 0, '1944-04-08', '', '', '', '', 1),
(279, ' Jose Felix', 'Troya Gordillo', 1900185131, 0, '0000-00-00', '', '', '', '', 1),
(280, ' Paul Norlander', 'Zumba Avila', 1900525310, 0, '0000-00-00', '', '', '', '', 1),
(281, ' Ilvar Rodrigo', 'Zumba Avila', 1900525328, 0, '0000-00-00', '', '', '', '', 1),
(282, ' Claudio Edgar', 'Zumba Zumba', 0, 0, '0000-00-00', '', '', '', '', 1),
(283, ' Santiago', 'Giron Angel', 1104039761, 0, '1981-11-15', '', '', '', '', 1),
(284, ' Marcelo Miguel', 'Garrido Hidalgo', 0, 0, '0000-00-00', '', '', '', '', 1),
(285, ' Rodrigo Efrain', 'Abad Jaramillo', 0, 0, '0000-00-00', '', '', '', '', 1),
(286, ' Luis Felipe', 'Abad Flores', 0, 0, '0000-00-00', '', '', '', 'm', 1),
(287, ' Roberto Miguel', 'Salazar Ortiz', 0, 0, '0000-00-00', '', '', '', '', 1),
(288, ' Oswaldo Marcelo', 'Jimenez Gonzaga', 0, 0, '0000-00-00', '', '', '', '', 1),
(289, ' Melecio Mauricio', 'Mayo Hidalgo', 0, 0, '0000-00-00', '', '', '', '', 1),
(290, ' Wuilman Efren', 'Mayo Hidalgo', 0, 0, '0000-00-00', '', '', '', '', 1),
(291, ' Bolivar', 'Merino Escobar', 0, 0, '0000-00-00', '', '', '', '', 1),
(292, ' Artimidoro', 'Merino Escobar', 0, 0, '0000-00-00', '', '', '', '', 1),
(293, ' Carlos Napoleon', 'Mayo Hidalgo', 0, 0, '0000-00-00', '', '', '', '', 1),
(294, ' Ilda Maria', 'Mayo Hidalgo', 0, 0, '0000-00-00', '', '', '', '', 1),
(295, ' David Rodrigo', 'Chamba Escobar', 0, 0, '0000-00-00', '', '', '', '', 1),
(296, ' Jose Maria', 'Mayo Hidalgo', 1103170294, 0, '1972-09-01', '', '', '', '', 1),
(297, ' Juan Manuel', 'Chamba Escobar', 1104291990, 0, '1983-04-20', '', '', '', '', 1),
(298, ' Cesar Vitaliano', 'Chamba Arevalo', 1101800363, 0, '0000-00-00', '', '', '', '', 1),
(299, ' Efrain', 'Abad Marco', 2100329677, 0, '1979-12-06', '', '', '', '', 1),
(300, 'Juan', 'Hartman Merino', 0, 0, '0000-00-00', '', '', '', 'm', 1),
(301, 'Gilver', 'Rosillo', 0, 0, '0000-00-00', '', '', '', 'm', 1),
(302, 'Harvey', 'Merino', 0, 0, '0000-00-00', '', '', '', 'm', 1),
(303, 'Manuel', 'Tillaguango', 0, 0, '0000-00-00', '', '', '', 'm', 1),
(304, 'Jose', 'Cueva', NULL, 0, NULL, NULL, NULL, NULL, NULL, 1),
(310, 'Nuevo', 'Nuevo', 123123, 0, '0000-00-00', 'art_s@hotmail.es', '', NULL, 'm', 5),
(311, 'Alex', 'Plascencia', 1104635501, 0, '1995-01-12', 'art_s@hotmail.es', 'DIRECCION', NULL, 'm', NULL),
(312, 'Alex', 'Plascencia', 1104635501, 0, '1995-01-12', 'art_s@hotmail.es', 'DIRECCION', NULL, 'm', NULL),
(313, 'Alex', 'Plascencia', 11123213, 19238123, '2015-01-12', '', '', '', '1', 16),
(317, 'nuevo1', 'nuevo1', 11231, 29877, '1995-01-12', 'email@email.com', 'calle', NULL, 'm', 16);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provincia`
--

CREATE TABLE IF NOT EXISTS `provincia` (
`id_provincia` int(11) NOT NULL,
  `provincia` varchar(45) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `provincia`
--

INSERT INTO `provincia` (`id_provincia`, `provincia`) VALUES
(1, 'Zamora Chinchipe'),
(2, 'Loja'),
(3, 'Azuay'),
(4, 'Bolívar'),
(5, 'Cañar'),
(6, 'Carchi'),
(7, 'Chiborazo'),
(8, 'Cotopaxi'),
(9, 'El Oro'),
(10, 'Esmeraldas'),
(11, 'Gálapagos'),
(12, 'Guayas'),
(13, 'Imbabura'),
(14, 'Los Ríos'),
(15, 'Manabí'),
(16, 'Morona Santiago'),
(17, 'Napo'),
(18, 'Orellana'),
(19, 'Pastaza'),
(20, 'Pichincha'),
(21, 'Santa Elena'),
(22, 'Santo Domingo de los Tsáchilas'),
(23, 'Sucumbios'),
(24, 'Tungurahua');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socios`
--

CREATE TABLE IF NOT EXISTS `socios` (
`id_socio` int(11) NOT NULL,
  `id_grupo` int(11) DEFAULT NULL,
  `id_persona` int(11) DEFAULT NULL,
  `codigo` text COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=308 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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
(68, 2, 69, 'AG81'),
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
(305, 9, 310, 'FA58'),
(306, 3, 311, 'AG61'),
(307, 3, 317, 'AG82');

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
) ENGINE=InnoDB AUTO_INCREMENT=305 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `subparcelas`
--

INSERT INTO `subparcelas` (`id`, `id_parcela`, `superficie`, `variedad`, `variedad2`, `siembra`, `densidad`, `marco`, `hierbas`, `sombreado`, `roya`, `broca`, `ojo_pollo`, `mes_inicio_cosecha`, `duracion_cosecha`) VALUES
(1, 1, 2.00, 'catimoro', 'catucaÃ­', 2005, 0, 'Regular', 'Limpio', 'Poco', '25', '25', '0', 'Febrero', 0),
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
(69, 69, 2.00, 'catucaÃ­', 'catucaÃ­', 2008, 0, 'Regular', 'Limpio', 'Poco', '25', '0', '0', '', 0),
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
(297, 297, 6.00, '', '', 2009, 0, '', '', '', '', '', '', '', 0),
(304, 1, 20.00, 'catucaÃ­', 'catucaÃ­', 2000, 20, 'Regular', 'Limpio', 'Poco', '25', '50', '50', 'Enero', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
`id` int(11) NOT NULL,
  `user` text COLLATE latin1_spanish_ci NOT NULL,
  `pass` text COLLATE latin1_spanish_ci NOT NULL,
  `id_nivel` int(11) NOT NULL,
  `id_persona` int(11) DEFAULT NULL,
  `estado` varchar(2) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `user`, `pass`, `id_nivel`, `id_persona`, `estado`) VALUES
(1, 'admin', 'admin', 1, 304, 'A'),
(2, 'prueba', '123', 3, 310, 'A'),
(5, 'Jafv', '123', 1, NULL, 'A'),
(6, 'Javier', '12345', 3, NULL, 'A'),
(7, 'Nuevo2', '123', 2, NULL, 'B'),
(8, 'alex2', '1234', 2, NULL, 'B');

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
-- Indices de la tabla `canton`
--
ALTER TABLE `canton`
 ADD PRIMARY KEY (`id_canton`), ADD KEY `FK_provincia_idx` (`id_provincia`);

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
-- Indices de la tabla `historial`
--
ALTER TABLE `historial`
 ADD PRIMARY KEY (`id_historial`);

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
 ADD PRIMARY KEY (`id_persona`), ADD KEY `FK_id_provincia_idx` (`id_canton`);

--
-- Indices de la tabla `provincia`
--
ALTER TABLE `provincia`
 ADD PRIMARY KEY (`id_provincia`);

--
-- Indices de la tabla `socios`
--
ALTER TABLE `socios`
 ADD PRIMARY KEY (`id_socio`), ADD KEY `id_socio` (`id_socio`), ADD KEY `FK_SOCIO_GRUPO_idx` (`id_grupo`), ADD KEY `FK_PERSONA_SOCIO_idx` (`id_persona`);

--
-- Indices de la tabla `subparcelas`
--
ALTER TABLE `subparcelas`
 ADD PRIMARY KEY (`id`), ADD KEY `fk_subparcela_parcela_idx` (`id_parcela`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
 ADD PRIMARY KEY (`id`), ADD KEY `USUARIOS_PERSONA` (`id_persona`), ADD KEY `FK_USUARIO_NIVEL_idx` (`id_nivel`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `acciones`
--
ALTER TABLE `acciones`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=712;
--
-- AUTO_INCREMENT de la tabla `altas`
--
ALTER TABLE `altas`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=52;
--
-- AUTO_INCREMENT de la tabla `analisis`
--
ALTER TABLE `analisis`
MODIFY `id_analisis` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `asociaciones`
--
ALTER TABLE `asociaciones`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=758;
--
-- AUTO_INCREMENT de la tabla `canton`
--
ALTER TABLE `canton`
MODIFY `id_canton` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=222;
--
-- AUTO_INCREMENT de la tabla `catas`
--
ALTER TABLE `catas`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=149;
--
-- AUTO_INCREMENT de la tabla `certificacion`
--
ALTER TABLE `certificacion`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=350;
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
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `envios`
--
ALTER TABLE `envios`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `estimacion`
--
ALTER TABLE `estimacion`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT de la tabla `fotos`
--
ALTER TABLE `fotos`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `grupos`
--
ALTER TABLE `grupos`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT de la tabla `historial`
--
ALTER TABLE `historial`
MODIFY `id_historial` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=154;
--
-- AUTO_INCREMENT de la tabla `lotes`
--
ALTER TABLE `lotes`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=172;
--
-- AUTO_INCREMENT de la tabla `niveles`
--
ALTER TABLE `niveles`
MODIFY `id_niveles` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `parcelas`
--
ALTER TABLE `parcelas`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=298;
--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
MODIFY `id_persona` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=318;
--
-- AUTO_INCREMENT de la tabla `provincia`
--
ALTER TABLE `provincia`
MODIFY `id_provincia` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT de la tabla `socios`
--
ALTER TABLE `socios`
MODIFY `id_socio` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=308;
--
-- AUTO_INCREMENT de la tabla `subparcelas`
--
ALTER TABLE `subparcelas`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=305;
--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
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
-- Filtros para la tabla `canton`
--
ALTER TABLE `canton`
ADD CONSTRAINT `fk_provin` FOREIGN KEY (`id_provincia`) REFERENCES `provincia` (`id_provincia`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
ADD CONSTRAINT `fk_canton` FOREIGN KEY (`id_canton`) REFERENCES `canton` (`id_canton`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `socios`
--
ALTER TABLE `socios`
ADD CONSTRAINT `FK_PERSONA_SOCIO` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `FK_SOCIO_GRUPO` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
ADD CONSTRAINT `FK_USUARIO_NIVEL` FOREIGN KEY (`id_nivel`) REFERENCES `niveles` (`id_niveles`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `FK_USUARIO_SOCIO` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
