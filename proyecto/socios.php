<?php
include ("cabecera.php");
include("grupos_funciones.php");
include ("socio.php") ;

if(!isset($_GET["criterio"]))
{
	$res=consultarCriterio("","");


}else{
	if (!isset($_POST["busca"])) {
		$res=consultarCriterio($_GET["criterio"],"");

	}
	else{	
		$res=consultarCriterio($_GET["criterio"],$_POST["busca"]);
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
$result=obtenerGrupos();
while ($rowloc = mysqli_fetch_array($result)){
    $localidad=$rowloc["grupo"];
    echo "<option value='$localidad'>$localidad</option>";
}
echo "</select><br>";
echo "<input type='submit' value='filtrar'>";
echo "</form></td>";


echo "<table data-toggle='table' cellspacing=1 cellspadding=1 align=center border=2 >";
		echo "<td >Nombre</td>";
		echo "<td>Apellido</td>";
		echo "<td>Poblacion</td>";
		echo "<td>Certificacion</td>";
		echo  "<td>opciones </td>";
		echo "</tr>";

while ($row = mysqli_fetch_assoc($res)) {
	// mysqli_free_result($res);
	echo "<tr>";
		echo "<td>".$row['nombres']."</td>";
		echo "<td>".$row['apellidos']."</td>";
		echo "<td>".$row['grupo']."</td>";
		if (isset($row['certificacion'])) {
				echo "<td>".$row['certificacion']."</td>";
			}
			else{
				echo  "<td>sin certificacion</td>";
			}	
		echo "<td><a href=ficha_socio.php?user=".$row['id']."><img src=images/user_edit.png width=50><br></a></td>";
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