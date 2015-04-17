<?php
include ("cabecera.php");

$sql="SELECT * FROM analisis WHERE id_subparcela=".$_GET["subparcela"];
$resultado=mysqli_query($link, $sql);



echo "<div align=center><table class=tablas><tr><th colspan=2><h3>Lista de análisis de la subparcela ".$_GET["subparcela"]."</h3></th></tr>";

while($datos = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){

echo "<tr><td align=center><a href=ficha_analisis.php?id_analisis=".$datos["id_analisis"]."&parcela=".$_GET["parcela"]."><h4>".date("d-m-Y",strtotime($datos["fecha"]))."</h4></a></td>";
echo "<td><a href=ficha_analisis_editar.php?analisis=".$datos["id_analisis"]."&parcela=".$_GET["parcela"]."><img src=images/pencil.png></a>";
echo "<a href=ficha_analisis_borrar.php?analisis=".$datos["id_analisis"]."&parcela=".$_GET["parcela"]."><img src=images/cross.png></a>";
echo "</td></tr>";
}
echo"</table><br>";

echo "<a href=ficha_parcela.php?parcela=".$_GET["parcela"]."><button class=boton>volver</button></a></div>";
echo "</div>";

include("pie.php");

?>