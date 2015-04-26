<?php
/**
 * Created by PhpStorm.
 * User: Alex
 * Date: 08/04/2015
 * Time: 20:23
 */


function consultarCriterio($criterio,$valor){
    require("conect.php");
    $SQL="call sp_socio_cons('".$criterio."','".$valor."')";
    $result=mysqli_query($link,$SQL);   
    return($result);
}
function obtenerSocio($id){
    require("conect.php");
    $SQL="call SP_socio_find(".$id.")";
    $result=mysqli_query($link,$SQL);
    return ($result);
}

function certificarsocio($id,$anio,$estado){
	require("conect.php");
    $sql="call SP_socio_certificar(".$id.",'".$anio."','".$estado."')";
    $result=mysqli_query($link,$sql) or die(mysqli_error($link));
}
function certificacion($socio)
{
	require("conect.php");
	
	$SQL1="SELECT id_socio FROM socios left join persona on socios.id_persona=persona.id_persona where persona.id_persona=".$socio;
	$resultado1=mysqli_query($link,$SQL1);
	$row = mysqli_fetch_array($resultado1);
	$id=$row["id_socio"];

	$SQL="SELECT * FROM certificacion WHERE id_socio=".$id;
	$resultado=mysqli_query($link,$SQL);
	while($socio = mysqli_fetch_array($resultado))
	{
	$estatus[$id]["year"]=$socio["year"];		
	$estatus[$id]["estatus"]=$socio["estatus"];		
		}
	if(isset($estatus)){
		return ($estatus);
	}
}

function estimacion($socio)
{
	require("conect.php");
	$SQL="call SP_socio_estimacion(".$socio.");";
	$resultado=mysqli_query($link,$SQL);
	while($socio = mysqli_fetch_array($resultado)){
	$id=$socio["id"];	
	$estimados[$id]["year"]=$socio["year"];		
	$estimados[$id]["estimados"]=$socio["estimados"];		
	$estimados[$id]["entregados"]=$socio["entregados"];		
		}
	if(isset($estimados))
		{return ($estimados);

	}
}
function altas_bajas($socio)
{
	require ("conect.php");
	$SQL="call SP_socio_altas(".$socio.");";
	$resultado=mysqli_query($link,$SQL);
	while($socio = mysqli_fetch_array($resultado)){
	$id=$socio["id"];
	$altas[$id]["estado"]=$socio["estado"];	
	$altas[$id]["year"]=$socio["fecha"];	
	}
	if(isset($altas)){
		return ($altas);
	}
}
function actualizarsocio($id,$nombre,$apellido,$codigo,$cedula,$celular,$f_nac,$direccion,$poblacion,$canton,$provincia,$genero,$mail){
    require ("conect.php");
    $SQL="call SP_socio_update(".$id.",'".$nombre."','".$apellido."','".$codigo."','".$cedula."','".$celular."','".$f_nac."','".$direccion."','".$poblacion."','".$canton."','".$provincia."','".$genero."','".$mail."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link));    
}


function comprobar_mail($mail){
	require ("conect.php");
	$SQL="SELECT email FROM persona where email='".$mail."'";
	$result=mysqli_query($link, $SQL)or die(mysqli_error($link));
	if(mysqli_num_rows($result)==0 or $mail==''){
		return false;
	}else
	return true;
	}

function insertar_socio($nombre,$apellido,$codigo,$cedula,$celular,$f_nac,$direccion,$poblacion,$canton,$provincia,$genero,$mail){
	require ("conect.php");
	$SQL="call SP_socio_ins('".$nombre."','".$apellido."','".$codigo."','".$cedula."','".$celular."','".$f_nac."','".$direccion."','".$poblacion."','".$canton."','".$provincia."','".$genero."','".$mail."')";
	mysqli_query($link,$SQL) or die(mysqli_error($link));
}


function obtenerLotes($socio){
	require ("conect.php");
	$SQL="SELECT * FROM lotes where id_socio=".$socio;
	$resultado=mysqli_query($link,$SQL);
	
	return ($resultado);
}
function parcelas($socio){
	require ("conect.php");
	$SQL="SELECT * FROM parcelas WHERE id_socio=".$socio;
	$resultado=mysqli_query($link,$SQL);
	return ($resultado);
}



function obtenerSocioLotes($id){
    require("conect.php");

    $SQL="SELECT `id_socio`,`nombres`, `apellidos`, `codigo`, `cedula`, `f_nacimiento`, `email`, `direccion`, `canton`, `provincia`, `genero`,`grupo` as poblacion FROM persona
left join socios
on socios.id_persona=persona.id_persona
left join grupos
on grupos.id=socios.id_grupo
where socios.id_persona='".$id."'";
    $resultado=mysql_query($SQL,$link);
    return ($resultado);
}

?>