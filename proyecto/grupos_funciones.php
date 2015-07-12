<?php
function consultarGrupo($criterio,$valor){
     require("conect.php");
    $SQL="call SP_grupos_cons('".$criterio."','".$valor."')";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
    require("config_disconnect.php");
    return (transformar_a_lista($resultado));
}

function eliminarGrupo($id_grupo){
	 require("conect.php");
    $SQL="call SP_grupos_del('".$id_grupo."')";
    $result=mysqli_query($link,$SQL) or die(mysqli_error($link));
     global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"], $operaciones_constantes["D"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["grupos"], gethostname()); 
    require("config_disconnect.php");
}
function insertarGrupo($grupo,$codigo){
	require("conect.php");
    $SQL="call SP_grupos_ins('".$grupo."','".$codigo."')";
    $result=mysqli_query($link,$SQL) or die(mysqli_error($link));
     global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"], $operaciones_constantes["I"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["grupos"], gethostname()); 
    require("config_disconnect.php");
}
function actualizarGrupo($id,$grupo,$codigo){
	require("conect.php");
    $SQL="call SP_grupos_upd('".$grupo."','".$codigo."','".$id."')";
    $result=mysqli_query($link,$SQL) or die(mysqli_error($link));
     global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"], $operaciones_constantes["U"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["grupos"], gethostname()); 
    require("config_disconnect.php");
}


?>