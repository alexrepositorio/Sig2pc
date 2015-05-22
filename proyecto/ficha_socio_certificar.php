<?php
include ("cabecera.php");
include ("certificaciones_funciones.php") ;

if (isset($_POST["anio"]) & isset($_POST["estado"])){
	certificarsocio($_POST["certifica"],$_POST["anio"],$_POST["estado"]);
	echo "<div align=center><h1>CERTIFICANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=historial_certificacion.php?socio=".$_POST["certifica"]."''></font></h1></div>";	
}else{
echo "<div align=center>";
	echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
	echo "<table class=tablas><tr><th colspan=2><h4>Agregar certificacion </th></tr>";
	echo "<input type='hidden' name='certifica' value=".$_GET["socio"].">";
	echo "<tr><th>Año de certificacion:</th><td><input type='number' name='anio' min='1900' max='9999' required></td></tr>";
	echo "<tr><th><h4>Estado</th><td>";
			echo "<select name=estado required>";
			foreach ($certificados as $certificado) {
				echo "<option value='".$certificado[1]."'>".$certificado[0]."</option>";
			}
			echo "</select></td></tr>";
echo "</table><br>";
	echo "</table><br><input type='submit' value='Guardar'>";
	echo "</form>";

}
include("pie.php");
?>