<?php
include ("cabecera.php");
include ("conect.php");
include ("configuracion_funciones.php");
include ("certificaciones_funciones.php");
include ("estimaciones_funciones.php");

		$pago1 = busqueda_pagos("lote",$_GET["lote"]);
		$cuenta = count($pago1);

		if($cuenta==0){
			$pago["exportable"]="<h4><font color=red>Pendiente</font></h4>";
			$pago["descarte"]="<h4><font color=red>Pendiente</font></h4>";
			$pago["calidad"]="<h4><font color=red>Pendiente</font></h4>";
			$total="<h4><font color=red>Pendiente</font></h4>";}
		else{
			$pago = busqueda_pagos("lote",$_GET["lote"]);
			$total = $pago[0]["exportable"]+$pago[0]["descarte"]+$pago[0]["calidad"];
		}

		$lote = LotesConsultarCriterio("id", $_GET["lote"]);
		$lote=$lote[0];
		$pilado = round((($lote["peso"]*(1-($lote["humedad"])/100))/0.88)*($lote["rto_pilado"])/100,2);
		$exportable = round($pilado*($lote["rto_exportable"]/100),2);
		$descarte = round($pilado-$exportable,2);

		if($lote["apto_cata"]==0){
			$cata["puntuacion"]="NO APTO";
			$input_q="NO APTO<input type='hidden' name=calidad value='0'>";}
		else{
			$cata1 = busqueda_catas($_GET["lote"]);

			if(empty($cata1)){
				$cata["puntuacion"]="PEND";
				$input_q="PENDIENTE DE CATA<input type='hidden' name=calidad value='0'>";
			}
			else{
				$cata = busqueda_catas($_GET["lote"]);
				$input_q="$<input type='text' name=calidad value='".$pago[0]["calidad"]."'>";
				if($cata["puntuacion"]<=84){
					$input_q="NO APTO<input type='hidden' name=calidad value='0'>";
				}
			}
		}


if(isset ($_POST["calidad"])){

	actualizar_calidad($_POST["calidad"], $_GET["lote"]);

	//echo "$SQL_edit";
	//para el historial
	// $cadena=str_replace("'", "", $SQL_edit);
	// guarda_historial($cadena);


	echo "<div align=center><h1>GUARDANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=pagos.php'></font></h1></div>";
	
}


else{
	

echo "<div align=center><h1>AÑADIR PAGO POR CALIDAD</h1><br>";

//muestra_array($socio);

echo "<form name=form action=".$_SERVER['PHP_SELF']."?lote=".$_GET["lote"]." method='post'>";
echo "<table class=tablas>";
echo "<tr><th><h4>Lote</th><td colspan=2><h4>".$lote["codigo_lote"]."</td></tr>";
echo "<tr><th><h4>Fecha</th><td colspan=2>".$pago[0]["fecha"]."</td></tr>";
echo "<tr><th><h4>Exportable</th><td>$exportable qq</td><td>$".$pago[0]["exportable"]."</td></tr>";
echo "<tr><th><h4>Descarte</th><td>$descarte qq</td><td>$".$pago[0]["descarte"]."</td></tr>";
echo "<tr><th><h4>Extra por calidad</th><td>".$cata["puntuacion"]."</td><td>$input_q</td></tr>";
echo "</table><br>";
echo "<input type='hidden' name=codigo_lote value='".$_GET["lote"]."'>";
echo "<input type='submit' value='Actualizar'>";
echo "</form>";
}

include("pie.php");
?>