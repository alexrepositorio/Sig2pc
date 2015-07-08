<?php
include ("cabecera.php");
require("estimaciones_funciones.php");

$resultado_estimaciones=estimacion('listado','');
if (is_array($resultado_estimaciones)) {
	foreach ($resultado_estimaciones as $estimacion) {
		if (!is_null($estimacion["pesosum"])) {
				echo $estimacion["id"]." ".$estimacion["id_socio"]."-".$estimacion["year"]." (".$estimacion["estimados"].")=".$estimacion["entregados"].">>".$estimacion["pesosum"]."<br>";
				estimacion_actualizar($estimacion["pesosum"],$estimacion["id"]);
		}
	}
}
echo "<div align=center><h1>ACTUALIZANDO LOS TOTALES ENTREGADOS, ESPERA... <meta http-equiv='Refresh' content='2;url=socios.php'></font></h1></div>";
include("pie.php");

?>
