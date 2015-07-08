<?php

function listar_provincias(){
    require("conect.php");
    $SQL="SELECT * FROM provincia";
    $resultado=mysqli_query($link,$SQL) or die(MYSQLI_ERROR($link)); 
    while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
				$cantones[]=$row;	
			}  		
            require("config_disconnect.php"); 
    return($cantones);
}
?>