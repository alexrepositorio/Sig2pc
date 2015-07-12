<?php
include ("cabecera.php");
include ("socio_funciones.php");
include ("certificaciones_funciones.php");

$socio = consultarCriterio('id',$_GET["socio"]);
$socio=$socio[0];
$estatus=certificacion('socio',$_GET["socio"]);
if (isset ($_GET["borrar"])) {
	if (isset($_GET["opcion"])) {
		certificacionborrar($_GET["borrar"]);
	echo "<div align=center><h1>BORRANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=historial_certificacion.php?socio=".$_GET["socio"]."'></font></h1></div>";
	}else{
	echo "<div align=center>";
	echo "<notif>¿ESTA SEGURO?</notif><br><br>";
	echo "<table class=tablas><tr>";
	echo "<td width=50%>
	<a href='historial_certificacion.php?borrar=".$_GET["borrar"]."&opcion=1&socio=".$_GET["socio"]."'>
	<notifsi>SI</notifsi>
	</a></td>";
	echo "<td width=50%><a href='historial_certificacion.php?socio=".$_GET["socio"]."'<notifno>NO</notifno></a></td>";
	echo "</tr></table></div>";

	}	
}
	echo "<div align=center><h1>Historial de certificación orgánica del socio</h1><br><h2>".$socio["nombres"]." ".$socio["apellidos"]."</h2><br>";
	echo "<br><table class=tablas><tr><th colspan=3><h2>Historial</h2></th></tr>";
	echo "<tr><th>Año</th><th>Certificación</th><th>Borrar</th></tr>";
	if (is_array($estatus)) {
		foreach ($estatus as $estado)
		{
			if($estado["year"]==0){
				$estado["year"]="fecha desconocida";
		}
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
}else{
		echo "<tr><td align=center>";	
		echo "<h4>SIN CERTIFICACION</h4>";
		echo "<td align=center>";	
		echo "<h4></h4></td>";
		echo "<td align=center>";	
		echo "<h4>";
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