<?php
include ("cabecera.php");
include ("socio.php");
include ("certificaciones_funciones.php");
$socio = consultarCriterio('id',$_GET["socio"]);
if(isset ($_POST["estatus"])){
	certificarsocio($_POST["socio"],$_POST["year"],$_POST["estatus"]);
	echo "<div align=center><h1>GUARDANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=historial_certificacion.php?socio=".$_GET["socio"]."'></font></h1></div>";

}
else{
echo "<div align=center><h1>NUEVA CERTIFICACIÓN PARA ".$socio["nombres"]." ".$socio["apellidos"]."</h1><br>";
//muestra_array($socio);
echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
echo "<table class=tablas>";
echo "<input type='hidden' name='socio' value=".$_GET["socio"].">";
echo "<tr><th><h4>Año</th><td><input type='text' name=year value='".date("Y",time())."'></td></tr>";
echo "<tr><th><h4>Estado</th><td>";
			echo "<select name=estatus>";
			echo "<option value=''>Elige estado</option>";
			echo "<option value='O'>Organico</option>";
			echo "<option value='T1'>Convencional T1</option>";
			echo "<option value='T2'>Convencional T2</option>";
			echo "<option value='T3'>Convencional T3</option>";
			echo "<option value='N'>Nuevo</option>";
			echo "</select></td></tr>";
echo "</table><br>";
echo "<input type='submit' value='Guardar'>";
echo "</form>";
}


include("pie.php");
?>