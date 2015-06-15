<?php

function asociaciones_consultar($id){
    require("conect.php");
    $SQL="call SP_asociaciones_cons('".$id."')";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
     return (transformar_a_lista($resultado));
    
}

function asociaciones_insertar($concepto,$valor,$asociacion,$tipo,$elemento){
    require("conect.php");
    $SQL="call SP_asociaciones_ins('".$concepto."','".$valor."','".$tipo."','".$elemento."','".$asociacion."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link)); 

}
function asociaciones_borrar($id){
    require("conect.php");
    $SQL="call SP_asociaciones_del('".$id."')";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
}

?>