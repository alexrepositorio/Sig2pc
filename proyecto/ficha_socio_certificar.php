<?php
include ("cabecera.php");
include ("socio.php") ;

if (isset($_POST["anio"]) & isset($_POST["estado"])){
	certificarsocio($_POST["certifica"],$_POST["anio"],$_POST["estado"]);
	echo $_POST["certifica"];

echo "<div align=center><h1>CERTIFICANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=socios.php'></font></h1></div>";	
}else{
echo "<div align=center>";
	echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
	echo "<table class=tablas><tr><th colspan=2><h4>Agregar certificacion </th></tr>";
	echo "<input type='hidden' name='certifica' value=".$_GET["socio"].">";
	echo "<tr><th>Año de certificacion:</th><td><input type='date' name=anio required></td></tr>";
	echo "<tr><th>Estado:</th><td><input type='text' name=estado required></td></tr>";
	echo "</table><br><input type='submit' value='Guardar'>";
	echo "</form>";

}
include("pie.php");
?>