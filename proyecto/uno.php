<?php


function obtenerGrupos(){
    require("conect.php");
    $sql_localidad="SELECT DISTINCT(grupo)  FROM GRUPOS ORDER BY grupo ASC";
    $result=mysql_query($sql_localidad,$link);
    return ($result);
}
function nombre_socio($id)
{
	include ("conect.php");
	mysqli_query($link, "SET NAMES 'utf8'");
	$SQL="SELECT * FROM socios WHERE codigo='$id'";
	$resultado=mysqli_query($link, $SQL);
	$socio = mysqli_fetch_array($resultado,MYSQLI_ASSOC);
	$datos_socio["nombres"]=$socio["nombres"];
	$datos_socio["apellidos"]=$socio["apellidos"];
	$datos_socio["codigo"]=$socio["codigo"];
	$datos_socio["poblacion"]=$socio["poblacion"];
	$datos_socio["id"]=$socio["id_socio"];
	$datos_socio["foto"]=$socio["foto"];
	return ($datos_socio);
}


function certificacion($socio)
{
	require("conect.php");
	
	$SQL1="SELECT id_socio FROM socios left join persona on socios.id_persona=persona.id_persona where persona.id_persona=".$socio;
	$resultado1=mysql_query($SQL1,$link);
	$row = mysql_fetch_array($resultado1);
	$id=$row["id_socio"];

	$SQL="SELECT * FROM certificacion WHERE id_socio=".$id;
	$resultado=mysql_query($SQL,$link);
	while($socio = mysql_fetch_array($resultado))
	{
	$estatus[$id]["year"]=$socio["year"];		
	$estatus[$id]["estatus"]=$socio["estatus"];		
		}
	if(isset($estatus)){
		return ($estatus);
	}
}

function altas_bajas($socio)
{
	require ("conect.php");
	$SQL="SELECT * FROM altas WHERE id_socio='$socio'";
	$resultado=mysql_query($SQL,$link);
	while($socio = mysql_fetch_array($resultado)){
	$id=$socio["id"];
	$altas[$id]["estado"]=$socio["estado"];	
	$altas[$id]["year"]=$socio["fecha"];	
	}
	if(isset($altas)){
		return ($altas);
	}
}
function obtenerLotes($socio){
	require ("conect.php");
	$SQL="SELECT * FROM lotes where id_socio=".$socio;
	$resultado=mysql_query($SQL,$link);
	
	return ($resultado);
}
function parcelas($socio){
	require ("conect.php");
	$SQL="SELECT * FROM parcelas WHERE id_socio=".$socio;
	$resultado=mysql_query($SQL,$link);
	return ($resultado);
}

function estimacion($socio)
{
	require("conect.php");
	$SQL="SELECT * FROM estimacion WHERE id_socio='$socio'";
	$resultado=mysql_query($SQL,$link);
	while($socio = mysql_fetch_array($resultado)){
	$id=$socio["id"];	
	$estimados[$id]["year"]=$socio["year"];		
	$estimados[$id]["estimados"]=$socio["estimados"];		
	$estimados[$id]["entregados"]=$socio["entregados"];		
		}
	if(isset($estimados))
		{return ($estimados);

	}
}



function muestra_array($array)
{
	echo "<pre>";
	print_r($array);
	echo "</pre><br>";
}

function guarda_historial($comentario)
{
	$link = mysqli_connect("localhost", "root", "", "sig");
	mysqli_query($link, "SET NAMES 'utf8'");
	$SQL_historial="INSERT INTO acciones VALUES ('','".$_COOKIE['username']."','".date("Y-m-d H:i:s",time())."','$comentario')";
	mysqli_query($link, $SQL_historial);		
}

function yes_no($valor)
{
	switch ($valor){
		case 0:
			$tic="<img width=20 src=images/no.png>";
			break;
		case 1:
			$tic="<img width=20 src=images/yes.png>";
			break;
			}
return ($tic);	
}
function nivel($nivel){
	switch ($nivel){
		case 1:
			$nivel_t="Administrador";
			break;
		case 2:
			$nivel_t="Contable";
			break;
		case 3:
			$nivel_t="Bodeguero";
			break;
		case 4:
			$nivel_t="Socio";
			break;
		case 5:
			$nivel_t="Catador";
			break;
	}
return ($nivel_t);
}
function logout(){

session_start();
session_unset();
session_destroy();

header ('Location: login.php');
	exit (0); 
}

function Vactuales(){

require("conect.php");	
// catas pendientes
$SQL_catas_pendientes="SELECT codigo_lote FROM lotes WHERE calidad='A' AND codigo_lote NOT IN (SELECT lote FROM catas)";
$resultado=mysql_query($SQL_catas_pendientes,$link);
$cuenta_catas=mysql_num_rows($resultado);

	$cuenta_catas="<font size=6>(<font color=red><b>$cuenta_catas</b></font>)</font>";



// pagos pendientes
$SQL_pagos_pendientes="SELECT codigo_lote FROM lotes WHERE codigo_lote NOT IN (SELECT lote FROM pagos)";
$resultado2=mysql_query($SQL_pagos_pendientes,$link);
$cuenta_pagos=mysql_num_rows($resultado2);

		$cuenta_pagos="<font size=6>(<font color=red><b>$cuenta_pagos</b></font>)</font>";
	
//*****************************

// estado de almacén
$SQL_estado_almacen_entradas="SELECT SUM(peso) FROM lotes";
$resultado3=mysql_query($SQL_estado_almacen_entradas,$link);
$almacen_entradas=mysql_fetch_row($resultado3);
$almacen_entradas=$almacen_entradas[0];
$SQL_estado_almacen_salidas="SELECT SUM(cantidad) FROM despachos";
$resultado4=mysql_query($SQL_estado_almacen_salidas,$link);
$almacen_salidas=mysql_fetch_row($resultado4);
$almacen_salidas=$almacen_salidas[0];
$stock_almacen=$almacen_entradas-$almacen_salidas;
$stock_almacen="<font size=6>(<font color=red><b>".$stock_almacen."qq</b></font>)</font>";
//*****************************


return array($cuenta_pagos,$cuenta_catas,$stock_almacen);
}


$permisos_admin=array(1);
$permisos_administrativos=array(1,2);
$permisos_lotes=array(1,3);
$permisos_pagos=array(1,2);
$permisos_general=array(1,2,3,4,5);
$permisos_catador=array(1,5);
?>
