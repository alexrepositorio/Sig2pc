<?php
include ("cabecera.php");



if(isset($_GET["analisis"]) AND isset($_GET["borra"])){
	
$SQL_edit="DELETE FROM analisis WHERE id_analisis='".$_GET["borra"]."'";
$resultado=mysqli_query($link, $SQL_edit);

$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);
//echo "$SQL_edit";

echo "<div align=center><h1>BORRANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=analisis.php?subparcela=".$_GET["subparcela"]."&parcela=".$_GET["parcela"]."'></font></h1></div>";
	
}


else{
	


//muestra_array($socio);
$SQL="SELECT * FROM analisis where id_analisis='".$_GET["analisis"]."'";
$resultado=mysqli_query($link, $SQL);
$lote = mysqli_fetch_array($resultado,MYSQLI_ASSOC);

echo "<div align=center><h1>Borrar el analisis</h1><br><h2>".$lote["fecha"]."<br>subparcela #".$lote["id_subparcela"]."<br><br><br>";

echo "<notif>¿ESTA SEGURO?</notif><br><br>";

echo "<table class=tablas><tr>";
echo "<td width=50%><a href=ficha_analisis_borrar.php?analisis=".$_GET["analisis"]."&borra=".$_GET["analisis"]."&subparcela=".$lote["id_subparcela"]."&parcela=".$_GET["parcela"]."><notifsi>SI</notifsi></a></td>";
echo "<td width=50%><a href=analisis.php?subparcela=".$lote["id_subparcela"]."&parcela=".$_GET["parcela"]."><notifno>NO</notifno></a></td>";
echo "</tr></table>";

}
include("pie.php");
?>