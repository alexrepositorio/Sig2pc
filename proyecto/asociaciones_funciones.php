<?php

function asociaciones_consultar($criterio,$id){
    require("conect.php");
    $SQL="call SP_asociaciones_cons('".$criterio."','".$id."')";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
     require("config_disconnect.php");
     return (transformar_a_lista($resultado));
}

function asociaciones_insertar($concepto,$valor,$asociacion,$tipo,$elemento){

    require("conect.php");
    $SQL="call SP_asociaciones_ins('".ucfirst($concepto)."','".$valor."','".$asociacion."','".$tipo."','".ucfirst($elemento)."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"], $operaciones_constantes["I"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["asociaciones"], gethostname()); 
    require("config_disconnect.php");
}
function asociaciones_borrar($id){
    require("conect.php");
    $SQL="call SP_asociaciones_del('".$id."')";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"], $operaciones_constantes["D"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["asociaciones"], gethostname()); 
    require("config_disconnect.php");
}

?>