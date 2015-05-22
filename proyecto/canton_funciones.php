<?php

function listar_cantones(){
    require("conect.php");
    $SQL="SELECT * FROM canton";
    $resultado=mysqli_query($link,$SQL) or die(MYSQLI_ERROR($link)); 
    while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
				$cantones[]=$row;	
			}  		
    return($cantones);
}
?>