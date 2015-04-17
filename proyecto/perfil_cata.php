<?php
include ("cabecera.php");
echo "<div align=center><h1>CATA DEL LOTE ".$_GET["lote"]."</h1><br>";
echo "<img src=ficha_cata_perfil.php?lote=".$_GET["lote"].">";
echo "<br><br></div><br>";

echo "<div align=center><a href='ficha_cata.php?lote=".$_GET["lote"]."'>Volver a la ficha</a><br><br>";


include("pie.php");

?>
