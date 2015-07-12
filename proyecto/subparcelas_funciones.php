<?php
function consultarSubparcelas($criterio,$id){
    require("conect.php");
    $SQL="call SP_subparcelas_cons('".$criterio."','".$id."')";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    require("config_disconnect.php"); 
    return (transformar_a_lista($resultado)); 
}

function subparcelas_insertar($id_parcela,$superficie,$variedad,$variedad2,$siembra,$densidad,$marco,$hierbas,$sombreado,$roya
    ,$broca,$ojo_pollo,$mes_inicio_cosecha,$duracion_cosecha){
    require("conect.php");
    $SQL="CALL SP_subparcelas_ins('".$id_parcela."','".$superficie."','".$variedad."','".$variedad2."',
        '".$siembra."','".$densidad."','".$marco."','".$hierbas."','".$sombreado."','".$roya."',
        '".$broca."','".$ojo_pollo."','".$mes_inicio_cosecha."','".$duracion_cosecha."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    global $operaciones_constantes,$tabla_constantes;
            guarda_historia($_SESSION["user"], $operaciones_constantes["I"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["subparcelas"], gethostname()); 
            require("config_disconnect.php");    
}
function subparcela_editar($id_parcela,$superficie,$variedad,$variedad2,$siembra,$densidad,$marco,$hierbas,$sombreado,$roya
    ,$broca,$ojo_pollo,$mes_inicio_cosecha,$duracion_cosecha,$id){
    require("conect.php");

     $SQL="CALL SP_subparcelas_upd('".$id_parcela."','".$superficie."','".$variedad."','".$variedad2."',
        '".$siembra."','".$densidad."','".$marco."','".$hierbas."','".$sombreado."','".$roya."',
        '".$broca."','".$ojo_pollo."','".$mes_inicio_cosecha."','".$duracion_cosecha."','".$id."')";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
    global $operaciones_constantes,$tabla_constantes;
            guarda_historia($_SESSION["user"], $operaciones_constantes["U"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["subparcelas"], gethostname()); 
            require("config_disconnect.php");    
}
function subparcela_borrar($id){
    require("conect.php");
    $SQL="call SP_subparcelas_del('".$id."')";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"], $operaciones_constantes["U"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["subparcelas"], gethostname()); 
    require("config_disconnect.php");  
}
?>