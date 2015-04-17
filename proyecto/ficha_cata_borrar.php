<?php
include ("cabecera.php");



if(isset ($_GET["cata"]) AND isset($_GET["borra"])){
	
$SQL_edit="DELETE FROM catas WHERE lote='".$_GET["borra"]."'";
$resultado=mysqli_query($link, $SQL_edit);

$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);
//echo "$SQL_edit";

echo "<div align=center><h1>BORRANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=catas.php'></font></h1></div>";
	
}


else{
	


//muestra_array($socio);
$SQL="SELECT * FROM catas where lote='".$_GET["cata"]."'";
$resultado=mysqli_query($link, $SQL);
$lote = mysqli_fetch_array($resultado,MYSQLI_ASSOC);

echo "<div align=center><h1>Borrar la cata del lote</h1><br><h2>".$lote["lote"]."<br>".$lote["fecha"]."<br><br><h3>resultado de la cata: ".$lote["puntuacion"]." puntos</h2><br><br>";

echo "<notif>¿ESTA SEGURO?</notif><br><br>";

echo "<table class=tablas><tr>";
echo "<td width=50%><a href=ficha_cata_borrar.php?cata=".$_GET["cata"]."&borra=".$_GET["cata"]."><notifsi>SI</notifsi></a></td>";
echo "<td width=50%><a href=catas.php><notifno>NO</notifno></a></td>";
echo "</tr></table>";

}
include("pie.php");
?>