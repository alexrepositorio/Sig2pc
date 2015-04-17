<?php
include ("cabecera.php");


if(!isset($_GET["criterio"]))
{
$_POST["busca"]="";
$criterio="";
$encontrados="";
$SQL="SELECT parcelas.*, SUM(subparcelas.superficie) as sup_cafe FROM parcelas LEFT JOIN subparcelas ON parcelas.id=subparcelas.id_parcela GROUP BY parcelas.id";

}else{
	if(isset($_GET["socio"])){$_POST["busca"]=$_GET["socio"];}
	$encontrados="ENCONTRADOS";
	switch ($_GET["criterio"])
		{
		case "socio":
			$SQL="SELECT parcelas.*, SUM(subparcelas.superficie) as sup_cafe FROM parcelas LEFT JOIN subparcelas ON parcelas.id=subparcelas.id_parcela WHERE parcelas.id_socio = '".$_POST["busca"]."' GROUP BY parcelas.id";
			$datos_del_socio=nombre_socio($_POST["busca"]);
			$_texto=$datos_del_socio["apellidos"].", ".$datos_del_socio["nombres"];
			break;
		case "localidad":
			$SQL="SELECT parcelas.*, SUM(subparcelas.superficie) as sup_cafe, socios.poblacion as poblacion FROM parcelas INNER JOIN subparcelas ON parcelas.id=subparcelas.id_parcela INNER JOIN socios on parcelas.id_socio=socios.codigo WHERE socios.poblacion = '".$_POST["busca"]."' GROUP BY parcelas.id";
			$_texto=$_POST["busca"];
			break;
		case "organico":
			if($_GET["opcion"]=="si"){
			$SQL="SELECT parcelas.*, SUM(subparcelas.superficie) as sup_cafe FROM parcelas LEFT JOIN subparcelas ON parcelas.id=subparcelas.id_parcela LEFT JOIN (SELECT id_socio, year, estatus FROM certificacion WHERE year=(select max(year) from certificacion i where i.id_socio = certificacion.id_socio)) t on parcelas.id_socio=t.id_socio WHERE t.estatus='O' GROUP BY parcelas.id";
			$_texto="CON certificación Orgánica";
			}
			elseif($_GET["opcion"]=="no"){
			$SQL="SELECT parcelas.*, SUM(subparcelas.superficie) as sup_cafe FROM parcelas LEFT JOIN subparcelas ON parcelas.id=subparcelas.id_parcela LEFT JOIN (SELECT id_socio, year, estatus FROM certificacion WHERE year=(select max(year) from certificacion i where i.id_socio = certificacion.id_socio)) t on parcelas.id_socio=t.id_socio WHERE t.estatus<>'O' GROUP BY parcelas.id";
			$_texto="SIN certificación Orgánica";
			}
			break;		
		}
$criterio="<h4>Criterio de búsqueda: <b>".$_GET["criterio"]."</b> es <i>''$_texto''</i></h4>";

}

