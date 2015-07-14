<?php
include ("cabecera.php");
include ("socio_funciones.php");
include ("grupos_funciones.php");
include ("canton_funciones.php");

if(isset ($_POST["nombres"])){				
		if(comprobar_mail($_POST["email"])){
			echo "<div align=center><notif>El email ya está en uso por otro socio y no se guardará</notif></div><br>";				
		//echo "$SQL_edit";
		echo "<div align=center><h1>GUARDANDO, ESPERA...
		<meta http-equiv='Refresh' content='2;url=socios.php'></font></h1></div>";
		//echo "$SQL_edit";	
		}
		else{
		
		insertar_socio($_POST["nombres"],$_POST["apellidos"],calcular_codigo($_POST["poblacion"]),$_POST["cedula"],$_POST["celular"],$_POST["f_nacimiento"]
			,$_POST["direccion"],$_POST["poblacion"],$_POST["canton"],$_POST["genero"],$_POST["email"]);
		
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
echo "<tr><th><h4>Nombres</th><td><input type='text' name=nombres required></td></tr>";
echo "<tr><th><h4>Apellidos</th><td><input type='text' name=apellidos required></td></tr>";
echo "<tr><th><h4>Código</th><td>*se calculará automáticamente</td></tr>";
echo "<tr><th><h4>Grupo</th><td>";
echo "<input list='grupos' name='poblacion'>";	
echo "<datalist  id='grupos'>";	
//echo "<option value=".$socio["poblacion"].">".$socio["poblacion"]."</option>";
 $grupos=consultarGrupo('lista','');
 foreach ($grupos as $grupo)
	{
		echo "<option>".$grupo["grupo"]."</option>";
	}
echo "</datalist></td></tr>";
echo "<tr><th><h4>Cédula</th><td><input type='text' name=cedula required></td></tr>";
echo "<tr><th><h4>Celular</th><td><input type='text' name=celular></td></tr>";
echo "<tr><th><h4>Fecha de nacimiento</th><td><input type='date' name=f_nacimiento></td></tr>";
echo "<tr><th><h4>email</th><td><input type='email' name=email></td></tr>";
echo "<tr><th><h4>Dirección</th><td><input type='text' name=direccion></td></tr>";
echo "<tr><th><h4>Canton</th><td>";
echo "<input list='cantones' name='canton'>";	
echo "<datalist  id='cantones'>";	
 $cantones=listar_cantones();
 foreach ($cantones as $canton)
	{
		echo "<option>".$canton["canton"]."</option>";
	}
echo "</datalist></td></tr>";
//echo "<tr><th><h4>Provincia</th><td><input type='text' name=provincia></td></tr>";
echo "<tr><th><h4>Género</th><td><select name=genero required>
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