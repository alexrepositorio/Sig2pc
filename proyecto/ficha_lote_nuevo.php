<?php
include ("cabecera.php");
include ("socio_funciones.php");
include ("configuracion_funciones.php");

if(isset($_POST["socio"])){

	if(isset($_POST["reposo"])){
		$_POST["reposo"]=1;
	}else{$_POST["reposo"]=0;
	}
	if(isset($_POST["moho"])){
		$_POST["moho"]=1;
	}else{
			$_POST["moho"]=0;}
	if(isset($_POST["fermento"])){
		$_POST["fermento"]=1;
	}else{
			$_POST["fermento"]=0;
		}
	if(isset($_POST["contaminado"])){
		$_POST["contaminado"]=1;
	}else{$_POST["contaminado"]=0;
	}
echo $_POST["socio"];
lote_insertar($_POST["socio"],$_POST["codigo_lote"],$_POST["fecha"],$_POST["peso"],$_POST["humedad"],$_POST["rto_descarte"],$_POST["rto_exportable"],
	$_POST["defecto_negro"],$_POST["defecto_vinagre"],$_POST["defecto_decolorado"],$_POST["defecto_mordido"],$_POST["defecto_brocado"],
	$_POST["reposo"],$_POST["moho"],$_POST["fermento"],$_POST["contaminado"],$_POST["calidad"]);
				
echo "<div align=center><h1>GUARDANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=lotes.php'></font></h1></div>";
	
}


else{

//calculo del código para el nuevo lote


echo "<div align=center><h1>NUEVO LOTE</h1><br>";

//muestra_array($socio);

echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h3>Datos del lote</th></tr>";

echo "<tr><th align=right><h4>Socio</th><td><select name=socio>";
$lista=consultarCriterio('','');
foreach ($lista as $elemento) {
	echo "<option value='".$elemento["id"]."'>".$elemento["apellidos"]." ".$elemento["nombres"]."</option>";
}
echo "</select><br>";
//echo "<tr><th align=right><h4></th><td><input type='hidden' name=id_socio value='".$_GET["socio"]."'></td></tr>";
echo "<tr><th align=right><h4></th><td><input type='hidden' name=fecha value='".date("Y-m-d H:i:s",time())."'></td></tr>";
echo "<tr><th align=right><h4>Código LOTE</th><td><input size=15 type='text' name=codigo_lote value='".lote_codigo()."'></td></tr>";
echo "<tr><th align=right><h4>Peso entrada</th><td><input size=5 type='number' step=0.01 min=0  name=peso> qq pergamino</td></tr>";
echo "<tr><th align=right><h4>Humedad</th><td><input size=2 type='number' step=0.01 min=0  name=humedad> %</td></tr>";
//echo "<tr><th align=right><h4>Rendimiento Pilado</th><td><input size=2 type='text' name=rto_pilado> %</td></tr>";
echo "<tr><th align=right><h4>Exportable</th><td><input size=2 type='number' name=rto_exportable> gr trillados sobre la muestra de ".('gr_muestra')."gr</td></tr>";
echo "<tr><th align=right><h4>Descarte</th><td><input size=2 type='number' name=rto_descarte> gr trillados sobre la muestra de ".configuracion_cons('parametro','gr_muestra')[0]["valor"]."gr</td></tr>";
echo "</table>&nbsp&nbsp";

echo "<table class=tablas>";
echo "<tr><th align=center><h3>Defectos</th><th align=center>granos</th></tr>";
echo "<tr><th align=right><h4>Negro o parcial</th><td><input size=2 type='number' name=defecto_negro value='0'></td></tr>";
echo "<tr><th align=right><h4>Vinagre o parcial</th><td><input size=2 type='number' name=defecto_vinagre value='0'></td></tr>";
echo "<tr><th align=right><h4>Decolorados</th><td><input size=2 type='number' name=defecto_decolorado value='0'></td></tr>";
echo "<tr><th align=right><h4>Mordidos y cortados</th><td><input size=2 type='number' name=defecto_mordido value='0'></td></tr>";
echo "<tr><th align=right><h4>Brocados</th><td><input size=2 type='number' name=defecto_brocado value='0'></td></tr>";
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