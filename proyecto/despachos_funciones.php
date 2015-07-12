<?php
function despachos_consultar_criterio($criterio,$id)
{
	require("conect.php");
	$SQL="call SP_despachos_cons('".$criterio."','".$id."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	require("config_disconnect.php");
	return(transformar_a_lista($resultado));
}
function insertar_despacho($lote,$fecha,$cant,$envio)
{
	require("conect.php");
	$SQL="call SP_despacho_ins('".$lote."','".$fecha."','".$cant."','".$envio."')";
	mysqli_query($link,$SQL) or die(mysqli_error($link));
	global $operaciones_constantes,$tabla_constantes;	
	guarda_historia($_SESSION["user"], $operaciones_constantes["I"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["despachos"], gethostname());	
	require("config_disconnect.php");
}
function eliminar_despacho($id){
	require("conect.php");
	$SQL="call SP_despachos_del('".$id."')";
	mysqli_query($link,$SQL) or die(mysqli_error($link));
	global $operaciones_constantes,$tabla_constantes;
	guarda_historia($_SESSION["user"], $operaciones_constantes["D"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["despachos"], gethostname());	
	require("config_disconnect.php");
}
?>