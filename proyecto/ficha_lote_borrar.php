<?php
include ("cabecera.php");
include ("socio_funciones.php");

if(isset ($_GET["lote"]) AND isset($_GET["borra"]))
{
	lote_borrar($_GET["lote"]);
	echo "<div align=center><h1>BORRANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=lotes.php?criterio=socio&socio=".$_GET["socio"]."'></font></h1></div>";
}else{
	$lote=LotesConsultarCriterio('id',$_GET["lote"]);
	$lote=$lote[0];
	$socio=consultarCriterio('id',$lote["id_socio"]);
	$socio=$socio[0];
	echo "<div align=center><h1>Borrar el lote</h1><br><h2>".$socio["nombres"]."  ".$socio["apellidos"]."<br>".$lote["fecha"]."<br>".$lote["peso"]."kg </h2><br><br>";
	echo "<notif>¿ESTA SEGURO?</notif><br><br>";
	echo "<table class=tablas><tr>";
	echo "<td width=50%><a href=ficha_lote_borrar.php?lote=".$lote["id"]."&borra=1&socio=".$lote["id_socio"]."><notifsi>SI</notifsi></a></td>";
	echo "<td width=50%><a href=socios.php><notifno>NO</notifno></a></td>";
	echo "</tr></table>";
}
include("pie.php");
?>