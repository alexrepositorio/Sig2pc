<?php
	include ("cabecera.php");
	include ("envios_funciones.php");
	$criterio='editar';
	//funcion
	@list($resultado,$cuenta,$envio)=editar_envio_presentar($_GET["envio"],$criterio);
	if(isset ($_POST["fecha"])){
		//FUNCION
		list($resultado,$nuevo_id,$cadena)=editar_envio_actualizar($_POST["fecha"],$_POST["destino"],$_POST["chofer"],$_POST["responsable"],$_POST["envio"]);
		echo "<div align=center><h1>GUARDANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=envios.php'></font></h1></div>";
	}else{
		echo "<div align=center><h1>EDITAR ENVIO</h1><br>";
		echo "<form name=form action=".$_SERVER['PHP_SELF']."?envio=".$_GET["envio"]." method='post'>";
		echo "<table class=tablas>";
		echo "<tr><th><h4></th><td><input type='hidden' name=envio value='".$_GET["envio"]."'></td></tr>";
		echo "<tr><th><h4>Fecha</th><td><input type='date' name=fecha value='".$envio["fecha"]."'></td></tr>";
		echo "<tr><th><h4>Destino</th><td><input type='text' name=destino value='".$envio["destino"]."'></td></tr>";
		echo "<tr><th><h4>Chófer</th><td><input type='text' name=chofer value='".$envio["chofer"]."'></td></tr>";
		echo "<tr><th><h4>Responsable</th><td><input type='text' name=responsable value='".$envio["responsable"]."'></td></tr>";
		echo "</table><br>";

		echo "<input type='submit' value='Guardar'>";
		echo "</form>";
	}
	include("pie.php");
?>