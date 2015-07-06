<?php
function despachos_consultar_criterio($criterio,$id)
{
	require("conect.php");
	$SQL="call SP_despachos_cons('".$criterio."','".$id."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	return(transformar_a_lista($resultado));
}
function insertar_despacho($lote,$fecha,$cant,$envio)
{
	require("conect.php");
	$SQL="call SP_despacho_ins('".$lote."','".$fecha."','".$cant."','".$envio."')";
	mysqli_query($link,$SQL) or die(mysqli_error($link));	
}
function eliminar_despacho($id){
	require("conect.php");
	$SQL="call SP_despachos_del('".$id."')";
	mysqli_query($link,$SQL) or die(mysqli_error($link));
}
?>