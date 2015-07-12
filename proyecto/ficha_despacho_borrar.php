<?php
include ("cabecera.php");

if(isset ($_GET["despacho"]) AND isset($_GET["borra"])){	
	eliminar_despacho($_GET["borra"]);
	echo "<div align=center><h1>BORRANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=almacen.php'></font></h1></div>";
}else{
	$resultado=despachos_consultar_criterio('id',$_GET["despacho"]);
	$lote = $resultado[0];
	echo "<div align=center><h1>Borrar el despacho del lote ".$_GET["lote"]."</h1><br><br>";
	echo "<notif>¿ESTA SEGURO?</notif><br><br>";
	echo "<table class=tablas><tr>";
	echo "<td width=50%><a href=ficha_despacho_borrar.php?despacho=".$_GET["despacho"]."&borra=".$_GET["despacho"]."><notifsi>SI</notifsi></a></td>";
	echo "<td width=50%><a href=almacen.php><notifno>NO</notifno></a></td>";
	echo "</tr></table>";
}
include("pie.php");
?>