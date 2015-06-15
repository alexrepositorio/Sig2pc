<?php

function analisis_suelos($id){
    require("conect.php");
    $SQL="CALL SP_analisis_cons('','".$id."')";
    $resultado=mysqli_query($link,$SQL) or die(mysql_error($link)); 
    return(transformar_a_lista($resultado));  
}

function analisis_subparcela($id){
    require("conect.php");
    $SQL="CALL SP_analisis_cons('subparcelas','".$id."')";
    $resultado=mysqli_query($link,$SQL) or die(mysql_error($link)); 
    return(transformar_a_lista($resultado));  
}


?>