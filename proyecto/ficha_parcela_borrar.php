<?php
include ("cabecera.php");



if(isset($_GET["parcela"]) AND isset($_GET["borra"])){
	
$SQL_edit="DELETE FROM parcelas WHERE id='".$_GET["borra"]."'";
$resultado=mysqli_query($link, $SQL_edit);

$SQL_edit2="DELETE FROM subparcelas WHERE id_parcela='".$_GET["borra"]."'";
$resultado2=mysqli_query($link, $SQL_edit2);

$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);
$cadena2=str_replace("'", "", $SQL_edit2);
guarda_historial($cadena2);
//echo "$SQL_edit";

echo "<div align=center><h1>BORRANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=parcelas.php'></font></h1></div>";
	
}


else{
	


//muestra_array($socio);
$SQL="SELECT * FROM parcelas where id='".$_GET["parcela"]."'";
$resultado=mysqli_query($link, $SQL);
$lote = mysqli_fetch_array($resultado,MYSQLI_ASSOC);

echo "<div align=center><h1>Borrar la parcela</h1><br><h2>".$lote["sup_total"]."<br>".$lote["id_socio"]."<br>¡Esta acción borrará las subparcelas correspondientes!</h2><br><br>";

echo "<notif>¿ESTA SEGURO?</notif><br><br>";

echo "<table class=tablas><tr>";
echo "<td width=50%><a href=ficha_parcela_borrar.php?parcela=".$_GET["parcela"]."&borra=".$_GET["parcela"]."><notifsi>SI</notifsi></a></td>";
echo "<td width=50%><a href=parcelas.php><notifno>NO</notifno></a></td>";
echo "</tr></table>";

}
include("pie.php");
?>