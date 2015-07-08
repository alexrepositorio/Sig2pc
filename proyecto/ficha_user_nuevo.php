<?php
include ("cabecera.php");
include ("users_funciones.php") ;

if(isset ($_POST["user"])){
	

insertar_Usuarios($_POST["user"],$_POST["pass"],$_POST["nivel"],$_POST["nombre"]);
//recordar que la cadenda sql tiene  que ir a la taba acciones
echo "<div align=center><h1>GUARDANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=users.php'></font></h1></div>";
}else{
echo "<div align=center><h1>NUEVO USUARIO</h1><br>";
echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
echo "<table class=tablas>";
echo "<tr><th><h4>Usuario</th><td><input type='text' name=user></td></tr>";
echo "<tr><th><h4>Contraseña</th><td><input type='password' name=pass></td></tr>";

echo "<tr><th><h4>Nivel</th><td>";
echo "<input list='niveles' name='nivel'>";	
echo "<datalist  id='niveles'>";	
 $niveless=listar_niveles();
 foreach ($niveless as $niveles)
	{
		echo "<option>".$niveles["nivel"]."</option>";
	}
echo "</datalist></td></tr>";
////////////////////////////////////////CORREGIR echo "<input list='niveles' name='nivel'>";	
echo "<tr><th><h4>Nombres</th><td>";
echo "<select name=nombre required>";
			echo "<option value=''>Verifique que sus nombres esten en la base</option>";
  	 $nombress=obtenerNombres();
 foreach ($nombress as $nombre)
	{
		echo "<option value='$localidad'>".$nombre["nombres"]." ".$nombre["apellidos"]."</option>";
	}
echo "</select></td></tr>";
echo "</table><br>";
echo "<input type='submit' value='Guardar'>";
echo "</form>";
}
include("pie.php");
?>