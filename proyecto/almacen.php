<?php
include ("cabecera.php");


if(!isset($_GET["criterio"]))
{
$_POST["busca"]="";
$criterio="";
$encontrados="";
$SQL="SELECT * FROM lotes order by fecha desc";

}else{
	if(isset($_GET["socio"])){$_POST["busca"]=$_GET["socio"];}
	$encontrados="ENCONTRADOS";
	switch ($_GET["criterio"])
		{
		case "socio":
			$SQL="SELECT * FROM lotes WHERE id_socio = '".$_POST["busca"]."' order by fecha desc";
			$datos_del_socio=nombre_socio($_POST["busca"]);
			$_texto=$datos_del_socio["apellidos"].", ".$datos_del_socio["nombres"];
			break;
		case "localidad":
			$SQL="SELECT * FROM lotes INNER JOIN socios on lotes.id_socio=socios.id_socio WHERE socios.poblacion = '".$_POST["busca"]."' order by fecha desc";
			$_texto=$_POST["busca"];
			break;
		case "fecha":
			$SQL="SELECT * FROM lotes WHERE date_format(fecha,'%Y-%m-%d') = '".$_POST["busca"]."' order by fecha desc";
			$_texto=$_POST["busca"];
			break;		
		}
$criterio="<h4>Criterio de búsqueda: <b>".$_GET["criterio"]."</b> es <i>''$_texto''</i></h4>";

}

                        
$resultado=mysqli_query($link, $SQL);
$cuenta=mysqli_num_rows($resultado);
while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
	$lotes[]=$row;
	$pesos[]=$row["peso"];
	
}
if(!isset($pesos)){$pesos[]=0;}
//if(!isset($costos)){$costos[]=0;}

//muestra_array($socios); 
echo "<div align=center><h1>Estado de almacén</h1><br><br>";

//*****************************************************************************************************
//busquedas
//*****************************************************************************************************
echo "<table width=700px border=0 cellpadding=0 cellspacing=0><tr>";
//echo "<td align=center></td><td align=center></td><td align=center></td></tr><tr>";

echo "<td align=center><h4>Socio<br><form name=form1 action=".$_SERVER['PHP_SELF']."?criterio=socio method='post'>";
echo "<select name=busca>";
$sql_socios="SELECT id_socio, nombres, apellidos, codigo FROM socios ORDER BY codigo ASC";
$r_socio=mysqli_query($link, $sql_socios);
while ($rowsocio = mysqli_fetch_array($r_socio,MYSQLI_ASSOC)){$socio_n=$rowsocio["codigo"]."-".$rowsocio["apellidos"].", ".$rowsocio["nombres"];echo "<option value='".$rowsocio["id_socio"]."'>$socio_n</option>";}
echo "</select><br>";
echo "<input type='submit' value='buscar'>";
echo "</form></td>";


echo "<td align=center><h4>Grupo<br><form name=form2 action=".$_SERVER['PHP_SELF']."?criterio=localidad method='post'>";
echo "<select name=busca>";
$sql_localidad="SELECT grupo as pob, codigo_grupo as cod FROM grupos ORDER BY codigo_grupo ASC";
$r_loc=mysqli_query($link, $sql_localidad);
while ($rowloc = mysqli_fetch_array($r_loc,MYSQLI_ASSOC)){echo "<option value='".$rowloc["pob"]."'>(".$rowloc["cod"].")  ".$rowloc["pob"]."</option>";}
echo "</select><br>";
echo "<input type='submit' value='filtrar'>";
echo "</form></td>";

echo "<td align=center><h4>Fecha<br><form name=form3 action=".$_SERVER['PHP_SELF']."?criterio=fecha method='post'>";
echo "<select name=busca>";
$sql_fecha="SELECT DISTINCT date_format(fecha,'%Y-%m-%d') as fecha FROM lotes ORDER BY fecha ASC";
$r_fec=mysqli_query($link, $sql_fecha);
while ($rowfec = mysqli_fetch_array($r_fec,MYSQLI_ASSOC)){$fecha=$rowfec["fecha"];echo "<option value='$fecha'>$fecha</option>";}
echo "</select><br>";
echo "<input type='submit' value='filtrar'>";
echo "</form></td>";
echo "</tr></table>";

//*****************************************************************************************************
//fin busquedas
//*****************************************************************************************************
$sumatotal=array_sum($pesos);



echo "<div align=center>$criterio<br>";
echo "<table class=tablas>";
	echo "<tr><th>";
	echo "<h4>LOTES $encontrados</h4><br>$sumatotal qq pergamino en $cuenta lotes";
	echo "</th>";
	echo "<th width=10px><h6>rend.</h6></th>";
	echo "<th width=10px><h6>org.</h6></th>";
	echo "<th width=10px><h6>cata</h6></th>";
	echo "<th width=10px><h6>lote (pergamino)</h6></th>";
	echo "<th width=10px><h6>despachado</h6></th>";
	echo "<th width=10px><h6>restante</h6></th>";
	echo "<th width=10px><h6>despachar</h6></th></tr>";

