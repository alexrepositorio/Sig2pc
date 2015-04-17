<?php

include("config.php");
mysqli_query($conexion, "SET NAMES 'utf8'");

function validar()
{
	include("config.php");	
	$user = ($_POST["user"]);
	$pass = ($_POST["pass"]);
	$sql="SELECT * FROM usuarios WHERE user='".$_POST["user"]."' AND pass='".$_POST["pass"]."'";
	$cpin=mysqli_num_rows(mysqli_query($conexion,$sql));
	$row_user=mysqli_fetch_array(mysqli_query($conexion,$sql));
	if ($cpin==1)
	{
	session_start();	
	$_SESSION["cuenta"]=$f['COD_CUENTA'];
	$_SESSION["user"]=$username;
	$_SESSION["acceso"]=$row_user['nivel'];
	header("Location:index.php");
	}
	else 
	{
		echo"<div align=center><notif>Usuario o clave incorrecta</notif></div>";
	}
}

function nombre_socio($id)
{
	include("config.php");	
	$SQL="SELECT * FROM socios WHERE codigo='$id'";
	$resultado=mysqli_query($conexion, $SQL);
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
	include("config.php");
	
	$SQL="SELECT * FROM certificacion WHERE id_socio='$socio'";
	$resultado=mysqli_query($conexion, $SQL);
	while($socio = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
	$id=$socio["id"];	
	$estatus[$id]["year"]=$socio["year"];		
	$estatus[$id]["estatus"]=$socio["estatus"];		
		}
	if(isset($estatus)){return ($estatus);}
}

function altas_bajas($socio)
{
	include("config.php");
	
	$SQL="SELECT * FROM altas WHERE id_socio='$socio'";
	$resultado=mysqli_query($conexion, $SQL);
	while($socio = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
	$id=$socio["id"];
	$altas[$id]["estado"]=$socio["estado"];	
	$altas[$id]["year"]=$socio["fecha"];	
	}
	if(isset($altas)){return ($altas);}
}

function estimacion($socio)
{
	include("config.php");
	
	$SQL="SELECT * FROM estimacion WHERE id_socio='$socio'";
	$resultado=mysqli_query($conexion, $SQL);
	while($socio = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
	$id=$socio["id"];	
	$estimados[$id]["year"]=$socio["year"];		
	$estimados[$id]["estimados"]=$socio["estimados"];		
	$estimados[$id]["entregados"]=$socio["entregados"];		
		}
	if(isset($estimados)){return ($estimados);}
}

function muestra_array($array)
{
	echo "<pre>";
	print_r($array);
	echo "</pre><br>";
}

function guarda_historial($comentario)
{
	include("config.php");	
	$SQL_historial="INSERT INTO acciones VALUES ('','".$_COOKIE['username']."','".date("Y-m-d H:i:s",time())."','$comentario')";
	mysqli_query($conexion, $SQL_historial);		
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

//****************PARAMETROS DE CONFIGURACION************************
$SQL_conf="SELECT * FROM configuracion";
$res_conf=mysqli_query($conexion, $SQL_conf);
while($configuraciones = mysqli_fetch_array($res_conf,MYSQLI_ASSOC)){
	$parametro=$configuraciones["parametro"];
	$config[$parametro]=$configuraciones["valor"];
	}
//*******************************************************************
	
$permisos_admin=array(1);
$permisos_administrativos=array(1,2);
$permisos_lotes=array(1,3);
$permisos_pagos=array(1,2);
$permisos_general=array(1,2,3,4,5);
$permisos_catador=array(1,5);
?>
