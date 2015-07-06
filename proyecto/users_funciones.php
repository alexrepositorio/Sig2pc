<?php

function consultarCriterio($criterio){
    require("conect.php");
    $SQL="call SP_lista_usuarios_con('".$criterio."')";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
    return(transformar_a_lista($resultado));
}
function obtenerNombres(){

    require("conect.php");
    $sql="call SP_personas_cons('','')";
    $resultado=mysqli_query($link,$sql) or die(mysqli_error($link));
    return(transformar_a_lista($resultado));
}
function insertar_Usuarios($user,$pass,$nivel,$persona){
	require ("conect.php");
	$SQL="call SP_usuarios_ins('".$user."','".$pass."','".$nivel."','".$persona."')";
	mysqli_query($link,$SQL) or die(mysqli_error($link));
}

function comprobar_mail($mail){
    require ("conect.php");
    $SQL="call SP_personas_cons('','".$mail."')";
    $resultado=mysqli_query($link, $SQL)or die(mysqli_error($link));
    if(mysqli_num_rows($result)==0 or $mail==''){
        return false;
    }else
        return true;
    }

function insertar_persona($nombre,$apellido,$cedula,$celular,$f_nac,$mail,$direccion,$foto,$genero,$canton){
    require ("conect.php");
    $SQL="call SP_persona _ins('".$nombre."','".$apellido."','".$cedula."','".$celular."','".$f_nac."','".$mail."','".$direccion."','".$foto."','".$genero."','".$canton."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link));
}

function listar_niveles(){
    require("conect.php");
    $SQL="call SP_niveles_cons()";
    $resultado=mysqli_query($link,$SQL) or die(MYSQLI_ERROR($link)); 
    return(transformar_a_lista($resultado));
}
function borrarUsuarios($criterio,$operacion){
    require("conect.php");
        $SQL="call SP_users_del('".$criterio."','".$operacion."')";
        mysqli_query($link, $SQL) or die(MYSQLI_ERROR($link));;
}
function actualizaruser($id,$cuenta,$contra,$nivel){
    require ("conect.php");
    $SQL="call SP_user_update(".$id.",'".$cuenta."','".$contra."','".$nivel."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link));    
}
?>
