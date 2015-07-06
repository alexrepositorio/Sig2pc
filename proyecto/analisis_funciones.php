<?php

function analisis_suelos($id){
    require("conect.php");
    $SQL="CALL SP_analisis_cons('','".$id."')";
    $resultado=mysqli_query($link,$SQL) or die(mysql_error($link)); 
    return(transformar_a_lista($resultado));  
}

function analisis_subparcela($id){
    require("conect.php");
    $SQL="CALL SP_analisis_cons('subparcelas','".$id."')";
    $resultado=mysqli_query($link,$SQL) or die(mysql_error($link)); 
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
}
?>