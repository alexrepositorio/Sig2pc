<?php
include ("cabecera.php");
include ("asociaciones_funciones.php");
include ("parcelas_funciones.php");
include ("analisis_funciones.php");
include ("subparcelas_funciones.php");
include ("socio_funciones.php");
//*****************************ASOCIACIONES*********************************************

$resultado_asoc=asociaciones_consultar("parcela",$_GET["parcela"]);
if (is_array($resultado_asoc)) {
	foreach ($resultado_asoc as $asoc) {
	$asociaciones[]=$asoc;
	$asoc_cultivos[$asoc["tipo"]][]=$asoc["concepto"]." (".$asoc["valor"].")";
	}
}

if(isset($asoc_cultivos["cultivo"])){
	$listado_cult=implode(", ",$asoc_cultivos["cultivo"]);
}else{
	$listado_cult="No existen";
}
if(isset($asoc_cultivos["animales"])){
	$listado_ani=implode(", ",$asoc_cultivos["animales"]);
}else{
	$listado_ani="No existen";
}

//**********TABLA AUTOMATICA*****************************************************************
$resultado=parcelas_consultarCriterio('id',$_GET["parcela"]);
echo "<div id=imprimir>";
echo "<div align=center><h2>Ficha de la Parcela</h2><br>";
echo "<table class=tablas>";
if (count($resultado)>0) {
	foreach ($resultado as $datos) {
	$datos_socio=consultarCriterio('id',$datos["id_socio"]);
	$datos_socio=$datos_socio[0];
	echo "<tr><th align=right><h4>Socio</th><td><h4>".$datos_socio["nombres"]." ".$datos_socio["apellidos"]." (".$datos["id_socio"].")</td></tr>";		
	echo "<tr><th align=right><h4>Superficie Finca</th><td><h4>".$datos["sup_total"]."</h4>ha</td></tr>";	
	echo "<tr><th align=right><h4>Superficie café</th><td><h4>".parcelas_consultarCriterio('sup_total',$_GET["parcela"])[0]["sup_cafe"]."</h4>ha</td></tr>";	
	echo "<tr><th align=right><h4>Coordenada X</th><td><h4>".$datos["coorX"]."</h4></td></tr>";	
	echo "<tr><th align=right><h4>Coordenada Y</th><td><h4>".$datos["coorY"]."</h4></td></tr>";	
	echo "<tr><th align=right><h4>Altitud</th><td><h4>".$datos["alti"]."</h4>msnm</td></tr>";	
	echo "<tr><th align=right><h4>Riego</th><td><h4>".$datos["riego"]."</h4></td></tr>";
	echo "<tr><th align=right><h4>Mano de Obra Contratada</th><td><h4>".$datos["MOcontratada"]."</h4></td></tr>";	
	echo "<tr><th align=right><h4>Mano de Obra Familiar</th><td><h4>".$datos["MOfamiliar"]."</h4></td></tr>";	
	echo "<tr><th align=right><h4>Miembros de la Familia</th><td><h4>".$datos["Miembros_familia"]."</h4></td></tr>";	
	echo "<tr><th align=right><h4>Cultivos de la finca</th><td><h4>".$listado_cult."</h4></td></tr>";	
	echo "<tr><th align=right><h4>Producción animal</th><td><h4>".$listado_ani."</h4></td></tr>";	
	echo "<tr><th colspan=2><a href=ficha_parcela_editar.php?parcela=".$datos["id"]."><img src=images/pencil.png></a></th></tr>";
	}
}else{
		echo "<tr><th align=right><h4>Sin datos<h4></th></h4></td></tr>";	

}
echo "</table><br>";
echo "<a href=parcelas.php><button class=boton>volver</button></a></div>";
$resultado2=consultarSubparcelas('parcela',$_GET["parcela"]);

