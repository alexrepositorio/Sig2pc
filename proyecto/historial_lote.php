<?php
include ("cabecera.php");
include ("configuracion_funciones.php");
include ("catas_funciones.php");
include ("socio_funciones.php");
include ("certificaciones_funciones.php");
include ("altas_funciones.php");
include ("estimaciones_funciones.php");
$lote=LotesConsultarCriterio("id",$_GET["lote"]);
$lote=$lote[0];

$trillado_gr=configuracion_cons('parametro','gr_muestra')[0]["valor"]-($lote["rto_exportable"]+$lote["rto_descarte"]);
$trillado=100-($lote["rto_exportable"]+$lote["rto_descarte"])/configuracion_cons('parametro','gr_muestra')[0]["valor"]*100;
$descarte_prc=($lote["rto_descarte"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)+1.5;
$exportable_prc=($lote["rto_exportable"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)-1.5;
$descarte_qq=($lote["peso"]*(1-($trillado)/100))*$descarte_prc/100;
$exportable_qq=($lote["peso"]*(1-($trillado)/100))*$exportable_prc/100;
$trillado_qq=$lote["peso"]*(($trillado)/100);


$estados["entrada"] ="<h4>Registro el ".date("d-m-Y H:i:s",strtotime($lote["fecha"]))."
<br>Cantidad:".$lote["peso"]." qq pergamino
<br>Humedad:".$lote["humedad"]."%
<br>Exportable:".round($exportable_prc,2)."% (".round($exportable_qq,2)." qq)
<br>Descarte:".round($descarte_prc,2)."% (".round($descarte_qq,2)." qq)
<br>Trillado:".$trillado."%</h4>";

$r_c=catas_consultar('lote',$_GET["lote"]);
if (is_array($r_c)) {
	foreach ($r_c as $cata) {
		$estados["cata"] ="<h6>Cata el ".date("d-m-Y H:i:s",strtotime($cata["fecha"]))."<br>puntuacion:".$cata["puntuacion"]."</h6>";
	}
}else{
		$estados["cata"]="<h6><font color=red>PENDIENTE DE CATA</font></h6>";$movimientos[]="PENDIENTE DE CATA";
}
$r_p=LotesConsultarpagos($_GET["lote"]);
if (is_array($r_p)) {
	foreach ($r_p as $pago) {
		$total=$pago["exportable"]+$pago["descarte"]+$pago["calidad"]+$pago["fuera"]+$pago["cliente"]+$pago["microlote"]+$pago["tazadorada"];	
		$estados["pago"]= "<h4>Pagado el ".date("d-m-Y H:i:s",strtotime($pago["fecha"]))."<br>
		exportable: $".$pago["exportable"]."<br>
		descarte: $".$pago["descarte"]."<br>
		fuera de contrato: $".$pago["fuera"]."<br>
		calidad: $".$pago["calidad"]."<br>
		cliente: $".$pago["cliente"]."<br>
		microlote: $".$pago["microlote"]."<br>
		taza dorada: $".$pago["tazadorada"]."<hr>
		<font color=blue>Total: $".$total."</h4>";
		$movimientos[]=$total;
	}	
}else{
	$estados["pago"]="<h6><font color=red>PENDIENTE DE PAGO</font></h6>";$movimientos[]="PENDIENTE DE PAGO";
}
$res_des=despachos_consultar_criterio('lote',$_GET["lote"]);
if (is_array($res_des)) {
	foreach ($res_des as $despacho) {
		$despachados[]=$despacho["cantidad"];
		$despachos[]="<h4>".$despacho["cantidad"]." qq el ".
								date("d-m-Y",strtotime($despacho["fecha"])).
								" a ". $despacho["destino"]."<br></h4>";
	}
}else{
	$despachados[]=0;
	$despachos[]="<h6><font color=red>SIN DESPACHAR</font></h6>";
}

$total_despacho=array_sum($despachados);	
$restante=$lote["peso"]-$total_despacho;
$despachos[]="<hr><h4><font color=blue>Total despachado:".$total_despacho." qq<br>Restante:".$restante."qq</font>";	
$estados["despachoS"]=implode("", $despachos);

$socio=consultarCriterio("id",$lote["id_socio"]);
$socio=$socio[0];

$estatus=certificacion('actual',$lote["id_socio"]);
$estatus_actual=$estatus[0];

$estimado=estimacion('actual',$lote["id_socio"]);
$estimado_actual=$estimado[0];

$altas=altas_consultar('actual',$lote["id_socio"]);
$ultimafecha=$altas[0]['fecha'];
if($ultimafecha==0)
{
	$ultimafecha="\"fecha desconocida\"";
}else{
	$ultimafecha=date("d-m-Y",strtotime($ultimafecha));
}
if(strpos($estatus_actual["estatus"], "O"))
{
	$estatus_t="ORGANICO";
}else{
	$estatus_t="CONVENCIONAL";
}

$resultado_lotes=LotesConsultarid_fecha($socio["id_socio"],$estimado_actual["year"]);

if (is_array($resultado_lotes)) {
	foreach ($resultado_lotes as $lot) {
		$pesos_del_socio[]=$lot["peso"];	
	}
}else{
	$pesos_del_socio[]=0;
}

$peso_entregado=array_sum($pesos_del_socio);
$estimado_actual_max=$estimado_actual["estimados"]*(1+(configuracion_cons('parametro','margen_contrato')[0]["valor"]/100));
$peso_restante=$estimado_actual_max-$peso_entregado;
echo "<div id=imprimir>";
echo "<div align=center><h1>Ficha del lote ".$lote["codigo_lote"]."</h1><br><h2>".$socio["apellidos"].", ".$socio["nombres"]."<br>
					".$socio["codigo"]."-".$socio["poblacion"]."</h2><br>
					<h3>Estatus Certificación ".$estatus_actual["year"].": $estatus_t (".$estatus_actual["estatus"].")<br><br>";

if (in_array($_SESSION['acceso'],$permisos_admin))
{
		//historial del lote ******************************************************************
		echo "<table class=tablas><tr><th><h2>Historial del lote</h2></th></tr>";
		echo "<tr><td align=center>";
		foreach ($estados as $titulo=>$estado1)
		{
			echo "<h4>".strtoupper($titulo)."</h4><hr>";
			echo $estados[$titulo]."<br>";
		}
		echo "</td></tr></table>";
		//************************************************************************************
}
echo "</td></tr></table>";
echo "</div></div><br><br>";
?>
<div align=center><a href="javascript:imprimir('imprimir')"><img width=25 src=images/imprimir.png>Imprimir ficha</a></div>
<?php

echo "<br><br><div align=center><table class=tablas><tr>";
if (in_array($_SESSION['acceso'],$permisos_lotes)){echo "<th><a href=ficha_lote.php?lote=".$_GET["lote"]."><h3>VOLVER</h3></a></td>";}
if (in_array($_SESSION['acceso'],$permisos_administrativos)){echo "<th><a href=ficha_socio.php?user=".$lote["id_socio"]."><h3>VER SOCIO</h3></a></td>";}
if (in_array($_SESSION['acceso'],$permisos_administrativos)){echo "<th><a href=lotes.php?criterio=socio&socio=".$lote["id_socio"]."><h3>LOTES SOCIO</h3></a></td>";}

echo "</tr></table></div>";
include("pie.php");
?>	