<?php
include ("cabecera.php");
include ("users_funciones.php");
include ("canton_funciones.php");
if(isset ($_POST["nombres"])){				
		if(comprobar_mail($_POST["email"])){
			echo "<div align=center><notif>El email ya está en uso por otro socio y no se guardará</notif></div><br>";				
		//echo "$SQL_edit";
		echo "<div align=center><h1>GUARDANDO, ESPERA...
		<meta http-equiv='Refresh' content='2;url=users.php'></font></h1></div>";
		//echo "$SQL_edit";	
		}
		else{
		insertar_persona($_POST["nombres"],$_POST["apellidos"],$_POST["cedula"],$_POST["celular"],$_POST["f_nacimiento"],$_POST["email"]
			,$_POST["direccion"],$_POST["foto"],$_POST["genero"],$_POST["canton"]);
		
		//echo "$SQL_edit";
		
		echo "<div align=center><h1>GUARDANDO, ESPERA...
		<meta http-equiv='Refresh' content='2;url=users.php'></font></h1></div>";
		
		//echo "$SQL_edit";
		}
	}
		
		
else{
	

echo "<div align=center><h1>NUEVA PERSONA</h1><br>";


echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
echo "<table class=tablas>";
echo "<tr><th><h4>Nombres</th><td><input type='text' name=nombres></td></tr>";
echo "<tr><th><h4>Apellidos</th><td><input type='text' name=apellidos></td></tr>";
echo "<tr><th><h4>Cedula</th><td><input type='text' name=cedula></td></tr>";
echo "<tr><th><h4>Celular</th><td><input type='text' name=celular></td></tr>";
echo "<tr><th><h4>Fecha de Nacimiento</th><td><input type='date' name=f_nacimiento></td></tr>";
echo "<tr><th><h4>Correo</th><td><input type='email' name=email></td></tr>";
echo "<tr><th><h4>Direccion</th><td><input type='text' name=direccion></td></tr>";
echo "<tr><th><h4>Foto</th><td><input type='text' name=foto></td></tr>";
echo "<tr><th><h4>Genero</th><td>";
			echo "<select name=genero>";
			echo "<option value='1'>Masculino</option>";
			echo "<option value='2'>Femenino</option>";
			echo "</select></td></tr>";
echo "<tr><th><h4>Canton</th><td>";
echo "<input list='cantones' name='canton'>";	
echo "<datalist  id='cantones'>";	
 $cantones=listar_cantones();
 foreach ($cantones as $canton)
	{
		echo "<option>".$canton["canton"]."</option>";
	}
echo "</datalist></td></tr>";
echo "</table><br><br>";
echo "<input type='submit' value='Guardar'>";
echo "</form>";
}


include("pie.php");
?>