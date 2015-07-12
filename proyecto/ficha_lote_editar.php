<?php
include ("cabecera.php");
include ("socio_funciones.php");
include ("certificaciones_funciones.php");
include ("configuracion_funciones.php");

if(isset ($_GET["guarda"]))
{
	if(isset($_POST["reposo"]))
	{
		$_POST["reposo"]=1;
	}else{
		$_POST["reposo"]=0;
	}

	if(isset($_POST["moho"]))
	{	
		$_POST["moho"]=1;
	}else{
		$_POST["moho"]=0;
	}

	if(isset($_POST["fermento"]))
	{
		$_POST["fermento"]=1;
	}else{
		$_POST["fermento"]=0;
	}

	if(isset($_POST["contaminado"]))
	{
		$_POST["contaminado"]=1;
	}else{
		$_POST["contaminado"]=0;
	}

		$id_lote_socio = $_POST["id_socio"];
		$codigo_lote = $_POST["codigo_lote"];
		$fecha_lote = $_POST["fecha"];
		$peso_lote = $_POST["peso"];
		$humedad_lote = $_POST["humedad"];
		$rto_descarte_lote = $_POST["rto_descarte"];
		$rto_exportable_lote = $_POST["rto_exportable"];
		$defecto_negro_lote = $_POST["defecto_negro"];
		$defecto_vinagre_lote = $_POST["defecto_vinagre"];
		$defecto_decolorado_lote = $_POST["defecto_decolorado"];
		$defecto_mordido_lote = $_POST["defecto_mordido"];
		$defecto_brocado_lote = $_POST["defecto_brocado"];
		$reposo_lote = $_POST["reposo"];
		$moho_lote = $_POST["moho"];
		$fermento_lote = $_POST["fermento"];
		$contaminado_lote = $_POST["contaminado"];
		$calidad_lote = $_POST["calidad"];
		$id_lote = $_GET["guarda"];

	lote_actualizar($id_lote,$id_lote_socio, $codigo_lote, $fecha_lote,
		$peso_lote, $humedad_lote, $rto_descarte_lote, $rto_exportable_lote,
		$defecto_negro_lote, $defecto_vinagre_lote, $defecto_decolorado_lote, 
		$defecto_mordido_lote, $defecto_brocado_lote, $reposo_lote, $moho_lote,
		$fermento_lote, $contaminado_lote, $calidad_lote, $id_lote);
	echo "<div align=center><h1>ACTUALIZANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=ficha_lote.php?lote=$_GET[guarda]'></font></h1></div>";

}else{
	$id_lote = $_GET["lote"];
	$lote=LotesConsultarCriterio('id',$id_lote);
	$lote=$lote[0];
	if($lote["reposo"]==1)
	{
		$check_reposo="checked";
	}else{
		$check_reposo="";
	}
	if($lote["moho"]==1)
	{
		$check_moho="checked";
	}else{
		$check_moho="";
	}
	if($lote["fermento"]==1)
	{
		$check_fermento="checked";
	}else{
		$check_fermento="";
	}
	if($lote["contaminado"]==1)
	{
		$check_contaminado="checked";
	}else{
		$check_contaminado="";
	}

	$datos_socio=consultarCriterio('id',$lote["id_socio"]);
	$datos_socio=$datos_socio[0];
	$estatus=certificacion('socio',$datos_socio["id_socio"]);
	$estatus_actual= certificacion('actual',$datos_socio["id_socio"]);
	$estatus_actual=$estatus_actual[0];

	echo "<div align=center><h1>Edición de la ficha del lote</h1><br><h2>".$datos_socio["apellidos"].", ".$datos_socio["nombres"]."<br>
						".$datos_socio["codigo"]."-".$datos_socio["poblacion"]."</h2><br>
						<h3>Estatus Certificación ".$estatus[$estatus_actual]["year"].":".$estatus[$estatus_actual]["estatus"]."<br><br>";

	echo "<table class=tablas><tr><td>";

	echo "<form name=form action=ficha_lote_editar.php?guarda=".$_GET["lote"]." method='post'>";
	echo "<table class=tablas>";
	echo "<tr><th align=center colspan=2><h3>Datos del lote</th></tr>";
	echo "<tr><th align=right><h4>Socio</th><td><select name=id_socio>";

	$r_socio=consultarCriterio("","");
	foreach ($r_socio as $rowsocio) {
		$socio_n=$rowsocio["apellidos"].", ".$rowsocio["nombres"];
		$socio_codigo=$rowsocio["codigo"];
		if ($rowsocio["codigo"]==$lote["id_socio"]){
			$sel="selected";}else{$sel="";}
		echo "<option $sel value='".$rowsocio["id"]."'>$socio_codigo-$socio_n</option>";
	}
	echo "</select><br>";
	echo "<tr><th align=right><h4>Fecha</th><td><input type='date' name=fecha value='".$lote["fecha"]."'></td></tr>";
	echo "<tr><th align=right><h4>Código LOTE</th><td><input size=15 type='text' name=codigo_lote value='".$lote["codigo_lote"]."'></td></tr>";
	echo "<tr><th align=right><h4>Peso</th><td><input size=5 type='number' step=0.01 min=0 name=peso value='".$lote["peso"]."'> qq</td></tr>";
	echo "<tr><th align=right><h4>Humedad</th><td><input size=2 type='number' step=0.01 min=0 name=humedad value='".$lote["humedad"]."'> %</td></tr>";
	echo "<tr><th align=right><h4>Descarte</th><td><input size=2 type='number' name=rto_descarte value='".$lote["rto_descarte"]."'> gr trillados sobre la muestra de ".configuracion_cons('parametro','gr_muestra')[0]["valor"]."gr</td></tr>";
	echo "<tr><th align=right><h4>Exportable</th><td><input size=2 type='number' name=rto_exportable value='".$lote["rto_exportable"]."'> gr trillados sobre la muestra de ".configuracion_cons('parametro','gr_muestra')[0]["valor"]."gr</td></tr>";
	echo "</table>&nbsp&nbsp";

	echo "<table class=tablas>";
	echo "<tr><th align=center><h3>Defectos</th><th align=center>granos</th></tr>";
	echo "<tr><th align=right><h4>Negro o parcial</th><td><input size=2 type='number' name=defecto_negro value='".$lote["defecto_negro"]."'></td></tr>";
	echo "<tr><th align=right><h4>Vinagre o parcial</th><td><input size=2 type='number' name=defecto_vinagre value='".$lote["defecto_vinagre"]."'></td></tr>";
	echo "<tr><th align=right><h4>Decolorados</th><td><input size=2 type='number' name=defecto_decolorado value='".$lote["defecto_decolorado"]."'></td></tr>";
	echo "<tr><th align=right><h4>Mordidos y cortados</th><td><input size=2 type='number' name=defecto_mordido value='".$lote["defecto_mordido"]."'></td></tr>";
	echo "<tr><th align=right><h4>Brocados</th><td><input size=2 type='number' name=defecto_brocado value='".$lote["defecto_brocado"]."'></td></tr>";
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
	echo "</table>";

	echo "</td></tr></table><br>";

	echo "<input type='submit' value='GUARDAR'>";
	echo "</form>";
}
include("pie.php");
?>