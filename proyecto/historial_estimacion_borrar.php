<?php
include ("cabecera.php");

if(isset($_GET["borra"])){
	
$SQL_edit="DELETE FROM estimacion WHERE id='".$_GET["borra"]."'";
$resultado=mysqli_query($link, $SQL_edit);

$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);
//echo "$SQL_edit";

echo "<div align=center><h1>BORRANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=historial_estimacion.php?socio=".$_GET["socio"]."'></font></h1></div>";
	
}


else{
	

//muestra_array($socio);
$SQL="SELECT * FROM socios where id_socio='".$_GET["socio"]."'";
$resultado=mysqli_query($link, $SQL);
$socio = mysqli_fetch_array($resultado,MYSQLI_ASSOC);

echo "<div align=center><h1>Borrar la estimacion del usuario</h1><br><h2>".$socio["nombres"]." ".$socio["apellidos"]."<br><br>";

echo "<notif>¿ESTA SEGURO?</notif><br><br>";

echo "<table class=tablas><tr>";
echo "<td width=50%><a href=historial_estimacion_borrar.php?borra=".$_GET["id"]."&socio=".$_GET["socio"]."><notifsi>SI</notifsi></a></td>";
echo "<td width=50%><a href=historial_estimacion.php?socio=".$_GET["socio"]."><notifno>NO</notifno></a></td>";
echo "</tr></table>";

}
include("pie.php");
?>