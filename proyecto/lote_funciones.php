<?php

function lote_insertar($socio,$codigo,$fecha,$peso,$humedad,$rto_descarte,$rto_exportable,$defecto_negro,
		$defecto_vinagre,$defecto_decolorado,$defecto_mordido,$defecto_brocado,$reposo,$moho,$fermento,$contaminado,
		$calidad)
	{
		 require("conect.php");
		$SQL="CALL SP_lote_ins(".$socio.",'".$codigo."','".$fecha."','".$peso."','".$humedad."','".$rto_descarte."','".$rto_exportable."','".$defecto_negro."','".$defecto_vinagre."','".$defecto_decolorado."','".$defecto_mordido."','".$defecto_brocado."','".$reposo."','".$moho."','".$fermento."','".$contaminado."','".$calidad."')";
		 $result=mysqli_query($link,$SQL) or die(mysqli_error($link));    	
	}
function lote_actualizar($id,$socio,$codigo,$fecha,$peso,$humedad,$rto_descarte,$rto_exportable,$defecto_negro,
		$defecto_vinagre,$defecto_decolorado,$defecto_mordido,$defecto_brocado,$reposo,$moho,$fermento,$contaminado,
		$calidad)
	{
		 require("conect.php");
		$SQL="CALL SP_lote_upd('".$id."',".$socio."','".$codigo."','".$fecha."','".$peso."','".$humedad."','".$rto_descarte."','".$rto_exportable."','".$defecto_negro."','".$defecto_vinagre."','".$defecto_decolorado."','".$defecto_mordido."','".$defecto_brocado."','".$reposo."','".$moho."','".$fermento."','".$contaminado."','".$calidad."')";
		 $result=mysqli_query($link,$SQL) or die(mysqli_error($link));    	
	}
function lote_borrar($id)
	{
		require("conect.php");
		$SQL="CALL SP_lote_del('".$id."')";
		$result=mysqli_query($link,$SQL) or die(mysqli_error($link));    	
	}

function lote_codigo(){

 	require("conect.php");
	$r_nuevolote=LotesConsultarCriterio('codigos',date("Y",time()));
	if (is_array($r_nuevolote)) {
		foreach ($r_nuevolote as $rowlotes) {
			$lote=$rowlotes["codigo_lote"];
			$lote=str_replace("C-","C",$lote);
			$lote=str_replace("C","C-",$lote);
			$lote=explode ("-",$lote);
			$numeraciones[]=$lote[1];
			$siguiente=max($numeraciones)+1;
			$nuevo_lote="APC-".str_pad($siguiente,5,"0",STR_PAD_LEFT)."-".date("y",time());
		}
	}else{
		$nuevo_lote="APC-00001-".date("y",time());
	}
	return ($nuevo_lote);
}

/*
function obtenerLotesfecha($socio,$fecha){
	require ("conect.php");
	//echo 	$socio."    ".$fecha;
	$SQL="SELECT * FROM lotes where id_socio='".$socio."' and fecha='".$fecha."'";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	return (transformar_a_lista($resultado));
}
*/
function LotesConsultarCriterio($criterio,$valor){
	require ("conect.php");
	$SQL="CALL SP_lote_cons('".$criterio."','".$valor."','')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	return (transformar_a_lista($resultado));
}
function LotesConsultarid_fecha($valor1,$valor2){
	require ("conect.php");
	$SQL="CALL SP_lote_cons('id_fecha','".$valor1."','".$valor2."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	return (transformar_a_lista($resultado));
}

function LotesConsultarpago($valor,$valor2){
	require ("conect.php");
	$SQL="CALL SP_lote_cons('pago','".$valor."','".$valor2."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	return (transformar_a_lista($resultado));
}
function LotesConsultarpagos($valor){
	require ("conect.php");
	$SQL="CALL SP_lote_cons('pagos','".$valor."','')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	return (transformar_a_lista($resultado));
}
?>