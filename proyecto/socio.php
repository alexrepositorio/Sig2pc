<?php
function consultarCriterio($criterio,$valor){
    require("conect.php");
    $SQL="call sp_socio_cons('".$criterio."','".$valor."')";
    $resultado=mysqli_query($link,$SQL); 
    return (transformar_a_lista($resultado));
}

function calcular_codigo($poblacion){
    require("conect.php");
    $codigo_grupo=substr($poblacion,0,2);
    $SQL="SELECT codigo from socios" ;
    $result=mysqli_query($link,$SQL) or die(mysqli_error($link));
    $cuenta_p=mysqli_num_rows($result);
		if($cuenta_p==0){
			$nuevo_codigo=$codigo_grupo."01";
		}
		else{
			while ($rowcodigos = mysqli_fetch_array($result,MYSQLI_ASSOC)){
				$nsocio=substr($rowcodigos["codigo"],2,2);
				$numeraciones[]=$nsocio;
			}
			$siguiente=max($numeraciones)+1;
			$nuevo_codigo=$codigo_grupo.$siguiente;
		}
    return ($nuevo_codigo);
}

function actualizarsocio($id,$nombre,$apellido,$codigo,$cedula,$celular,$f_nac,$direccion,$poblacion,$canton,$provincia,$genero,$mail){
    require ("conect.php");
    $SQL="call SP_socio_update(".$id.",'".$nombre."','".$apellido."','".$codigo."','".$cedula."','".$celular."','".$f_nac."','".$direccion."','".$poblacion."','".$canton."','".$provincia."','".$genero."','".$mail."')";
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
function insertar_socio($nombre,$apellido,$codigo,$cedula,$celular,$f_nac,$direccion,$poblacion,$canton,$provincia,$genero,$mail){
	require ("conect.php");
	$SQL="call SP_socio_ins('".$nombre."','".$apellido."','".$codigo."','".$cedula."','".$celular."','".$f_nac."','".$direccion."','".$poblacion."','".$canton."','".$provincia."','".$genero."','".$mail."')";
	mysqli_query($link,$SQL) or die(mysqli_error($link));
}
?>