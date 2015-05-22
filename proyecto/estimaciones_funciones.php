<?php

function insertarestimacion($socio,$fecha,$estimados,$entregados){
    require("conect.php");
    $SQL="INSERT INTO estimacion VALUES('',
				'".$socio."',
				'".$fecha."',
				'".$estimados."',
				'".$entregados."')";
	mysqli_query($link,$SQL)or die(mysqli_error($link)); 
}

function estimacion($socio)
{
	require("conect.php");
	$SQL="call SP_socio_estimacion(".$socio.");";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	return (transformar_a_lista($resultado));
}
function estimacion_actual($socio)
{
	require("conect.php");
	$SQL="SELECT * FROM estimacion order by year desc limit 1;";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	return (transformar_a_lista($resultado));
}
function estimacion_actualizar($entregados,$id){
	require("conect.php");
	$SQL="UPDATE estimacion SET
				entregados='".$entregados."'
				WHERE id='".$id."'";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
}
function estimacion_eliminar($id){
	require("conect.php");
	$SQL="DELETE FROM estimacion where id='".$id."'";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
}
?>
