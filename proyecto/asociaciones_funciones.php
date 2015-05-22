<?php

function asociaciones_consultar($id){
    require("conect.php");
    $SQL="SELECT * FROM asociaciones WHERE elemento='parcela' AND subparcela_id='".$id."'";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
     if (mysqli_num_rows($resultado)>0) {
     	while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
				$asociaciones[]=$row;	
			} 
			return($asociaciones);	    	
    }else{
    	
    	return 0;
    }
    
}

function asociaciones_insertar($concepto,$valor,$asociacion,$tipo,$elemento){
    require("conect.php");
    $SQL="INSERT INTO asociaciones VALUES ('','".$concepto."',
                                                 '".$valor."',
                                                 '".$asociacion."',
                                                 '".$tipo."',
                                                 '".$elemento."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link)); 

}
function asociaciones_borrar($id){
    require("conect.php");
    $SQL="DELETE FROM asociaciones WHERE id=".$id;
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
}

?>