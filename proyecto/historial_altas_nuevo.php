<?php
include ("cabecera.php");
include ("socio_funciones.php");
include ("altas_funciones.php");


if(isset ($_POST["estado"])){
	insertaraltas($_POST["socio"],$_POST["fecha"],$_POST["estado"]);
	echo "<div align=center><h1>GUARDANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=historial_altas.php?socio=".$_POST["socio"]."'></font></h1></div>";
}
else{
	$socio=consultarCriterio('id',$_GET["socio"]);
	$socio=$socio[0];
	echo "<div align=center><h1>NUEVO ESTADO PARA ".$socio["nombres"]." ".$socio["apellidos"]."</h1><br>";
	echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
	echo "<table class=tablas>";
	echo "<input type='hidden' name='socio' value=".$_GET["socio"].">";
	echo "<tr><th><h4>Fecha</th><td><input type='date' name=fecha value='".$fecha."'></td></tr>";
	echo "<tr><th><h4>Estado</th><td>";
				echo "<select name=estado>";
				foreach ($altas_estados as $estado) {
					echo "<option value='".$estado."'>".$estado."</option>";
				}
				echo "</select></td></tr>";
	echo "</table><br>";
	echo "<input type='submit' value='Guardar'>";
	echo "</form>";
}
include("pie.php");
?>