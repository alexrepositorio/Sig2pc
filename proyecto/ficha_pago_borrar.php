<?php
include ("cabecera.php");

if(isset ($_GET["pago"]) AND isset($_GET["borra"])){
	borrar_pago($_GET["pago"]);
	echo "<div align=center><h1>BORRANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=pagos.php'></font></h1></div>";
}


else{

echo "<div align=center><h1>Borrar el pago del lote <br>".$_GET["codigo"]."</h1><br><br>";

echo "<notif>¿ESTA SEGURO?</notif><br><br>";

echo "<table class=tablas><tr>";
echo "<td width=50%><a href=ficha_pago_borrar.php?pago=".$_GET["pago"]."&borra=1><notifsi>SI</notifsi></a></td>";
echo "<td width=50%><a href=pagos.php><notifno>NO</notifno></a></td>";
echo "</tr></table>";

}
include("pie.php");
?>