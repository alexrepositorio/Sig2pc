<?php
include ("cabecera.php");
$SQL="SELECT * FROM socios where id_socio=".$_GET["socio"];
$resultado=mysqli_query($link, $SQL);
$socio = mysqli_fetch_array($resultado,MYSQLI_ASSOC);



if(isset ($_GET["socio"]) AND isset($_GET["borra"])){
	
$SQL_edit="DELETE FROM socios WHERE id_socio=".$_GET["socio"];
$resultado=mysqli_query($link, $SQL_edit);

$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);
//echo "$SQL_edit";

echo "<div align=center><h1>BORRANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=socios.php'></font></h1></div>";
	
}


else{
	


//muestra_array($socio);
echo "<div align=center><h1>Borrar la Ficha del socio</h1><br><h2>".$socio["nombres"]." ".$socio["apellidos"]."</h2><br><br>";

echo "<notif>¿ESTA SEGURO?</notif><br><br>";

echo "<table class=tablas><tr>";
echo "<td width=50%><a href=ficha_socio_borrar.php?socio=".$socio["id_socio"]."&borra=1><notifsi>SI</notifsi></a></td>";
echo "<td width=50%><a href=socios.php><notifno>NO</notifno></a></td>";
echo "</tr></table>";

}

include("pie.php");
?>