<?php
include ("cabecera.php");

if(isset ($_GET["guarda"])){
if(isset($_POST["reposo"])){$_POST["reposo"]=1;}else{$_POST["reposo"]=0;}
if(isset($_POST["moho"])){$_POST["moho"]=1;}else{$_POST["moho"]=0;}
if(isset($_POST["fermento"])){$_POST["fermento"]=1;}else{$_POST["fermento"]=0;}
if(isset($_POST["contaminado"])){$_POST["contaminado"]=1;}else{$_POST["contaminado"]=0;}
//if(isset($_POST["apto_cata"])){$_POST["apto_cata"]=1;}else{$_POST["apto_cata"]=0;}
	
$SQL_edit="UPDATE lotes SET 
				id_socio='".$_POST["id_socio"]."',
				codigo_lote='".$_POST["codigo_lote"]."',
				fecha='".$_POST["fecha"]."',
				peso='".$_POST["peso"]."',
				humedad='".$_POST["humedad"]."',
				rto_descarte='".$_POST["rto_descarte"]."',
				rto_exportable='".$_POST["rto_exportable"]."',
				defecto_negro='".$_POST["defecto_negro"]."',
				defecto_vinagre='".$_POST["defecto_vinagre"]."',
				defecto_decolorado='".$_POST["defecto_decolorado"]."',
				defecto_mordido='".$_POST["defecto_mordido"]."',
				defecto_brocado='".$_POST["defecto_brocado"]."',
				reposo='".$_POST["reposo"]."',
				moho='".$_POST["moho"]."',
				fermento='".$_POST["fermento"]."',
				contaminado='".$_POST["contaminado"]."',
				calidad='".$_POST["calidad"]."'
				
			where id='".$_GET["guarda"]."'";
$resultado=mysqli_query($link, $SQL_edit);

//para el historial
$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);


//echo "$SQL_edit";

echo "<div align=center><h1>ACTUALIZANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=ficha_lote.php?lote=$_GET[guarda]'></font></h1></div>";

}


else{
	

$SQL="SELECT * FROM lotes where id=".$_GET["lote"];
$resultado=mysqli_query($link, $SQL);
$lote = mysqli_fetch_array($resultado,MYSQLI_ASSOC);
if($lote["reposo"]==1){$check_reposo="checked";}else{$check_reposo="";}
if($lote["moho"]==1){$check_moho="checked";}else{$check_moho="";}
if($lote["fermento"]==1){$check_fermento="checked";}else{$check_fermento="";}
if($lote["contaminado"]==1){$check_contaminado="checked";}else{$check_contaminado="";}
//if($lote["apto_cata"]==1){$check_apto_cata="checked";}else{$check_apto_cata="";}

$datos_socio=nombre_socio($lote["id_socio"]);
$estatus=certificacion($datos_socio["codigo"]);
$estatus_actual=max(array_keys($estatus));

echo "<div align=center><h1>Edición de la ficha del lote</h1><br><h2>".$datos_socio["apellidos"].", ".$datos_socio["nombres"]."<br>
					".$datos_socio["codigo"]."-".$datos_socio["poblacion"]."</h2><br>
					<h3>Estatus Certificación ".$estatus[$estatus_actual]["year"].":".$estatus[$estatus_actual]["estatus"]."<br><br>";

echo "<table class=tablas><tr><td>";

echo "<form name=form action=ficha_lote_editar.php?guarda=".$_GET["lote"]." method='post'>";
echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h3>Datos del lote</th></tr>";
echo "<tr><th align=right><h4>Socio</th><td><select name=id_socio>";
$sql_socios="SELECT id_socio, nombres, apellidos, codigo FROM socios ORDER BY codigo ASC";
$r_socio=mysqli_query($link, $sql_socios);
while ($rowsocio = mysqli_fetch_array($r_socio,MYSQLI_ASSOC)){
	$socio_n=$rowsocio["apellidos"].", ".$rowsocio["nombres"];
	$socio_codigo=$rowsocio["codigo"];
	if ($rowsocio["codigo"]==$lote["id_socio"]){$sel="selected";}else{$sel="";}
	echo "<option $sel value='".$rowsocio["codigo"]."'>$socio_codigo-$socio_n</option>";}
echo "</select><br>";
echo "<tr><th align=right><h4>Fecha</th><td><input type='text' name=fecha value='".$lote["fecha"]."'></td></tr>";
echo "<tr><th align=right><h4>Código LOTE</th><td><input size=15 type='text' name=codigo_lote value='".$lote["codigo_lote"]."'></td></tr>";
echo "<tr><th align=right><h4>Peso</th><td><input size=5 type='text' name=peso value='".$lote["peso"]."'> qq</td></tr>";
echo "<tr><th align=right><h4>Humedad</th><td><input size=2 type='text' name=humedad value='".$lote["humedad"]."'> %</td></tr>";
echo "<tr><th align=right><h4>Descarte</th><td><input size=2 type='text' name=rto_descarte value='".$lote["rto_descarte"]."'> gr trillados sobre la muestra de ".$config["gr_muestra"]."gr</td></tr>";
echo "<tr><th align=right><h4>Exportable</th><td><input size=2 type='text' name=rto_exportable value='".$lote["rto_exportable"]."'> gr trillados sobre la muestra de ".$config["gr_muestra"]."gr</td></tr>";
echo "</table>&nbsp&nbsp";

echo "<table class=tablas>";
echo "<tr><th align=center><h3>Defectos</th><th align=center>granos</th></tr>";
echo "<tr><th align=right><h4>Negro o parcial</th><td><input size=2 type='text' name=defecto_negro value='".$lote["defecto_negro"]."'></td></tr>";
echo "<tr><th align=right><h4>Vinagre o parcial</th><td><input size=2 type='text' name=defecto_vinagre value='".$lote["defecto_vinagre"]."'></td></tr>";
echo "<tr><th align=right><h4>Decolorados</th><td><input size=2 type='text' name=defecto_decolorado value='".$lote["defecto_decolorado"]."'></td></tr>";
echo "<tr><th align=right><h4>Mordidos y cortados</th><td><input size=2 type='text' name=defecto_mordido value='".$lote["defecto_mordido"]."'></td></tr>";
echo "<tr><th align=right><h4>Brocados</th><td><input size=2 type='text' name=defecto_brocado value='".$lote["defecto_brocado"]."'></td></tr>";
echo "</table>&nbsp&nbsp";

echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h3>Otros parámetros</th></tr>";
echo "<tr><th align=right rowspan=4><h4>Olor</th><td><input type='checkbox' $check_reposo name=reposo>Reposo</td></tr>";
echo "<tr><td><input type='checkbox' $check_moho name=moho >Moho</td></tr>";
echo "<tr><td><input type='checkbox' $check_fermento name=fermento >Fermento</td></tr>";
echo "<tr><td><input type='checkbox' $check_contaminado name=contaminado >Contaminado</td></tr>";
echo "<tr><th align=right><h4>Calidad</th><td><select name=calidad>";
echo "<option value='".$lote["calidad"]."'>".$lote["calidad"]."</option>";
echo "<option value='MN'>MN</option>";
echo "<option value='B'>B</option>";
echo "<option value='A'>A</option>";
echo "</select>";
//echo "<tr><th align=right><h4>Apto para cata</th><td><input type='checkbox' $check_apto_cata name=apto_cata>";
echo "</table>";

echo "</td></tr></table><br>";

echo "<input type='submit' value='GUARDAR'>";
echo "</form>";
}
include("pie.php");
?>