<?php
include ("cabecera.php");

$SQL="SELECT * FROM socios where codigo='".$_GET["socio"]."'";
$resultado=mysqli_query($link, $SQL);
$socio = mysqli_fetch_array($resultado,MYSQLI_ASSOC);



if(isset ($_POST["estatus"])){
	

$SQL_edit="INSERT INTO certificacion VALUES('',
				'".$_POST["cod_socio"]."',
				'".$_POST["year"]."',
				'".$_POST["estatus"]."')";

$resultado=mysqli_query($link, $SQL_edit);
$nuevo_id=mysqli_insert_id($link);


$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);

//echo "$SQL_edit";

echo "<div align=center><h1>GUARDANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=historial_certificacion.php?socio=".$_GET["socio"]."'></font></h1></div>";

//echo "$SQL_edit";
}


else{
	

echo "<div align=center><h1>NUEVA CERTIFICACIÓN PARA ".$socio["nombres"]." ".$socio["apellidos"]."</h1><br>";

//muestra_array($socio);

echo "<form name=form action=".$_SERVER['PHP_SELF']."?socio=".$_GET["socio"]." method='post'>";
echo "<table class=tablas>";
echo "<tr><th><h4>Usuario</th><td><h4>".$socio["codigo"]."</td></tr>";
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
echo "<input type='hidden' name=cod_socio value='".$socio["codigo"]."'>";
echo "<input type='submit' value='Guardar'>";
echo "</form>";
}


include("pie.php");
?>