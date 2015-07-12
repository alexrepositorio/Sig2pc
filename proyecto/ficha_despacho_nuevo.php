<?php
include ("cabecera.php");
include ("envios_funciones.php");
if(isset ($_POST["lote"])){
	
	if($_POST["cantidad"]>$_POST["restante"]){
		echo "<div align=center><notif>no es posible despachar esa cantidad <br>
		pues sólo quedan ".$_POST["restante"]."qq</notif><br><br><br>
		<a href=ficha_despacho_nuevo.php?lote=".$_POST["lote"]."&restante=".$_POST["restante"]."><h2>VOLVER</h2></a></div><br>";
	}else{
		insertar_despacho($_POST["lote"],$_POST["fecha"],$_POST["cantidad"],$_POST["envio"]);
		echo "<div align=center><h1>GUARDANDO, ESPERA...
		<meta http-equiv='Refresh' content='2;url=envios.php'></font></h1></div>";
		}
}else{	
	echo "<div align=center><h1>NUEVO DESPACHO DEL LOTE ".$_GET["lote"]."</h1><br>";
	echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
	echo "<table class=tablas>";
	echo "<tr><th><h4>Fecha</th><td><input type='text' name=fecha value='".date("Y-m-d H:i:s",time())."'></td></tr>";
	echo "<tr><th><h4>Cantidad</th><td><input type='number' name=cantidad  step='0.01' max='round(".$_GET["restante"].",2)'>qq<br>*max.".round($_GET["restante"],2)."qq</td></tr>";
	echo "<tr><th align=right><h4>Envío</h4><br>
	<br><a href=ficha_envio_nuevo.php>*nuevo envío</a></th><td><select name=envio>";
	$r_envios=busquedas('','');
	$r_envios=$r_envios[0];
	while ($rowenvio = mysqli_fetch_array($r_envios,MYSQLI_ASSOC)) {
		$envio_n=date("d-m-Y",strtotime($rowenvio["fecha"]))." a ".$rowenvio["destino"];
		$envio_codigo=$rowenvio["id"];
		echo "<option value='".$envio_codigo."'>$envio_n</option>";
	}
	echo "</select></td></tr>";
	echo "</table><br>";
	echo "<input type='hidden' name=lote value='".$_GET["lote"]."'>";
	echo "<input type='hidden' name=restante value='".$_GET["restante"]."'>";
	echo "<input type='submit' value='Guardar'>";
	echo "</form>";
}
include("pie.php");
?>