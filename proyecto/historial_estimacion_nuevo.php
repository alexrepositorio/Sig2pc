<?php
include ("cabecera.php");
include ("socio_funciones.php");
include ("altas_funciones.php");
include ("estimaciones_funciones.php");
if(isset ($_POST["estimados"])){	
	insertarestimacion($_POST["socio"],$_POST["fecha"],$_POST["estimados"],$_POST["entregados"]);
echo "<div align=center><h1>GUARDANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=historial_estimacion.php?socio=".$_POST["socio"]."'></font></h1></div>";
}
else{
$socio=consultarCriterio('id',$_GET["socio"]);	
$socio=$socio[0];
echo "<div align=center><h1>NUEVA ESTIMACION PARA ".$socio["nombres"]." ".$socio["apellidos"]."</h1><br>";
//muestra_array($socio);
echo "<form name=form action=".$_SERVER['PHP_SELF']."?socio=".$_GET["socio"]." method='post'>";
echo "<table class=tablas>";
echo "<tr><th>Año de Estimacion:</th><td><input type='number' name='fecha' min='1900' max='9999' required></td></tr>";
echo "<tr><th align=right><h4>Estimados</th><td><input type='number'  min='0' step='0.01'  max='9999' name='estimados'>qq</td></tr>";
echo "<tr><th align=right><h4>Entregados</th><td><input type='number' min='0' step='0.01'  max='9999' name='entregados'>qq</td></tr>";
echo "</table><br>";
echo "<input type='hidden' name=socio value='".$_GET["socio"]."'>";
echo "<input type='submit' value='Guardar'>";
echo "</form>";
}

include("pie.php");
?>