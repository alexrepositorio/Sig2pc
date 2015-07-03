<?php
function consultarSubparcelas($criterio,$id){
    require("conect.php");
    $SQL="call SP_subparcelas_cons('".$criterio."','".$id."')";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    return (transformar_a_lista($resultado)); 
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