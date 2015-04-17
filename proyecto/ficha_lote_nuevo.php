<?php
include ("cabecera.php");

if(isset($_POST["peso"])){
if(isset($_POST["reposo"])){$_POST["reposo"]=1;}else{$_POST["reposo"]=0;}
if(isset($_POST["moho"])){$_POST["moho"]=1;}else{$_POST["moho"]=0;}
if(isset($_POST["fermento"])){$_POST["fermento"]=1;}else{$_POST["fermento"]=0;}
if(isset($_POST["contaminado"])){$_POST["contaminado"]=1;}else{$_POST["contaminado"]=0;}
//if(isset($_POST["apto_cata"])){$_POST["apto_cata"]=1;}else{$_POST["apto_cata"]=0;}
	
$SQL_edit="INSERT INTO lotes VALUES ('',
				'".$_POST["id_socio"]."',
				'".$_POST["codigo_lote"]."',
				'".$_POST["fecha"]."',
				'".$_POST["peso"]."',
				'".$_POST["humedad"]."',
				'".$_POST["rto_descarte"]."',
				'".$_POST["rto_exportable"]."',
				'".$_POST["defecto_negro"]."',
				'".$_POST["defecto_vinagre"]."',
				'".$_POST["defecto_decolorado"]."',
				'".$_POST["defecto_mordido"]."',
				'".$_POST["defecto_brocado"]."',
				'".$_POST["reposo"]."',
				'".$_POST["moho"]."',
				'".$_POST["fermento"]."',
				'".$_POST["contaminado"]."',
				'".$_POST["calidad"]."'
				)";

$resultado=mysqli_query($link, $SQL_edit);

//echo "$SQL_edit";
//para el historial
$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);


echo "<div align=center><h1>GUARDANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=lotes.php'></font></h1></div>";
	
}


