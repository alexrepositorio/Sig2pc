<?php
include ("cabecera.php");
include ("socio_funciones.php");
include ("grupos_funciones.php");
include ("certificaciones_funciones.php");
include ("configuracion_funciones.php");

if(!isset($_GET["criterio"]))
{
	$_POST["busca"]="";
	$criterio="";
	$encontrados="";
	$resultado=LotesConsultarCriterio('','');
}else{
	if(isset($_GET["socio"])){
		$_POST["busca"]=$_GET["socio"];
	}
	if (!isset($_POST["busca"])) {
		$resultado=LotesConsultarCriterio($_GET["criterio"],'');
	}else{
		if (isset($_POST["busca2"])) {
			$resultado=LotesConsultarfecha($_POST["busca"],$_POST["busca2"]);
		}else{
			$resultado=LotesConsultarCriterio($_GET["criterio"],$_POST["busca"]);
		}
	}
	$encontrados="ENCONTRADOS";
	$envio_val = $_GET["criterio"];
	
	$criterio="<h4>Criterio de búsqueda: <b>".$_GET["criterio"]."</b> <i></i></h4>";
}
if (is_array($resultado)) {
	$cuenta=count($resultado);
	foreach ($resultado as $row) {
		$lotes[]=$row;
		$pesos[]=$row["peso"];
	}
}else{
	$cuenta=$resultado;
	$pesos[]=0;
}
echo "<div align=center><h1>Listado de lotes</h1><br><br>";
echo "<table border=0 cellpadding=0 cellspacing=10><tr>";
echo "<td align=center><a href=lotes.php?criterio=organico>";
echo "<img src=images/organico.png width=50><br><h4>Orgánicos</a>";
echo "</td>";
echo "<td align=center><a href=lotes.php?criterio=no_organico>";
echo "<img src=images/noorganico.png width=50><br><h4>No Orgánicos</a>";
echo "</td>";
echo "<td align=center><h4>Socio<br><form name=form1 action=".$_SERVER['PHP_SELF']."?criterio=socio method='post'>";
echo "<select name=busca>";
//lotes_socios ();
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
		echo "<option value=".$grupo["id"].">".$grupo["grupo"]."</option>";
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
echo "<td align=center><a href=ficha_lote_nuevo.php>";
echo "<img src=images/add.png width=50><br><h4>nuevo</a>";
echo "</td>";

$sumatotal=array_sum($pesos);
echo "</tr></table>";
echo "<div align=center>$criterio<br>";
echo "<h4>Total de lotes: $cuenta pergamino total:$sumatotal qq  </h4> <br>";
echo "<table id='table_id' style='width: 60%' class='tablas' posicion>";
echo "<thead>";
		echo "<th width=500px>";
		echo "<h4>LOTES </h4>";
		echo "</th>";
		echo "<th width=15%><h6>opciones</h6></th>";
		echo "</thead>";
		echo "<tbody>";
if(isset($lotes))
{
	foreach ($lotes as $lote)
	{
		
		$datos_socio=consultarCriterio('id',$lote["id_socio"]);
		$datos_socio=$datos_socio[0];
		$estatus=certificacion('actual',$datos_socio["id_socio"]);
		$estatus_actual=$estatus[0];
		if(strpos($estatus_actual["estatus"], "O"))
			{
				$estatus_t="<img title='socio CON certificación orgánica' src=images/organico.png width=25>";
			}else{
				$estatus_t="<img title='socio SIN certificación orgánica' src=images/noorganico.png width=25>";
			}
		
		$trillado_gr=configuracion_cons('parametro','gr_muestra')[0]["valor"]-($lote["rto_exportable"]+$lote["rto_descarte"]);
		$trillado=100-($lote["rto_exportable"]+$lote["rto_descarte"])/configuracion_cons('parametro','gr_muestra')[0]["valor"]*100;
		$descarte_prc=($lote["rto_descarte"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)+1.5;
		$exportable_prc=($lote["rto_exportable"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)-1.5;
		$descarte_qq=($lote["peso"]*(1-($trillado)/100))*$descarte_prc/100;
		$exportable_qq=($lote["peso"]*(1-($trillado)/100))*$exportable_prc/100;
		$trillado_qq=$lote["peso"]*(($trillado)/100);
		
		echo "<tr>";
		echo "<td><a href=ficha_lote.php?lote=".$lote["id"]."><h3>".$lote["codigo_lote"]."<br><h4>".date("d-m-Y H:i",strtotime($lote["fecha"]))."<br>$estatus_t".$datos_socio["codigo"]."-".$datos_socio["apellidos"].", "
		.$datos_socio["nombres"]."<br> Pergamino:" .$lote["peso"]." qq <br><font size=1>(Exp. " .round($exportable_qq,1)." qq / Des. " .round($descarte_qq,1)." qq)</font> <br>Calidad: ".$lote["calidad"]."</td>";
		echo "</td>";
		echo "<td><a href=ficha_lote_editar.php?lote=".$lote["id"]."><img title=editar src=images/pencil.png width=25></a>
				  <a href=ficha_lote_borrar.php?lote=".$lote["id"]."><img title=borrar src=images/cross.png width=25></a>
				  </td></tr>";
	}
}
echo "<tbody>";
echo "</table></div>";
include("pie.php");
?>