<?php
include ("cabecera.php");
$SQL="SELECT * FROM usuarios where id='".$_GET["user"]."'";
$resultado=mysqli_query($link, $SQL);
$user = mysqli_fetch_array($resultado,MYSQLI_ASSOC);

if(isset ($_POST["user"])){
$SQL_edit="UPDATE usuarios SET
				user= '".$_POST["user"]."',
				pass= '".$_POST["pass"]."',
				nivel= '".$_POST["nivel"]."'
				WHERE id='".$_GET["user"]."'";
				
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
	

echo "<div align=center><h1>EDITAR USUARIO</h1><br>";

//muestra_array($socio);
$tipos=array(1=>"Administrador",2=>"Contable",3=>"Bodeguero",4=>"Socio",5=>"Catador");

echo "<form name=form action=".$_SERVER['PHP_SELF']."?user=".$user["id"]." method='post'>";
echo "<table class=tablas>";
echo "<tr><th><h4>Usuario</th><td><input type='text' name=user value='".$user["user"]."'></td></tr>";
echo "<tr><th><h4>Contraseña</th><td><input type='text' name=pass value='".$user["pass"]."'></td></tr>";
echo "<tr><th><h4>Nivel</th><td>";
			echo "<select name=nivel>";
			foreach($tipos as $key=>$tipo){
				if($user["nivel"]==$key){$sel="selected";}else{$sel="";}	
				echo "<option $sel value='$key'>$tipo</option>";
			}
			echo "</select></td></tr>";
echo "</table><br>";

echo "<input type='submit' value='Guardar'>";
echo "</form>";
}


include("pie.php");
?>