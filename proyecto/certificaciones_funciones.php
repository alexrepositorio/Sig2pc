<?php
function certificacion($criterio,$in_socio)
{
	require("conect.php");
	$SQL="call SP_certificaciones_cons('".$criterio."','".$in_socio."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	return(transformar_a_lista($resultado));
}
function certificarsocio($id,$anio,$estado){	
	require("conect.php");
    $SQL="call SP_socio_certificar('".$id."','".$anio."','".ucfirst($estado)."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link));
    global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"], $operaciones_constantes["I"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["certificaciones"], gethostname()); 
    require("config_disconnect.php");
}
function certificacionborrar($id){
	require("conect.php");
    $SQL="call SP_certificaciones_del('".$id."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link));
    global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"], $operaciones_constantes["D"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["certificaciones"], gethostname()); 
    require("config_disconnect.php");
}

