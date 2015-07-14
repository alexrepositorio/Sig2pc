<?php
include ("cabecera.php");
include ("socio_funciones.php");
include ("grupos_funciones.php");
include ("configuracion_funciones.php");
include ("certificaciones_funciones.php");
include ("catas_funciones.php");

if(!isset($_GET["criterio"]))
{
	$resultado=LotesConsultarCriterio("","");
	$criterio="";
	$encontrados="";

}else{
	$encontrados="ENCONTRADOS";
	if (!isset($_POST["busca"])) {
		$resultado=LotesConsultarCriterio($_GET["criterio"],"");
	}
	else{	
		if (isset($_POST["busca2"])) {
			$resultado=LotesConsultarfecha($_POST["busca"],$_POST["busca2"]);
		}else{
			$resultado=LotesConsultarCriterio($_GET["criterio"],$_POST["busca"]);

		}
	}
	$criterio="<h4>Criterio de búsqueda: <b>".$_GET["criterio"]."</b> </h4>";
}
if (is_array($resultado)) {
	$cuenta=count($resultado);
}else{
	$cuenta=0;
}
if (is_array($resultado)) {
	foreach ($resultado as $row) {
		$lotes[]=$row;
		$pesos[]=$row["peso"];
	}
}
if(!isset($pesos)){
	$pesos[]=0;
}
echo "<div align=center><h1>Estado de almacén</h1><br><br>";
//*****************************************************************************************************
//busquedas
//*****************************************************************************************************
echo "<table width=700px border=0 cellpadding=0 cellspacing=0><tr>";
//echo "<td align=center></td><td align=center></td><td align=center></td></tr><tr>";

echo "<td align=center><br><form name=form0 action=".$_SERVER['PHP_SELF']."?criterio=socio method='post'>";
echo "</form></td>";

echo "<td align=center><h4>Socio<br><form name=form1 action=".$_SERVER['PHP_SELF']."?criterio=socio method='post'>";
echo "<select name=busca>";
$r_socio=consultarCriterio('','');
$lista=consultarCriterio('lotes','');
foreach ($lista as $rowsocio) {
	if($rowsocio["lotes"]>0)
	{
		if($rowsocio["lotes"]>1)
		{
			$lotes_t="lotes";
		}else{
				$lotes_t="lote";
		}
		$lotess="(".$rowsocio["lotes"]." $lotes_t)";
		$mark="style='background-color:skyblue; color:blue;'";
	}else{
		$mark="";
		$lotess="";
	}
	$socio_n=$rowsocio["codigo"]."-".$rowsocio["apellidos"].", ".$rowsocio["nombres"]." $lotess";
	echo "<option $mark value='".$rowsocio["id_socio"]."'>$socio_n</option>";
}
echo "</select><br>";
echo "<input type='submit' value='buscar'>";
echo "</form></td>";

echo "<td align=center><h4>Grupo<br><form name=form2 action=".$_SERVER['PHP_SELF']."?criterio=localidad method='post'>";
echo "<input list='grupos' name='busca' placeholder='Seleccione...'>";	
	echo "<datalist  id='grupos'>";	
	//echo "<option value=".$socio["poblacion"].">".$socio["poblacion"]."</option>";
	$grupos=consultarGrupo('','');
 	foreach ($grupos as $grupo)
	{
		echo "<option>".$grupo["grupo"]."</option>";
	}
	echo "</datalist></br>";
	echo "<input type='submit' value='filtrar'>";
echo "</form></td>";

echo "<td align=center><h4>Fecha<br>
	<form name=form3 action=".$_SERVER['PHP_SELF']."?criterio=fecha method='post'>";
	echo "
		<label for='desde'>Desde:</label>
		<input type='date' name='busca' id='desde' >
		<label for='hasta'>Hasta:</label>
		<input type='date' name='busca2' id='hasta'>
	";
	echo "<input type='submit' value='filtrar'>";
	echo "</form></td>";
echo "</tr></table>";

//*****************************************************************************************************
//fin busquedas
//*****************************************************************************************************
$sumatotal=array_sum($pesos);
echo "<div align=center>$criterio<br>";
	echo "<h4>Total de lotes: $cuenta Total pergamino: $sumatotal qq </h4><br>";
echo "<table id='table_id' style='width: 80%' class='tablas' posicion>";
echo "<thead>";
	echo "<th>";
	echo "<h4>LOTES</h4>";
	echo "</th>";
	echo "<th width=10px><h6>rend.</h6></th>";
	echo "<th width=10px><h6>org.</h6></th>";
	echo "<th width=10px><h6>cata</h6></th>";
	echo "<th width=10px><h6>lote (pergamino)</h6></th>";
	echo "<th width=10px><h6>despachado</h6></th>";
	echo "<th width=10px><h6>restante</h6></th>";
	echo "<th width=10px><h6>despachar</h6></th>";
echo "</thead>";
echo "<tbody>";
	

