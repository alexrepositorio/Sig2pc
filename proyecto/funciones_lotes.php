<?php
function busqueda_lotes()
{
    $SQL="CALL sp_lotes_busqueda()";
    $resultado=mysqli_query($link, $SQL);
    return $resultado; 
}

function busqueda_lotes_criterio($envio_val)
{
	$busqueda_criterio = $_POST["busca"];
    switch ($envio_val)
	{
		case "socio":
			$SQL="call sp_lotes_criterio ('".$envio_val."','".$busqueda_criterio."')";
			$datos_del_socio=nombre_socio($_POST["busca"]);
			$_texto=$datos_del_socio["apellidos"].", ".$datos_del_socio["nombres"];
			break;
		case "localidad":
			$SQL="call sp_lotes_criterio ('".$envio_val."','".$busqueda_criterio."')";
			$_texto=$_POST["busca"];
			break;
		case "fecha":
			$SQL="call sp_lotes_criterio ('".$envio_val."','".$busqueda_criterio."')";
			$_texto=$_POST["busca"];
			break;		
		case "organico":
			if($_GET["opcion"]=="si")
			{
				$envio_val = "organico_1";
				$SQL="call sp_lotes_criterio ('".$envio_val."','".$busqueda_criterio."')";
				$_texto="CON certificación Orgánica";
			}
			elseif($_GET["opcion"]=="no")
			{
				$envio_val = "organico_2";
				$SQL="call sp_lotes_criterio ('".$envio_val."','".$busqueda_criterio."')";
				$_texto="SIN certificación Orgánica";
			}
			break;		
	}
	$resultado=mysqli_query($link, $SQL);
	return $resultado; 
}

function lotes_socios ()
{
	$sql_socios="CALL sp_lotes_socios()";
	$r_socio=mysqli_query($link, $sql_socios);
	return $r_socio;
}

function lotes_localidad()
{
	$sql_localidad="CALL sp_lotes_localidad()";
	$r_loc=mysqli_query($link, $sql_localidad);
	return $r_loc;
}

function lotes_fecha()
{
	$sql_fecha="CALL sp_lotes_fecha()";
	$r_fec=mysqli_query($link, $sql_fecha);
	return $r_fec;
}

?>