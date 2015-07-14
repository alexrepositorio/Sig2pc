<?php
function consultarCriterio($criterio,$valor){
    require("conect.php");
    $SQL="call sp_socio_cons('".$criterio."','".$valor."')";
    $resultado=mysqli_query($link,$SQL); 
	require("config_disconnect.php");
    return (transformar_a_lista($resultado));
}
function calcular_codigo($poblacion){
    require("conect.php");
    $codigo_grupo=substr($poblacion,0,2);  
    $result=consultarCriterio('codigos','');
    $cuenta_p=count($result);
    if (is_array($result)) {
    	foreach ($result as $rowcodigos) {
				$nsocio=substr($rowcodigos["codigo"],2,2);
				$numeraciones[]=$nsocio;
			}
			$siguiente=max($numeraciones)+1;
			$nuevo_codigo=$codigo_grupo.$siguiente;
    }else{
    	$nuevo_codigo=$codigo_grupo."01";
    }		
    return ($nuevo_codigo);
}

function actualizarsocio($id,$nombre,$apellido,$codigo,$cedula,$celular,$f_nac,$direccion,$poblacion,$canton,$genero,$mail){
    require ("conect.php");
    $SQL="call SP_socio_update(".$id.",'".ucfirst($nombre)."','".ucfirst($apellido)."','".$codigo."','".$cedula."','".$celular."','".$f_nac."','".$direccion."','".$poblacion."','".$canton."','".strtoupper($genero)."','".$mail."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"],$operaciones_constantes["U"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["socios"], gethostname());	
	require("config_disconnect.php");  
}
function comprobar_mail($mail){
	require ("conect.php");
	$estado=false;	
	$result=consultarCriterio('','');
	foreach ($result as $row) {
		if ($row['email']==$mail) {
			$estado=true;
		}
	}
	return ($estado);
}
function insertar_socio($nombre,$apellido,$codigo,$cedula,$celular,$f_nac,$direccion,$poblacion,$canton,$genero,$mail){
	require ("conect.php");
	$SQL="call SP_socio_ins('".$nombre."','".$apellido."','".$codigo."','".$cedula."','".$celular."','".$f_nac."','".$direccion."','".$poblacion."','".$canton."','".$genero."','".$mail."')";
	mysqli_query($link,$SQL) or die(mysqli_error($link));
	global $operaciones_constantes,$tabla_constantes;
	guarda_historia($_SESSION["user"], $operaciones_constantes["I"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["socios"], gethostname());	
	require("config_disconnect.php");  
}
?>