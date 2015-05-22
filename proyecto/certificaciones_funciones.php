<?php
function certificacion($in_socio)
{
	require("conect.php");
	$SQL="SELECT * FROM certificacion WHERE id_socio='".$in_socio."'";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	return(transformar_a_lista($resultado));
}
function certificarsocio($id,$anio,$estado){	
	require("conect.php");
    $sql="call SP_socio_certificar('".$id."','".$anio."','".$estado."')";
    $result=mysqli_query($link,$sql) or die(mysqli_error($link));
}
function certificacionborrar($id){
	require("conect.php");
    $SQL="DELETE FROM certificacion WHERE id='".$id."'";
    $result=mysqli_query($link,$SQL) or die(mysqli_error($link));
}
