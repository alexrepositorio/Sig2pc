<?php
include ("cabecera.php");
include ("funciones_lotes.php");

if(isset ($_GET["lote"]) AND isset($_GET["borra"]))
{
	$id_lote = $_GET["lote"];
	borrar_lotes_id($id_lote);
	guarda_historial($cadena);
	echo "<div align=center><h1>BORRANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=lotes.php?criterio=socio&socio=".$_GET["socio"]."'></font></h1></div>";
	
}else{
	$id_lote = $_GET["lote"];
	busqueda_lote_id($id_lote);
	
	echo "<div align=center><h1>Borrar el lote</h1><br><h2>".nombre_socio($lote["id_socio"])."<br>".$lote["fecha"]."<br>".$lote["peso"]."kg </h2><br><br>";
	echo "<notif>¿ESTA SEGURO?</notif><br><br>";
	echo "<table class=tablas><tr>";
	echo "<td width=50%><a href=ficha_lote_borrar.php?lote=".$lote["id"]."&borra=1&socio=".$lote["id_socio"]."><notifsi>SI</notifsi></a></td>";
	echo "<td width=50%><a href=socios.php><notifno>NO</notifno></a></td>";
	echo "</tr></table>";
}
include("pie.php");
?>