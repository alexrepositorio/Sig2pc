<?php
include ("cabecera.php");
include ("socio.php");
include ("grupos_funciones.php");

if(isset ($_POST["nombres"])){				
		if(comprobar_mail($_POST["email"])){
			echo "<div align=center><notif>El email ya está en uso por otro socio y no se guardará</notif></div><br>";				

		//echo "$SQL_edit";
		
		echo "<div align=center><h1>GUARDANDO, ESPERA...
		<meta http-equiv='Refresh' content='2;url=socios.php'></font></h1></div>";
		
		//echo "$SQL_edit";
		
		
		
		}
		else{
		
		insertar_socio($_POST["nombres"],$_POST["apellidos"],'AN00',$_POST["cedula"],$_POST["celular"],$_POST["f_nacimiento"]
			,$_POST["direccion"],$_POST["poblacion"],$_POST["canton"],$_POST["provincia"],$_POST["genero"],$_POST["email"]);
		
		
		//echo "$SQL_edit";
		
		echo "<div align=center><h1>GUARDANDO, ESPERA...
		<meta http-equiv='Refresh' content='2;url=socios.php'></font></h1></div>";
		
		//echo "$SQL_edit";
		}
	}
		
		
else{
	

echo "<div align=center><h1>NUEVO SOCIO</h1><br>";

//muestra_array($socio);

echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
echo "<table class=tablas>";
echo "<tr><th><h4>Nombres</th><td><input type='text' name=nombres></td></tr>";
echo "<tr><th><h4>Apellidos</th><td><input type='text' name=apellidos></td></tr>";
echo "<tr><th><h4>Código</th><td>*se calculará automáticamente</td></tr>";
echo "<tr><th><h4>Grupo</th><td>";
			echo "<select name=poblacion>";
			echo "<option value=''>Elige grupo</option>";
			$result=obtenerGrupos();
    while ($rowloc = mysqli_fetch_array($result)){
        $localidad=$rowloc["grupo"];
        echo "<option value='$localidad'>$localidad</option>";
    }
			echo "</select></td></tr>";
echo "<tr><th><h4>Cédula</th><td><input type='text' name=cedula></td></tr>";
echo "<tr><th><h4>Celular</th><td><input type='text' name=celular></td></tr>";
echo "<tr><th><h4>Fecha de nacimiento</th><td><input type='date' name=f_nacimiento></td></tr>";
echo "<tr><th><h4>email</th><td><input type='email' name=email></td></tr>";
echo "<tr><th><h4>Dirección</th><td><input type='text' name=direccion></td></tr>";
echo "<tr><th><h4>Cantón</th><td><input type='text' name=canton></td></tr>";
echo "<tr><th><h4>Provincia</th><td><input type='text' name=provincia></td></tr>";
echo "<tr><th><h4>Género</th><td><select name=genero>
		<option value=''>Elige género</option>
		<option value='masculino'>M</option>
		<option value='femenino'>F</option>
		</select></td></tr>";
echo "</table><br>";

echo "<input type='submit' value='Guardar'>";
echo "</form>";
}

include("pie.php");
?>