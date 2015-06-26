<?php

function cargar_datos($criterio){
	require("conect.php");
	mysqli_query($link, "SET NAMES 'utf8'");
	$SQL = "call SP_pagos_cons_datos('".$criterio."')";
	$resultado = mysqli_query($link, $SQL);

	while ($row = mysqli_fetch_array($resultado, MYSQLI_ASSOC)) {
		$datos[] = $row;
	}

	return $datos;
}

//consultar datos del socio en referencia al lote   ((( Preliminar -> debe quedar como la función siguiente )))
function consultar_nombre_socio($id_socio){
	include ("conect.php");
	mysqli_query($link, "SET NAMES 'utf8'");
	$SQL = "call sp_pagos_cons_nombre_socio('".$id_socio."')";
	$resultado = mysqli_query($link, $SQL);
	$socio = mysqli_fetch_array($resultado, MYSQLI_ASSOC);
	$datos_socio["nombres"] = $socio["nombres"];
	$datos_socio["apellidos"] = $socio["apellidos"];
	$datos_socio["codigo"] = $socio["codigo"];
	$datos_socio["poblacion"] = $socio["grupo"];
	$datos_socio["id_socio"] = $socio["id_socio"];
	$datos_socio["foto"] = $socio["foto"];

	return $datos_socio;
}

//consultar datos del socio en referencia al lote
// function consultar_nombre_socio($id){
// 	include ("conect.php");
// 	//mysqli_query($link, "SET NAMES 'utf8'");
// 	$SQL = "call sp_pagos_cons_nombre_socio('".$id."')";
// 	$resultado = mysqli_query($link, $SQL);
// 	return (transformar_a_lista($resultado));
// }

//listado de lotes según el criterio de búsqueda
function busqueda_lotes ($criterio, $valor){
	require("conect.php");
	$SQL = "call sp_pagos_cons_lotes('".$criterio."','".$valor."')";
	$resultado = mysqli_query($link, $SQL);
	return (transformar_a_lista($resultado));
}

function busqueda_catas($lote){
	require("conect.php");
	$SQL = "call SP_pagos_cons_catas('".$lote."')";
	$resultado = mysqli_query($link, $SQL);
	return (transformar_a_lista($resultado));
}

function busqueda_pagos($lote){
	require("conect.php");
	$SQL = "call SP_pagos_cons_pagos('".$lote."')";
	$resultado = mysqli_query($link, $SQL);
	return (transformar_a_lista($resultado));
}

//Cambiar o buscar la función para esta acción
function altas_bajas($socio)
{
	include ("conect.php");
	mysqli_query($link, "SET NAMES 'utf8'");
	$SQL="SELECT * FROM altas WHERE id_socio='$socio'";
	$resultado=mysqli_query($link, $SQL);
	while($socio = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
	$id=$socio["id"];
	$altas[$id]["estado"]=$socio["estado"];	
	$altas[$id]["year"]=$socio["fecha"];	
	}
	if(isset($altas)){return ($altas);}
}
//Sin probar aún, probar guardado de sentencia
function borrar_pago($pago){
	include ("conect.php");
	$SQL = "call SP_pagos_del('".$pago."')";
	$resultado = mysqli_query($link, $SQL);
	$sentencia = "DELETE FROM pagos WHERE id=$pago";
	$cadena=str_replace("'", "", $sentencia);
	guarda_historial($cadena);
}

?>