echo "<hr><div align=center><table><tr><td><h2>SUBPARCELAS</h2></td>";
echo "<td align=center><a href=ficha_subparcela_nuevo.php?parcela=".$_GET["parcela"].">";
echo "<img src=images/add.png width=30><br><h4>nuevo</a>";
echo "</td></tr></table>";
foreach ($resultado2 as $datos) {
	$resultado_analisis=analisis_subparcela($datos["id"]);
	if (is_array($resultado_analisis)) {
		$cuenta_analisis=count($resultado_analisis);	
	}else{
		$cuenta_analisis=0;
	}
	
//analisis de suelos*******************************************************************		
$resultado_asoc=asociaciones_consultar("subparcela",$datos["id"]);
unset($asoc_cultivos_sub);
if (is_array($resultado_asoc)) {	
	foreach ($resultado_asoc as $asoc2) {
		$asoc_cultivos_sub[$asoc2["tipo"]][]=$asoc2["concepto"]." (".$asoc2["valor"].")";
	}
}
if(isset($asoc_cultivos_sub["cultivo"])){
	$listado_cult_sub=implode("<br>",$asoc_cultivos_sub["cultivo"]);
}else{
$listado_cult_sub="No existen";
}
	//*******************************************************************************************	
	echo "<table class=tablas align=center width=300px>";
	//echo "<tr><th align=right width=90px><h4>Id Parcela</th><td width=210px><h4>".$datos["id_parcela"]."</td></tr>";	
	echo "<tr><th align=right><h4>Superficie</th><td><h4>".$datos["superficie"]."</h4>ha</td></tr>";	
	echo "<tr><th align=right><h4>Variedad</th><td><h4>".$datos["variedad"]."</td></tr>";	
	echo "<tr><th align=right><h4>Variedad secundaria</th><td><h4>".$datos["variedad2"]."</td></tr>";	
	echo "<tr><th align=right><h4>Año de siembra</th><td><h4>".$datos["siembra"]."</td></tr>";	
	echo "<tr><th align=right><h4>Densidad</th><td><h4>".$datos["densidad"]."</h4> pl/ha</td></tr>";	
	echo "<tr><th align=right><h4>Marco</th><td><h4>".$datos["marco"]."</td></tr>";	
	echo "<tr><th align=right><h4>Malas hierbas</th><td><h4>".$datos["hierbas"]."</td></tr>";	
	echo "<tr><th align=right><h4>Sombreado</th><td><h4>".$datos["sombreado"]."</td></tr>";	
	echo "<tr><th align=right><h4>Roya</th><td><h4>".$datos["roya"]."</h4>%</td></tr>";	
	echo "<tr><th align=right><h4>Broca</th><td><h4>".$datos["broca"]."</h4>%</td></tr>";	
	echo "<tr><th align=right><h4>Ojo de pollo</th><td><h4>".$datos["ojo_pollo"]."</h4>%</td></tr>";	
	echo "<tr><th align=right><h4>Mes de inicio de cosecha</th><td><h4>".$datos["mes_inicio_cosecha"]."</td></tr>";	
	echo "<tr><th align=right><h4>Duración cosecha</th><td><h4>".$datos["duracion_cosecha"]."</h4> meses</td></tr>";		
	echo "<tr><th align=right><h4>Asociación</th><td><h4>".$listado_cult_sub."</h4></td></tr>";		
	echo "<tr><th colspan=2><a href=ficha_subparcela_editar.php?subparcela=".$datos["id"]."><img src=images/pencil.png></a>";
	echo "<a href=ficha_subparcela_borrar.php?subparcela=".$datos["id"]."&parcela=".$datos["id_parcela"]."><img src=images/cross.png></a>";
	echo "<a title='añadir análisis' href=ficha_analisis_nuevo.php?subparcela=".$datos["id"]."&parcela=".$datos["id_parcela"]."><img width=25 src=images/lab_add.png></a>";
	if($cuenta_analisis>0){
		echo "<a title='ver análisis' href=analisis.php?subparcela=".$datos["id"]."&parcela=".$datos["id_parcela"]."><img width=25 src=images/lab.png><font color=green>($cuenta_analisis)</font></a>";
	}
	echo "</th></tr></table> &nbsp";	

}	
	echo "</div>";
	echo "</div>";
	echo "<br>";
	echo "<br>";
	echo "<br>";	
//**********TABLA AUTOMATICA*****************************************************************
?>
<div align=center><a href="javascript:imprimir('imprimir')"><img width=25 src=images/imprimir.png><br><h6>Imprimir ficha</a></div>
<?php

include("pie.php");

?>