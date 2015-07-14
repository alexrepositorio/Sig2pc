<?php
include ("cabecera.php");
include ("parcelas_funciones.php");
include ("certificaciones_funciones.php");
include ("grupos_funciones.php");
include ("subparcelas_funciones.php");
include ("analisis_funciones.php");
include ("asociaciones_funciones.php");
include ("socio_funciones.php");

if(!isset($_GET["criterio"]))
{
	$parcelas=parcelas_consultarCriterio("","");
	$criterio="";
	$encontrados="";

}else{
	$encontrados="ENCONTRADOS";
	if (!isset($_POST["busca"])&&!isset($_GET["socio"])) {
		$parcelas=parcelas_consultarCriterio($_GET["criterio"],"");
	}
	elseif (isset($_GET["socio"])) {
		$parcelas=parcelas_consultarCriterio($_GET["criterio"],$_GET["socio"]);
	
	}else{	
		$parcelas=parcelas_consultarCriterio($_GET["criterio"],$_POST["busca"]);
		
	}
$criterio="<h4>Criterio de búsqueda: <b>".$_GET["criterio"]."</b></h4>";		

}
$cuenta=count($parcelas);
if (is_array($parcelas)) {  
	foreach ($parcelas as $parcela) {
		$superficie_cafe[]=$parcela["sup_cafe"];
			if($parcela["coorX"]!=0 && $parcela["coorY"]!=0 && $parcela["alti"]!=0){
				$coordenadas[$parcela["id"]]="<img valign=top title='UTM ".$parcela["coorX"]."-".$parcela["coorY"]."\n(".$parcela["alti"]." msnm)' width=25 src=images/gps_si.png>";
			}else{
				$coordenadas[$parcela["id"]]="<img valign=top title='Sin coordenadas GPS' width=25 src=images/gps_no.png>";
			}
			$subparcelas=consultarSubparcelas('id',$parcela["id"]);
			if (is_array($subparcelas)) {
				foreach ($subparcelas as $subparcela) {
					if($subparcela["variedad"]!=""){
						$variedades[$parcela["id"]][]=$subparcela["variedad"];
						}
						if($subparcela["variedad2"]!=""){
							$variedades[$parcela["id"]][]=$subparcela["variedad2"];
						}
						if($subparcela["siembra"]=="1900"){
							$subparcela["siembra"]="hace más de 15 años";
						}else{
							$subparcela["siembra"]="en ".$subparcela["siembra"];
						}

						if($subparcela["siembra"]!=""){
							$siembras[$parcela["id"]][]=$subparcela["siembra"];
						}	
				}
			}
			if(!isset($variedades[$parcela["id"]])){
				$variedades[$parcela["id"]][]="variedades sin especificar";
			}
			if(!isset($siembras[$parcela["id"]])){
				$siembras[$parcela["id"]][]="edad sin especificar";
			}			
			$asociaciones=asociaciones_consultar("parcela",$parcela["id"]);
			if (is_array($asociaciones)) {
				foreach ($asociaciones as $asociacion) {
					$asoc_cultivos[$parcela["id"]][]=$asociacion["concepto"];
				}
				
			}
			if(!isset($asoc_cultivos[$parcela["id"]])){
				$asoc_cultivos[$parcela["id"]][]="no existen";
			}

		
		}

	echo "<div align=center><h1>Listado de Parcelas</h1><br><br>";
	echo "<table border=0 cellpadding=0 cellspacing=10><tr>";
	//echo "<td align=center></td><td align=center></td><td align=center></td></tr><tr>";


	echo "<td align=center><a href=parcelas.php?criterio=organico>";
	echo "<img src=images/organico.png width=50><br><h4>Orgánicos</a>";
	echo "</td>";

	echo "<td align=center><a href=parcelas.php?criterio=no_organico>";
	echo "<img src=images/noorganico.png width=50><br><h4>No Orgánicos</a>";
	echo "</td>";

	echo "<td align=center>
	<form name=form0 action=".$_SERVER['PHP_SELF']." method='post'>";
	echo "</form></td>";

	echo "<td align=center><h4>Socio<br>
	<form name=form1 action=".$_SERVER['PHP_SELF']."?criterio=socio method='post'>";
	echo "<select name=busca>";
	$lista=consultarCriterio('parcelas','');
	foreach ($lista as $elemento) {
		if($elemento["parcelas"]>0){
			if($elemento["parcelas"]>1){
				$lotes_t="parcelas";}
				else{
					$lotes_t="parcela";
				}
			$lotess="(".$elemento["parcelas"]." $lotes_t)";
			$mark="style='background-color:skyblue; color:blue;'";
		}else{$mark="";$lotess="";
	}
		$socio_n=$elemento["codigo"]."-".$elemento["apellidos"].", ".$elemento["nombres"]." $lotess";
		echo "<option $mark value=".$elemento["id_socio"].">$socio_n</option>";
	}
	echo "</select><br>";
	echo "<input type='submit' value='buscar'>";
	echo "</form></td>";
	echo "<td align=center><h4>Grupo<br>
	<form name=form2 action=".$_SERVER['PHP_SELF']."?criterio=localidad method='post'>";
	echo "<input list='grupos' name='busca' placeholder='Seleccione...' required>";	
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
	echo "<td align=center><a href=ficha_parcela_nuevo.php>";
	echo "<img src=images/add.png width=50><br><h4>nuevo</a>";
	echo "</td>";

	if(isset($superficie_cafe)){$total_cafe=array_sum($superficie_cafe);}else{$total_cafe="no se encuentran";}
	echo "</tr></table>";
	echo "<div align=center>$criterio<br>";
	echo "<h4>PARCELAS $encontrados ($cuenta parcelas, $total_cafe ha de café) </h4> <br>";
	echo "<table id='table_id' style='width: 60%' class='tablas' posicion>";
	echo "<thead>";
		echo "<th width=500px>";
		echo "<h4>PARCELAS </h4>";
		echo "</th>";
		echo "<th width=13%><h6>opciones</h6></th>";
		echo "</thead>";
		echo "<tbody>";
	if(isset($parcelas) && $cuenta>0)
	{
		foreach ($parcelas as $parcela)
		{
			$datos_socio=consultarCriterio('id',$parcela["id_socio"]);		
			$estatus_actual=certificacion('actual',$datos_socio[0]["id_socio"]);
			$estatus_actual=$estatus_actual[0];
				if(strrpos($estatus_actual["estatus"], 'O')){
					$estatus_t="<img title='socio CON certificación orgánica' src=images/organico.png width=25 valign=top>";
				}else{
					$estatus_t="<img title='socio SIN certificación orgánica' src=images/noorganico.png width=25 valign=top>";
				}
			
			//analisis de suelos*******************************************************************		
				//$sql_analisis="SELECT * FROM analisis WHERE id_subparcela in (SELECT id FROM subparcelas WHERE id_parcela=".$parcela["id"].")";
				$resultado_analisis=analisis_suelos($parcela["id"]);
				$cuenta_analisis=count($resultado_analisis);
				if(is_array($resultado_analisis)){
					$analisis_t="<img title='$cuenta_analisis análisis realizados' width=25 src=images/lab.png><font color=green>($cuenta_analisis)</font>";
				}else{
					$analisis_t="";
			}				
			echo "<tr>";
			echo "<td><h4>".$datos_socio[0]["codigo"]."-".$datos_socio[0]["nombres"]." ".$datos_socio[0]["apellidos"]."$estatus_t<br>
			".$datos_socio[0]["poblacion"]."<br>
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
	}else{
		echo "no data";
	}
}else{
	echo "</tbody>";
	echo "<div align=center><h1>Sin datos redireccionando.................
	<meta http-equiv='Refresh' content='2;url=parcelas.php'></font></h1></div>";	
}
echo "</table></div>";
include("pie.php");
?>