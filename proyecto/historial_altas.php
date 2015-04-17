<?php
include ("cabecera.php");

$SQL="SELECT * FROM socios where codigo='".$_GET["socio"]."'";
$resultado=mysqli_query($link, $SQL);
$socio = mysqli_fetch_array($resultado,MYSQLI_ASSOC);

$estatus=altas_bajas($socio["codigo"]);

echo "<div align=center><h1>Historial de altas y bajas del socio</h1><br><h2>".$socio["nombres"]." ".$socio["apellidos"]."</h2><br>";

echo "<br><table class=tablas><tr><th colspan=3><h2>Historial</h2></th></tr>";
echo "<tr><th>Año</th><th>Estado</th><th>Borrar</th></tr>";
//estado de pagos
foreach ($estatus as $id=>$estado)
	{
		if($estado["year"]==0){$estado["year"]="fecha desconocida";}
	echo "<tr><td align=center>";	
	echo "<h4>".$estado["year"]."</h4>";
	echo "<td align=center>";	
	echo "<h4>".$estado["estado"]."</h4></td>";
	echo "<td align=center>";	
	echo "<h4>";
if(in_array($_COOKIE['acceso'],$permisos_admin)){echo "<a href=historial_altas_borrar.php?id=".$id."&socio=".$_GET["socio"]."><img title='borrar este estado' src=images/cross.png width=25></a>";}
	echo "</h4></td></tr>";
	}
echo "</table>";
echo "<br><br>

<table class=tablas><tr>";
if(in_array($_COOKIE['acceso'],$permisos_general)){echo "<td><a href=ficha_socio.php?socio=".$_GET["socio"]."><h3>VOLVER</h3></a></td>";}
//if(in_array($_COOKIE['acceso'],$permisos_administrativos)){echo "<td><a href=ficha_socio_borrar.php?socio=".$_GET["socio"]."><h3>ELIMINAR</h3></a></td>";}
if(in_array($_COOKIE['acceso'],$permisos_admin)){echo "<td><a href=historial_altas_nuevo.php?socio=".$_GET["socio"]."><h3>AÑADIR</h3></a></td>";}
//if(in_array($_COOKIE['acceso'],$permisos_general)){echo "<td><a href=lotes.php?criterio=socio&socio=".$_GET["socio"]."><h3>VER LOTES</h3></a></td>";}
echo "</tr></table>";
include("pie.php");
?>