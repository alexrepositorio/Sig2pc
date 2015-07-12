<?php
	include ("cabecera.php");
	include ("configuracion_funciones.php");
	include ("certificaciones_funciones.php");
	include ("estimaciones_funciones.php");
	include ("socio_funciones.php");
	include ("catas_funciones.php");
	include ("altas_funciones.php");

	$pago1 = busqueda_pagos("lote", $_GET["lote"]);
	$pago1=$pago1[0];
	if (is_array($pago1)) {
		$cuenta = count($pago1);
		$total = $pago1["exportable"]+$pago1["descarte"]+$pago1["calidad"];
	}else{
		$cuenta = $pago1;
		$pago["exportable"] = "<h4><font color=red>Pendiente</font></h4>";
		$pago["descarte"] = "<h4><font color=red>Pendiente</font></h4>";
		$pago["calidad"] = "<h4><font color=red>Pendiente</font></h4>";
		$total = "<h4><font color=red>Pendiente</font></h4>";
	}

	$lote = LotesConsultarCriterio("id", $_GET["lote"]);
	$lote = $lote[0];

	$trillado_gr = configuracion_cons('parametro',"gr_muestra")[0]["valor"]-($lote["rto_exportable"]+$lote["rto_descarte"]);
	$trillado = 100-($lote["rto_exportable"]+$lote["rto_descarte"])/configuracion_cons('parametro',"gr_muestra")[0]["valor"]*100;
	$descarte_prc = ($lote["rto_descarte"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)+1.5;
	$exportable_prc = ($lote["rto_exportable"]/($lote["rto_exportable"]+$lote["rto_descarte"])*100)-1.5;
	$descarte_qq = ($lote["peso"]*(1-($trillado)/100))*$descarte_prc/100;
	$exportable_qq = ($lote["peso"]*(1-($trillado)/100))*$exportable_prc/100;
	$trillado_qq = $lote["peso"]*(($trillado)/100);
	$suma_trillado = $descarte_qq+$exportable_qq;
		
	$socio = consultarCriterio('id',$lote["id_socio"]);
	$socio = $socio[0];

	$estatus = certificacion('actual',$lote["id_socio"]);
	if (is_array($estatus)) {
		$estatus_actual = $estatus[0];
		if(strpos($estatus_actual["estatus"], 'O')){
			$estatus_t = "<img title='socio CON certificación orgánica' src=images/organico.png width=20>";
		}else{
			$estatus_t = "<img title='socio SIN certificación orgánica' src=images/noorganico.png width=20>";
		}
	}else{
		$estatus_actual = $estatus;
		$estatus_t = "<img title='socio SIN certificación orgánica' src=images/noorganico.png width=20>";
	}
		
	if($lote["calidad"] <> "A"){
		$cata["puntuacion"] = "NO APTO";
		$input_q = "NO APTO<input type='hidden' name=calidad value='0'>";
	}
	else{
		$input_q = "$<input type='text' name=calidad>";
		$cata1 = catas_consultar('lote',$_GET["lote"]);
		if (is_array($cata1)) {
			$cata = $cata1[0];
			$input_q = "$<input type='text' name=calidad>";
			if($cata["puntuacion"] <= configuracion_cons('parametro',"extra_cata")[0]["valor"]){
				$input_q = "NO APTO<input type='hidden' name=calidad value='0'>";
			}
		}else{
			$cata["puntuacion"] = "PEND";
			$input_q = "PENDIENTE DE CATA<input type='hidden' name=calidad value='0'>";
		}
	}

	$estimado = estimacion('actual',$socio["id_socio"]);
	if (is_array($estimado)) {
		$estimado_actual = $estimado[0];
		$enlace_estimado = "<a href=historial_estimacion.php?socio=".$socio["id_socio"].">ver historial</a>";
	}else{
		$estimado_actual = $estimado;
		$enlace_estimado = "<a href=historial_estimacion_nuevo.php?socio=".$socio["id_socio"].">añadir</a>";
	}

	$altas = altas_consultar('actual',$socio["id_socio"]);
	if (is_array($altas)) {
		$altas = $altas[0];
		$enlace_altas = "<a href=historial_altas.php?socio=".$socio["id_socio"].">ver historial</a>";
		if ($altas["fecha"] == 0) {
			$altas["fecha"] = "<i>\"fecha desconocida\"</i>";
			$altas["estado"] = "";
		}else{
			$altas["fecha"]=date("d-m-Y",strtotime($altas["fecha"]));
		}
	}else{
		$enlace_altas = "<a href=historial_altas_nuevo.php?socio=".$socio["id_socio"].">añadir</a>";
	}

	$lotes = LotesConsultarpagos($socio["id_socio"]);
	if (is_array($lotes)) {
		$cuenta_lotes = count($lotes);
		foreach ($lotes as $lote1) {
			$pesos_del_socio[] = $lote1["peso"];	
			$todos_lotes_del_socio[] = $lote1;
		}
		$peso_entregado = array_sum($pesos_del_socio);
		$cuenta_lotes_t = "(<font color=red><b>$cuenta_lotes</b></font>)";
	} else {
		$cuenta_lotes = $lotes;
		$peso_entregado = 0;
		$cuenta_lotes_t = "";
	}
	if (is_array($estimado_actual)) {
		$estimado_actual_max = $estimado_actual["estimados"]*(1+(configuracion_cons('parametro',"margen_contrato")[0]["valor"]/100));
	} else {
		$estimado_actual_max = 0;
	}
	$peso_restante = $estimado_actual_max-$peso_entregado;

	if(isset ($_POST["fecha"])) {
		if(in_array($_SESSION['acceso'],$permisos_admin)) {
			insertar_pagos($_POST["codigo_lote"],$_POST["fecha"],$_POST["exportable"],$_POST["descarte"],$_POST["fuera"],
				$_POST["calidad"],$_POST["cliente"],$_POST["microlote"],$_POST["tazadorada"]);
		} else {
			insertar_pagos($_POST["codigo_lote"],$_POST["fecha"],$_POST["exportable"],$_POST["descarte"],$_POST["fuera"],
				$_POST["calidad"]); //en este caso se envía 0's en los tres últimos atributos
		}
		echo "<div align=center><h1>GUARDANDO, ESPERA...
		<meta http-equiv='Refresh' content='2;url=pagos.php'></font></h1></div>";
	} 

	else {
	echo "<div align=center><h1>NUEVO PAGO</h1><br>";

//muestra_array($socio);


	echo "<form name=form action=".$_SERVER['PHP_SELF']."?lote=".$_GET["lote"]." method='post'>";
	echo "<table class=tablas>";
	echo "
	<td colspan=3><h4>".$socio["codigo"]."-".$socio["nombres"]." ".$socio["apellidos"]."
	&nbsp&nbsp&nbsp<a href=pagos.php?criterio=socio&socio=".$socio["id_socio"]."><img width=15 src=images/history.png></a><br>
	".$socio["poblacion"]."<br><br>Lote:<hr>".$lote["codigo_lote"]."<br>".$lote["fecha"]."<br>
	Calidad: ".$lote["calidad"].$estatus_t."</td></tr>";
	echo "<tr><th colspan=3>";
		echo "
		<table class=tablas><tr>
		<td width=33% valign=top><div align=center><h3>Estimacion ".$estimado_actual["year"]."</h3><br>$enlace_estimado</div><hr>";
				
		if($estimado_actual=="00"){
			echo "<div align=center><h4>Sin datos</h4></div>";
		}else{
		echo "		
				<table><tr><th><h4>Estimado</h4><br><h6>".$estimado_actual["estimados"]."qq<br>(max $estimado_actual_max qq)</th>
						   <th><h4>Entregado</h4><br><h6>$peso_entregado qq</th>
						   <th><h4>Restante</h4><br><h6>$peso_restante qq</th>
				</tr></table>";
		}
		echo "		
		</td>
		<td width=33% valign=top><div align=center><h3>Estado actual</h3><br>$enlace_altas<hr><h4>".$altas["estado"]." el<br>".$altas["fecha"]."</div></td>
		</tr></table>";
		
		
		echo "</td></tr><tr><td colspan=3 align=center><br><br>lotes anteriores del socio:<br>";
		echo "<div align=center><table class=tablas>";
		echo "<tr><th><h6>Código</td><th><h6>Fecha</td><th><h6>Pergamino</td><th><h6>Acumulado</td><th><h6>Restante</td><th><h6>Pagado</td></tr>";
		$acumulado=0;
		$restante=$estimado_actual["estimados"]*(1+(configuracion_cons('parametro',"margen_contrato")[0]["valor"]/100));
		
		foreach($todos_lotes_del_socio as $ls){
			if(strtotime($ls["fecha"])<=strtotime($lote["fecha"])) {

				if($ls["exportable"]>0){
					$pagado=1;
					$enlace_pago = "";
				} else {
					$pagado=0;
					$enlace_pago = "<a href=ficha_pago_nuevo.php?lote=".$ls["id"].">";
				}	
				$pagado = yes_no($pagado);
				$acumulado = $acumulado+$ls["peso"];
				$restante = $restante-$ls["peso"];
				if($ls["codigo_lote"] == $_GET["lote"]){
					$color = "<font color=red>";
					$enlace_pago="";
					$pagado="";
				} else {$color="";}
				echo "<tr><td><h6>$color".$ls["codigo_lote"]. "</td><td><h6>$color" .$ls["fecha"]. "</td><td><h6>$color" .$ls["peso"]."qq</td><td><h6>$color $acumulado qq</td><td><h6>$color $restante qq</td><td align=center><h6>$color $enlace_pago".$pagado."</td></tr>";
			}
		}
		echo "</table></div>";
		
		$diferencia = $acumulado-($estimado_actual["estimados"]*(1+(configuracion_cons('parametro',"margen_contrato")[0]["valor"]/100)));
		if($diferencia > 0) { //Estamos fuera
			if ($diferencia >= $lote["peso"]) { //lote completamente fuera 
				echo "<h4><font color=red>Este lote excede completamente el contrato actual</font></h4>";
				$hidden = "'hidden' value=0 ";//ocultamos export y descart	
				$dentro_de_contrato = 0;
				$descarte_qq = 0;
				$exportable_qq = 0;
				$diferencia = $lote["peso"];
			} else { // lote parcialmente dentro
				$hidden = "'text'";//mostramos expor y descart
				$dentro_de_contrato = $lote["peso"]-$diferencia;
				echo "<h4><font color=red>Este lote cumple con el contrato en $dentro_de_contrato qq <br>y excede el contrato actual en $diferencia qq</font></h4>";
				$descarte_qq = round(($dentro_de_contrato*(1-($trillado)/100))*$descarte_prc/100,2);
				$exportable_qq = round(($dentro_de_contrato*(1-($trillado)/100))*$exportable_prc/100,2);
			}					
		} else{// estamos dentro
			$hidden = "'text'";//mostramos expor y descart
			echo "<h4><font color=blue>Este lote está completamente dentro contrato actual</font></h4>";
			$diferencia = 0;
		}
		
		
		//muestra_array($todos_lotes_del_socio);
	echo "</th></tr>";

	//datos de calidad del lote
	echo "<tr><td align=center colspan=3>";

	echo "<table class=tablas>";
	echo "<tr><th align=right>Defectos</th><th>granos</th>";
	echo "<tr><th align=right><h6>Humedad</th><td><h6>".$lote["humedad"]."%</td></tr>";
	if($lote["defecto_negro"]>0){echo "<tr><th align=right><h6>Negro o parcial</th><td><h6>".$lote[0]["defecto_negro"]."</td></tr>";}
	if($lote["defecto_vinagre"]>0){echo "<tr><th align=right><h6>Vinagre o parcial</th><td><h6>".$lote[0]["defecto_vinagre"]."</td></tr>";}
	if($lote["defecto_decolorado"]>0){echo "<tr><th align=right><h6>Decolorado</th><td><h6>".$lote[0]["defecto_decolorado"]."</td></tr>";}
	if($lote["defecto_mordido"]>0){echo "<tr><th align=right><h6>Mordidos y cortados</th><td><h6>".$lote[0]["defecto_mordido"]."</td></tr>";}
	if($lote["defecto_brocado"]>0){echo "<tr><th align=right><h6>Brocados</th><td><h6>".$lote[0]["defecto_brocado"]."</td></tr>";}
	echo "</table>&nbsp&nbsp";

	echo "<table class=tablas>";
	echo "<tr><th align=center>Olor</th>";
	//echo "		  <th width=33% align=center><h4>Apto Cata</th></tr>";
	echo "<tr><td align=left><h6>".yes_no($lote["reposo"])." Reposo 
								   ".yes_no($lote["moho"])." Moho<br>
								   ".yes_no($lote["fermento"])." Fermento 
								   ".yes_no($lote["contaminado"])." Contaminado</td>";
	echo "</tr></table>";


	echo "</td></tr>";

	//**************************

	echo "<tr><th><h4>Fecha</th><td colspan=2><input type='date' name=fecha value='".date("Y-m-d",time())."'></td></tr>";
	echo "<tr><th><h4>Exportable</th><td><b>$exportable_qq qq</td><td>$<input type=hidden name=exportable ></td></tr>";
	echo "<tr><th><h4>Descarte</th><td><b>$descarte_qq qq</td><td>$<input type=hidden name=descarte ></td></tr>";
	if($acumulado>$estimado_actual["estimados"]){
		echo "<tr><th><h4>Fuera de contrato</th><td><b>$diferencia qq</td><td>$<input type='number'  name=fuera ></td></tr>";
	} else {
		echo "<tr><th><h4>Fuera de contrato</th><td><b>$diferencia qq</td><td>$0<input type='hidden' value=0 name=fuera ></td></tr>";
	}
	echo "<tr><th><h4>Extra por calidad</th><td><b>".$cata["puntuacion"]."</td><td>$input_q</td></tr>";
	if(in_array($_SESSION['acceso'],$permisos_admin)){
		echo "<tr><th><h4>Extra por Cliente</th><td colspan=2>$<input type='number' name=cliente value=''><b>*solo admin</b></td></tr>";
	}
	if(in_array($_SESSION['acceso'],$permisos_admin)){
		echo "<tr><th><h4>Extra por Mircolote</th><td colspan=2>$<input type='number' name=microlote value=''><b>*solo admin</b></td></tr>";
	}
	if(in_array($_SESSION['acceso'],$permisos_admin)){
		echo "<tr><th><h4>Extra por Taza Dorada</th><td colspan=2>$<input type='number' name=tazadorada value=''><b>*solo admin</b></td></tr>";
	}
	echo "</table><br>";
	echo "<input type='hidden' name=codigo_lote value='".$_GET["lote"]."'>";
	echo "<input type='submit' value='Guardar'>";
	echo "</form>";
	}

	include("pie.php");
?>