if(isset($lotes))
{
	foreach ($lotes as $lote)
	{
		$datos_socio=nombre_socio($lote["id_socio"]);
		//certificacion
		$estatus=certificacion($datos_socio["codigo"]);
		if(isset($estatus)){
			$estatus_actual=max(array_keys($estatus));
			if($estatus[$estatus_actual]["estatus"]=="O"){$estatus_t="<img title='socio CON certificación orgánica' src=images/organico.png width=25>";}else{$estatus_t="<img title='socio SIN certificación orgánica' src=images/noorganico.png width=25>";}
		}

		//datos del lote
$trillado_gr=$config["gr_muestra"]-($lote["rto_exportable"]+$lote["rto_descarte"]);
$trillado=100-($lote["rto_exportable"]+$lote["rto_descarte"])/$config["gr_muestra"]*100;
$descarte_prc=($lote["rto_descarte"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)+1.5;
$exportable_prc=($lote["rto_exportable"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)-1.5;
$descarte_qq=round(($lote["peso"]*(1-($trillado)/100))*$descarte_prc/100,2);
$exportable_qq=round(($lote["peso"]*(1-($trillado)/100))*$exportable_prc/100,2);
$trillado_qq=$lote["peso"]*(($trillado)/100);
$suma_trillado=$descarte_qq+$exportable_qq;

		//buscamos las catas para cada lote
		$SQL="SELECT * FROM catas where lote='".$lote["codigo_lote"]."'";
		$res_cata=mysqli_query($link, $SQL);
		$cuenta=mysqli_num_rows($res_cata);
		if($cuenta==0){
			$cata["puntuacion"]="<font color=red>Pendiente</font>";$unidades_cata="";}
		else{$cata = mysqli_fetch_array($res_cata,MYSQLI_ASSOC);$unidades_cata=" pts";}

		//buscamos los despachos para cada lote
		unset($cantidades); //limpiamos entre lote y lote
		unset($despachos_del_lote); //limpiamos entre lote y lote
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
					$despachos_del_lote[]="<a href=ficha_despacho_editar.php?despacho=".$despacho["cod"]."&lote=".
											$lote["codigo_lote"]."&cantidad=".$lote["peso"].">"
											.$despacho["cantidad"]."qq ".
											date("d-m-Y",strtotime($despacho["fecha"])).
											" a ". $despacho["destino"]."</a>
											<a href=ficha_despacho_borrar.php?despacho=".$despacho["cod"]."&lote=".$lote["codigo_lote"]."><img title=borrar src=images/cross.png width=10></a>";
					$cantidades[]=$despacho["cantidad"];
				}
			}
		else{
				$despachos_del_lote[]="<font color=red>SIN<br>DESPACHAR</font>";
			 	$cantidades[]=0;
			}
		$cantidad_despachada=round(array_sum($cantidades),2);
		$unidades_despachadas="qq";
		$restante=round($lote["peso"],2)-$cantidad_despachada;
		
		if($cata["puntuacion"]<$config["extra_cata"] && $cata["puntuacion"]>0 || $lote["calidad"]<>"A"){$pago["calidad"]="<font color=blue>No Apto</font>";}
		if($lote["calidad"]<>"A"){$cata["puntuacion"]="<font color=blue>No Apto</font>";$unidades_cata="";}


		echo "<tr>";
		echo "<td><h3>".$lote["codigo_lote"]."<br><h4>".date("d-m-Y H:i",strtotime($lote["fecha"]))."<br>".$datos_socio["codigo"]."-".$datos_socio["apellidos"].", ".$datos_socio["nombres"]."<br>" .$lote["peso"]." qq pergamino</h4></td>";
		echo "</td>";
		echo "<td align=center>".$lote["humedad"]."% HR<br>".round($exportable_qq,1)."qq EXP.<br>".round($descarte_qq,1)."qq DES.</td>";
		echo "<td align=center><h4>$estatus_t</td>";
		echo "<td align=center><h4>".$cata["puntuacion"]." $unidades_cata</td>";
		echo "<td align=center><h4>".round($lote["peso"],2)." qq</td>";
		echo "<td align=center>".implode("<br>", $despachos_del_lote)."<hr>Total: $cantidad_despachada $unidades_despachadas</td>";
		echo "<td align=center><h4>".round($restante,2)." qq</td>";
		echo "<td align=center>";
//if($cantidad_despachada>0){echo "<a href=ficha_despacho_editar.php?lote=".$lote["codigo_lote"]."><img title=editar src=images/pencil.png width=25></a>";}
//if($cantidad_despachada>0){echo "<a href=ficha_despacho_borrar.php?pago=".$lote["codigo_lote"]."&codigo=".$lote["codigo_lote"]."><img title=borrar src=images/cross.png width=25></a>";}
if($restante>0){echo "<a href=ficha_despacho_nuevo.php?lote=".$lote["codigo_lote"]."&restante=$restante><img title='añadir despacho al lote' src=images/add.png width=25></a>";}
		echo "	  </td></tr>";
	}
}
echo "</table></div>";


include("pie.php");

?>