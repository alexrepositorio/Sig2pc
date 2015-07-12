<SCRIPT LANGUAGE="Javascript">
function add(c) {
valor = document.getElementById(0+ c).value;
valor = (valor*1) + 1;
document.getElementById(0+ c).value= valor;
return valor;  
}
function rest(c) {
valor = document.getElementById(0+c).value;
valor = (valor*1) - 1;
document.getElementById(0+ c).value= valor;
return valor;  
}
</script>
<?php
include ("cabecera.php");
include ("catas_funciones.php");

$resultado=catas_consultar('lote',$_GET["lote"]);
$cata = $resultado[0];

if(isset($_GET["lote_guardar"])){
	if ($_POST["fragancia"]>4 && $_POST["sabor"]>4 && $_POST["acidez"]>4 && $_POST["cuerpo"]>4 && $_POST["balance"]>4){
	$puntuacion= $_POST["fragancia"]+
				 $_POST["sabor"]+
				 $_POST["sabor_residual"]+
				 $_POST["acidez"]+
				 $_POST["cuerpo"]+
				 $_POST["uniformidad"]+
				 $_POST["balance"]+
				 $_POST["puntaje_catador"]+
				 $_POST["taza_limpia"]+
				 $_POST["dulzor"]-
				 $_POST["d_general"];
	}else {
		$puntuacion=$cata["puntuacion"];
	}
	if (isset($_POST["tipo_aroma1"])) {
		$tipo_aroma1=implode(",",$_POST["tipo_aroma1"]);
	}else{
		$tipo_aroma1="";
	}
	if (isset($_POST["tipo_sabor"])) {
		$tipo_sabor=implode(",",$_POST["tipo_sabor"]);
	}else{
		$tipo_sabor="";
	}
	if (isset($_POST["tipo_sabor_residual"])) {
		$tipo_sabor_residual=implode(",",$_POST["tipo_sabor_residual"]);
	}else{
		$tipo_sabor_residual="";
	}
	catas_actualizar(
		$cata["id"],$_GET["lote"],$_POST["fecha"],$_POST["catador"],$_POST["tostado"],
		$_POST["fragancia"],$tipo_aroma1,$_POST["nota_aroma"],
		$_POST["sabor"],$tipo_sabor,$_POST["nota_sabor"],$_POST["sabor_residual"],
		$tipo_sabor_residual,$_POST["nota_sabor_residual"],
		$_POST["acidez"],$_POST["cuerpo"],$_POST["uniformidad"],$_POST["balance"],
		$_POST["puntaje_catador"],$_POST["taza_limpia"],$_POST["nota_catacion"],$_POST["dulzor"],
		$puntuacion,$_POST["d_fermento"],$_POST["d_metalico"],$_POST["d_quimico"],$_POST["d_vinagre"],
		$_POST["d_stinker"],$_POST["d_fenol"],$_POST["d_reposo"],$_POST["d_moho"],$_POST["d_terroso"],
		$_POST["d_extrano"],$_POST["d_sucio"],$_POST["d_astringente"],$_POST["d_quaquers"],$_POST["dl_cereal"],
		$_POST["dl_fermento"],$_POST["dl_reposo"],$_POST["dl_moho"],$_POST["dl_astringencia"],$_POST["d_general"]
	);
	echo "<div align=center><h1>GUARDANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=ficha_cata.php?lote=".$_GET["lote_guardar"]."'></font></h1></div>";	
}else{
	$lote=LotesConsultarCriterio('id',$_GET["lote"]);
	$lote=$lote[0];
	echo "<div align=center><h1>EDICION DE LA CATA DEL LOTE ".$lote["codigo_lote"]."</h1><br>";
	echo "<h3><font color=red>Puntuación actual: ".$cata["puntuacion"]. "pts.</font></h3><br>";
	echo "<form name=form action=".$_SERVER['PHP_SELF']."?lote=".$_GET["lote"]."&lote_guardar=".$_GET["lote"]." method='post'>";
	echo "<table class=tablas>";
	echo "<tr><th align=right><h4>Fecha</th><td><input type='text' name=fecha  value='".$cata["fecha"]."'></td>";
	echo "<th align=right><h4>Catador</th><td><input size=45 type='text' name=catador value='".$cata["catador"]."'></td></tr>";
	echo "</table><br><br>";
	echo "<table class=tablas><tr><td>";
	echo "<table class=tablas>";
	echo "<tr><th align=center colspan=2><h4>Nivel de Tostado</th></tr>";
	echo "<tr><th align=right><h4>Nivel de<br>Tostado</th><td><select name=tostado>";
	for($i=0;$i<=6;$i++){
		if($cata["tostado"]==$i){
			$sel="selected";
		}else{
			$sel="";
		}
		echo "<option $sel value=$i>$i</option>";
	}
	echo "</select><br>[0 - 6]</td></tr>";
	echo "<tr><td align=right>Nº Quaquers</th><td>
	<input type='text' size=1 name='d_quaquers' id='999' value='".$cata["d_quaquers"]."'><br>
	<input type='button' value='-' onClick='javascript:rest(999)' style='font-size: 8'>
	<input type='button' value='+' onClick='javascript:add(999)' style='font-size: 8'>
	</td></tr>";							
	echo "</table>&nbsp&nbsp";
	echo "<table class=tablas>";
	echo "<tr><th align=center colspan=2><h4>Aroma</th></tr>";
	echo "<tr><th align=right><h4>Fragancia</th><td><select name=fragancia>";
	for($i=5;$i<=10;$i=$i+0.25){
		if($cata["fragancia"]==$i){
			$sel="selected";
		}else{
			$sel="";
		}
		echo "<option $sel value=$i>$i</option>";
	}
	echo "</select><br>[5.00 - 10.00]</td></tr>";				
	echo "<tr><th align=right valign=top><h4>Elija</th><td>";
		//*****************************
	foreach($tipos_aroma as $tipo_aroma){
		if(in_array($tipo_aroma, explode(",",$cata["tipo_aroma1"]))){
			$ch="checked";
		}else{
			$ch="";
		}	
		echo "<input type=checkbox $ch name='tipo_aroma1[]' value='$tipo_aroma'>$tipo_aroma<br>";
	}
	//*****************************
	echo "</td></tr>";
	echo "<tr><th colspan=2 align=left valign=top><h4>Nota<br><textarea name='nota_aroma' rows=7 cols=20>".$cata["nota_aroma"]."</textarea></td></tr>";
	echo "</table>&nbsp&nbsp";
	echo "<table class=tablas>";
	echo "<tr><th align=center colspan=2><h4>Sabor</th></tr>";
	echo "<tr><th align=right><h4>Sabor</th><td><select name=sabor>";
	for($i=5;$i<=10;$i=$i+0.25){
		if($cata["sabor"]==$i){
			$sel="selected";
		}else{
			$sel="";
		}
		echo "<option $sel value=$i>$i</option>";
	}
	echo "</select><br>[5.00 - 10.00]</td></tr>";					
	echo "<tr><th align=right valign=top><h4>Elija</th><td>";
		//*****************************
	foreach($tipos_sabor as $tipo_sabor){
		if(in_array($tipo_sabor, explode(",",$cata["tipo_sabor"]))){
			$ch="checked";
			}else{
				$ch="";
			}	
		echo "<input type=checkbox $ch name='tipo_sabor[]' value='$tipo_sabor'>$tipo_sabor<br>";
	}
	//*****************************
	echo "</td></tr>";
	echo "<tr><th colspan=2 align=left valign=top><h4>Nota<br><textarea name='nota_sabor' rows=6 cols=20>".$cata["nota_sabor"]."</textarea></td></tr>";
	echo "</table>&nbsp";
	echo "<table class=tablas>";
	echo "<tr><th align=center colspan=2><h4>Sabor residual</th></tr>";
	echo "<tr><th align=right><h4>Sabor<br>residual</th><td><select name=sabor_residual>";
	for($i=5;$i<=10;$i=$i+0.25){
		if($cata["sabor_residual"]==$i){
			$sel="selected";
		}else{
				$sel="";
		}
		echo "<option $sel value=$i>$i</option>";
	}
	echo "</select><br>[5.00 - 10.00]</td></tr>";
	echo "<tr><th align=right valign=top><h4>Elija</th><td>";
	//*****************************
	foreach($tipos_sabor_res as $tipo_sabor_res){
		if(in_array($tipo_sabor_res, explode(",",$cata["tipo_sabor_residual"]))){
			$ch="checked";
		}else{
			$ch="";
		}	
	echo "<input type=checkbox  $ch name='tipo_sabor_residual[]' value='$tipo_sabor_res'>$tipo_sabor_res<br>";}
	//*****************************
	echo "</td></tr>";
	echo "<tr><th colspan=2 align=left valign=top><h4>Nota<br><textarea name='nota_sabor_residual' rows=6 cols=18>".$cata["nota_sabor_residual"]."</textarea></td></tr>";
	echo "</table>&nbsp&nbsp";
	echo "<table class=tablas>";
	echo "<tr><th align=center colspan=2><h4>Otros Parámetros</th></tr>";
	echo "<tr><td align=right><h4>Acidez</h4><br><select name=acidez>";
	for($i=5;$i<=10;$i=$i+0.25){
		if($cata["acidez"]==$i){
			$sel="selected";
		}else{
			$sel="";
		}
		echo "<option $sel value=$i>$i</option>";
	}
	echo "</select><br>[5.00 - 10.00]</td>";
	echo "<td align=right><h4>Uniformidad</h4><br><select name=uniformidad>";
	for($i=5;$i<=10;$i=$i+0.25){
			if($cata["uniformidad"]==$i){
				$sel="selected";
			}else{
				$sel="";
		}
			echo "<option $sel value=$i>$i</option>";
	}
	echo "</select><br>[5.00 - 10.00]</td></tr>";
	echo "<tr><td align=right><h4>Cuerpo</h4><br><select name=cuerpo>";
	for($i=5;$i<=10;$i=$i+0.25){
		if($cata["cuerpo"]==$i){
			$sel="selected";
		}else{
			$sel="";
		}
		echo "<option $sel value=$i>$i</option>";
	}
	echo "</select><br>[5.00 - 10.00]</td>";
	echo "<td align=right><h4>Balance</h4><br><select name=balance>";
	for($i=5;$i<=10;$i=$i+0.25){
		if($cata["balance"]==$i){
			$sel="selected";
		}else{
			$sel="";
		}
		echo "<option $sel value=$i>$i</option>";
	}
	echo "</select><br>[5.00 - 10.00]</td></tr>";
	echo "<tr><td align=right rowspan=2><h4>Puntaje<br>Catador</h4><br><select name=puntaje_catador>";
	for($i=5;$i<=10;$i=$i+0.25){
		if($cata["puntaje_catador"]==$i){
			$sel="selected";
		}else{
			$sel="";
		}
		echo "<option $sel value=$i>$i</option>";
	}
	echo "</select><br>[5.00 - 10.00]</td>";
	echo "<td align=right><h4>Taza<br>limpia</h4><br><select name=taza_limpia>";
	for($i=5;$i<=10;$i=$i+0.25){
		if($cata["taza_limpia"]==$i){
			$sel="selected";
		}else{
			$sel="";
		}
		echo "<option $sel value=$i>$i</option>";
	}
	echo "</select><br>[5.00 - 10.00]</td></tr>";
	echo "<tr><td align=right><h4>Dulzor</h4><br><select name=dulzor>";
	for($i=5;$i<=10;$i=$i+0.25){
		if($cata["dulzor"]==$i){
			$sel="selected";
		}else{
			$sel="";
		}
		echo "<option $sel value=$i>$i</option>";
	}
	echo "</select><br>[5.00 - 10.00]</td></tr>";
	echo "<tr><th colspan=2 align=left valign=top><h4>Nota Catador<br><textarea name='nota_catacion' rows=10 cols=20>".$cata["nota_catacion"]."</textarea></td></tr>";
	echo "</table>&nbsp";
	echo "<table class=tablas>";
	echo "<tr><th align=center colspan=2><h4>Defectos</th></tr>";
	foreach($defectos as $key=>$defecto){
		if($key<=11){		
			$defecto_texto=explode("_", $defecto);
			$defecto_texto=$defecto_texto[1];
			echo "<tr><td align=right>".ucfirst($defecto_texto)."</th><td>
			<input type='text' size=1 name='".$defecto."' id='$key' value='".$cata[$defecto]."'><br>
			<input type='button' value='-' onClick='javascript:rest($key)' style='font-size: 8'>
			<input type='button' value='+' onClick='javascript:add($key)' style='font-size: 8'>
			</td></tr>";
		}
	}

	echo "</table>&nbsp";
	echo "<table class=tablas>";
	echo "<tr><th align=center colspan=2><h4>Defectos ligeros</th></tr>";

	foreach($defectos as $key=>$defecto){
		if($key>11){	
			$defecto_texto=explode("_", $defecto);
			$defecto_texto=$defecto_texto[1];
			echo "<tr><td align=right>".ucfirst($defecto_texto)."</th><td>
			<input type='text' size=1 name='".$defecto."' id='$key' value='".$cata[$defecto]."'><br>
			<input type='button' value='-' onClick='javascript:rest($key)' style='font-size: 8'>
			<input type='button' value='+' onClick='javascript:add($key)' style='font-size: 8'>
			</td></tr>";
		}
	}
	echo "<tr><th align=center colspan=2><h4>GENERAL</th></tr>";
	echo "<tr><td align=right>DEFECTOS</th><td>
	<input type='text' size=1 name='d_general' id='99' value='".$cata["d_general"]."'><br>
	<input type='button' value='-' onClick='javascript:rest(99)' style='font-size: 8'>
	<input type='button' value='+' onClick='javascript:add(99)' style='font-size: 8'>
	</td></tr>";
	echo "</table>";
								
	echo "</td></tr></table>";
	echo "<br><br><input type='submit' value='GUARDAR'>";
	echo "</form>";
}

include("pie.php");
?>