if(isset($lotes)){
	foreach ($lotes as $lote)
	{
		$datos_socio=consultarCriterio("id",$lote["id_socio"]);
		$estatus=certificacion('actual',$lote["id_socio"]);
		if (isset($estatus)) {
			if (strpos($estatus[0]["estatus"], 'O')) {
				$estatus_t="<img title='socio CON certificación orgánica' src=images/organico.png width=25>";
			}else{
				$estatus_t="<img title='socio SIN certificación orgánica' src=images/noorganico.png width=25>";
			}
		}
		$trillado_gr=configuracion_cons('parametro','gr_muestra')[0]["valor"]-($lote["rto_exportable"]+$lote["rto_descarte"]);
		$trillado=100-($lote["rto_exportable"]+$lote["rto_descarte"])/configuracion_cons('parametro','gr_muestra')[0]["valor"]*100;
		$descarte_prc=($lote["rto_descarte"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)+1.5;
		$exportable_prc=($lote["rto_exportable"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)-1.5;
		$descarte_qq=round(($lote["peso"]*(1-($trillado)/100))*$descarte_prc/100,2);
		$exportable_qq=round(($lote["peso"]*(1-($trillado)/100))*$exportable_prc/100,2);
		$trillado_qq=$lote["peso"]*(($trillado)/100);
		$suma_trillado=$descarte_qq+$exportable_qq;

		$res_cata=catas_consultar('lote',$lote["id"]);
		if (is_array($res_cata)) {
			$cata=$res_cata[0];
			$unidades_cata=" pts";
		}else{
			$cata["puntuacion"]="<font color=red>Pendiente</font>";
			$unidades_cata="";
		}
		unset($cantidades); 
		unset($despachos_del_lote); 
		$res_des=despachos_consultar_criterio('lote',$lote["id"]);
		if (is_array($res_des)) {
			if (count($res_des,COUNT_RECURSIVE)/6>1) {
				foreach ($res_des as $despacho) {
						$despachos_del_lote[]="<a href=ficha_despacho_editar.php?despacho=".$despacho['id']."&lote=".
											$lote['id']."&cantidad=".$lote['peso'].">"
											.$despacho['cantidad']."qq ".
											date("d-m-Y",strtotime($despacho["fecha"])).
											" a ". $despacho['destino']."</a>
											<a href=ficha_despacho_borrar.php?despacho=".$despacho['id']."&lote=".$lote['id'].">
											<img title=borrar src=images/cross.png width=10></a>";
					$cantidades[]=$despacho["cantidad"];
					
				}
			}else {
				$despachos_del_lote[]="<a href=ficha_despacho_editar.php?despacho=".$res_des["id"]."&lote=".
											$lote["codigo_lote"]."&cantidad=".$lote["peso"].">"
											.$res_des["cantidad"]."qq ".
											date("d-m-Y",strtotime($res_des["fecha"])).
											" a ". $res_des["destino"]."</a>
											<a href=ficha_despacho_borrar.php?despacho=".$despacho["id"]."&lote=".$lote["codigo_lote"].">
											<img title=borrar src=images/cross.png width=10></a>";
									$cantidades[]=$res_des["cantidad"];
			}
		}else{
			$despachos_del_lote[]="<font color=red>SIN<br>DESPACHAR</font>";
			 $cantidades[]=0;
			}
		$cantidad_despachada=round(array_sum($cantidades),2);
		$unidades_despachadas="qq";
		$restante=round($lote["peso"],2)-$cantidad_despachada;
		if($cata["puntuacion"]<configuracion_cons('parametro','extra_cata')[0]["valor"] && configuracion_cons('parametro','puntuacion')[0]["valor"] >0 || $lote["calidad"]<>"A")
		{
			$pago["calidad"]="<font color=blue>No Apto</font>";
		}
		if($lote["calidad"]<>"A"){
			$cata["puntuacion"]="<font color=blue>No Apto</font>";
			$unidades_cata="";
		}
		echo "<tr>";
		echo "<td><h3>".$lote["codigo_lote"]."<br><h4>".date("d-m-Y H:i",strtotime($lote["fecha"]))."<br>".$datos_socio[0]["codigo"]."-".$datos_socio[0]["apellidos"].", ".$datos_socio[0]["nombres"]."<br>" .$lote["peso"]." qq pergamino</h4></td>";
		echo "</td>";
		echo "<td align=center>".$lote["humedad"]."% HR<br>".round($exportable_qq,1)."qq EXP.<br>".round($descarte_qq,1)."qq DES.</td>";
		echo "<td align=center><h4>$estatus_t</td>";
		echo "<td align=center><h4>".$cata["puntuacion"]." $unidades_cata</td>";
		echo "<td align=center><h4>".round($lote["peso"],2)." qq</td>";
		echo "<td align=center>".implode("<br>", $despachos_del_lote)."<hr>Total: $cantidad_despachada $unidades_despachadas</td>";
		echo "<td align=center><h4>".round($restante,2)." qq</td>";
		echo "<td align=center>";
		if($restante>0){
			echo "<a href=ficha_despacho_nuevo.php?lote=".$lote["id"]."&restante=$restante><img title='añadir despacho al lote' src=images/add.png width=25></a>";
		}
			echo "	  </td></tr>";	
	}
}
echo "</table></div>";
include("pie.php");

?>