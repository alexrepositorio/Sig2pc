<?php

function cargar_datos($criterio){
	require("conect.php");
	mysqli_query($link, "SET NAMES 'utf8'");
	$SQL = "call SP_pagos_cons_datos('".$criterio."')";
	$resultado = mysqli_query($link, $SQL)or die(mysqli_error($link));
	return (transformar_a_lista($resultado));
}

function consultar_nombre_socio($id_socio){
	include ("conect.php");
	mysqli_query($link, "SET NAMES 'utf8'");
	$SQL = "call sp_pagos_cons_nombre_socio('".$id_socio."')";
	$resultado = mysqli_query($link, $SQL)or die(mysqli_error($link));
	$socio = mysqli_fetch_array($resultado, MYSQLI_ASSOC);
	$datos_socio["nombres"] = $socio["nombres"];
	$datos_socio["apellidos"] = $socio["apellidos"];
	$datos_socio["codigo"] = $socio["codigo"];
	$datos_socio["poblacion"] = $socio["grupo"];
	$datos_socio["id_socio"] = $socio["id_socio"];
	$datos_socio["foto"] = $socio["foto"];

	return $datos_socio;
}

//listado de lotes según el criterio de búsqueda
function busqueda_lotes ($criterio, $valor){
	require("conect.php");
	$SQL = "call sp_pagos_cons_lotes('".$criterio."','".$valor."')";
	$resultado = mysqli_query($link, $SQL)or die(mysqli_error($link));
	return (transformar_a_lista($resultado));
}

function busqueda_catas($lote){
	require("conect.php");
	$SQL = "call SP_pagos_cons_catas('".$lote."')";
	$resultado = mysqli_query($link, $SQL)or die(mysqli_error($link));
	return (transformar_a_lista($resultado));
}

function busqueda_pagos($criterio, $valor){
	require("conect.php");
	$SQL = "call SP_pagos_cons('".$criterio."','".$valor."')";
	$resultado = mysqli_query($link, $SQL)or die(mysqli_error($link));
	return (transformar_a_lista($resultado));
}

function insertar_pagos($codigo_lote, $fecha, $exportable, $descarte, $fuera, $calidad, $cliente = "0", $microlote = "0", $tazadorada = "0"){
	require("conect.php");
	$SQL = "call SP_pagos_ins('".$codigo_lote."','".$fecha."','".$exportable."','".$descarte."','".$fuera."','".$calidad."','".$cliente."','".$microlote."','".$tazadorada."')";
	$resultado = mysqli_query($link, $SQL)or die(mysqli_error($link));
}

function actualizar_pagos($fecha, $exportable, $descarte, $fuera, $calidad, $cliente = "0", $microlote = "0", $tazadorada = "0", $id){
	require("conect.php");
	$SQL = "call SP_pagos_upd('".$fecha."','".$exportable."','".$descarte."','".$fuera."','".$calidad."','".$cliente."','".$microlote."','".$tazadorada."','".$id."')";
	$resultado = mysqli_query($link, $SQL)or die(mysqli_error($link));
}

function actualizar_calidad($calidad, $lote){
	require("conect.php");
	$SQL = "call SP_pagos_upd_calidad('".$calidad."','".$lote."')";
	$resultado = mysqli_query($link, $SQL)or die(mysqli_error($link));
}

function borrar_pago($pago){
	include ("conect.php");
	$SQL = "call SP_pagos_del('".$pago."')";
	$resultado = mysqli_query($link, $SQL)or die(mysqli_error($link));
}
function pagos_consultar_criterio($criterio,$valor){
	require("conect.php");
	$SQL = "call SP_pagos_cons('".$criterio."','".$valor."')";
	$resultado = mysqli_query($link, $SQL) or die(mysqli_error($link));
	return (transformar_a_lista($resultado));
}

?>