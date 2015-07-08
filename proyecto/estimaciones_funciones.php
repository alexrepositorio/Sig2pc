<?php
function insertarestimacion($socio,$fecha,$estimados,$entregados){
    require("conect.php");
    $SQL="call SP_estimaciones_ins('".$socio."','".$fecha."','".$estimados."','".$entregados."')";
	mysqli_query($link,$SQL)or die(mysqli_error($link)); 
	global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"], $operaciones_constantes["I"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["configuraciones"], gethostname()); 
    require("config_disconnect.php");
}
function estimacion($criterio,$socio)
{
	require("conect.php");
	$SQL="call SP_estimaciones_cons('".$criterio."','".$socio."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	require("config_disconnect.php");
	return (transformar_a_lista($resultado));
}
function estimacion_actualizar($entregados,$id){
	require("conect.php");
	$SQL="call SP_estimaciones_upd('".$entregados."','".$id."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"], $operaciones_constantes["U"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["configuraciones"], gethostname()); 
    require("config_disconnect.php");
}
function estimacion_eliminar($id){
	require("conect.php");
	$SQL="call SP_estimaciones_del('".$id."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"], $operaciones_constantes["D"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["configuraciones"], gethostname()); 
    require("config_disconnect.php");
}
?>
