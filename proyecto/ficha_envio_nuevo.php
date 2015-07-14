<?php
	include ("cabecera.php");
	include ("envios_funciones.php");

	if(isset ($_POST["destino"])){
		list($resultado, $nuevo_id)=ingresar_nuevo_envio($_POST["fecha"],$_POST["destino"],$_POST["chofer"],$_POST["responsable"]);
		echo "<div align=center><h1>GUARDANDO, ESPERA...
		<meta http-equiv='Refresh' content='2;url=envios.php'></font></h1></div>";
	}else{	
		echo "<div align=center><h1>NUEVO ENVIO</h1><br>";

		echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
		echo "<table class=tablas>";
			echo "<tr><th><h4>Fecha</th><td><input type='date' name=fecha value='".date('Y-m-d', time())."'  ></td></tr>";
			echo "<tr><th><h4>Destino</th><td><input type='text' name=destino></td></tr>";
			echo "<tr><th><h4>Chófer</th><td><input type='text' name=chofer></td></tr>";
			echo "<tr><th><h4>Responsable</th><td><input type='text' name=responsable></td></tr>";
			echo "</table><br>";
		echo "<input type='submit' value='Guardar'>";
		echo "</form>";
	}
	include("pie.php");
?>