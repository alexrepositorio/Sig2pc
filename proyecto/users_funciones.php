<?php

function consultarCriterio(){
    require("conect.php");
    $SQL="call SP_lista_usuarios_con( )";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    return(transformar_a_lista($resultado));
}

function obtenerNombres(){

    require("conect.php");
    $sql="SELECT nombres, apellidos FROM persona ORDER BY nombres ASC";
    $resultado=mysqli_query($link,$sql) or die(mysqli_error($link));
      while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
                $nombress[]=$row; 
            }  
    return ($nombress);
}


function obtenerNiveles(){

    require("conect.php");
    $sql="SELECT niveles FROM niveles";
    $resultado=mysqli_query($link,$sql) or die(mysqli_error($link));
      while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
                $niveless[]=$row; 
            }  
    return ($niveless);
}

function insertar_Usuarios($user,$pass,$nivel,$persona){
	require ("conect.php");
	$SQL="call SP_usuarios_ins('".$user."','".$pass."','".$nivel."','".$persona."')";
	mysqli_query($link,$SQL) or die(mysqli_error($link));
}

function comprobar_mail($mail){
    require ("conect.php");
    $SQL="SELECT email FROM persona where email='".$mail."'";
    $result=mysqli_query($link, $SQL)or die(mysqli_error($link));
    if(mysqli_num_rows($result)==0 or $mail==''){
        return false;
    }else
        return true;
    }
function insertar_socio($nombre,$apellido,$cedula,$celular,$f_nac,$mail,$direccion,$foto,$genero,$canton){
    require ("conect.php");
    $SQL="call SP_socio_nuevo('".$nombre."','".$apellido."','".$cedula."','".$celular."','".$f_nac."','".$mail."','".$direccion."','".$foto."','".$genero."','".$canton."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link));
}

function listar_niveles(){
    require("conect.php");
    $SQL="call SP_niveles_cons()";
    $resultado=mysqli_query($link,$SQL) or die(MYSQLI_ERROR($link)); 
    return(transformar_a_lista($resultado));
}
?>
