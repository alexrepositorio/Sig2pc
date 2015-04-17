<?php
include ("cabecera.php");


//******************************************
if(isset ($_GET["editar"])){
$SQL_edit="UPDATE configuracion SET 
				valor='".$_POST["valor"]."'
				WHERE id=".$_GET["editar"];

$resultado=mysqli_query($link, $SQL_edit);

$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);


echo "<div align=center><h1>ACTUALIZANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=configuracion.php'></font></h1></div>";
	
}


else{
//******************************************
$sql="SELECT * FROM configuracion WHERE id=".$_GET["id"];

//**********TABLA AUTOMATICA*****************************************************************
$resultado=mysqli_query($link, $sql);
while($object = mysqli_fetch_field($resultado)){
	$campos[]=$object->name;
}
echo "<div align=center><h2>EDITAR EL CAMPO</h2><br>";
echo "<table class=tablas><tr>";
foreach ($campos as $columna){
	if($columna!="id" && $columna!="parametro"){echo "<th align=center><h4>$columna</th>";}
}
//echo "<th align=center><h4>editar</td>";
echo "</tr>";
echo "<form name=form action=".$_SERVER['PHP_SELF']."?editar=".$_GET["id"]." method='post'>";

while($datos = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
	echo "<tr>";
	foreach ($campos as $columna){
		switch ($columna){
			case "id":
				break;
			case "parametro":
				break;
			case "descripcion":
				echo "<td align=center><h4>".$datos[$columna]."</td>";
				break;
			case "valor":
				echo "<td align=center><input type=text name=valor value='".$datos[$columna]."'></td>";
				break;
		}
	}
}
echo "</table><br>";
echo "<input type='submit' value='Guardar'>";
echo "</form></div>";
}
//**********TABLA AUTOMATICA*****************************************************************

include("pie.php");

?>