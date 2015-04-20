<?php
include ("cabecera.php");
include ("socio.php");
if(isset ($_GET["guarda"])){

//compruebo si el email ya está en uso
$sql_nuevo_email="SELECT email FROM socios";
$r_nuevo_email=mysqli_query($link, $sql_nuevo_email);
while ($row = mysqli_fetch_array($r_nuevo_email,MYSQLI_ASSOC)){
	$listaemails[]=$row["email"];}

if(in_array($_POST["email"],$listaemails)){
	echo "<div align=center><notif>El email ya está en uso por otro socio y no se guardará</notif></div><br>";

$SQL_edit="UPDATE socios SET 
				nombres='".$_POST["nombres"]."',
				apellidos='".$_POST["apellidos"]."',
				cedula='".$_POST["cedula"]."',
				celular='".$_POST["celular"]."',
				f_nacimiento='".$_POST["f_nacimiento"]."',
				direccion='".$_POST["direccion"]."',
				poblacion='".$_POST["poblacion"]."',
				canton='".$_POST["canton"]."',
				codigo='".$_POST["codigo"]."',
				provincia='".$_POST["provincia"]."', 
				genero='".$_POST["genero"]."' 
			where id_socio='".$_GET["guarda"]."'";
$resultado=mysqli_query($link, $SQL_edit);

$resultado=mysqli_query($link, $SQL_edit);
$nuevo_id=mysqli_insert_id($link);


$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);

//echo "$SQL_edit";

echo "<div align=center><h1>GUARDANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=ficha_socio.php?socio=".$_GET["guarda"]."'></font></h1></div>";

//echo "$SQL_edit";

}
else{

$SQL_edit="UPDATE socios SET 
				nombres='".$_POST["nombres"]."',
				apellidos='".$_POST["apellidos"]."',
				cedula='".$_POST["cedula"]."',
				celular='".$_POST["celular"]."',
				f_nacimiento='".$_POST["f_nacimiento"]."',
				email='".$_POST["email"]."',
				direccion='".$_POST["direccion"]."',
				poblacion='".$_POST["poblacion"]."',
				canton='".$_POST["canton"]."',
				codigo='".$_POST["codigo"]."',
				provincia='".$_POST["provincia"]."', 
				genero='".$_POST["genero"]."' 
			where id_socio='".$_GET["guarda"]."'";
$resultado=mysqli_query($link, $SQL_edit);

$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);

echo "<div align=center><h1>ACTUALIZANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=ficha_socio.php?socio=".$_GET["guarda"]."'></font></h1></div>";
	
}}


else{


$SQL="SELECT * FROM socios where id_socio=".$_GET["socio"];
$resultado=mysqli_query($link, $SQL);
$socio = mysqli_fetch_array($resultado,MYSQLI_ASSOC);

if(isset($_GET["foto"])){$socio["foto"]=$_GET["foto"];}

echo "<div align=center><h1>Edición de la Ficha del socio</h1><br><h2>".$socio["nombres"]." ".$socio["apellidos"]."</h2><br><br>";

//muestra_array($socio);

echo "<form name=form action=".$_SERVER['PHP_SELF']."?guarda=".$_GET["socio"]." method='post'>";
if($socio["foto"]==""){$socio["foto"]="sinfoto.jpg";}
echo "<a href=galery2.php?socio=".$socio["id_socio"]."><img src=fotos/th/small_".$socio["foto"]." width=100></a><br><h5>click en la foto para cambiarla</h5><br>";
echo "<table class=tablas>";
echo "<tr><th align=right><h4>Nombres</td><td><input type='text' name=nombres value='".$socio["nombres"]."'></td></tr>";
echo "<tr><th align=right><h4>Apellidos</td><td><input type='text' name=apellidos value='".$socio["apellidos"]."'></td></tr>";
echo "<tr><th align=right><h4>Código</td><td><input type='text' name=codigo value='".$socio["codigo"]."'></td></tr>";
echo "<tr><th align=right><h4>Grupo</th><td>";
			echo "<select name=poblacion>";
            $result=obtenerGrupos();
    while ($rowloc = mysql_fetch_array($result)){
        $localidad=$rowloc["grupo"];
        echo "<option value='$localidad'>$localidad</option>";
    }
			echo "</select></td></tr>";
echo "<tr><th align=right><h4>Cédula</td><td><input type='text' name=cedula value='".$socio["cedula"]."'></td></tr>";
echo "<tr><th align=right><h4>Celular</td><td><input type='text' name=celular value='".$socio["celular"]."'></td></tr>";
echo "<tr><th align=right><h4>Fecha de nacimiento</td><td><input type='date' name=f_nacimiento value='".$socio["f_nacimiento"]."'>\"aaaa-mm-dd\"</td></tr>";
echo "<tr><th align=right><h4>email</td><td><input type='text' name=email value='".$socio["email"]."'></td></tr>";
echo "<tr><th align=right><h4>Dirección</td><td><input type='text' name=direccion value='".$socio["direccion"]."'></td></tr>";
echo "<tr><th align=right><h4>Cantón</td><td><input type='text' name=canton value='".$socio["canton"]."'></td></tr>";
echo "<tr><th align=right><h4>Provincia</td><td><input type='text' name=provincia value='".$socio["provincia"]."'></td></tr>";
echo "<tr><th><h4>Género</th><td><select name=genero>
		<option value='".$socio["genero"]."'>".$socio["genero"]."</option>
		<option value='masculino'>M</option>
		<option value='femenino'>F</option>
		</select></td></tr>";
echo "</table><br>";

echo "<input type='submit' value='Guardar'>";
echo "</form>";
}

include("pie.php");
?>