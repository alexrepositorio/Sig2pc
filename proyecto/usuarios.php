<?php
include ("cabecera.php");

$SQL="SELECT * FROM usuarios order by user asc";

$resultado=mysqli_query($link, $SQL);
$cuenta=mysqli_num_rows($resultado);
while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
	$users[]=$row;
}
/*
if(isset($_GET["separa"])){
	foreach ($socios as $persona){
		$nombrescompletos="";
		echo "<b>".$persona["nombres"];
		$nombres=explode(" ",$persona["nombres"]);
		echo "&nbsp&nbsp&nbsp&nbsp&nbsp Apellidos : ".$nombres[0]." ".$nombres[1]." ";
		$apellidoscompletos=$nombres[0]." ".$nombres[1];
		foreach ($nombres as $key=>$partes){if($key>1){$nombrescompletos=$nombrescompletos." ".$partes;}}
		//$nombrescompletos=$nombres[2]." ".$nombres[3]." ".$nombres[4];
		echo "&nbsp&nbsp&nbsp&nbsp&nbsp Nombres : $nombrescompletos</b><br>";
		$apellidoscompletos=ucwords(strtolower($apellidoscompletos));
		$nombrescompletos=ucwords(strtolower($nombrescompletos));
		$SQL_update="UPDATE socios SET apellidos='$apellidoscompletos', nombres='$nombrescompletos' WHERE id_socio=".$persona["id_socio"];
		echo $SQL_update."<br>";
		$resultado=mysqli_query($link, $SQL_update);
	}	
}
*/

//muestra_array($socios); 
echo "<div align=center><h1>Listado de usuarios</h1><br><br>";

If ($_COOKIE['acceso']>1){
	echo "<img src=images/oops.jpg><br><subtitulo>Ohh! lo sentimos, <br>necesitas una cuenta de administrador para ver este contenido</subtitulo><br>";
}
else{
//echo $_COOKIE['acceso'];
echo "<table width=700px border=0 cellpadding=0 cellspacing=0><tr>";
//echo "<td align=center></td><td align=center></td><td align=center></td></tr><tr>";

echo "<td align=center><a href=ficha_user_nuevo.php>";
echo "<img src=images/add.png width=50><br><h4>nuevo</a>";
echo "</td>";

echo "</tr></table>";

echo "<table class=tablas>";
	echo "<tr><th width=500px>";
	echo "<h4>SOCIOS($cuenta)</h4>";
	echo "</th>";
	echo "<th><h6>Nivel</th>";
	echo "<th width=20px><h6>opciones</h6></th></tr>";

if(isset($users))
{
	foreach ($users as $user)
	{
		echo "<tr>";
		echo "<td><a href=ficha_user.php?user=".$user["id"]."><h4>".$user["user"]. "</td><td><h4>" .nivel($user["nivel"]);
		echo "</td>";
		echo "<td><a href=ficha_user_editar.php?user=".$user["id"]."><img title=editar src=images/pencil.png width=25></a>
				  <a href=ficha_user_borrar.php?user=".$user["id"]."><img title=borrar src=images/cross.png width=25></a>
				  </td></tr>";
	}
}
echo "</table></div>";
}

include("pie.php");

?>