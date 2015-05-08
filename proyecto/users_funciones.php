<?php
/**
 * Created by PhpStorm.
 * User: Alex
 * Date: 08/04/2015
 * Time: 20:23
 */


function consultarCriterio(){
    require("conect.php");
    $SQL="call SP_lista_usuarios_con( )";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
				$usuarios[]=$row;

			}  
    return($usuarios);

}

?>