<?php
include("cabecera.php");
//$id_historial=$_GET["id_historial"];
include('SimpleImage.php');
	
//la grande
$nombre_archivo = "fotos/".$_GET["borrar"];
$nombre_archivo_p = "fotos/th/small_".$_GET["borrar"];
unlink($nombre_archivo);
unlink($nombre_archivo_p);
			echo "<div align=center><h1><font color=red size=6>BORRANDO, ESPERA...<meta http-equiv='Refresh' content='1;url=galery2.php?socio=".$_GET["socio"]."'></font></h1></div><br><br>";

include("pie.php");
?>