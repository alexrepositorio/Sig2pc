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
    $resultado=mysqli_query($link,$SQL); 
    while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
				$socios[]=$row;	
			}  
    return($socios);

}
function obtenerSocio($id){
    require("conect.php");
    $SQL="call SP_socio_find(".$id.")";
    $resultado=mysqli_query($link,$SQL);
    $row = mysqli_fetch_array($resultado,MYSQLI_ASSOC);			
    return ($row);
}

function calcular_codigo($poblacion){
    require("conect.php");

    $codigo_grupo=substr($poblacion,0,2);
    $SQL="SELECT codigo from socios" ;
    $result=mysqli_query($link,$SQL) or die(mysqli_error($link));;
    $cuenta_p=mysqli_num_rows($result);
		if($cuenta_p==0){
			$nuevo_codigo=$codigo_grupo."01";
		}
		else{
			while ($rowcodigos = mysqli_fetch_array($result,MYSQLI_ASSOC)){
				$nsocio=substr($rowcodigos["codigo"],2,2);
				//$codigo_grupo=$codigo_grupo;
				$numeraciones[]=$nsocio;
			}
			$siguiente=max($numeraciones)+1;
			$nuevo_codigo=$codigo_grupo.$siguiente;
		}

    return ($nuevo_codigo);
}

function certificarsocio($id,$anio,$estado){
	require("conect.php");
    $sql="call SP_socio_certificar(".$id.",'".$anio."','".$estado."')";
    $result=mysqli_query($link,$sql) or die(mysqli_error($link));
}
function certificacion($in_socio)
{
	require("conect.php");
	
	$SQL="SELECT * FROM certificacion WHERE id_socio=".$in_socio;
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	while($socio = mysqli_fetch_array($resultado));
	{
	$estatus[$in_socio]["year"]=$socio["year"];		
	$estatus[$in_socio]["estatus"]=$socio["estatus"];		
		}
	if(isset($estatus)){
		return ($estatus);
	}
}

function estimacion($socio)
{
	require("conect.php");
	$SQL="call SP_socio_estimacion(".$socio.");";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
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
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)) ;
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