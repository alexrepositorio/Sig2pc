<?php
include ("cabecera.php");
include ("socio.php");
include ("certificaciones_funciones.php");

$socio = consultarCriterio('id',$_GET["socio"]);
$estatus=certificacion($_GET["socio"]);
if (isset ($_GET["borrar"])) {
	certificacionborrar($_GET["borrar"]);
	echo "<div align=center><h1>BORRANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=historial_certificacion.php?socio=".$_GET["socio"]."'></font></h1></div>";

}
	echo "<div align=center><h1>Historial de certificación orgánica del socio</h1><br><h2>".$socio["nombres"]." ".$socio["apellidos"]."</h2><br>";
	echo "<br><table class=tablas><tr><th colspan=3><h2>Historial</h2></th></tr>";
	echo "<tr><th>Año</th><th>Certificación</th><th>Borrar</th></tr>";

	if (!is_array($estatus)) {
		echo "<tr><td align=center>";	
		echo "<h4>SIN CERTIFICACION</h4>";
		echo "<td align=center>";	
		echo "<h4></h4></td>";
		echo "<td align=center>";	
		echo "<h4>";
		
	}elseif(count($estatus)/4==1) {
		if($estatus["year"]==0){
			$estatus["year"]="fecha desconocida";
		}
		echo "<tr><td align=center>";	
		echo "<h4>".$estatus["year"]."</h4>";
		echo "<td align=center>";	
		echo "<h4>".$estatus["estatus"]."</h4></td>";
		echo "<td align=center>";	
		echo "<h4>";
		if(in_array($_SESSION['acceso'],$permisos_admin)){
		echo "<a href=?borrar=".$estatus['id']."&socio=".$_GET["socio"].">
			<img title='borrar este estado' src=images/cross.png width=25></a>";
		}
		echo "</h4></td></tr>";
	} else{
		foreach ($estatus as $estado)
		{
			if($estado["year"]==0){
				$estado["year"]="fecha desconocida";}
		echo "<tr><td align=center>";	
		echo "<h4>".$estado["year"]."</h4>";
		echo "<td align=center>";	
		echo "<h4>".$estado["estatus"]."</h4></td>";
		echo "<td align=center>";	
		echo "<h4>";
	if(in_array($_SESSION['acceso'],$permisos_admin)){
		echo "<a href=?borrar=".$estado['id']."&socio=".$_GET["socio"].">
			<img title='borrar este estado' src=images/cross.png width=25></a>";
		}
		echo "</h4></td></tr>";
		}
	}

	echo "</table>";
	echo "<br><br>

	<table class=tablas><tr>";


	if(in_array($_SESSION['acceso'],$permisos_general)){
		echo "<td><a href=ficha_socio.php?user=".$_GET["socio"]."><h3>VOLVER</h3></a></td>";
	}
	//if(in_array($_COOKIE['acceso'],$permisos_administrativos)){echo "<td><a href=ficha_socio_borrar.php?socio=".$_GET["socio"]."><h3>ELIMINAR</h3></a></td>";}
	if(in_array($_SESSION['acceso'],$permisos_admin)){
		echo "<td><a href=ficha_socio_certificar.php?socio=".$_GET["socio"]."><h3>AÑADIR</h3></a></td>";
	}
	//if(in_array($_COOKIE['acceso'],$permisos_general)){echo "<td><a href=lotes.php?criterio=socio&socio=".$_GET["socio"]."><h3>VER LOTES</h3></a></td>";}
	echo "</tr></table>";





include("pie.php");
?>