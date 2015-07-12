<?php
function consultarCriterio($criterio){
    require("conect.php");
    $SQL="call SP_lista_usuarios_con('".$criterio."')";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
    require("config_disconnect.php");
    return(transformar_a_lista($resultado));
}
function obtenerNombres(){

    require("conect.php");
    $sql="call SP_personas_cons('','')";
    $resultado=mysqli_query($link,$sql) or die(mysqli_error($link));
    require("config_disconnect.php");
    return(transformar_a_lista($resultado));
}
function insertar_Usuarios($user,$pass,$nivel,$persona){
	require ("conect.php");
	$SQL="call SP_usuarios_ins('".$user."','".$pass."','".$nivel."','".$persona."')";
	mysqli_query($link,$SQL) or die(mysqli_error($link));
    echo $SQL;
     global $operaciones_constantes,$tabla_constantes;
	guarda_historia($_SESSION["user"], $operaciones_constantes["I"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["usuarios"], gethostname());	
	require("config_disconnect.php");
}

function comprobar_mail($mail){
    require ("conect.php");
    $SQL="call SP_personas_cons('','".$mail."')";
    $resultado=mysqli_query($link, $SQL)or die(mysqli_error($link));
    if(mysqli_num_rows($resultado)==0 or $mail==''){
        return false;
    }else
        return true;
    }

function insertar_persona($nombre,$apellido,$cedula,$celular,$f_nac,$mail,$direccion,$foto,$genero,$canton){
    require ("conect.php");
    $SQL="call SP_persona_ins('".$nombre."','".$apellido."','".$cedula."','".$celular."','".$f_nac."','".$mail."','".$direccion."','".$foto."','".$genero."','".$canton."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link));
     global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"], $operaciones_constantes["I"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["personas"], gethostname()); 
    require("config_disconnect.php");
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
        mysqli_query($link, $SQL) or die(MYSQLI_ERROR($link));
         global $operaciones_constantes,$tabla_constantes;
        guarda_historia($_SESSION["user"], $operaciones_constantes["D"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["usuarios"], gethostname());	
		require("config_disconnect.php");
}
function actualizaruser($id,$cuenta,$contra,$nivel){
    require ("conect.php");
    $SQL="call SP_user_update(".$id.",'".$cuenta."','".$contra."','".$nivel."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    global $operaciones_constantes,$tabla_constantes;   
    guarda_historia($_SESSION["user"], $operaciones_constantes["U"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["usuarios"], gethostname());	
	require("config_disconnect.php");
}
function validar(){
    require("conect.php");
    $user = ($_POST["user"]);
    $pass = ($_POST["pass"]);

    $sql="call SP_usuario_find('".$user."','".$pass."')";
    $res_sql=mysqli_query($link,$sql);
    $cpin=mysqli_num_rows($res_sql);
    $row_user=mysqli_fetch_array($res_sql);
    require("config_disconnect.php");
    if ($cpin>0)
    {
        session_start();
        $_SESSION["cuenta"]=$row_user['id'];
        $_SESSION["user"]=$user;
        $_SESSION["acceso"]=$row_user['id_nivel'];
        header("Location:index.php");
    }
    else
    {
        echo"<div align=center><notif>Usuario o clave incorrecta</notif></div>";
    }
}
?>
