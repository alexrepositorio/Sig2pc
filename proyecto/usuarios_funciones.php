<?php
/**
 * Created by PhpStorm.
 * User: Alex
 * Date: 08/04/2015
 * Time: 20:23
 */

function validar(){

    require("conect.php");
    $user = ($_POST["user"]);
    $pass = ($_POST["pass"]);

    $sql="call SP_usuario_find('".$user."','".$pass."')";
    $res_sql=mysqli_query($link,$sql);
    $cpin=mysqli_num_rows($res_sql);
    $row_user=mysqli_fetch_array($res_sql);
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
