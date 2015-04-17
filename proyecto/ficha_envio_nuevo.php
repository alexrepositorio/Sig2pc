<?php
include ("cabecera.php");

if(isset ($_POST["fecha"])){
	

$SQL_edit="INSERT INTO envios VALUES('',
				'".$_POST["fecha"]."',
				'".$_POST["destino"]."',
				'".$_POST["chofer"]."',
				'".$_POST["responsable"]."')";

$resultado=mysqli_query($link, $SQL_edit);
$nuevo_id=mysqli_insert_id($link);


$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);

//echo "$SQL_edit";

echo "<div align=center><h1>GUARDANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=envios.php'></font></h1></div>";

//echo "$SQL_edit";
}


else{
	

echo "<div align=center><h1>NUEVO ENVIO</h1><br>";

//muestra_array($socio);

echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
echo "<table class=tablas>";
echo "<tr><th><h4>Fecha</th><td><input type='text' name=fecha value='".date("Y-m-d H:i:s",time())."'></td></tr>";
echo "<tr><th><h4>Destino</th><td><input type='text' name=destino></td></tr>";
echo "<tr><th><h4>Chófer</th><td><input type='text' name=chofer></td></tr>";
echo "<tr><th><h4>Responsable</th><td><input type='text' name=responsable></td></tr>";
echo "</table><br>";

echo "<input type='submit' value='Guardar'>";
echo "</form>";
}


include("pie.php");
?>