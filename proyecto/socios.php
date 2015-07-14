<?php
include ("cabecera.php");
include("grupos_funciones.php");
include ("socio_funciones.php") ;



if(!isset($_GET["criterio"]))
{
	$socios=consultarCriterio("","");
	$texto="";
}else{
	if (!isset($_POST["busca"])) {
		$socios=consultarCriterio($_GET["criterio"],"");
		$texto="Criterio de busqueda: ".$_GET["criterio"]."";
	}
	else{	
		$socios=consultarCriterio($_GET["criterio"],$_POST["busca"]);
		$texto="Criterio de busqueda: ".$_GET["criterio"]." Valor:".$_POST["busca"]."";
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


echo "<td align=center>  <h4>Nombre y apellidos<br>
<form name=form2 action=".$_SERVER['PHP_SELF']."?criterio=nombres method='post'>";
echo "<input type='text' name=busca ><br>";
echo "<input type='submit' value='buscar'>";
echo "</form></td>";


echo "<td align=center> <h4>Localidad<br>
<form name=form3 action=".$_SERVER['PHP_SELF']."?criterio=localidad method='post'>";
echo "<input list='grupos' name='busca' placeholder='Seleccione...' >";	
echo "<datalist  id='grupos'>";	
$grupos=consultarGrupo('lista','');
 foreach ($grupos as $grupo)
	{
		echo "<option>".$grupo["grupo"]."</option>";
	}
echo "</datalist></br>";
echo "<input type='submit' value='filtrar'>";
echo "</form></td>";
echo "</div>";

echo "<div name='tabla' style='width:95%; height:48px; overflow:auto;''>";
echo "</div>";
echo "<table id='table_id' style='width: 60%' class='tablas'>";
echo "<H4>$texto</h4></br>";
echo "<H4 > Total socios: (".count($socios).")</h4> </br>";
echo "<thead>";
		echo "<th  width=8%><h3>Codigo</h3></th>";
		echo "<th  width=60%><h3>Socios</h3></th>";
		echo "<th><h3>Poblacion</h3></th>";
		echo "<th width=8%><h3>Certificacion</h3></th>";
		echo  "<th width=8%><h3>Opciones</h3></th>";
		echo "</thead>";
		echo "<tbody>";
if (is_array($socios)) {
	foreach ($socios as $socio) {
		echo "<tr>";
		echo "<td><h4>".$socio['codigo']."</h4></td>";
			echo "<td><h4>".$socio['apellidos'].", ".$socio['nombres']." </h4></td>";
			echo "<td><h4>".$socio['grupo']."<h4></td>";
			if (isset($socio['certificacion'])) {
					echo "<td><img title='socio CON certificación orgánica' src=images/organico.png width=25></td>";
				}
				else{
					echo "<td><img title='socio CON certificación orgánica' src=images/noorganico.png width=25>
					<a href=ficha_socio_certificar.php?socio=".$socio['id']."><img src=images/add1.ico width=30></a>
					</td>";
				}	
			echo "<td><a href=ficha_socio.php?user=".$socio['id']."><img src=images/user_edit.png width=30><br></a></td>";
			echo "</tr>";
		}	
}else{
	echo "<tr>";
	echo "<td>sin datos</td>";
	echo "</tr>";
}

echo "</tbody>";
echo "</table>";
echo "</div>";
echo "</table>";
echo "<table>";
echo "</table>";

include("pie.php");
?>
</body>






 