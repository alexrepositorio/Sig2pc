<?php
include ("cabecera.php");
include ("users_funciones.php");

if(isset ($_GET["id"]) ){
	borrarUsuarios($_GET["id"],'bajas');
	echo "<div align=center><h1>BORRANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=users.php'></font></h1></div>";
}
else{
echo "<div align=center><h1>BORRAR USUARIO</h1><br>";
	echo "<table class=tablas>";
		echo "<tr><th><h4></th><td><input type='hidden' name=id value='".$_GET["id"]."'></td></tr>";
	echo "</table><br>";
}
include("pie.php");
?>