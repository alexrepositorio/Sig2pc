<?php

function analisis_suelos($id){
    require("conect.php");
    $SQL="CALL SP_analisis_cons('','".$id."')";
    $resultado=mysqli_query($link,$SQL) or die(mysql_error($link)); 
    require("config_disconnect.php");
    return(transformar_a_lista($resultado));  
}

function analisis_subparcela($id){
    require("conect.php");
    $SQL="CALL SP_analisis_cons('subparcelas','".$id."')";
    $resultado=mysqli_query($link,$SQL) or die(mysql_error($link)); 
    require("config_disconnect.php");
    return(transformar_a_lista($resultado));  
}
function analisis_insertar($id_subparcela,$fecha,$muestra,$submuestra,$estructura,$grado,$rocas,$rocas_size,$profundidad,
	$pendiente,$lombrices,$densidad_aparente,$observaciones,$s_ph,$s_n,$s_p,$s_k,$s_ca,$s_mg,$s_mo,$s_textura,$f_n,$f_p,$f_k)
{
    require("conect.php");
    $SQL="CALL SP_analisis_ins('".$id_subparcela."','".$fecha."','".$muestra."','".$submuestra."','".$estructura."',
    	'".$grado."','".$rocas."','".$rocas_size."','".$profundidad."','".$pendiente."',
    	'".$lombrices."','".$densidad_aparente."','".$observaciones."','".$s_ph."','".$s_n."',
    	'".$s_p."','".$s_k."','".$s_ca."','".$s_mg ."','".$s_mo."','".$s_textura."','".$f_n."',
    	'".$f_p."','".$f_k."')";
    mysqli_query($link,$SQL) or die(mysql_error($link)); 
    global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"], $operaciones_constantes["I"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["analisis"], gethostname()); 
    require("config_disconnect.php");
}
?>