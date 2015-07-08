<?php

function listar_cantones(){
    require("conect.php");
    $SQL="call SP_cantones_cons()";
    $resultado=mysqli_query($link,$SQL) or die(MYSQLI_ERROR($link)); 
    require("config_disconnect.php");
    return(transformar_a_lista($resultado));
}
?>