<?php
include ("cabecera.php");



if(isset ($_GET["despacho"]) AND isset($_GET["borra"])){
	
$SQL_edit="DELETE FROM despachos WHERE id='".$_GET["borra"]."'";
$resultado=mysqli_query($link, $SQL_edit);

$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);
//echo "$SQL_edit";

echo "<div align=center><h1>BORRANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=almacen.php'></font></h1></div>";
	
}


else{
	


//muestra_array($socio);
$SQL="SELECT * FROM despachos where id='".$_GET["despacho"]."'";
$resultado=mysqli_query($link, $SQL);
$lote = mysqli_fetch_array($resultado,MYSQLI_ASSOC);

echo "<div align=center><h1>Borrar el despacho del lote ".$_GET["lote"]."</h1><br><br>";

echo "<notif>¿ESTA SEGURO?</notif><br><br>";

echo "<table class=tablas><tr>";
echo "<td width=50%><a href=ficha_despacho_borrar.php?despacho=".$_GET["despacho"]."&borra=".$_GET["despacho"]."><notifsi>SI</notifsi></a></td>";
echo "<td width=50%><a href=almacen.php><notifno>NO</notifno></a></td>";
echo "</tr></table>";

}
include("pie.php");
?>