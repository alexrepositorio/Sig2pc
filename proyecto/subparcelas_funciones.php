<?php

function consultarSubparcela($id){
    require("conect.php");
    $SQL="SELECT * FROM subparcelas WHERE id='".$id."'";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    if (mysqli_num_rows($resultado)>0) {
        while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
                $subparcelas[]=$row;    
            } 
            return($subparcelas);           
    }else{
        
        return 0;
    }
}

function consultarSubparcelas($id){
    require("conect.php");
    $SQL="SELECT * FROM subparcelas WHERE id_parcela='".$id."'";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    if (mysqli_num_rows($resultado)>0) {
     	while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
				$subparcelas[]=$row;	
			} 
			return($subparcelas);	    	
    }else{
    	
    	return 0;
    }
}

function subparcelas_insertar($id_parcela,$superficie,$variedad,$variedad2,$siembra,$densidad,$marco,$hierbas,$sombreado,$roya
    ,$broca,$ojo_pollo,$mes_inicio_cosecha,$duracion_cosecha){
    require("conect.php");
    $SQL="INSERT INTO subparcelas VALUES ('',
                '".$id_parcela."',
                '".$superficie."',
                '".$variedad."',
                '".$variedad2."',
                '".$siembra."',
                '".$densidad."',
                '".$marco."',
                '".$hierbas."',
                '".$sombreado."',
                '".$roya."',
                '".$broca."',
                '".$ojo_pollo."',
                '".$mes_inicio_cosecha."',
                '".$duracion_cosecha."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link));    
}
function subparcela_editar($id_parcela,$superficie,$variedad,$variedad2,$siembra,$densidad,$marco,$hierbas,$sombreado,$roya
    ,$broca,$ojo_pollo,$mes_inicio_cosecha,$duracion_cosecha,$id){
    require("conect.php");
    $SQL="UPDATE subparcelas SET 
                id_parcela='".$id_parcela."',
                superficie='".$superficie."',
                variedad='".$variedad."',
                variedad2='".$variedad2."',
                siembra='".$siembra."',
                densidad='".$densidad."',
                marco='".$marco."',
                hierbas='".$hierbas."',
                sombreado='".$sombreado."',
                roya='".$roya."',
                broca='".$broca."',
                ojo_pollo='".$ojo_pollo."',
                mes_inicio_cosecha='".$mes_inicio_cosecha."',
                duracion_cosecha='".$duracion_cosecha."'
                WHERE id='".$id."'";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 


}

?>