else{

//calculo del código para el nuevo lote
$sql_nuevolote="SELECT codigo_lote FROM lotes WHERE date_format(fecha,'%Y') = '".date("Y",time())."'ORDER BY codigo_lote ASC";
$r_nuevolote=mysqli_query($link, $sql_nuevolote);
$cuenta_p=mysqli_num_rows($r_nuevolote);
if($cuenta_p==0){$nuevo_lote="APC-00001-".date("y",time());}
else{
	while ($rowlotes = mysqli_fetch_array($r_nuevolote,MYSQLI_ASSOC)){
//		echo $rowlotes["codigo_lote"]."<br>";
		$lote=$rowlotes["codigo_lote"];
		$lote=str_replace("C-","C",$lote);
		$lote=str_replace("C","C-",$lote);
		$lote=explode ("-",$lote);
//		echo $lote[0]."----".$lote[1]."----".$lote[2]."<br>";
		$numeraciones[]=$lote[1];
	}
//	echo "maximo=".max($numeraciones)."<br>";
	$siguiente=max($numeraciones)+1;
	$nuevo_lote="APC-".str_pad($siguiente,5,"0",STR_PAD_LEFT)."-".date("y",time());
}
	

echo "<div align=center><h1>NUEVO LOTE</h1><br>";

//muestra_array($socio);

echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h3>Datos del lote</th></tr>";
echo "<tr><th align=right><h4>Socio</th><td><select name=id_socio>";
$sql_socios="SELECT socios.codigo, COUNT(lotes.id) as lotes, socios.nombres, socios.apellidos, a.alt, b.cert FROM socios
LEFT JOIN lotes on socios.codigo=lotes.id_socio
LEFT JOIN (SELECT id_socio,COUNT(id) as alt FROM altas GROUP BY id_socio) a ON a.id_socio=socios.codigo
LEFT JOIN (SELECT id_socio, COUNT(id) as cert FROM certificacion GROUP BY id_socio) b ON b.id_socio=socios.codigo
GROUP BY socios.codigo HAVING a.alt>0 AND b.cert>0 ORDER BY socios.codigo";

//$sql_socios="SELECT id_socio, nombres, apellidos, codigo FROM socios ORDER BY codigo ASC";
$r_socio=mysqli_query($link, $sql_socios);
while ($rowsocio = mysqli_fetch_array($r_socio,MYSQLI_ASSOC)){
	$socio_n=$rowsocio["apellidos"].", ".$rowsocio["nombres"];
	$socio_codigo=$rowsocio["codigo"];
		if($rowsocio["lotes"]>0){
		if($rowsocio["lotes"]>1){$lotes_t="lotes";}else{$lotes_t="lote";}
		$lotess="(".$rowsocio["lotes"]." $lotes_t)";
		$mark="style='background-color:skyblue; color:blue;'";
	}else{$mark="";$lotess="";}
	
	if ($rowsocio["codigo"]==$_GET["socio"]){$sel="selected";}else{$sel="";}
	$socio_n=$rowsocio["codigo"]."-".$rowsocio["apellidos"].", ".$rowsocio["nombres"]." $lotess";
	echo "<option $sel $mark value='".$rowsocio["codigo"]."'>$socio_n</option>";}
echo "</select><br>";
echo "<tr><th align=right><h4>Fecha</th><td><input type='text' name=fecha value='".date("Y-m-d H:i:s",time())."'></td></tr>";
echo "<tr><th align=right><h4>Código LOTE</th><td><input size=15 type='text' name=codigo_lote value='$nuevo_lote'></td></tr>";
echo "<tr><th align=right><h4>Peso entrada</th><td><input size=5 type='text' name=peso> qq pergamino</td></tr>";
echo "<tr><th align=right><h4>Humedad</th><td><input size=2 type='text' name=humedad> %</td></tr>";
//echo "<tr><th align=right><h4>Rendimiento Pilado</th><td><input size=2 type='text' name=rto_pilado> %</td></tr>";
echo "<tr><th align=right><h4>Exportable</th><td><input size=2 type='text' name=rto_exportable> gr trillados sobre la muestra de ".$config["gr_muestra"]."gr</td></tr>";
echo "<tr><th align=right><h4>Descarte</th><td><input size=2 type='text' name=rto_descarte> gr trillados sobre la muestra de ".$config["gr_muestra"]."gr</td></tr>";
echo "</table>&nbsp&nbsp";

echo "<table class=tablas>";
echo "<tr><th align=center><h3>Defectos</th><th align=center>granos</th></tr>";
echo "<tr><th align=right><h4>Negro o parcial</th><td><input size=2 type='text' name=defecto_negro value='0'></td></tr>";
echo "<tr><th align=right><h4>Vinagre o parcial</th><td><input size=2 type='text' name=defecto_vinagre value='0'></td></tr>";
echo "<tr><th align=right><h4>Decolorados</th><td><input size=2 type='text' name=defecto_decolorado value='0'></td></tr>";
echo "<tr><th align=right><h4>Mordidos y cortados</th><td><input size=2 type='text' name=defecto_mordido value='0'></td></tr>";
echo "<tr><th align=right><h4>Brocados</th><td><input size=2 type='text' name=defecto_brocado value='0'></td></tr>";
echo "</table>&nbsp&nbsp";

echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h3>Otros parámetros</th></tr>";
echo "<tr><th align=right rowspan=4><h4>Olor</th>";
echo "	  <td><input type='checkbox' name=reposo >Reposo</td></tr>";
echo "<tr><td><input type='checkbox' name=moho >Moho</td></tr>";
echo "<tr><td><input type='checkbox' name=fermento >Fermento</td></tr>";
echo "<tr><td><input type='checkbox' name=contaminado >Contaminado</td></tr>";
echo "<tr><th align=right><h4>Calidad</th><td><select name=calidad>";
echo "<option value='MN'>MN</option>";
echo "<option value='B'>B</option>";
echo "<option value='A'>A</option>";
echo "</select>";
//echo "<tr><th align=right><h4>Apto para cata</th><td><input type='checkbox' name=apto_cata>";
echo "</table><br><br>";

echo "<input type='submit' value='GUARDAR'>";
echo "</form>";
}

include("pie.php");
?>