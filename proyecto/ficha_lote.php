<?php
include ("cabecera.php");

$SQL="SELECT * FROM lotes where id=".$_GET["lote"];
$resultado=mysqli_query($link, $SQL);
$lote = mysqli_fetch_array($resultado,MYSQLI_ASSOC);

$trillado_gr=$config["gr_muestra"]-($lote["rto_exportable"]+$lote["rto_descarte"]);
$trillado=100-($lote["rto_exportable"]+$lote["rto_descarte"])/$config["gr_muestra"]*100;
$descarte_prc=($lote["rto_descarte"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)+1.5;
$exportable_prc=($lote["rto_exportable"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)-1.5;
$descarte_qq=($lote["peso"]*(1-($trillado)/100))*$descarte_prc/100;
$exportable_qq=($lote["peso"]*(1-($trillado)/100))*$exportable_prc/100;
$trillado_qq=$lote["peso"]*(($trillado)/100);

/*
$estados["entrada"] ="<h6>Registro el ".date("d-m-Y H:i:s",strtotime($lote["fecha"]))."
<br>Cantidad:".$lote["peso"]." qq pergamino
<br>Humedad:".$lote["humedad"]."%
<br>Exportable:".round($exportable_prc,2)."% (".round($exportable_qq,2)." qq)
<br>Descarte:".round($descarte_prc,2)."% (".round($descarte_qq,2)." qq)
<br>Trillado:".$trillado."%</h6>";

$SQL_cata="SELECT * FROM catas where lote='".$lote["codigo_lote"]."'";
$r_c=mysqli_query($link, $SQL_cata);
$cuenta_c=mysqli_num_rows($r_c);
if($cuenta_c==0){$estados["cata"]="<h6><font color=red>PENDIENTE DE CATA</font></h6>";$movimientos[]="PENDIENTE DE CATA";}
else{
	while($cata = mysqli_fetch_array($r_c,MYSQLI_ASSOC))
	{
		$estados["cata"] ="<h6>Cata el ".date("d-m-Y H:i:s",strtotime($cata["fecha"]))."<br>puntuacion:".$cata["puntuacion"]."</h6>";
	}
}*/

$SQL_pago="SELECT * FROM pagos where lote='".$lote["codigo_lote"]."' ORDER BY fecha asc";
$r_p=mysqli_query($link, $SQL_pago);
$cuenta_p=mysqli_num_rows($r_p);
if($cuenta_p==0){$estados["pago"]="<h6><font color=red>PENDIENTE DE PAGO</font></h6>";$movimientos[]="PENDIENTE DE PAGO";}else{
	while($pago = mysqli_fetch_array($r_p,MYSQLI_ASSOC))
	{
		$total=$pago["exportable"]+$pago["descarte"]+$pago["calidad"]+$pago["fuera"]+$pago["cliente"]+$pago["microlote"]+$pago["tazadorada"];	
/*		$estados["pago"]= "<h6>Pagado el ".date("d-m-Y H:i:s",strtotime($pago["fecha"]))."<br>
		exportable: $".$pago["exportable"]."<br>
		descarte: $".$pago["descarte"]."<br>
		fuera de contrato: $".$pago["fuera"]."<br>
		calidad: $".$pago["calidad"]."<br>
		cliente: $".$pago["cliente"]."<br>
		microlote: $".$pago["microlote"]."<br>
		taza dorada: $".$pago["tazadorada"]."<hr>
		<font color=blue>Total: $".$total."</h6>";
		$movimientos[]=$total;*/
	}
}


		$SQL="SELECT despachos.id as cod, 
					 despachos.lote, 
					 despachos.fecha, 
					 despachos.cantidad, 
					 despachos.envio,
					 envios.destino 
					 FROM despachos 
					 INNER JOIN envios ON despachos.envio=envios.id WHERE lote='".$lote["codigo_lote"]."'";
		//echo "$SQL<br>";
		$res_des=mysqli_query($link, $SQL);
		$cuenta=mysqli_num_rows($res_des);
		if($cuenta!==0)
			{
				while($despacho = mysqli_fetch_array($res_des,MYSQLI_ASSOC))
				{
					//muestra_array($despacho);
					$despachados[]=$despacho["cantidad"];
					$despachos[]="<h6>".$despacho["cantidad"]." qq el ".
											date("d-m-Y",strtotime($despacho["fecha"])).
											" a ". $despacho["destino"]."<br></h6>";
				}
			}
		else{
					$despachados[]=0;
					$despachos[]="<h6><font color=red>SIN DESPACHAR</font></h6>";
			}

		$total_despacho=array_sum($despachados);	
		$restante=$lote["peso"]-$total_despacho;
		$despachos[]="<hr><h6><font color=blue>Total despachado:".$total_despacho." qq<br>Restante:".$restante."qq</font>";	
//		$estados["despachoS"]=implode("", $despachos);

		
		
$socio=nombre_socio($lote["id_socio"]);
$estatus=certificacion($lote["id_socio"]);
$estatus_actual=max(array_keys($estatus));
$estimado=estimacion($lote["id_socio"]);
$estimado_actual=max(array_keys($estimado));
//muestra_array($estimado);
$altas=altas_bajas($lote["id_socio"]);
$ultimafecha=max(array_keys($altas));
		if($ultimafecha==0){$ultimafecha="\"fecha desconocida\"";}else{$ultimafecha=date("d-m-Y",strtotime($ultimafecha));}
		if($estatus[$estatus_actual]["estatus"]=="O"){$estatus_t="ORGANICO";}else{$estatus_t="CONVENCIONAL";}

//lotes entregados por el socio
$SQL_lotes="SELECT * FROM lotes where id_socio='".$socio["codigo"]."' and date_format(fecha,'%Y') = '".$estimado[$estimado_actual]["year"]."'";
$resultado_lotes=mysqli_query($link, $SQL_lotes);
$cuenta_lotes=mysqli_num_rows($resultado_lotes);
while($lot = mysqli_fetch_array($resultado_lotes,MYSQLI_ASSOC)){
$pesos_del_socio[]=$lot["peso"];	
}
$peso_entregado=array_sum($pesos_del_socio);
$estimado_actual_max=$estimado[$estimado_actual]["estimados"]*(1+($config["margen_contrato"]/100));
$peso_restante=$estimado_actual_max-$peso_entregado;


echo "<div id=imprimir>";
echo "<div align=center><h1>Ficha del lote</h1><br><h2>".$socio["apellidos"].", ".$socio["nombres"]."<br>
					".$socio["codigo"]."-".$socio["poblacion"]."</h2><br>
					<h3>Estatus Certificación ".$estatus[$estatus_actual]["year"].": $estatus_t (".$estatus[$estatus_actual]["estatus"].")<br><br>";
		echo "
		<table class=tablas><tr>
		<td><h4>Estimacion ".$estimado[$estimado_actual]["year"]."</td><td><h4>".$estimado[$estimado_actual]["estimados"]."qq</h4><br><h6>(max $estimado_actual_max qq)</td></tr>
		<tr><td><h4>Entregados hasta ahora</td><td><h4>".$peso_entregado."qq ($cuenta_lotes lotes)</td></tr>
		<tr><th><h4>Restante</th><th><h4>$peso_restante qq</th>
		</tr></table><br><br>";
										



//muestra_array($socio);
echo "<table class=tablas><tr><td align=center>";

echo "<table class=tablas>";
echo "<tr><th><h4>Fecha</th><td><h4>".$lote["fecha"]."</td></tr>";
echo "<tr><th><h4>Lote</th><td><h4>".$lote["codigo_lote"]."</td></tr>";
echo "</table><br><br>";

echo "<table class=tablas>";
echo "<tr><th align=right><h4>Pergamino</th><td colspan=3 align=right><h4>".$lote["peso"]." qq</td></tr>";
echo "<tr><th align=right><h4>Humedad</th><td colspan=3 align=right><h4>".round($lote["humedad"],0)." %</td></tr>";
echo "<tr><th align=right><h4>Exportable</th><td align=right><h4>".$lote["rto_exportable"]."<font size=1>gr/".$config["gr_muestra"]."</td><td align=right><h4>".round($exportable_prc,1)."%</td><td align=right><h4>".round($exportable_qq,2)." qq</td></tr>";
echo "<tr><th align=right><h4>Descarte</th><td align=right><h4>".$lote["rto_descarte"]."<font size=1>gr/".$config["gr_muestra"]."</td><td align=right><h4>".round($descarte_prc,1)."%</td><td align=right><h4>".round($descarte_qq,2)." qq</td></tr>";
echo "<tr><th align=right><h4>Trillado</th><td align=right><h4>".$trillado_gr."<font size=1>gr/".$config["gr_muestra"]."</td><td align=right><h4>".round($trillado,1)." %</td><td align=right><h4>".round($trillado_qq,2)." qq</td></tr>";
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
//echo "		  <th width=33% align=center><h4>Apto Cata</th></tr>";
echo "<tr><td align=left><h4>".yes_no($lote["reposo"])." Reposo<br>
							   ".yes_no($lote["moho"])." Moho<br>
							   ".yes_no($lote["fermento"])." Fermento<br>
							   ".yes_no($lote["contaminado"])." Contaminado</td>
		  <td align=center><h1><font color=red>".$lote["calidad"]."</font></h1></td>";
//echo "	  <td align=center><h4>".yes_no($lote["apto_cata"])."<br></td>";
echo "</tr></table>";

echo "<br><br>";


if (in_array($_COOKIE['acceso'],$permisos_admin)){
			
echo "<a href=historial_lote.php?lote=".$lote["id"]."><img width=30 src=images/history.png><br><h6>Ver historial</a><br>";		
/*	
		//historial del lote ******************************************************************
		echo "<br><table class=tablas><tr><th><h2>Historial del lote</h2></th></tr>";
		echo "<tr><td align=center>";
		foreach ($estados as $titulo=>$estado1){
			echo "<h4>".strtoupper($titulo)."</h4><hr>";
			echo $estados[$titulo]."<br>";
		}
		echo "</td></tr></table>";
		//************************************************************************************

*/
}




echo "</td></tr></table>";


echo "</div></div><br><br>";
?>
<div align=center><a href="javascript:imprimir('imprimir')"><img width=25 src=images/imprimir.png><br><h6>Imprimir ficha</a></div>
<?php

echo "<br><br><div align=center><table class=tablas><tr>";
if (in_array($_COOKIE['acceso'],$permisos_lotes)){echo "<th><a href=ficha_lote_editar.php?lote=".$_GET["lote"]."><h3>EDITAR</h3></a></td>";}
if (in_array($_COOKIE['acceso'],$permisos_lotes)){echo "<th><a href=ficha_lote_borrar.php?lote=".$_GET["lote"]."><h3>ELIMINAR</h3></a></td>";}
if (in_array($_COOKIE['acceso'],$permisos_administrativos)){echo "<th><a href=ficha_socio.php?socio=".$lote["id_socio"]."><h3>VER SOCIO</h3></a></td>";}
//if (in_array($_COOKIE['acceso'],$permisos_pagos) && end($movimientos)!="salida"){echo "<th><a href=ficha_pago_nuevo.php?lote=".$_GET["lote"]."><h3>+ MOVIMIENTO</h3></a></td>";}
//if (in_array($_COOKIE['acceso'],$permisos_catador) AND $lote["calidad"]=="A"){echo "<th><a href=ficha_cata_nuevo.php?lote=".$lote["codigo_lote"]."><h3>CATA</h3></a></td>";}
if (in_array($_COOKIE['acceso'],$permisos_administrativos)){echo "<th><a href=lotes.php?criterio=socio&socio=".$lote["id_socio"]."><h3>LOTES SOCIO</h3></a></td>";}

echo "</tr></table></div>";



include("pie.php");
?>