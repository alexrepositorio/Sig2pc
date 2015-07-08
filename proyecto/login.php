<?php
include("cabecera_login.php");
include("users_funciones.php");
if (isset($_POST["user"]) AND isset($_POST["pass"])) {
	validar();
} 
else{
	
}
echo "<br><br><div align=center><h2>¡Bienvenido!</h2><br><h4>para acceder debes introducir una cuenta de usuario</h4></div><br>";
echo "
<div align=center>
	<form name=form action=".$_SERVER['PHP_SELF']." method='post'>
	<table class=tablas>
		<tr>
			<td align=center><menuindex><font size=5>Usuario</td>
			<td align=center><menuindex><font size=5>Contraseña</td>
		</tr>";
echo "	<tr>
			<td align=center><input type='text' name=user></td>
			<td align=center><input type='password' name=pass></td>
		</tr>";
echo "
	</table><br><br>
	<input type='submit' value='Entrar' onclick='validar()'></form>
	
</div>
";

echo "</div>";
include("pie.php");
?>
