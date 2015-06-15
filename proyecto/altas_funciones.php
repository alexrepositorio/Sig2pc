<?php

function insertaraltas($socio,$fecha,$estado){
    require("conect.php");
    $SQL="call sp_alta_ins('".$socio."','".$estado."','".$fecha."');";
	mysqli_query($link,$SQL)or die(mysqli_error($link)); 
}

function altas_bajas($socio)
{
	require ("conect.php");
	$SQL="call SP_socio_altas(".$socio.");";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)) ;
	return(transformar_a_lista($resultado));
}
function eliminaraltas($id)
{
	echo $id;
	require ("conect.php");
	$SQL="call SP_altas_del('".$id."')";
	mysqli_query($link,$SQL) or die(mysqli_error($link)) ;
}
?>