<?php

//carga socios en el combobox; implementada en la línea 68 de pagos.php
function cargar_socios(){
	require("conect.php");
	$SQL = "call sp_pagos_cons_socios()";
	$resultado = mysqli_query($link, $SQL);
	while ($row_socio = mysqli_fetch_array($resultado, MYSQLI_ASSOC)) {
		$socios[] = $row_socio;
	}
	return $socios;
}

//carga grupos en el combobox; implementada en la línea 96 de pagos.php
function cargar_grupos(){
	require("conect.php");
	$SQL = "call sp_pagos_cons_grupos()";
	$resultado = mysqli_query($link, $SQL);
    while ($row_grupo = mysqli_fetch_array($resultado, MYSQLI_ASSOC)){
        $grupos[] = $row_grupo; 
    }  
    return ($grupos);
}

//carga fechas en el combobox; implementada en la línea 109 de pagos.php
function cargar_fechas(){
	require("conect.php");
	$SQL = "call sp_pagos_cons_fechas()";
	$resultado = mysqli_query($link, $SQL);
	while ($row_fecha = mysqli_fetch_array($resultado, MYSQLI_ASSOC)){
		$fechas[] = $row_fecha["fecha"];
    }  
    return ($fechas);
}

//listado de lotes según el criterio de búsqueda
function busqueda_lotes ($criterio, $valor){
	require("conect.php");
	$SQL = "call sp_pagos_cons_lotes('".$criterio."','".$valor."')";
	$resultado = mysqli_query($link, $SQL);
	while ($row_lote = mysqli_fetch_array($resultado, MYSQLI_ASSOC)) {
		$lotes[] = $row_lote; 
	}
	return ($lotes);
}

//consultar datos del socio en referencia al lote
function consultar_nombre_socio($id){
	include ("conect.php");
	mysqli_query($link, "SET NAMES 'utf8'");
	$SQL = "call sp_pagos_cons_nombre_socio('".$id."')";
	$resultado = mysqli_query($link, $SQL);
	$socio = mysqli_fetch_array($resultado,MYSQLI_ASSOC);
	$datos_socio["nombres"]=$socio["nombres"];
	$datos_socio["apellidos"]=$socio["apellidos"];
	$datos_socio["codigo"]=$socio["codigo"];
	$datos_socio["poblacion"]=$socio["poblacion"];
	$datos_socio["id"]=$socio["id_socio"];
	$datos_socio["foto"]=$socio["foto"];
	return ($datos_socio);
}

?>