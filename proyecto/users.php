<?php
include ("cabecera.php");
include ("users_funciones.php") ;

$usuarios=consultarCriterio('altas');

echo "<div align=center><h1>Listado de usuarios</h1><br><br>";

echo "<table width=700px border=0 cellpadding=0 cellspacing=0><tr>";
	echo "<td align=center><a href=ficha_user_nuevo.php>";
		echo "<img src=images/add.png width=50><br><h4>nuevo</a>";
	echo "</td>";
	echo "<td align=center><a href=ficha_persona.php>";
		echo "<img src=images/add.png width=50><br><h4>Socio</a>";
	echo "</td>";
	echo "<td align=center><a href=users_bajas.php>";
		echo "<img src=images/add.png width=50><br><h4>Reactivaciones</a>";
	echo "</td>";
echo "</tr></table>";

echo "<table class=tablas>";
	echo "<tr><th width=500px>";
	echo "<h4>USUARIOS</h4>";
	echo "</th>";
	echo "<th><h6>Nivel</th>";
	echo "<th width=20px><h6>opciones</h6></th></tr>";

	foreach ($usuarios as $usuario) {
		echo "<tr>";
			echo "<td><h4>".$usuario["user"]."</td><h4>" ;
			echo "<td><h4>".$usuario["nivel"]."</td><h4>" ;
			echo "</td>";
			echo "<td><a href=ficha_user_editar.php?user=".$usuario["id"]."><img title=editar src=images/pencil.png width=25></a>
					  <a href=ficha_user_borrar.php?id=".$usuario["id"]."><img title=borrar src=images/cross.png width=25></a>
		    </td></tr>";
	}
echo "</table></div>";

include("pie.php");

?>