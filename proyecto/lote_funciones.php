<?php

function lote_insertar($socio,$codigo,$fecha,$peso,$humedad,$rto_descarte,$rto_exportable,$defecto_negro,
		$defecto_vinagre,$defecto_decolorado,$defecto_mordido,$defecto_brocado,$reposo,$moho,$fermento,$contaminado,
		$calidad)
	{
		 require("conect.php");
		$SQL="CALL SP_lote_ins(".$socio.",'".$codigo."','".$fecha."','".$peso."','".$humedad."','".$rto_descarte."','".$rto_exportable."','".$defecto_negro."','".$defecto_vinagre."','".$defecto_decolorado."','".$defecto_mordido."','".$defecto_brocado."','".$reposo."','".$moho."','".$fermento."','".$contaminado."','".$calidad."')";
		 $result=mysqli_query($link,$SQL) or die(mysqli_error($link));    	
	}

function lote_codigo(){

 	require("conect.php");
	$sql_nuevolote="SELECT codigo_lote FROM lotes WHERE date_format(fecha,'%Y') = '".date("Y",time())."'ORDER BY codigo_lote ASC";
$r_nuevolote=mysqli_query($link, $sql_nuevolote);
$cuenta_p=mysqli_num_rows($r_nuevolote);
if($cuenta_p==0){
	$nuevo_lote="APC-00001-".date("y",time());
}
else{
	while ($rowlotes = mysqli_fetch_array($r_nuevolote,MYSQLI_ASSOC)){
//		echo $rowlotes["codigo_lote"]."<br>";
		$lote=$rowlotes["codigo_lote"];
		$lote=str_replace("C-","C",$lote);
		$lote=str_replace("C","C-",$lote);
		$lote=explode ("-",$lote);
//		echo $lote[0]."----".$lote[1]."----".$lote[2]."<br>";
		$numeraciones[]=$lote[1];
	}
//	echo "maximo=".max($numeraciones)."<br>";
	$siguiente=max($numeraciones)+1;
	$nuevo_lote="APC-".str_pad($siguiente,5,"0",STR_PAD_LEFT)."-".date("y",time());
	
}
return ($nuevo_lote);
	
}

function obtenerLotes($socio){
	require ("conect.php");
	$SQL="SELECT * FROM lotes where id_socio=".$socio;
	$resultado=mysqli_query($link,$SQL);
	return (transformar_a_lista($resultado));
}
function obtenerLotesfecha($socio,$fecha){
	require ("conect.php");
	//echo 	$socio."    ".$fecha;
	$SQL="SELECT * FROM lotes where id_socio='".$socio."' and fecha='".$fecha."'";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	return (transformar_a_lista($resultado));
}
function LotesConsultarCriterio($criterio,$valor){
	require ("conect.php");
	//echo 	$socio."    ".$fecha;
	echo $valor;
	$SQL="CALL SP_lote_cons('".$criterio."','".$valor."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	return (transformar_a_lista($resultado));
}

?>