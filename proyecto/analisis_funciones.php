<?php

function analisis_suelos($id){
    require("conect.php");
    $SQL="SELECT * FROM analisis WHERE id_subparcela in (SELECT id FROM subparcelas WHERE id_parcela='".$id."')";
    $resultado=mysqli_query($link,$SQL) or die(mysql_error($link)); 
    if (mysqli_num_rows($resultado)>0) {
     	while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
				$analisis[]=$row;	
			} 
			return($analisis);	    	
    }else{
    	
    	return 0;
    }
}

function analisis_subparcela($id){
    require("conect.php");
    $SQL="SELECT * FROM analisis WHERE id_subparcela='".$id."'";
    $resultado=mysqli_query($link,$SQL) or die(mysql_error($link)); 
    if (mysqli_num_rows($resultado)>0) {
        while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
                $analisis[]=$row;   
            } 
            return($analisis);          
    }else{
        
        return 0;
    }
}



?>