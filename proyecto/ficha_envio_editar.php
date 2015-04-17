<?php
include ("cabecera.php");

$SQL="SELECT * FROM envios WHERE id='".$_GET["envio"]."' order by fecha desc";
$resultado=mysqli_query($link, $SQL);
$cuenta=mysqli_num_rows($resultado);
$envio = mysqli_fetch_array($resultado,MYSQLI_ASSOC);


if(isset ($_POST["fecha"])){
	

$SQL_edit="UPDATE envios SET
				fecha='".$_POST["fecha"]."',
				destino='".$_POST["destino"]."',
				chofer='".$_POST["chofer"]."',
				responsable='".$_POST["responsable"]."'
				WHERE id='".$_GET["envio"]."'";

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
	

echo "<div align=center><h1>EDITAR ENVIO</h1><br>";

//muestra_array($socio);

echo "<form name=form action=".$_SERVER['PHP_SELF']."?envio=".$_GET["envio"]." method='post'>";
echo "<table class=tablas>";
echo "<tr><th><h4>Fecha</th><td><input type='text' name=fecha value='".$envio["fecha"]."'></td></tr>";
echo "<tr><th><h4>Destino</th><td><input type='text' name=destino value='".$envio["destino"]."'></td></tr>";
echo "<tr><th><h4>Chófer</th><td><input type='text' name=chofer value='".$envio["chofer"]."'></td></tr>";
echo "<tr><th><h4>Responsable</th><td><input type='text' name=responsable value='".$envio["responsable"]."'></td></tr>";
echo "</table><br>";

echo "<input type='submit' value='Guardar'>";
echo "</form>";
}


include("pie.php");
?>