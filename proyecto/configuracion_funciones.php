<?php
function configuracion_cons($criterio,$parametro){
require("conect.php");
    $SQL="CALL SP_configuracion_cons('".$criterio."','".$parametro."')";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    require("config_disconnect.php");
    return(transformar_a_lista($resultado));
}
function configuracion_actualizar($descripcion,$valor,$id){
require("conect.php");
    $SQL="CALL SP_configuracion_upd('".$descripcion."','".$valor."','".$id."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"], $operaciones_constantes["U"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["estimaciones"], gethostname()); 
    require("config_disconnect.php");
}
?>