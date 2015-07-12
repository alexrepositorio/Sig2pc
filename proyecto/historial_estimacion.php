<?php
include ("cabecera.php");
include ("socio_funciones.php");
include ("estimaciones_funciones.php");



if (isset ($_GET["borrar"])) {

	if (isset($_GET["opcion"])) {
		estimacion_eliminar($_GET["borrar"]);
	echo "<div align=center><h1>BORRANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=historial_estimacion.php?socio=".$_GET["socio"]."'></font></h1></div>";
	}else{
		echo "<div align=center>";
		echo "<notif>¿ESTA SEGURO?</notif><br><br>";
		echo "<table class=tablas><tr>";
		echo "<td width=50%>
		<a href='historial_estimacion.php?borrar=".$_GET["borrar"]."&opcion=1&socio=".$_GET["socio"]."'>
		<notifsi>SI</notifsi>
		</a></td>";
		echo "<td width=50%><a href='historial_estimacion.php?socio=".$_GET["socio"]."'<notifno>NO</notifno></a></td>";
		echo "</tr></table></div>";
	}	
}

if(isset($_GET["actualiza"]) && isset($_GET["entregados"])){
	estimacion_actualizar($_GET["entregados"],$_GET["actualiza"]);
	echo "<div align=center><h1>ACTUALIZANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=?socio=".$_GET["socio"]."'></font></h1></div>";
}
else{
$socio = consultarCriterio('id',$_GET["socio"]);
$socio=$socio[0];	
$estatus=estimacion('',$_GET["socio"]);
echo "<div align=center><h1>Historial de estimados y entregados del socio</h1><br><h2>".$socio["nombres"]." ".$socio["apellidos"]."</h2><br>";
echo "<br><table class=tablas><tr><th colspan=4><h2>Historial</h2></th></tr>";
echo "<tr><th>Año</th><th>Estimado (qq)</th><th>Entregado (qq)</th><th>Borrar</th></tr>";

if (is_array($estatus)) {		
	foreach ($estatus as $estado){
		if($estado["year"]==0){$estado["year"]="fecha desconocida";}
		echo "<tr><td align=center>";	
		echo "<h4>".$estado["year"]."</h4>";
		echo "<td align=center>";	
		echo "<h4>".$estado["estimados"]."</h4></td>";
		echo "<td align=center>";	
		echo "<h4>".$estado["entregados"]."</h4></td>";
		echo "<td align=center>";	
		echo "<h4>";
		if(in_array($_SESSION['acceso'],$permisos_admin)){
			echo "<a href=?borrar=".$estado["id"]."&socio=".$_GET["socio"]."><img title='borrar este estado' src=images/cross.png width=25></a>";
		}
			echo "</h4></td></tr>";
	}
}else {
	echo "<tr><td align=center>";	
	echo "<h4>SIN ESTIMACIONES</h4>";
	echo "<td align=center>";	
	echo "<h4></h4></td>";
	echo "<td align=center>";	
	echo "<h4>";	
}
$estimado_actual=estimacion('actual',$_GET["socio"]);
$estimado_actual=$estimado_actual[0];
echo "</table>";
echo "<br><br>";

$resultado_lotes=LotesConsultarid_fecha($_GET["socio"],$estimado_actual["year"]);
if (is_array($resultado_lotes)) {
	foreach ($resultado_lotes as $lot) {
		$pesos_del_socio[]=$lot["peso"];
	}
}else{
	$pesos_del_socio="0";
}

if (is_array($pesos_del_socio)) {
	$peso_entregado=array_sum($pesos_del_socio);
}else{
	$peso_entregado=$pesos_del_socio;
}

$peso_restante=$estimado_actual["estimados"]-$peso_entregado;
$diferencia=round($peso_entregado,2)-$estimado_actual["entregados"];
if(in_array($_SESSION['acceso'],$permisos_admin) && $diferencia<>0){
	echo "<h4>Entregado en ".$estimado_actual["year"].": $peso_entregado qq <br><br>";
}

$estimado_actualizado=$estimado_actual['id'];
echo "<table class=tablas><tr>";
if(in_array($_SESSION['acceso'],$permisos_general)){
	echo "<td><a href=ficha_socio.php?user=".$_GET["socio"]."><h3>VOLVER</h3></a></td>";
}
if(in_array($_SESSION['acceso'],$permisos_admin)){
	echo "<td><a href=historial_estimacion_nuevo.php?socio=".$_GET["socio"]."><h3>AÑADIR</h3></a></td>";
}
if(in_array($_SESSION['acceso'],$permisos_admin) && $diferencia<>0){
	echo "<td><a href=historial_estimacion.php?actualiza=$estimado_actualizado&entregados=$peso_entregado&socio=".$_GET["socio"]."><h3>ACTUALIZAR ENTREGADO EN ".$estimado_actual["year"]."</h3></a></td>";
}

echo "</tr></table>";
	
}

include("pie.php");
?>