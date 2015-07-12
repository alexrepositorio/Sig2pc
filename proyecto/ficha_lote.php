<?php
include ("cabecera.php");
include ("configuracion_funciones.php");
include ("socio_funciones.php");
include ("certificaciones_funciones.php");
include ("estimaciones_funciones.php");
include ("altas_funciones.php");

$id_lote = $_GET["lote"];
$lote=LotesConsultarCriterio('id',$_GET["lote"]);
$lote=$lote[0];

$trillado_gr=configuracion_cons('parametro','gr_muestra')[0]["valor"]-($lote["rto_exportable"]+$lote["rto_descarte"]);
$trillado=100-($lote["rto_exportable"]+$lote["rto_descarte"])/configuracion_cons('parametro','gr_muestra')[0]["valor"]*100;
$descarte_prc=($lote["rto_descarte"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)+1.5;
$exportable_prc=($lote["rto_exportable"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)-1.5;
$descarte_qq=($lote["peso"]*(1-($trillado)/100))*$descarte_prc/100;
$exportable_qq=($lote["peso"]*(1-($trillado)/100))*$exportable_prc/100;
$trillado_qq=$lote["peso"]*(($trillado)/100);

$r_p=pagos_consultar_criterio('lote',$_GET["lote"]);
if (!is_array($r_p)) {
	$estados["pago"]="<h6><font color=red>PENDIENTE DE PAGO</font></h6>";
	$movimientos[]="PENDIENTE DE PAGO";
}else{
	foreach ($r_p as $pago) {
		$total=$pago["exportable"]+$pago["descarte"]+$pago["calidad"]+$pago["fuera"]+$pago["cliente"]+$pago["microlote"]+$pago["tazadorada"];	
	}
}

$res_des=despachos_consultar_criterio('lote',$_GET["lote"]);
if (is_array($res_des)) {
	foreach ($res_des as $despacho) {
		$despachados[]=$despacho["cantidad"];
		$despachos[]="<h6>".$despacho["cantidad"]." qq el ".
								date("d-m-Y",strtotime($despacho["fecha"])).
								" a ". $despacho["destino"]."<br></h6>";
	}
}else{
	$despachados[]=0;
		$despachos[]="<h6><font color=red>SIN DESPACHAR</font></h6>";
}

$total_despacho=array_sum($despachados);	
$restante=$lote["peso"]-$total_despacho;
$despachos[]="<hr><h6><font color=blue>Total despachado:".$total_despacho." qq<br>Restante:".$restante."qq</font>";	

$socio=consultarCriterio('id',$lote["id_socio"]);
$socio=$socio[0];
$estatus=certificacion('actual',$lote["id_socio"]);
$estatus_actual=$estatus[0];
$estimado=estimacion('actual',$lote["id_socio"]);
$estimado_actual=$estimado[0];

$altas=altas_consultar('actual',$lote["id_socio"]);

if($estatus_actual["estatus"]=="O")
{
	$estatus_t="ORGANICO";
}else{
	$estatus_t="CONVENCIONAL";
}

$resultado_lotes=LotesConsultarid_fecha($socio["id_socio"], $estimado_actual["year"]);
if (is_array($resultado_lotes)) {
	$cuenta_lotes=count($resultado_lotes);
	foreach ($resultado_lotes as $lot) {
		$pesos_del_socio[]=$lot["peso"];
	}
	$peso_entregado=array_sum($pesos_del_socio);
}else{
	$cuenta_lotes=0;
	$peso_entregado=0;
}
	$estimado_actual_max=$estimado_actual["estimados"]*(1+(configuracion_cons('parametro','margen_contrato')[0]["valor"]/100));
	$peso_restante=$estimado_actual_max-$peso_entregado;
echo "<div id=imprimir>";
echo "<div align=center><h1>Ficha del lote</h1><br><h2>".$socio["apellidos"].", ".$socio["nombres"]."<br>
					".$socio["codigo"]."-".$socio["poblacion"]."</h2><br>
					<h3>Estatus Certificación ".$estatus_actual["year"].": $estatus_t (".$estatus_actual["estatus"].")<br><br>";
echo "
<table class=tablas><tr>
<td><h4>Estimacion ".$estimado_actual["year"]."</td><td><h4>".$estimado_actual["estimados"]."qq</h4><br><h6>(max $estimado_actual_max qq)</td></tr>
<tr><td><h4>Entregados hasta ahora</td><td><h4>".$peso_entregado."qq ($cuenta_lotes lotes)</td></tr>
<tr><th><h4>Restante</th><th><h4>$peso_restante qq</th>
</tr></table><br><br>";
echo "<table class=tablas><tr><td align=center>";
echo "<table class=tablas>";
echo "<tr><th><h4>Fecha</th><td><h4>".$lote["fecha"]."</td></tr>";
echo "<tr><th><h4>Lote</th><td><h4>".$lote["codigo_lote"]."</td></tr>";
echo "</table><br><br>";
echo "<table class=tablas>";
echo "<tr><th align=right><h4>Pergamino</th><td colspan=3 align=right><h4>".$lote["peso"]." qq</td></tr>";
echo "<tr><th align=right><h4>Humedad</th><td colspan=3 align=right><h4>".round($lote["humedad"],0)." %</td></tr>";
echo "<tr><th align=right><h4>Exportable</th><td align=right><h4>".$lote["rto_exportable"]."<font size=1>gr/".configuracion_cons('parametro','gr_muestra')[0]["valor"]."</td><td align=right><h4>".round($exportable_prc,1)."%</td><td align=right><h4>".round($exportable_qq,2)." qq</td></tr>";
echo "<tr><th align=right><h4>Descarte</th><td align=right><h4>".$lote["rto_descarte"]."<font size=1>gr/".configuracion_cons('parametro','gr_muestra')[0]["valor"]."</td><td align=right><h4>".round($descarte_prc,1)."%</td><td align=right><h4>".round($descarte_qq,2)." qq</td></tr>";
echo "<tr><th align=right><h4>Trillado</th><td align=right><h4>".$trillado_gr."<font size=1>gr/".configuracion_cons('parametro','gr_muestra')[0]["valor"]."</td><td align=right><h4>".round($trillado,1)." %</td><td align=right><h4>".round($trillado_qq,2)." qq</td></tr>";
echo "</table>&nbsp&nbsp";
echo "<table class=tablas>";
echo "<tr><th align=right><h4>Defectos</th><th>granos</th>";
echo "<tr><th align=right><h4>Negro o parcial</th><td><h4>".$lote["defecto_negro"]."</td></tr>";
echo "<tr><th align=right><h4>Vinagre o parcial</th><td><h4>".$lote["defecto_vinagre"]."</td></tr>";
echo "<tr><th align=right><h4>Decolorado</th><td><h4>".$lote["defecto_decolorado"]."</td></tr>";
echo "<tr><th align=right><h4>Mordidos y cortados</th><td><h4>".$lote["defecto_mordido"]."</td></tr>";
echo "<tr><th align=right><h4>Brocados</th><td><h4>".$lote["defecto_brocado"]."</td></tr>";
echo "</table><br><br>";
echo "<table width=500 class=tablas>";
echo "<tr><th width=33% align=center><h4>Olor</th>
		  <th width=33% align=center><h4>Calidad</th>";	  
echo "<tr><td align=left><h4>".yes_no($lote["reposo"])." Reposo<br>
							   ".yes_no($lote["moho"])." Moho<br>
							   ".yes_no($lote["fermento"])." Fermento<br>
							   ".yes_no($lote["contaminado"])." Contaminado</td>
		  <td align=center><h1><font color=red>".$lote["calidad"]."</font></h1></td>";
echo "</tr></table>";
echo "<br><br>";
if (in_array($_SESSION['acceso'],$permisos_admin))
{			
	echo "<a href=historial_lote.php?lote=".$lote["id"]."><img width=30 src=images/history.png><br><h6>Ver historial</a><br>";		
}
echo "</td></tr></table>";
echo "</div></div><br><br>";
?>
<div align=center><a href="javascript:imprimir('imprimir')"><img width=25 src=images/imprimir.png><br><h6>Imprimir ficha</a></div>
<?php

echo "<br><br><div align=center><table class=tablas><tr>";
if (in_array($_SESSION['acceso'],$permisos_lotes)){
	echo "<th><a href=ficha_lote_editar.php?lote=".$_GET["lote"]."><h3>EDITAR</h3></a></td>";
}
if (in_array($_SESSION['acceso'],$permisos_lotes)){
	echo "<th><a href=ficha_lote_borrar.php?lote=".$_GET["lote"]."><h3>ELIMINAR</h3></a></td>";
}
if (in_array($_SESSION['acceso'],$permisos_administrativos)){
	echo "<th><a href=ficha_socio.php?user=".$lote["id_socio"]."><h3>VER SOCIO</h3></a></td>";
}
if (in_array($_SESSION['acceso'],$permisos_administrativos)){
	echo "<th><a href=lotes.php?criterio=socio&socio=".$lote["id_socio"]."><h3>LOTES SOCIO</h3></a></td>";
}
echo "</tr></table></div>";
include("pie.php");
?>