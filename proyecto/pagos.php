<?php
	include ("cabecera.php");
	include ("socio_funciones.php");
	include ("certificaciones_funciones.php");
	include ("configuracion_funciones.php");
	include ("grupos_funciones.php");
	include ("estimaciones_funciones.php");
	include ("altas_funciones.php");
	include ("catas_funciones.php");

	if(!isset($_GET["criterio"])){
		$_POST["busca"] = "";
		$criterio = "";
		$encontrados = "";
		$lotes = LotesConsultarCriterio('','');
	}else{
		//criterio obtenido desde la "vista"
		if(isset($_GET["socio"])) {
			$_POST["busca"] = $_GET["socio"];
		}
		if(!isset($_POST["busca"])) {
			$lotes = LotesConsultarCriterio($_GET["criterio"], ""); //caso de pendientes
		}else{
			if (isset($_POST["busca2"])) {
				$lotes=LotesConsultarfecha($_POST["busca"],$_POST["busca2"]);
			}else{
				$lotes = LotesConsultarCriterio($_GET["criterio"], $_POST["busca"]);
			}
		}
		$encontrados = "ENCONTRADOS";
		if ($_GET["criterio"] == "socio") {
			$datos_del_socio = consultarCriterio('id',$_POST["busca"]);
			$datos_del_socio = $datos_del_socio[0];
			$_texto = $datos_del_socio["apellidos"].", ".$datos_del_socio["nombres"]." (".$datos_del_socio["codigo"].")";		
		} elseif ($_GET["criterio"] == "pendientes") {
			$_texto = "";
		} else{
			if (!isset($_POST["busca2"])) {
				$_texto = "es <i>\"".$_POST["busca"]."\"</i>";
			}else{
				$_texto = "desde <i>\"".$_POST["busca"]."\" hasta  ".$_POST["busca2"]."</i>";

			}
		}
		$criterio = "<h4>Criterio de búsqueda: <b>".$_GET["criterio"]."</b> $_texto</h4>";
	}

	if (is_array($lotes)) {
		$cuenta = count($lotes);
		foreach ($lotes as $lote) {
			$pesos[]=$lote["peso"];
		}
	}else{
		$cuenta = 0;
	}

	if(!isset($pesos)){$pesos[] = 0;}
 
	echo "<div align=center><h1>Listado de Pagos por lote</h1><br><br>";

	//*****************************************************************************************************
	//busquedas
	//*****************************************************************************************************
	echo "<table width=700px border=0 cellpadding=0 cellspacing=10><tr>";

	//Combobox Socio
	echo "<td align=center><h4>Socio<br><form name=form1 action=".$_SERVER['PHP_SELF']."?criterio=socio method='post'>";
	echo "<select name=busca>";
	$socios = consultarCriterio('lotes','');
	foreach ($socios as $rowsocio)
	{
		if($rowsocio["lotes"]>0){
			if($rowsocio["lotes"]>1){
				$lotes_t="lotes";
			}
			else{
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
	echo "</select>";
	echo "<input type='submit' value='buscar'>";
	echo "</form></td>";

	//Combobox Grupo
	echo "<td align=center><h4>Grupo<br><form name=form2 action=".$_SERVER['PHP_SELF']."?criterio=localidad method='post'>";
	echo "<input list='grupos' name='busca' placeholder='Seleccione...' required>";	
	echo "<datalist  id='grupos'>";	
	$grupos=consultarGrupo('lista','');
 	foreach ($grupos as $grupo)
	{
		echo "<option>".$grupo["grupo"]."</option>";
	}
	echo "</datalist></br>";
	echo "<input type='submit' value='filtrar'>";
	echo "</form></td>";
	//Combobox Fecha
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

	//Pendientes
	echo "<td align=center valign=top><h4>Pendientes<br>";
	echo "<a href=?criterio=pendientes><img width=35 src=images/pendientes.png></a>";
	echo "</td>";

	$sumatotal=array_sum($pesos);
	echo "</tr></table>";
	//*****************************************************************************************************
	//fin busquedas
	//*****************************************************************************************************
	echo "<div align=center>$criterio<br>";
	//****************si hemos elegido un socio, esta es la información de el

	if(isset($_GET["criterio"]) && $_GET["criterio"] == "socio"){
		$estimado = estimacion('actual',$datos_del_socio["id_socio"]);
		if (is_array($estimado)) {
			$estimado_actual = estimacion('actual',$datos_del_socio["id_socio"]);
			$estimado_actual = $estimado_actual[0];
			$enlace_estimado = "<a href=historial_estimacion.php?socio=".$datos_del_socio["id_socio"].">ver historial</a>";
		}else{
			$estimado_actual = "00";
			$enlace_estimado = "<a href=historial_estimacion_nuevo.php?socio=".$datos_del_socio["id_socio"].">añadir</a>";
		}
		
		$altas = altas_consultar('actual',$datos_del_socio["id_socio"]);
		if (is_array($altas)) {
			$enlace_altas = "<a href=historial_altas.php?socio=".$datos_del_socio["id_socio"].">ver historial</a>";
			$altas = $altas[0];
			if ($altas["fecha"] == 0) {
				$altas["fecha"] = "<i>\"fecha desconocida\"</i>";
				$altas["estado"] = "";
			}else{
				$altas["fecha"] = date("d-m-Y",strtotime($altas["fecha"]));
			}
			
		}else{
			$enlace_altas = "<a href=historial_altas_nuevo.php?socio=".$datos_del_socio["id_socio"].">añadir</a>";
		}

		$resultado_lotes = LotesConsultarCriterio('socio',$datos_del_socio["id_socio"]);
		$lotes = $resultado_lotes; // lotes del usuario
		$cuenta_lotes = count($resultado_lotes);
		if (is_array($resultado_lotes)) {
			foreach ($resultado_lotes as $lot) {
				$pesos_del_socio[] = $lot["peso"];
			}
			$peso_entregado = array_sum($pesos_del_socio);
			$estimado_actual_max = $estimado[0]["estimados"]*(1+(configuracion_cons('parametro',"margen_contrato")[0]["valor"]/100));
			$peso_restante = $estimado_actual_max-$peso_entregado;
			$cuenta_lotes_t = "(<font color=red><b>$cuenta_lotes</b></font>)";
		}else{
			$peso_entregado = 0;
			$estimado_actual_max = $estimado[$estimado_actual]["estimados"]*(1+(configuracion_cons('parametro',"margen_contrato")[0]["valor"]/100));
			$peso_restante = $estimado_actual_max-$peso_entregado;
			$cuenta_lotes_t = "";
		}

		echo "
		<table class=tablas><tr>
		<td valign=top><div align=center><h3>Estimacion ".$estimado[0]["year"]."</h3><br>$enlace_estimado</div><hr>";
		if($estimado_actual=="00"){
			echo "<div align=center><h4>Sin datos</h4></div>";
		}else{
		echo "		
				<table><tr><th><h4>Estimado</h4><br><h6>".$estimado[0]["estimados"]."qq<br>(max $estimado_actual_max qq)</th>
						   <th><h4>Entregado</h4><br><h6>$peso_entregado qq</th>
						   <th><h4>Restante</h4><br><h6>$peso_restante qq</th>
				</tr></table>";
		}
		echo "		
		</td>
		<td width=33% valign=top><div align=center><h3>Estado actual</h3><br>$enlace_altas<hr><h4
		>".$altas["estado"]." el<br>".$altas["fecha"]."</div></td>
		</tr></table><br><br>";
	}
	//************************fin información del socio elegido
	echo "<h4>Total de lotes: $cuenta Total Pergamino:$sumatotal qq  </h4> ";
	echo "<table id='table_id' style='width: 90%' class='tablas' posicion>";
	echo "<thead>";
	echo "<th width=500px>";
	echo "<h4>LOTES </h4>";
	echo "</th>";
	echo "<th width=20px><h6>Exportable</h6></th>";
	echo "<th width=20px><h6>Descarte</h6></th>";
	echo "<th width=20px><h6>Fuera de contrato</h6></th>";
	echo "<th width=20px><h6>Calidad Cata</h6></th>";
	echo "<th width=20px><h6>Extra Cliente</h6></th>";
	echo "<th width=20px><h6>Extra Microlote</h6></th>";
	echo "<th width=20px><h6>Extra Taza dorada</h6></th>";
	echo "<th width=20px><h6>Total</h6></th>";
	echo "<th width=20px><h6>Opciones de Pago</h6></th>";
		echo "</thead>";
		echo "<tbody>";
	if(is_array($lotes)){
		foreach ($lotes as $lote){
			$datos_socio = consultarCriterio('id',$lote["id_socio"]);//información del socio de cada lote
			$datos_socio = $datos_socio[0];
			
			$estatus = certificacion('socio',$lote["id_socio"]);
			if(isset($estatus)){
				$estatus_actual = certificacion('actual',$lote["id_socio"]);
				if (is_array($estatus_actual)) {
					$estatus_actual = $estatus_actual[0];
					if (strpos($estatus_actual["estatus"], 'O')) {
						$estatus_t = "<img title='socio CON certificación orgánica' src=images/organico.png width=25>";
					}else{
						$estatus_t = "<img title='socio SIN certificación orgánica' src=images/noorganico.png width=25>";
					}
				}else{
						$estatus_t = "<img title='socio SIN certificación orgánica' src=images/noorganico.png width=25>";
				}
			}
			
			$estimado_actual22 = estimacion('actual',$lote["id_socio"]);
			if (is_array($estimado_actual22)) {
				$estimado_actual22 = $estimado_actual22[0];
			}else{
				@$estimado_actual22["estimados"]="00";
			}
			
			//datos del lote
			$trillado_gr = configuracion_cons('parametro',"gr_muestra")[0]["valor"]-($lote["rto_exportable"]+$lote["rto_descarte"]);
			$trillado = 100-($lote["rto_exportable"]+$lote["rto_descarte"])/configuracion_cons('parametro',"gr_muestra")[0]["valor"]*100;
			$descarte_prc = ($lote["rto_descarte"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)+1.5;
			$exportable_prc = ($lote["rto_exportable"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)-1.5;
			$descarte_qq = ($lote["peso"]*(1-($trillado)/100))*$descarte_prc/100;
			$exportable_qq = ($lote["peso"]*(1-($trillado)/100))*$exportable_prc/100;
			$trillado_qq = $lote["peso"]*(($trillado)/100);
			$suma_trillado = $descarte_qq+$exportable_qq;
			
			$resultado_lotes22 = LotesConsultarCriterio('lote22',$lote["id_socio"]);
			$acumulado = 0;
			$restante = $estimado_actual22["estimados"]*(1+(configuracion_cons('parametro',"margen_contrato")[0]["valor"]/100));
			if (is_array($resultado_lotes22)) {
				foreach ($$resultado_lotes22 as $ls22) {
					if(strtotime($ls22["fecha"]) <= strtotime($lote["fecha"]))
					{
						$acumulado = $acumulado+$ls22["peso"];
						$restante = $restante-$ls22["peso"];
					}
				}
			}	

			$diferencia = $acumulado-($estimado_actual22["estimados"]*(1+(configuracion_cons('parametro',"margen_contrato")[0]["valor"]/100)));
			if($diferencia > 0) {
				if ($diferencia >= $lote["peso"]){ //lote completamente fuera
					$dentro_de_contrato = 0;
					$descarte_qq = 0;
					$exportable_qq = 0;
					$diferencia = $lote["peso"];
				} else { // lote parcialmente dentro
					$dentro_de_contrato = $lote["peso"]-$diferencia;
					$descarte_qq = round(($dentro_de_contrato*(1-($trillado)/100))*$descarte_prc/100,2);
					$exportable_qq = round(($dentro_de_contrato*(1-($trillado)/100))*$exportable_prc/100,2);
				}					
			} else {
				$diferencia = 0;
			}
			//***************************************************************************************************************************		
			$fuerasT[] = $diferencia;		

			$exportablesT[] = $exportable_qq;
			$descartesT[] = $descarte_qq;		
			
			//Catas del lote
			$cata1 = catas_consultar('lote',$lote["id"]);
			if (is_array($cata1)) {
				$cata = $cata1;
				$unidades_cata = "pt.";
				$unidades_dolar_cata = "$";
				$calidades[] = $cata[0]["puntuacion"];
			}else{
				$cata[0]["puntuacion"] = "<font color=red>Pendiente</font>";
				$unidades_cata = "";
				$unidades_dolar_cata = "";
				$calidades[] = 0;
			}
			//Pago del lote
			$pago1 = busqueda_pagos("lote",$lote["id"]);
			if (empty($pago1)) {
				$pago[0]["exportable"] = "<h4><font color=red>Pendiente</font></h4>";
				$pago[0]["descarte"] = "<h4><font color=red>Pendiente</font></h4>";
				$pago[0]["fuera"] = "<h4><font color=red>Pendiente</font></h4>";
				$pago[0]["calidad"] = "<h4><font color=red>Pendiente</font></h4>";
				$pago[0]["cliente"] = "<h4><font color=red>Pendiente</font></h4>";
				$pago[0]["microlote"] = "<h4><font color=red>Pendiente</font></h4>";
				$pago[0]["tazadorada"] = "<h4><font color=red>Pendiente</font></h4>";
				$total = "<h4><font color=red>Pendiente</font></h4>";
				$unidades_dolar = "";
				$unidades_dolar_cata = "";
			}else{
				$pago = busqueda_pagos("lote",$lote["id"]);
				$unidades_dolar = "$";

				if($pago[0]["calidad"]==0){
					$pago[0]["calidad"]="<h4><font color=red>Pendiente</font></h4>";
					$unidades_dolar_cata="";
					$total = $pago[0]["exportable"]+$pago[0]["descarte"]+$pago[0]["fuera"]+$pago[0]["cliente"]+$pago[0]["microlote"]+$pago[0]["tazadorada"];
				}else{
					$total=$pago[0]["exportable"]+$pago[0]["descarte"]+$pago[0]["fuera"]+$pago[0]["calidad"]+$pago[0]["cliente"]+$pago[0]["microlote"]+$pago[0]["tazadorada"];
				}		
			}

			$totales[]=$total;
			$pagos["exportable"][] = $pago[0]["exportable"];
			$pagos["descarte"][] = $pago[0]["descarte"];
			$pagos["fuera"][] = $pago[0]["fuera"];
			$pagos["calidad"][] = $pago[0]["calidad"];
			$pagos["cliente"][] = $pago[0]["cliente"];
			$pagos["microlote"][] = $pago[0]["microlote"];
			$pagos["tazadorada"][] = $pago[0]["tazadorada"];
		
			if($cata[0]["puntuacion"] < configuracion_cons('parametro',"extra_cata")[0]["valor"] && $cata[0]["puntuacion"]>0 || $lote["calidad"]<>"A"){
				$pago[0]["calidad"] = "<font color=blue>No Apto</font>";
				$unidades_dolar_cata = "";
			}

			if($lote["calidad"] <> "A"){
				$cata[0]["puntuacion"] = "<font color=blue>No Apto</font>";
				$unidades_dolar_cata = "";
				$unidades_cata = "";
			}
			
			echo "<tr>";
			echo "<td><h3>".$lote["codigo_lote"]."<br><h4>".date("d-m-Y H:i",strtotime($lote["fecha"]))."<br>$estatus_t".$datos_socio["codigo"]."-".$datos_socio["apellidos"].", ".$datos_socio["nombres"];
			if(!isset($_GET["criterio"]) || $_GET["criterio"]<>"socio"){
				echo "&nbsp<a href=pagos.php?criterio=socio&socio=".$datos_socio["id_socio"]."><img width=20 src=images/ver.png></a>";
			}
			echo "<br>".$lote["peso"]." qq </h4>(".$lote["humedad"]."% HR, EXP.".round($exportable_qq,1)."qq DES.".round($descarte_qq,1)."qq)";
			echo "</td>";
			echo "<td><h4>".round($exportable_qq,1)." qq<hr>$unidades_dolar".$pago[0]["exportable"]."</td>";
			echo "<td><h4>".round($descarte_qq,1)." qq<hr>$unidades_dolar".$pago[0]["descarte"]."</td>";
			echo "<td><h4>".$diferencia ."qq<hr>$unidades_dolar".$pago[0]["fuera"]."</td>";
			echo "<td><h4>".$cata[0]["puntuacion"]." $unidades_cata<hr><h4>$unidades_dolar_cata".$pago[0]["calidad"]."</td>";
			echo "<td><h4>$unidades_dolar_cata".$pago[0]["cliente"]."</td>";
			echo "<td><h4>$unidades_dolar_cata".$pago[0]["microlote"]."</td>";
			echo "<td><h4>$unidades_dolar_cata".$pago[0]["tazadorada"]."</td>";
			echo "<td><h4>".round($suma_trillado,2)." qq<hr>$unidades_dolar".$total."</td>";
			echo "<td align=center>";
			if(in_array($_SESSION['acceso'],$permisos_admin) && $total>0){
				echo "<a href=ficha_pago_editar.php?pago=".$pago[0]["id"]."><img title=editar src=images/pencil.png width=25></a>";
			}
			if(in_array($_SESSION['acceso'],$permisos_admin) && $total>0){
				echo "<a href=ficha_pago_borrar.php?pago=".$pago[0]["id"]."&codigo=".$lote["codigo_lote"]."><img title=borrar src=images/cross.png width=25></a>";
			}
			if(in_array($_SESSION['acceso'],$permisos_administrativos) && $total==0){
				echo "<a href=ficha_pago_nuevo.php?lote=".$lote["id"]."><img title=añadir src=images/add.png width=25></a>";
			}
			if(in_array($_SESSION['acceso'], $permisos_administrativos) && $total>0 && $pago[0]["calidad"]==0 && $lote["calidad"]=="A" && $cata[0]["puntuacion"]>=84){
				echo "<a href=ficha_pago_calidad.php?lote=".$lote["id"]."><img title='añadir pago por calidad' src=images/add.png width=25></a>";
			}
					echo "	  </td></tr>";	
		}
	}

	if(isset($totales)){
		echo "<tr>";
		echo "<th>TOTALES</th>";
		echo "<th><h4>".round(array_sum($exportablesT),2)." qq<hr>$".round(array_sum($pagos["exportable"]),2)."</th>";
		echo "<th><h4>".round(array_sum($descartesT),2)." qq<hr>$".round(array_sum($pagos["descarte"]),2)."</th>";
		echo "<th><h4>".round(array_sum($fuerasT),2)." qq<hr>$".round(array_sum($pagos["fuera"]),2)."</th>";
		echo "<th><h4>".round(array_sum($calidades)/count($calidades),2)."<hr>$".round(array_sum($pagos["calidad"]),2)."</th>";
		echo "<th><h4>$".round(array_sum($pagos["cliente"]),2)."</th>";
		echo "<th><h4>$".round(array_sum($pagos["microlote"]),2)."</th>";
		echo "<th><h4>$".round(array_sum($pagos["tazadorada"]),2)."</th>";
		echo "<th><h4>$".round(array_sum($totales),2)."</th>";
		echo "<th align=center></th></tr>";
	}
	echo "</tbody>";
	echo "</table></div>";
	include("pie.php");
?>