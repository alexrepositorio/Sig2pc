<?php
include ("cabecera.php");
include ("users_funciones.php") ;

if(isset ($_POST["update"])){
	actualizaruser($_POST["update"],$_POST["user"],$_POST["pass"],$_POST["nivel"]);
	echo "<div align=center><h1>ACTUALIZANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=users.php?user=".$_POST["update"]."'></font></h1></div>";
}
else{

echo "<div align=center><h1>EDITAR USUARIO</h1><br>";

echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
echo "<table class=tablas>";
	echo "<input type='hidden' name='update' value=".$_GET["user"].">";
	echo "<tr><th><h4>Usuario</th><td><input type='text' name=user value=''></td></tr>";
	echo "<tr><th><h4>Contraseña</th><td><input type='text' name=pass value=''></td></tr>";
	echo "<tr><th><h4>Nivel</th><td>";
		echo "<input list='niveles' name='nivel'>";	
		echo "<datalist  id='niveles'>";	
 			$niveless=listar_niveles();

 			foreach ($niveless as $niveles)
			{
				echo "<option>".$niveles["nivel"]."</option>";
			}
		echo "</datalist></td></tr>";
echo "</table><br>";
echo "<input type='submit' value='Actualizar'>";
echo "</form>";
}
include("pie.php");
?>