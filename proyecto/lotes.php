<?php
include ("cabecera.php");
include ("lote_funciones.php");
include ("socio.php");
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
	if(isset($_GET["socio"]))
	{
		$_POST["busca"]=$_GET["socio"];
	}
	$encontrados="ENCONTRADOS";
	$envio_val = $_GET["criterio"];
	
	$resultado=LotesConsultarCriterio('socio',$_GET["criterio"]);

	$criterio="<h4>Criterio de búsqueda: <b>".$_GET["criterio"]."</b> es <i>''$_texto''</i></h4>";
}
                        
//$resultado=mysqli_query($link, $SQL);

$cuenta=count($resultado);
foreach ($resultado as $row) {
	$lotes[]=$row;
	$pesos[]=$row["peso"];
}
if(!isset($pesos))
{
	$pesos[]=0;
}

echo "<div align=center><h1>Listado de lotes</h1><br><br>";
echo "<table border=0 cellpadding=0 cellspacing=10><tr>";
echo "<td align=center><a href=lotes.php?criterio=organico&opcion=si>";
echo "<img src=images/organico.png width=50><br><h4>Orgánicos</a>";
echo "</td>";
echo "<td align=center><a href=lotes.php?criterio=organico&opcion=no>";
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
		$mark="";$lotess="";
	}
	$socio_n=$rowsocio["codigo"]."-".$rowsocio["apellidos"].", ".$rowsocio["nombres"]." $lotess";
	echo "<option $mark value='".$rowsocio["codigo"]."'>$socio_n</option>";
}

echo "</select><br>";
echo "<input type='submit' value='buscar'>";
echo "</form></td>";
echo "<td align=center><h4>Grupo<br><form name=form2 action=".$_SERVER['PHP_SELF']."?criterio=localidad method='post'>";
echo "<input list='grupos' name='busca' required>";	
	echo "<datalist  id='grupos'>";	
	//echo "<option value=".$socio["poblacion"].">".$socio["poblacion"]."</option>";
	$grupos=consultarGrupo('lista','');
 	foreach ($grupos as $grupo)
	{
		echo "<option>".$grupo["grupo"]."</option>";
	}
	echo "</datalist></br>";
	echo "<input type='submit' value='filtrar'>";
echo "</form></td>";
echo "<td align=center><h4>Fecha<br><form name=form3 action=".$_SERVER['PHP_SELF']."?criterio=fecha method='post'>";
echo "<select name=busca>";


$fechas=LotesConsultarCriterio('fechas','');
 	foreach ($fechas as $fecha)
	{
		echo "<option>".$fecha["fecha"]."</option>";
	}
echo "</select><br>";
echo "<input type='submit' value='filtrar'>";
echo "</form></td>";
echo "<td align=center><a href=ficha_lote_nuevo.php>";
echo "<img src=images/add.png width=50><br><h4>nuevo</a>";
echo "</td>";

$sumatotal=array_sum($pesos);
echo "</tr></table>";
echo "<div align=center>$criterio<br>";
echo "<table id='table_id' style='width: 60%' class='tablas' posicion>";
echo "<tr><th width=500px>";
echo "<h4>LOTES $encontrados</h4> ($cuenta) total:$sumatotal qq pergamino";
echo "</th>";
echo "<th width=20px><h6>opciones</h6></th></tr>";

if(isset($lotes))
{
	foreach ($lotes as $lote)
	{
		$datos_socio=consultarCriterio('id',$lote["id_socio"]);
		$datos_socio=$datos_socio[0];
		$estatus=certificacion('socio',$datos_socio["id_socio"]);
		if (is_array($estatus)) {
			$estatus_actual=certificacion('actual',$datos_socio["id_socio"]);
			$estatus_actual=$estatus_actual[0];
			if($estatus_actual["estatus"]=="O")
			{
				$estatus_t="<img title='socio CON certificación orgánica' src=images/organico.png width=25>";
			}else{
				$estatus_t="<img title='socio SIN certificación orgánica' src=images/noorganico.png width=25>";
			}
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
echo "</table></div>";
include("pie.php");
?>