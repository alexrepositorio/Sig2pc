<?php
/**
 * Created by PhpStorm.
 * User: Alex
 * Date: 08/04/2015
 * Time: 20:23
 */


function consultarCriterio($criterio,$valor){
    require("conect.php");
    $SQL="call sp_socio_cons('".$criterio."','".$valor."')";
    $resultset=mysql_query($SQL,$link);
    return($resultset);
}

function actualizarsocio($id,$nombre,$apellido,$cedula,$celular,$f_nac,$direccion,$poblacion,$canton,$provincia,$genero){
    $SQL="UPDATE persona SET
				nombres='".$nombre."',
				apellidos='".$apellido."',
				cedula='".$cedula."',
				celular='".$celular."',
				f_nacimiento='".$f_nac."',
				direccion='".$direccion."',
				canton='".$canton."',
				provincia='".$provincia."',
				genero='".$genero."'
			where id_persona='".$id."'";
    $resultado=mysql_query($SQL,$link);
    $SQL2="SELECT id from grupos where grupo like %".$poblacion."%";
    $resultado=mysql_query($SQL2,$link);
    $row = mysql_fetch_array($result);
    $SQL3="UPDATE socios
		set id_grupo=".$row["id"]."
			where id_persona=".$id;
    $resultado=mysql_query($SQL3,$link);
}

function obtenerSocio($id){
    require("conect.php");
    $SQL="SELECT `id_socio`,`nombres`, `apellidos`, `codigo`, `cedula`, `f_nacimiento`, `email`, `direccion`, `canton`, `provincia`, `genero`,`grupo` as poblacion FROM persona
left join socios
on socios.id_persona=persona.id_persona
left join grupos
on grupos.id=socios.id_grupo
where socios.id_persona='".$id."'";
    $resultado=mysql_query($SQL,$link);
    return ($resultado);
}


function obtenerSocioLotes($id){
    require("conect.php");

    $SQL="SELECT `id_socio`,`nombres`, `apellidos`, `codigo`, `cedula`, `f_nacimiento`, `email`, `direccion`, `canton`, `provincia`, `genero`,`grupo` as poblacion FROM persona
left join socios
on socios.id_persona=persona.id_persona
left join grupos
on grupos.id=socios.id_grupo
where socios.id_persona='".$id."'";
    $resultado=mysql_query($SQL,$link);
    return ($resultado);
}

?>