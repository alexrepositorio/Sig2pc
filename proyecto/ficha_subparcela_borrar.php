<?php
include ("cabecera.php");



if(isset($_GET["subparcela"]) AND isset($_GET["borra"])){
	

$SQL_edit="DELETE FROM subparcelas WHERE id=".$_GET["borra"];
$resultado=mysqli_query($link, $SQL_edit);

$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);
//echo "$SQL_edit";

echo "<div align=center><h1>BORRANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=ficha_parcela.php?parcela=".$_GET["parcela"]."'></font></h1></div>";
	
}


else{
	


//muestra_array($socio);
$SQL="SELECT * FROM subparcelas where id='".$_GET["subparcela"]."'";
$resultado=mysqli_query($link, $SQL);
$lote = mysqli_fetch_array($resultado,MYSQLI_ASSOC);

echo "<div align=center><h1>Borrar la subparcela ".$_GET["subparcela"]."</h1><br><h2>".$lote["superficie"]." ha <br> de la parcela ".$lote["id_parcela"]."<br></h2><br><br>";

echo "<notif>¿ESTA SEGURO?</notif><br><br>";

echo "<table class=tablas><tr>";
echo "<td width=50%><a href=ficha_subparcela_borrar.php?subparcela=".$_GET["subparcela"]."&borra=".$_GET["subparcela"]."&parcela=".$_GET["parcela"]."><notifsi>SI</notifsi></a></td>";
echo "<td width=50%><a href=ficha_parcela.php?parcela=".$_GET["parcela"]."><notifno>NO</notifno></a></td>";
echo "</tr></table>";

}
include("pie.php");
?>