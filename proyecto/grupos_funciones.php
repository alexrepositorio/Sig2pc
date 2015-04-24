<?php
function obtenerGrupos(){

    require("conect.php");
    $sql_localidad="SELECT DISTINCT(grupo)  FROM GRUPOS ORDER BY grupo ASC";
    $result=mysqli_query($link,$sql_localidad);
    return ($result);
}
?>