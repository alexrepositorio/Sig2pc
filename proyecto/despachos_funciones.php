<?php
function despachosporlote($id)
{
	require("conect.php");
	$SQL="call SP_despachos_cons('".$id."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	return(transformar_a_lista($resultado));
}
?>