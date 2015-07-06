<?php
function insertarestimacion($socio,$fecha,$estimados,$entregados){
    require("conect.php");
    $SQL="call SP_estimaciones_ins('".$socio."','".$fecha."','".$estimados."','".$entregados."')";
	mysqli_query($link,$SQL)or die(mysqli_error($link)); 
}
function estimacion($criterio,$socio)
{
	require("conect.php");
	$SQL="call SP_estimaciones_cons('".$criterio."','".$socio."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	return (transformar_a_lista($resultado));
}
function estimacion_actualizar($entregados,$id){
	require("conect.php");
	$SQL="call SP_estimaciones_upd('".$entregados."','".$id."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
}
function estimacion_eliminar($id){
	require("conect.php");
	$SQL="call SP_estimaciones_del('".$id."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
}
?>