//echo "$SQL";                         
$resultado=mysqli_query($link, $SQL);
$cuenta=mysqli_num_rows($resultado);
while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
	$parcelas[]=$row;
	$superficie_cafe[]=$row["sup_cafe"];
	if($row["coorX"]!=0 && $row["coorY"]!=0 && $row["alti"]!=0)
	{$coordenadas[$row["id"]]="<img valign=top title='UTM ".$row["coorX"]."-".$row["coorY"]."\n(".$row["alti"]." msnm)' width=25 src=images/gps_si.png>";}
	else{$coordenadas[$row["id"]]="<img valign=top title='Sin coordenadas GPS' width=25 src=images/gps_no.png>";}
	
	
	//info subparcelas
	$sql_sub="SELECT * FROM subparcelas WHERE id_parcela=".$row["id"];
	$res_sub=mysqli_query($link,$sql_sub);
	while ($row_sub = mysqli_fetch_array($res_sub,MYSQLI_ASSOC)){
				if($row_sub["variedad"]!=""){$variedades[$row["id"]][]=$row_sub["variedad"];}
				if($row_sub["variedad2"]!=""){$variedades[$row["id"]][]=$row_sub["variedad2"];}
				if($row_sub["siembra"]=="1900"){$row_sub["siembra"]="hace más de 15 años";}else{$row_sub["siembra"]="en ".$row_sub["siembra"];}
				if($row_sub["siembra"]!=""){$siembras[$row["id"]][]=$row_sub["siembra"];}
			}
	if(!isset($variedades[$row["id"]])){$variedades[$row["id"]][]="variedades sin especificar";}
	if(!isset($siembras[$row["id"]])){$siembras[$row["id"]][]="edad sin especificar";}
	
	//info asociaciones
	$sql_asoc="SELECT * FROM asociaciones WHERE elemento='parcela' AND elemento_id=".$row["id"];
	$resultado_asoc=mysqli_query($link, $sql_asoc);
	while($asoc = mysqli_fetch_array($resultado_asoc,MYSQLI_ASSOC)){
				$asoc_cultivos[$row["id"]][]=$asoc["concepto"];
			}
	if(!isset($asoc_cultivos[$row["id"]])){$asoc_cultivos[$row["id"]][]="no existen";}
				
	
}
//muestra_array($socios); 
echo "<div align=center><h1>Listado de Parcelas</h1><br><br>";
echo "<table border=0 cellpadding=0 cellspacing=10><tr>";
//echo "<td align=center></td><td align=center></td><td align=center></td></tr><tr>";


echo "<td align=center><a href=parcelas.php?criterio=organico&opcion=si>";
echo "<img src=images/organico.png width=50><br><h4>Orgánicos</a>";
echo "</td>";

echo "<td align=center><a href=parcelas.php?criterio=organico&opcion=no>";
echo "<img src=images/noorganico.png width=50><br><h4>No Orgánicos</a>";
echo "</td>";

/*
echo "<td align=center><h4>Socio<br><form name=form1 action=".$_SERVER['PHP_SELF']."?criterio=socio method='post'>";
echo "<select name=busca>";
$sql_socios="SELECT id_socio, nombres, apellidos, codigo FROM socios ORDER BY codigo ASC";
$r_socio=mysqli_query($link, $sql_socios);
while ($rowsocio = mysqli_fetch_array($r_socio,MYSQLI_ASSOC)){$socio_n=$rowsocio["codigo"]."-".$rowsocio["apellidos"].", ".$rowsocio["nombres"];echo "<option value='".$rowsocio["id_socio"]."'>$socio_n</option>";}
echo "</select><br>";
echo "<input type='submit' value='buscar'>";
echo "</form></td>";
*/
echo "<td align=center><h4>Socio<br><form name=form1 action=".$_SERVER['PHP_SELF']."?criterio=socio method='post'>";
echo "<select name=busca>";
//$sql_socios="SELECT socios.id_socio, socios.nombres, socios.apellidos, socios.codigo, COUNT(lotes.id) FROM socios LEFT JOIN lotes ON socios.codigo=lotes.id_socio GROUP BY socios.id_socio ORDER BY codigo ASC";
$sql_socios="SELECT socios.*, COUNT(parcelas.id) as parcelas FROM socios
LEFT JOIN parcelas on socios.codigo=parcelas.id_socio
GROUP BY socios.codigo ORDER BY socios.codigo";
$r_socio=mysqli_query($link, $sql_socios);
while ($rowsocio = mysqli_fetch_array($r_socio,MYSQLI_ASSOC))
{
	if($rowsocio["parcelas"]>0){
		if($rowsocio["parcelas"]>1){$lotes_t="parcelas";}else{$lotes_t="parcela";}
		$lotess="(".$rowsocio["parcelas"]." $lotes_t)";
		$mark="style='background-color:skyblue; color:blue;'";
	}else{$mark="";$lotess="";}
	$socio_n=$rowsocio["codigo"]."-".$rowsocio["apellidos"].", ".$rowsocio["nombres"]." $lotess";
	echo "<option $mark value='".$rowsocio["codigo"]."'>$socio_n</option>";
}
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

