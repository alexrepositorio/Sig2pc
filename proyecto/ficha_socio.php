<?php
include ("cabecera.php");
include ("socio_funciones.php");
include ("certificaciones_funciones.php");
include ("parcelas_funciones.php");
include ("altas_funciones.php");
include ("estimaciones_funciones.php");
include ("configuracion_funciones.php");

$socio = consultarCriterio('id',$_GET["user"]);
$socio=$socio[0];
$estatus=certificacion('actual',$_GET["user"]);
$estatus=$estatus[0];
if (is_array($estatus)) {
	$enlace_estatus="<a href=historial_certificacion.php?socio=".$_GET["user"]."><h3>Ver historial Certificacion</h3></a>";}
else{
	$enlace_estatus="<a href=ficha_socio_certificar.php?socio=".$_GET["user"]."><h3>Añadir Certificacion</h3></a>";
}
$estimado=estimacion('',$socio["id_socio"]);
if (is_array($estimado)) {
	$enlace_estimado="<a href=historial_estimacion.php?socio=".$_GET["user"]."><h3>Ver historial Estimacion</h3></a>";
}else{
	$enlace_estimado="<a href=historial_estimacion_nuevo.php?socio=".$_GET["user"]."><h3>Añadir Estimacion</h3></a>";
}
$altas=altas_consultar('actual',$socio["id_socio"]);
$altas=$altas[0];
if (is_array($altas)) {
	$enlace_altas="<a href=historial_altas.php?socio=".$_GET["user"]."><h3>Ver historial Altas</h3></a>";
}else{
	$enlace_altas="<a href=historial_altas_nuevo.php?socio=".$_GET["user"]."><h3>Añadir Altas</h3></a>";
}
$resultado_lotes=LotesConsultarCriterio('socio',$socio["id_socio"]);
$estimado_actual= estimacion('actual',$_GET["user"]);
$estimado_actual=$estimado_actual[0];
if (is_array($resultado_lotes)) {
	$cuenta_lotes=count($resultado_lotes);
	foreach ($resultado_lotes as $lot) {
		$pesos_del_socio[]=$lot["peso"];
	}
	$peso_entregado=array_sum($pesos_del_socio);
	$estimado_actual_max=$estimado_actual["estimados"]*(1+(configuracion_cons('parametro','margen_contrato')[0]["valor"]/100));
	$cuenta_lotes_t="(<font color=red><b>$cuenta_lotes</b></font>)";
	$peso_restante=$estimado_actual_max-$peso_entregado;
}else{
		$peso_entregado=0;
		$estimado_actual_max="";
		$peso_restante=$estimado_actual_max-$peso_entregado;	
		$cuenta_lotes_t="";
}

$r_par=parcelas_consultarCriterio('id_socio',$socio["id_socio"]);
if (is_array($r_par)) {
	$cuenta_parcelas=count($r_par);
	$cuenta_parcelas_t="(<font color=red><b>$cuenta_parcelas</b></font>)";
}
else{
	$cuenta_parcelas=0;
	$cuenta_parcelas_t="";
}

echo "<div id=imprimir>";
echo "<div align=center><h1>Ficha del socio</h1><br><h2>".$socio["nombres"]." ".$socio["apellidos"]."</h2><br>";
//muestra_array($socio);
echo "<table class=tablas>";
echo "<tr><th><h4>Nombres</th><td><h4>".$socio["nombres"]."</td></tr>";
echo "<tr><th><h4>Apellidos</th><td><h4>".$socio["apellidos"]."</td></tr>";
echo "<tr><th><h4>Código</th><td><h4>".$socio["codigo"]."</td></tr>";
echo "<tr><th><h4>Grupo</th><td><h4>".$socio["poblacion"]."</td></tr>";
echo "<tr><th><h4>Cédula</th><td><h4>".$socio["cedula"]."</td></tr>";
echo "<tr><th><h4>Fecha de nacimiento</th><td><h4>".$socio["f_nacimiento"]."</td></tr>";
echo "<tr><th><h4>email</th><td><h4>".$socio["email"]."</td></tr>";
echo "<tr><th><h4>Dirección</th><td><h4>".$socio["direccion"]."</td></tr>";
echo "<tr><th><h4>Cantón</th><td><h4>".$socio["canton"]."</td></tr>";
echo "<tr><th><h4>Provincia</th><td><h4>".$socio["provincia"]."</td></tr>";
echo "<tr><th><h4>Género</th><td><h4>".$socio["genero"]."</td></tr>";
echo "</table>";
echo "<br><br>";

echo "<div align=center>
<table class=tablas><tr>";
echo "<tr>";
echo "<td>".$enlace_estatus."";
if (is_array($estatus)) {
	echo "<table><tr><th><h4>Estatus actual<br>".$estatus["estatus"]." 
		<th><img title='socio CON certificación orgánica' src=images/organico.png width=25></th>;
				</tr></table>";
};
echo" </td>";
echo "<td>".$enlace_altas."";
if (is_array($altas)) {
	echo "<table><tr><th><h4>Estado actual<br>".$altas["estado"]." </th>
			<th><h4>Desde<br>".$altas["fecha"]." </th>				
			</tr></table>";
};
echo" </td>";
echo "<td>".$enlace_estimado."";
if (is_array($estimado_actual)) {
	echo "<table><tr><th><h4>Estimado<br>".$estimado_actual["estimados"]."qq<br><h6> (max $estimado_actual_max qq)</h4></th>
						   <th><h4>Entregado<br>$peso_entregado qq</h4></th>
						   <th><h4>Restante<br>$peso_restante qq</h4></th>
				</tr></table>";
};
echo" </td>";
echo "</tr>";


if(in_array($_SESSION['acceso'],$permisos_administrativos))
	{echo "<td><a href=ficha_socio_editar.php?user=".$_GET["user"]."><h3>EDITAR</h3></a></td>";
}
//if(in_array($_COOKIE['acceso'],$permisos_administrativos)){echo "<td><a href=ficha_socio_borrar.php?socio=".$_GET["socio"]."><h3>ELIMINAR</h3></a></td>";}
if(in_array($_SESSION['acceso'],$permisos_lotes) && is_array($estatus)){
	echo "<td><a href=ficha_lote_nuevo.php?socio=".$socio["id_socio"]."><h3>AÑADIR LOTE</h3></a></td>";
}
else{echo "<td align=center><h3><font color=red>NO SE PUEDE AÑADIR LOTE</font></h3><br>*Primero añada certificación y estado actual</td>";}
if(in_array($_SESSION['acceso'],$permisos_general) && is_array($resultado_lotes)){
	echo "<td><a href=lotes.php?criterio=socio&socio=".$socio["id_socio"]."><h3>VER LOTES $cuenta_lotes_t</h3></a></td>";
}
if(in_array($_SESSION['acceso'],$permisos_general) && $cuenta_parcelas>0){
	echo "<td><a href=parcelas.php?criterio=socio&socio=".$socio["id_socio"]."><h3>VER PARCELAS $cuenta_parcelas_t</h3></a></td>";
}
echo "</tr></table></div>";

		
include("pie.php");
?>