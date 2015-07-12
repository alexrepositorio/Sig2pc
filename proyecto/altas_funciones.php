<?php
function insertaraltas($socio,$fecha,$estado){
    require("conect.php");
    $SQL="call sp_alta_ins('".$socio."','".ucfirst($estado)."','".$fecha."');";
	mysqli_query($link,$SQL)or die(mysqli_error($link)); 
	global $operaciones_constantes,$tabla_constantes;
	guarda_historia($_SESSION["user"], $operaciones_constantes["I"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["altas"], gethostname());	
	require("config_disconnect.php");
}
function altas_consultar($criterio,$valor){
	require("conect.php");
    $SQL="call sp_altas_cons('".$criterio."','".$valor."');";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)) ;
	require("config_disconnect.php");
	return(transformar_a_lista($resultado));
}
function eliminaraltas($id)
{
	require ("conect.php");
	$SQL="call SP_altas_del('".$id."')";
	mysqli_query($link,$SQL) or die(mysqli_error($link)) ;
	global $operaciones_constantes,$tabla_constantes;
	guarda_historia($_SESSION["user"], $operaciones_constantes["D"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["altas"], gethostname());	
	require("config_disconnect.php");
}
?>