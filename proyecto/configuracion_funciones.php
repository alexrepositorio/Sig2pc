<?php
/*
function obtener_configuracion_parametro($parametro){
require("conect.php");
    $SQL="SELECT valor FROM configuracion where parametro= '".$parametro."'";
    $resultado=mysqli_query($link,$SQL); 
    $row = mysqli_fetch_array($resultado,MYSQLI_ASSOC);
    return($row['valor']);
}
*/

function configuracion_cons($criterio,$parametro){
require("conect.php");
    $SQL="CALL SP_configuracion_cons('".$criterio."','".$parametro."')";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    return(transformar_a_lista($resultado));
}
function configuracion_actualizar($descripcion,$valor,$id){
require("conect.php");
    $SQL="CALL SP_configuracion_upd('".$descripcion."','".$valor."','".$id."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link)); 
}
?>