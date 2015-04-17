<?php
include ("cabecera.php");

if(isset ($_POST["user"])){
	

$SQL_edit="INSERT INTO usuarios VALUES('',
				'".$_POST["user"]."',
				'".$_POST["pass"]."',
				'".rand(0,9999)."',
				'".$_POST["nivel"]."')";

$resultado=mysqli_query($link, $SQL_edit);
$nuevo_id=mysqli_insert_id($link);


$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);

//echo "$SQL_edit";

echo "<div align=center><h1>GUARDANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=usuarios.php'></font></h1></div>";

//echo "$SQL_edit";
}


else{
	

echo "<div align=center><h1>NUEVO USUARIO</h1><br>";

//muestra_array($socio);

echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
echo "<table class=tablas>";
echo "<tr><th><h4>Usuario</th><td><input type='text' name=user></td></tr>";
echo "<tr><th><h4>Contraseña</th><td><input type='text' name=pass></td></tr>";
echo "<tr><th><h4>Nivel</th><td>";
			echo "<select name=nivel>";
			echo "<option value='1'>Administrador</option>";
			echo "<option value='2'>Contable</option>";
			echo "<option value='3'>Bodeguero</option>";
			echo "<option value='4'>Socio</option>";
			echo "<option value='5'>Catador</option>";
			echo "</select></td></tr>";
echo "</table><br>";

echo "<input type='submit' value='Guardar'>";
echo "</form>";
}


include("pie.php");
?>