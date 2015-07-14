<?php
include ("cabecera.php");
include ("parcelas_funciones.php");
include ("asociaciones_funciones.php");
include ("socio_funciones.php");
include ("configuracion_funciones.php");




if(isset($_GET["asociacion"])){
	asociaciones_insertar($_POST["concepto"],$_POST["valor"],$_GET["asociacion"],"parcela",$_GET["parcela"]);	
}
if(isset($_GET["borrar_asoc"])){
	asociaciones_borrar($_GET["borrar_asoc"]);
}
if(isset ($_POST["update"])){
	parcela_editar($_POST["sup_total"],$_POST["coorX"],$_POST["coorY"],$_POST["alti"],$_POST["id_socio"],$_POST["MOcontratada"]
	,$_POST["MOfamiliar"],$_POST["Miembros_familia"],$_POST["riego"],$_POST["update"]);	
	echo "<div align=center><h1>ACTUALIZANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=ficha_parcela.php?parcela=".$_POST["update"]."'></font></h1></div>";
}
else{
	$parcela=parcelas_consultarCriterio('id',$_GET["parcela"]);
	echo "<div align=center><h2>EDITAR LA PARCELA</h2><br><table class=tablas>";
	echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
	foreach ($parcela as $datos) {
		echo "<tr><th align=right><h4>Socio</th><td><h4>";
		echo "<select name=id_socio>";
		$r_socio=consultarCriterio('parcelas','');	
		foreach ($r_socio as $rowsocio) {
			echo $rowsocio["parcelas"];
			if($rowsocio["parcelas"]>0){
				if($rowsocio["parcelas"]>1){
					$lotes_t="parcelas";
				}else{
					$lotes_t="parcela";
				}
				$lotess="(".$rowsocio["parcelas"]." $lotes_t)";
				$mark="style='background-color:skyblue; color:blue;'";
			}else{
				$mark="";$lotess="";
			}
			if($rowsocio["id_socio"]==$datos["id_socio"]){
				$sel="selected";
			}else{
				$sel="";
			}
			$socio_n=$rowsocio["codigo"]."-".$rowsocio["apellidos"].", ".$rowsocio["nombres"]." $lotess";
			echo "<option $sel $mark value='".$rowsocio["id_socio"]."'>$socio_n</option>";
		}
		echo "</select><br>";
		echo "<input type='hidden' name='update' value=".$_GET["parcela"].">";
		echo "<tr><th align=right><h4>Superficie Finca</th><td><h4><input type=number step='any' name=sup_total size=3 value=".$datos["sup_total"]."></h4>ha</td></tr>";	
		echo "<tr><th align=right><h4>Coordenada X</th><td><h4><input type=number step='any' name=coorX size=10 value=".$datos["coorX"]."></h4></td></tr>";	
		echo "<tr><th align=right><h4>Coordenada Y</th><td><h4><input type=number step='any' name=coorY size=10 value=".$datos["coorY"]."></h4></td></tr>";	
		echo "<tr><th align=right><h4>Altitud</th><td><h4><input type=number step='any' name=alti size=3 value=".$datos["alti"]."></h4>msnm</td></tr>";	
		echo "<tr><th align=right><h4>Riego</th><td><h4><select name=riego>";
			foreach($riegos as $riego){
				if($riego==$datos["riego"]){$sel="selected";}else{$sel="";}
				echo "<option $sel value=$riego>$riego</option>";
			}
		echo "</select></h4></td></tr>";
		echo "<tr><th align=right><h4>Mano de Obra Contratada</th><td><h4><input type=number name=MOcontratada size=3 value=".$datos["MOcontratada"]."></h4></td></tr>";	
		echo "<tr><th align=right><h4>Mano de Obra Familiar</th><td><h4><input type=number name=MOfamiliar size=3 value=".$datos["MOfamiliar"]."></h4></td></tr>";	
		echo "<tr><th align=right><h4>Miembros de la Familia</th><td><h4><input type=number name=Miembros_familia size=3 value=".$datos["Miembros_familia"]."></h4></td></tr>";	
	}
	echo "</table><br>";
	//**********TABLA AUTOMATICA*****************************************************************
	echo "<input type='submit' value='Guardar'>";
	echo "</form></div>";
	//*****************************ASOCIACIONES*********************************************
	$resultado_asoc=asociaciones_consultar("parcela",$_GET["parcela"]);
	foreach ($resultado_asoc as $asoc) {
		$asociaciones[]=$asoc;
		$asoc_cultivos[]=$asoc["concepto"];
	}
	echo "<br><br><div align=center><table class=tablas><tr><th colspan=3><h4>Producciones de la Finca</th></tr>";
	echo "<tr><th><h4>Cultivos</td>";
	echo "<td>";
	if(isset($asociaciones)){
		foreach($asociaciones as $asociacion){
			if($asociacion["tipo"]=="cultivo"){
				echo $asociacion["concepto"]." (".$asociacion["valor"].")<a title=borrar href=?borrar_asoc=".$asociacion["id"]."&parcela=".$_GET["parcela"].">
				<img valign=top src=images/cross.png></a><br>";
			}
		}
	}else{
		echo"No existen";
	}
	echo "</td>";
	echo "<td>";
	echo "<form name=form1 action=".$_SERVER['PHP_SELF']."?asociacion=cultivo&parcela=".$_GET["parcela"]." method='post'>";
	echo "<select name=concepto>";
		foreach(explode(",",configuracion_cons('parametro','cultivos')[0]["valor"]) as $cultivo){
			if(!in_array($cultivo,$asoc_cultivos)){echo "<option value=$cultivo>$cultivo</option>";}
		}
	echo "</select></h4>";
	echo "<input type='submit' value='Añadir'><br>";
	echo "<input type=radio checked name=valor value=bajo>bajo";
	echo "<input type=radio  name=valor value=medio>medio";
	echo "<input type=radio  name=valor value=alto>alto";
	echo "</form>";
	echo "</td>";
	echo "</tr>";

	echo "<tr><th><h4>Animales</td>";
	echo "<td>";
	if(isset($asociaciones)){
	foreach($asociaciones as $key=>$asociacion){
			if($asociacion["tipo"]=="animales"){
				echo $asociacion["concepto"]." (".$asociacion["valor"].")<a title=borrar href=?borrar_asoc=".$asociacion["id"]."&parcela=".$_GET["parcela"]."><img valign=top src=images/cross.png></a><br>";
			}
		}
	}else{
		echo"No existen";
		}
	echo "</td>";
	echo "<td>";
	echo "<form name=form2 action=".$_SERVER['PHP_SELF']."?asociacion=animales&parcela=".$_GET["parcela"]." method='post'>";
	echo "<select name=concepto>";
		foreach(explode(",",configuracion_cons('parametro','animales')[0]["valor"]) as $animal){
			if(!in_array($animal,$asoc_cultivos)){echo "<option value=$animal>$animal</option>";}
		}
	echo "</select></h4>";
	echo "<input type='submit' value='Añadir'><br>";
	echo "<input type=radio checked name=valor value=bajo>bajo";
	echo "<input type=radio  name=valor value=medio>medio";
	echo "<input type=radio  name=valor value=alto>alto";
	echo "</form>";
	echo "</td>";
	echo "</tr>";
	echo "</table><br>";
	//muestra_array($asoc_cultivos);
	echo "<a href=ficha_parcela.php?parcela=".$_GET["parcela"]."><button class=boton>volver</button></a>";
}
include("pie.php");

?>