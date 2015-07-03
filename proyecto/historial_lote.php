<?php
include ("cabecera.php");
include ("funciones_lotes.php");

$id_lote = $_GET["lote"];
busqueda_lote_id($id_lote);

$trillado_gr=$config["gr_muestra"]-($lote["rto_exportable"]+$lote["rto_descarte"]);
$trillado=100-($lote["rto_exportable"]+$lote["rto_descarte"])/$config["gr_muestra"]*100;
$descarte_prc=($lote["rto_descarte"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)+1.5;
$exportable_prc=($lote["rto_exportable"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)-1.5;
$descarte_qq=($lote["peso"]*(1-($trillado)/100))*$descarte_prc/100;
$exportable_qq=($lote["peso"]*(1-($trillado)/100))*$exportable_prc/100;
$trillado_qq=$lote["peso"]*(($trillado)/100);


$estados["entrada"] ="<h6>Registro el ".date("d-m-Y H:i:s",strtotime($lote["fecha"]))."
<br>Cantidad:".$lote["peso"]." qq pergamino
<br>Humedad:".$lote["humedad"]."%
<br>Exportable:".round($exportable_prc,2)."% (".round($exportable_qq,2)." qq)
<br>Descarte:".round($descarte_prc,2)."% (".round($descarte_qq,2)." qq)
<br>Trillado:".$trillado."%</h6>";

$codigo_lote = $lote["codigo_lote"];
busqueda_lotes_catas ($codigo_lote);

if($cuenta_c==0)
{
	$estados["cata"]="<h6><font color=red>PENDIENTE DE CATA</font></h6>";$movimientos[]="PENDIENTE DE CATA";
}else{
	while($cata = mysqli_fetch_array($r_c,MYSQLI_ASSOC))
	{
		$estados["cata"] ="<h6>Cata el ".date("d-m-Y H:i:s",strtotime($cata["fecha"]))."<br>puntuacion:".$cata["puntuacion"]."</h6>";
	}
}
lotes_pagos($codigo_lote);

if($cuenta_p==0)
{
	$estados["pago"]="<h6><font color=red>PENDIENTE DE PAGO</font></h6>";$movimientos[]="PENDIENTE DE PAGO";
}else{
	while($pago = mysqli_fetch_array($r_p,MYSQLI_ASSOC))
	{
		$total=$
		+["exportable"]+$pago["descarte"]+$pago["calidad"]+$pago["fuera"]+$pago["cliente"]+$pago["microlote"]+$pago["tazadorada"];	
		$estados["pago"]= "<h6>Pagado el ".date("d-m-Y H:i:s",strtotime($pago["fecha"]))."<br>
		exportable: $".$pago["exportable"]."<br>
		descarte: $".$pago["descarte"]."<br>
		fuera de contrato: $".$pago["fuera"]."<br>
		calidad: $".$pago["calidad"]."<br>
		cliente: $".$pago["cliente"]."<br>
		microlote: $".$pago["microlote"]."<br>
		taza dorada: $".$pago["tazadorada"]."<hr>
		<font color=blue>Total: $".$total."</h6>";
		$movimientos[]=$total;
	}
}
$codigo_lote_pago = $lote["codigo_lote"];
lotes_despachos($codigo_lote_pago)($codigo_lote_pago);

if($cuenta!==0)
{
	while($despacho = mysqli_fetch_array($res_des,MYSQLI_ASSOC))
	{
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
$estados["despachoS"]=implode("", $despachos);

$socio=nombre_socio($lote["id_socio"]);
$estatus=certificacion($lote["id_socio"]);
$estatus_actual=max(array_keys($estatus));
$estimado=estimacion($lote["id_socio"]);
$estimado_actual=max(array_keys($estimado));

$altas=altas_bajas($lote["id_socio"]);
$ultimafecha=max(array_keys($altas));

if($ultimafecha==0)
{
	$ultimafecha="\"fecha desconocida\"";
}else{
	$ultimafecha=date("d-m-Y",strtotime($ultimafecha));
}
if($estatus[$estatus_actual]["estatus"]=="O")
{
	$estatus_t="ORGANICO";
}else{
	$estatus_t="CONVENCIONAL";
}

$id_socio_lote = $socio["codigo"];
$fecha_lote = $estimado[$estimado_actual]["year"];

busqueda_lote_id_fecha($id_socio_lote, $fecha_lote);

while($lot = mysqli_fetch_array($resultado_lotes,MYSQLI_ASSOC))
{
	$pesos_del_socio[]=$lot["peso"];	
}
$peso_entregado=array_sum($pesos_del_socio);
$estimado_actual_max=$estimado[$estimado_actual]["estimados"]*(1+($config["margen_contrato"]/100));
$peso_restante=$estimado_actual_max-$peso_entregado;

echo "<div id=imprimir>";
echo "<div align=center><h1>Ficha del lote ".$lote["codigo_lote"]."</h1><br><h2>".$socio["apellidos"].", ".$socio["nombres"]."<br>
					".$socio["codigo"]."-".$socio["poblacion"]."</h2><br>
					<h3>Estatus Certificación ".$estatus[$estatus_actual]["year"].": $estatus_t (".$estatus[$estatus_actual]["estatus"].")<br><br>";

if (in_array($_COOKIE['acceso'],$permisos_admin))
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
if (in_array($_COOKIE['acceso'],$permisos_lotes)){echo "<th><a href=ficha_lote.php?lote=".$_GET["lote"]."><h3>VOLVER</h3></a></td>";}
if (in_array($_COOKIE['acceso'],$permisos_administrativos)){echo "<th><a href=ficha_socio.php?socio=".$lote["id_socio"]."><h3>VER SOCIO</h3></a></td>";}
if (in_array($_COOKIE['acceso'],$permisos_administrativos)){echo "<th><a href=lotes.php?criterio=socio&socio=".$lote["id_socio"]."><h3>LOTES SOCIO</h3></a></td>";}

echo "</tr></table></div>";
include("pie.php");
?>	