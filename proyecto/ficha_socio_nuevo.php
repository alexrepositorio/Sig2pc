<?php
include ("cabecera.php");

if(isset ($_POST["nombres"])){
		
		$pobcod=explode("-",$_POST["poblacion"]);
		$codigo_grupo=$pobcod[0];
		$poblacion=$pobcod[1];
		
		//calculo del código nuevo
		$sql_nuevo_socio="SELECT socios.codigo, grupos.codigo_grupo  FROM socios LEFT JOIN grupos ON socios.poblacion=grupos.grupo WHERE poblacion='".$poblacion."'";
						  
		$r_nuevo_socio=mysqli_query($link, $sql_nuevo_socio);
		$cuenta_p=mysqli_num_rows($r_nuevo_socio);
		if($cuenta_p==0){$nuevo_codigo=$codigo_grupo."01";}
		else{
			while ($rowcodigos = mysqli_fetch_array($r_nuevo_socio,MYSQLI_ASSOC)){
				$nsocio=substr($rowcodigos["codigo"],2,2);
				//$codigo_grupo=$codigo_grupo;
				$numeraciones[]=$nsocio;
			}
			$siguiente=max($numeraciones)+1;
			$nuevo_codigo=$codigo_grupo.$siguiente;
		}
		//compruebo si el email ya está en uso


		$sql_nuevo_email="SELECT email FROM socios WHERE email='".$_POST["email"]."'";
		$r_nuevo_email=mysqli_query($link, $sql_nuevo_email);
		$cuenta_e=mysqli_num_rows($r_nuevo_email);
		if($cuenta_e>0){
			echo "<div align=center><notif>El email ya está en uso por otro socio y no se guardará</notif></div><br>";
		
		$SQL_edit="INSERT INTO socios VALUES('',
						'".$_POST["nombres"]."',
						'".$_POST["apellidos"]."',
						'".$nuevo_codigo."',
						'".$_POST["cedula"]."',
						'".$_POST["celular"]."',
						'".$_POST["f_nacimiento"]."',
						'',
						'".$_POST["direccion"]."',
						'".$poblacion."',
						'".$_POST["canton"]."',
						'".$_POST["provincia"]."',
						'','".$_POST["genero"]."')";
		
		$resultado=mysqli_query($link, $SQL_edit);
		$nuevo_id=mysqli_insert_id($link);
		
		
		$cadena=str_replace("'", "", $SQL_edit);
		guarda_historial($cadena);
		
		//echo "$SQL_edit";
		
		echo "<div align=center><h1>GUARDANDO, ESPERA...
		<meta http-equiv='Refresh' content='2;url=ficha_socio.php?socio=".$nuevo_codigo."'></font></h1></div>";
		
		//echo "$SQL_edit";
		
		
		
		
		
		
		}
		else{
		
		
		$SQL_edit="INSERT INTO socios VALUES('',
						'".$_POST["nombres"]."',
						'".$_POST["apellidos"]."',
						'".$nuevo_codigo."',
						'".$_POST["cedula"]."',
						'".$_POST["celular"]."',
						'".$_POST["f_nacimiento"]."',
						'".$_POST["email"]."',
						'".$_POST["direccion"]."',
						'".$poblacion."',
						'".$_POST["canton"]."',
						'".$_POST["provincia"]."',
						'','".$_POST["genero"]."')";
		
		$resultado=mysqli_query($link, $SQL_edit);
		$nuevo_id=mysqli_insert_id($link);
		
		
		$cadena=str_replace("'", "", $SQL_edit);
		guarda_historial($cadena);
		
		//echo "$SQL_edit";
		
		echo "<div align=center><h1>GUARDANDO, ESPERA...
		<meta http-equiv='Refresh' content='2;url=ficha_socio.php?socio=".$nuevo_codigo."'></font></h1></div>";
		
		//echo "$SQL_edit";
		}}
		
		
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
			$sql_pob="SELECT grupo as pob, codigo_grupo as cod FROM grupos ORDER BY grupo ASC";
			$r_pob=mysqli_query($link, $sql_pob);
			while ($row_pob = mysqli_fetch_array($r_pob,MYSQLI_ASSOC)){$pob=$row_pob["pob"];$cod=$row_pob["cod"];echo "<option value='$cod-$pob'>($cod) $pob</option>";}
			echo "</select></td></tr>";
echo "<tr><th><h4>Cédula</th><td><input type='text' name=cedula></td></tr>";
echo "<tr><th><h4>Celular</th><td><input type='text' name=celular></td></tr>";
echo "<tr><th><h4>Fecha de nacimiento</th><td><input type='text' name=f_nacimiento></td></tr>";
echo "<tr><th><h4>email</th><td><input type='text' name=email></td></tr>";
echo "<tr><th><h4>Dirección</th><td><input type='text' name=direccion></td></tr>";
echo "<tr><th><h4>Cantón</th><td><input type='text' name=canton></td></tr>";
echo "<tr><th><h4>Provincia</th><td><input type='text' name=provincia></td></tr>";
echo "<tr><th><h4>Género</th><td><select name=genero>
		<option value=''>Elige género</option>
		<option value='masculino'>Masculino</option>
		<option value='femenino'>Femenino</option>
		</select></td></tr>";
echo "</table><br>";

echo "<input type='submit' value='Guardar'>";
echo "</form>";
}


include("pie.php");
?>