/*echo "<td align=center><h4>Fecha<br><form name=form3 action=".$_SERVER['PHP_SELF']."?criterio=fecha method='post'>";
echo "<select name=busca>";
$sql_fecha="SELECT DISTINCT date_format(fecha,'%Y-%m-%d') as fecha FROM lotes ORDER BY fecha ASC";
$r_fec=mysqli_query($link, $sql_fecha);
while ($rowfec = mysqli_fetch_array($r_fec,MYSQLI_ASSOC)){$fecha=$rowfec["fecha"];echo "<option value='$fecha'>$fecha</option>";}
echo "</select><br>";
echo "<input type='submit' value='filtrar'>";
echo "</form></td>";
*/

echo "<td align=center><a href=ficha_parcela_nuevo.php>";
echo "<img src=images/add.png width=50><br><h4>nuevo</a>";
echo "</td>";


if(isset($superficie_cafe)){$total_cafe=array_sum($superficie_cafe);}else{$total_cafe="no se encuentran";}

echo "</tr></table>";

echo "<div align=center>$criterio<br>";
echo "<table class=tablas>";
	echo "<tr><th width=500px>";
	echo "<h4>PARCELAS $encontrados</h4> ($cuenta parcelas, $total_cafe ha de café)";
	echo "</th>";
//	echo "<th width=20px><h6>estado</h6></th>";
	echo "<th width=20px><h6>opciones</h6></th></tr>";

if(isset($parcelas) && $cuenta>0)
{
	foreach ($parcelas as $parcela)
	{
		$datos_socio=nombre_socio($parcela["id_socio"]);
		
		$estatus=certificacion($datos_socio["codigo"]);
		if(isset($estatus)){
			$estatus_actual=max(array_keys($estatus));
			if($estatus[$estatus_actual]["estatus"]=="O"){$estatus_t="<img title='socio CON certificación orgánica' src=images/organico.png width=25 valign=top>";}else{$estatus_t="<img title='socio SIN certificación orgánica' src=images/noorganico.png width=25 valign=top>";}
		}else{$estatus_t="";}
		
		//analisis de suelos*******************************************************************		
			$sql_analisis="SELECT * FROM analisis WHERE id_subparcela in (SELECT id FROM subparcelas WHERE id_parcela=".$parcela["id"].")";
			$resultado_analisis=mysqli_query($link, $sql_analisis);
			$cuenta_analisis=mysqli_num_rows($resultado_analisis);
			if($cuenta_analisis>0){$analisis_t="<img title='$cuenta_analisis análisis realizados' width=25 src=images/lab.png><font color=green>($cuenta_analisis)</font>";}else{$analisis_t="";}
		
		
		echo "<tr>";
		echo "<td><h4>".$datos_socio["codigo"]."-".$datos_socio["nombres"]." ".$datos_socio["apellidos"]."$estatus_t<br>
		".$datos_socio["poblacion"]."<br>
		".$coordenadas[$parcela["id"]]." <a href=ficha_parcela.php?parcela=".$parcela["id"]."><h3>Finca de ".$parcela["sup_total"]."ha<br><h4>".$parcela["sup_cafe"]." ha de café en ".count($siembras[$parcela["id"]])." subparcelas<br>
		<h6>
		".implode(", ",$variedades[$parcela["id"]])."<br>
		siembra ".implode(", ",$siembras[$parcela["id"]])."<br>
		otros aprovechamientos: ".implode(", ",$asoc_cultivos[$parcela["id"]])."<br>
		$analisis_t
		</td>";
		echo "</td>";
		echo "<td><a href=ficha_parcela_editar.php?parcela=".$parcela["id"]."><img title=editar src=images/pencil.png width=25></a>
				  <a href=ficha_parcela_borrar.php?parcela=".$parcela["id"]."><img title=borrar src=images/cross.png width=25></a>
				  </td></tr>";
	}
}
else{"no hay resultados";}
echo "</table></div>";


include("pie.php");

?>