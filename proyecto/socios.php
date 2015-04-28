
<?php
include ("cabecera.php");
include("grupos_funciones.php");
include ("socio.php") ;


if(!isset($_GET["criterio"]))
{
	$socios=consultarCriterio("","");


}else{
	if (!isset($_POST["busca"])) {
		$socios=consultarCriterio($_GET["criterio"],"");

	}
	else{	
		$socios=consultarCriterio($_GET["criterio"],$_POST["busca"]);
	}	
}


echo "<div align=center><h1>Listado de socios</h1><br><br>";
echo "<table border=0 cellpadding=15 cellspacing=0><tr>";

echo "<td align=center><a href=socios.php?criterio=organico>";
echo "<img src=images/organico.png width=50><br><h4>Orgánicos</a>";
echo "</td>";

echo "<td align=center><a href=socios.php?criterio=no_organico>";
echo "<img src=images/noorganico.png width=50><br><h4>No Orgánicos</a>";
echo "</td>";

echo "</form></td>";

echo "<td align=center>  <h4>Nombre y apellidos<br>
<form name=form2 action=".$_SERVER['PHP_SELF']."?criterio=nombres method='post'>";
echo "<input type='text' name=busca><br>";
echo "<input type='submit' value='buscar'>";
echo "</form></td>";

echo "<td align=center> <h4>Localidad<br>
<form name=form3 action=".$_SERVER['PHP_SELF']."?criterio=localidad method='post'>";
echo "<select name=busca>";
$grupos=obtenerGrupos();
 foreach ($grupos as $grupo)
	{
		echo "<option value=".$grupo["grupo"].">".$grupo["grupo"]."</option>";
	}

echo "</select><br>";
echo "<input type='submit' value='filtrar'>";
echo "</form></td>";


echo "<table class='paginated' cellspacing=1 cellspadding=1 align=center border=2 >";
		echo "<th >Nombre</th>";
		echo "<th>Apellido</th>";
		echo "<th>Poblacion</th>";
		echo "<th>Certificacion</th>";
		echo  "<th>opciones </th>";
		echo "</tr>";

foreach ($socios as $socio)
	{
		echo "<tr>";
		echo "<td>".$socio['nombres']."</td>";
		echo "<td>".$socio['apellidos']."</td>";
		echo "<td>".$socio['grupo']."</td>";
		if (isset($socio['certificacion'])) {
				echo "<td>".$socio['certificacion']."</td>";
			}
			else{
				echo "<td><a href=ficha_socio_certificar.php?socio=".$socio['id']."><img src=images/add1.ico width=50><br></a></td>";
			}	
		echo "<td><a href=ficha_socio.php?user=".$socio['id']."><img src=images/user_edit.png width=50><br></a></td>";
	echo "</tr>";
	}		

echo "</table>";

echo "</table></div>";

if(in_array($_SESSION['acceso'],$permisos_administrativos)){
echo "<td align=center><a href=ficha_socio_nuevo.php>";
echo "<img src=images/user_new.png width=50><br><h4>nuevo</a>";
echo "</td>";
}

if(in_array($_SESSION['acceso'],$permisos_administrativos)){
echo "<td align=center><a href=actualizar_entregados.php>";
echo "<img src=images/refresh.png width=30><br><h4>Actualizar<br>todos<br>entregados</a>";
echo "</td>";
}

if(in_array($_SESSION['acceso'],$permisos_administrativos)){
echo "<td align=center><a href=grupos.php>";
echo "<img src=images/grupos_admin.png width=40><br><h4>Administrar<br>grupos</a>";
echo "</td>";
}


echo "<table>";

echo "<th width=20px><h6>estados</h6></th>";
if(in_array($_SESSION['acceso'],$permisos_administrativos)){	echo "<th width=20px><h6>opciones</h6></th>";}
if(in_array($_SESSION['acceso'],$permisos_administrativos)){	echo "<th width=20px><h6>avisos</h6></th></tr>";}

echo "</table>";




include("pie.php");

?>