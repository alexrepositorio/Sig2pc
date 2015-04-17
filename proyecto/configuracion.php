<?php
include ("cabecera.php");
$sql="SELECT * FROM configuracion";

//**********TABLA AUTOMATICA*****************************************************************
$resultado=mysqli_query($link, $sql);
while($object = mysqli_fetch_field($resultado)){
	$campos[]=$object->name;
}

echo "<div align=center><h2>TABLA DE CONFIGURACIONES</h2><br><h4>* las listas deben estar separadas por comas y sin espacios</h6><br><table class=tablas><tr>";
foreach ($campos as $columna){
	if($columna!="id" && $columna!="parametro"){echo "<th align=center><h4>$columna</th>";}
}
echo "<th align=center><h4>editar</td>";
echo "</tr>";

while($datos = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
	echo "<tr>";
	foreach ($campos as $columna){
		if($columna!="id" && $columna!="parametro"){echo "<td align=center><h4>".$datos[$columna]."</td>";}		
	}
	echo "<td align=center><a href=configuracion_editar.php?id=".$datos["id"]."><img title=editar src=images/pencil.png width=20></a></td>";
	echo "</tr>";	
}
echo "</table></div>";
//**********TABLA AUTOMATICA*****************************************************************

include("pie.php");

?>