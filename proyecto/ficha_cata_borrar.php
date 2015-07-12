<?php
include ("cabecera.php");
include ("catas_funciones.php");


if( isset($_GET["borra"])){
catas_del($_GET["borra"]);
//echo "$SQL_edit";

echo "<div align=center><h1>BORRANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=catas.php'></font></h1></div>";
	
}


else{
//muestra_array(socio);
$resultado=LotesConsultarCriterio('id',$_GET["lote"]);
$lote=$resultado[0];

$cata=catas_consultar("lote",$_GET["lote"]);
$cata=$cata[0];

echo "<div align=center><h1>Borrar la cata del lote</h1><br><h2>".$lote["codigo_lote"]."<br>".$lote["fecha"]."<br><br><h3>resultado de la cata: ".$cata["puntuacion"]." puntos</h2><br><br>";

echo "<notif>¿ESTA SEGURO?</notif><br><br>";

echo "<table class=tablas><tr>";
echo "<td width=50%><a href=ficha_cata_borrar.php?cata=".$_GET["lote"]."&borra=".$cata["id"]."><notifsi>SI</notifsi></a></td>";
echo "<td width=50%><a href=catas.php><notifno>NO</notifno></a></td>";
echo "</tr></table>";

}
include("pie.php");
?>