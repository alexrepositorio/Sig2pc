<?php
include ("cabecera.php");
echo "<div align=center><table class=tablas><tr><td align=center><img src=historial_estimacion_grafica.php?socio=".$_GET["socio"].">";
echo "<br><br></td></tr></table><br>";

echo "<div align=center><a href='historial_estimacion.php?socio=".$_GET["socio"]."'>Volver a la ficha</a><br><br>";


include("pie.php");

?>
