<?php

function lote_insertar($socio,$codigo,$fecha,$peso,$humedad,$rto_descarte,$rto_exportable,$defecto_negro,
		$defecto_vinagre,$defecto_decolorado,$defecto_mordido,$defecto_brocado,$reposo,$moho,$fermento,$contaminado,
		$calidad)
	{
		 require("conect.php");
		$SQL="CALL SP_lote_ins('".$socio."','".$codigo."','".$fecha."','".$peso."','".$humedad."','".$rto_descarte."','".$rto_exportable."','".$defecto_negro."','".$defecto_vinagre."','".$defecto_decolorado."','".$defecto_mordido."','".$defecto_brocado."','".$reposo."','".$moho."','".$fermento."','".$contaminado."','".$calidad."')"; 
		 $result=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
		   global $operaciones_constantes,$tabla_constantes;
    		guarda_historia($_SESSION["user"], $operaciones_constantes["I"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["lotes"], gethostname()); 
    		require("config_disconnect.php"); 	
	}
function lote_actualizar($id,$socio,$codigo,$fecha,$peso,$humedad,$rto_descarte,$rto_exportable,$defecto_negro,
		$defecto_vinagre,$defecto_decolorado,$defecto_mordido,$defecto_brocado,$reposo,$moho,$fermento,$contaminado,
		$calidad)
	{
		 require("conect.php");
		$SQL="CALL SP_lote_upd('".$id."','".$socio."','".$codigo."','".$fecha."','".$peso."','".$humedad."','".$rto_descarte."','".$rto_exportable."','".$defecto_negro."','".$defecto_vinagre."','".$defecto_decolorado."','".$defecto_mordido."','".$defecto_brocado."','".$reposo."','".$moho."','".$fermento."','".$contaminado."','".$calidad."')";
		 $result=mysqli_query($link,$SQL) or die(mysqli_error($link));    
		 global $operaciones_constantes,$tabla_constantes;
    		guarda_historia($_SESSION["user"], $operaciones_constantes["U"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["lotes"], gethostname()); 
    		require("config_disconnect.php"); 	
		
	}
function lote_borrar($id)
	{
		require("conect.php");
		$SQL="CALL SP_lote_del('".$id."')";
		$result=mysqli_query($link,$SQL) or die(mysqli_error($link));
		global $operaciones_constantes,$tabla_constantes;
    		guarda_historia($_SESSION["user"], $operaciones_constantes["D"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["lotes"], gethostname()); 
    		require("config_disconnect.php"); 	
		    	
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
function LotesConsultarCriterio($criterio,$valor){
	require ("conect.php");
	$SQL="CALL SP_lote_cons('".$criterio."','".$valor."','')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	require("config_disconnect.php"); 
	return (transformar_a_lista($resultado));
}
function LotesConsultarid_fecha($valor1,$valor2){
	require ("conect.php");
	$SQL="CALL SP_lote_cons('id_fecha','".$valor1."','".$valor2."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	require("config_disconnect.php"); 
	return (transformar_a_lista($resultado));
}

function LotesConsultarpago($valor,$valor2){
	require ("conect.php");
	$SQL="CALL SP_lote_cons('pago','".$valor."','".$valor2."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	require("config_disconnect.php"); 
	return (transformar_a_lista($resultado));
}

function LotesConsultarfecha($valor1,$valor2){
	require ("conect.php");
	$SQL="CALL SP_lote_cons('fecha','".$valor1."','".$valor2."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	require("config_disconnect.php"); 
	return (transformar_a_lista($resultado));
}

function LotesConsultarpagos($valor){
	require ("conect.php");
	$SQL="CALL SP_lote_cons('pagos','".$valor."','')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	require("config_disconnect.php"); 
	return (transformar_a_lista($resultado));
}
?>