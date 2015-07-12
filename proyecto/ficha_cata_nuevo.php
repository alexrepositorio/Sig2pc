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

if(isset($_POST["catador"])){

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
catas_insertar($_GET["lote"],$_POST["fecha"],$_POST["catador"],$_POST["tostado"],$_POST["fragancia"],
	implode(",",$_POST["tipo_aroma1"]),$_POST["nota_aroma"],$_POST["sabor"],implode(",",$_POST["tipo_sabor"]),
	$_POST["nota_sabor"],$_POST["sabor_residual"],implode(",",$_POST["tipo_sabor_residual"]),
	$_POST["nota_sabor_residual"],$_POST["acidez"],$_POST["cuerpo"],$_POST["uniformidad"],$_POST["balance"],
	$_POST["puntaje_catador"],$_POST["taza_limpia"],$_POST["nota_catacion"],$_POST["dulzor"],
	$puntuacion,$_POST["d_fermento"],$_POST["d_metalico"],$_POST["d_quimico"],$_POST["d_vinagre"],
	$_POST["d_stinker"],$_POST["d_fenol"],$_POST["d_reposo"],$_POST["d_moho"],$_POST["d_terroso"],
	$_POST["d_extrano"],$_POST["d_sucio"],$_POST["d_astringente"],$_POST["d_quaquers"],$_POST["dl_cereal"],
	$_POST["dl_fermento"],$_POST["dl_reposo"],$_POST["dl_moho"],$_POST["dl_astringencia"],$_POST["d_general"]);

echo "<div align=center><h1>GUARDANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=catas.php'></font></h1></div>";
	
}


else{
	

echo "<div align=center><h1>CATA DEL LOTE ".$_GET["lote"]."</h1><br>";

//muestra_array($socio);

echo "<form name='form' action=".$_SERVER['PHP_SELF']."?lote=".$_GET["lote"]." method='post'>";
echo "<table class=tablas>";
//echo "<tr><th align=center colspan=2><h3>Datos del lote</th></tr>";
echo "<tr><th align=right><h4>Fecha</th><td><input type='text' name=fecha value='".date("Y-m-d H:i:s",time())."'></td>";
echo "<th align=right><h4>Catador</th><td><input size=45 type='text' name=catador></td></tr>";
echo "</table><br><br>";

echo "<table class=tablas><tr><td valign=top>";

echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h4>Nivel de Tostado</th></tr>";
echo "<tr><th align=right><h4>Nivel de<br>Tostado</th><td><select name=tostado>";
							for($i=0;$i<=6;$i=$i+0.25){
								echo "<option value=$i>$i</option>";
							}
							echo "</select><br>[0 - 6]</td></tr>";
echo "<tr><td align=right>Nº Quaquers</th><td>
<input type='text' size=1 name='d_quaquers' id='999' value='0'><br>
<input type='button' value='-' onClick='javascript:rest(999)' style='font-size: 8'>
<input type='button' value='+' onClick='javascript:add(999)' style='font-size: 8'>
</td></tr>";

echo "</table>&nbsp";


echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h4>Aroma</th></tr>";
/*echo "<tr><th align=right><h4>Nivel de<br>Tostado</th><td><select name=tostado>";
							for($i=0;$i<=6;$i=$i+0.25){
								echo "<option value=$i>$i</option>";
							}
							echo "</select><br>[0 - 6]</td></tr>";*/
echo "<tr><th align=right><h4>Fragancia</th><td><select name=fragancia>";
							for($i=5;$i<=10;$i=$i+0.25){
								echo "<option value=$i>$i</option>";
							}
							echo "</select><br>[5.00 - 10.00]</td></tr>";
echo "<tr><th align=right valign=top><h4>Elija</th><td>
							<input type=checkbox name='tipo_aroma1[]' value='Floral'>Floral<br>
							<input type=checkbox name='tipo_aroma1[]' value='Frutal'>Frutal<br>
							<input type=checkbox name='tipo_aroma1[]' value='Herbal'>Herbal<br>
							<input type=checkbox name='tipo_aroma1[]' value='Anuesado'>Anuesado<br>
							<input type=checkbox name='tipo_aroma1[]' value='Picante'>Picante<br>
							<input type=checkbox name='tipo_aroma1[]' value='Caramelo'>Caramelo<br>
							<input type=checkbox name='tipo_aroma1[]' value='Chocolate dulce'>Chocolate dulce<br>
							<input type=checkbox name='tipo_aroma1[]' value='Chocolate amargo'>Chocolate amargo<br>
							<input type=checkbox name='tipo_aroma1[]' value='Vainilla'>Vainilla<br>
							<input type=checkbox name='tipo_aroma1[]' value='Cítrico'>Cítrico<br>
							<input type=checkbox name='tipo_aroma1[]' value='Neutral'>Neutral<br>
							<input type=checkbox name='tipo_aroma1[]' value='Resinoso'>Resinoso<br>
							<input type=checkbox name='tipo_aroma1[]' value='Carbonoso'>Carbonoso<br>										
							</td></tr>";
echo "<tr><th colspan=2 align=left valign=top><h4>Nota<br><textarea name='nota_aroma' rows=7 cols=22></textarea></td></tr>";
echo "</table>&nbsp";

echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h4>Sabor</th></tr>";
echo "<tr><th align=right><h4>Sabor</th><td><select name=sabor>";
							for($i=5;$i<=10;$i=$i+0.25){
								echo "<option value=$i>$i</option>";
							}
							echo "</select><br>[5.00 - 10.00]</td></tr>";
echo "<tr><th align=right valign=top><h4>Elija</th><td>
							<input type=checkbox name='tipo_sabor[]' value='Floral'>Floral<br>
							<input type=checkbox name='tipo_sabor[]' value='Frutal'>Frutal<br>
							<input type=checkbox name='tipo_sabor[]' value='Herbal'>Herbal<br>
							<input type=checkbox name='tipo_sabor[]' value='Anuesado'>Anuesado<br>
							<input type=checkbox name='tipo_sabor[]' value='Picante'>Picante<br>
							<input type=checkbox name='tipo_sabor[]' value='Caramelo'>Caramelo<br>
							<input type=checkbox name='tipo_sabor[]' value='Chocolate dulce'>Chocolate dulce<br>
							<input type=checkbox name='tipo_sabor[]' value='Chocolate amargo'>Chocolate amargo<br>
							<input type=checkbox name='tipo_sabor[]' value='Articulado'>Articulado<br>
							<input type=checkbox name='tipo_sabor[]' value='Vainilla'>Vainilla<br>
							<input type=checkbox name='tipo_sabor[]' value='Cítrico'>Cítrico<br>
							<input type=checkbox name='tipo_sabor[]' value='Melón'>Melón<br>
							<input type=checkbox name='tipo_sabor[]' value='Mora'>Mora<br>
							<input type=checkbox name='tipo_sabor[]' value='Vinoso'>Vinoso<br>
							<input type=checkbox name='tipo_sabor[]' value='Carbonoso'>Carbonoso<br>										
							<input type=checkbox name='tipo_sabor[]' value='Madera'>Madera<br>
							<input type=checkbox name='tipo_sabor[]' value='Resinoso'>Resinoso<br>
							<input type=checkbox name='tipo_sabor[]' value='Neutral'>Neutral<br>
							</td></tr>";
echo "<tr><th colspan=2 align=left valign=top><h4>Nota<br><textarea name='nota_sabor' rows=6 cols=20></textarea></td></tr>";
echo "</table>&nbsp";


echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h4>Sabor residual</th></tr>";
echo "<tr><th align=right><h4>Sabor<br>residual</th><td><select name=sabor_residual>";
							for($i=5;$i<=10;$i=$i+0.25){
								echo "<option value=$i>$i</option>";
							}
							echo "</select><br>[5.00 - 10.00]</td></tr>";
echo "<tr><th align=right valign=top><h4>Elija</th><td>
							<input type=checkbox name='tipo_sabor_residual[]' value='Refrescante'>Refrescante<br>
							<input type=checkbox name='tipo_sabor_residual[]' value='Limpio'>Limpio<br>
							<input type=checkbox name='tipo_sabor_residual[]' value='Dulce'>Dulce<br>
							<input type=checkbox name='tipo_sabor_residual[]' value='Picante'>Picante<br>
							<input type=checkbox name='tipo_sabor_residual[]' value='Delicado'>Delicado<br>
							<input type=checkbox name='tipo_sabor_residual[]' value='Suave'>Suave<br>
							<input type=checkbox name='tipo_sabor_residual[]' value='Duro'>Duro<br>
							<input type=checkbox name='tipo_sabor_residual[]' value='Astringente'>Astringente<br>
							<input type=checkbox name='tipo_sabor_residual[]' value='Amargo'>Amargo<br>
							<input type=checkbox name='tipo_sabor_residual[]' value='Seco'>Seco<br>
							<input type=checkbox name='tipo_sabor_residual[]' value='Agrio'>Agrio<br>
							<input type=checkbox name='tipo_sabor_residual[]' value='Vinoso'>Vinoso<br>
							<input type=checkbox name='tipo_sabor_residual[]' value='Áspero'>Áspero<br>
							<input type=checkbox name='tipo_sabor_residual[]' value='Salado'>Salado<br>
							</td></tr>";
echo "<tr><th colspan=2 align=left valign=top><h4>Nota<br><textarea name='nota_sabor_residual' rows=6 cols=18></textarea></td></tr>";
echo "</table>&nbsp";

echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h4>Otros Parámetros</th></tr>";
echo "<tr><td align=right><h4>Acidez</h4><br><select name=acidez>";
							for($i=5;$i<=10;$i=$i+0.25){
								echo "<option value=$i>$i</option>";
							}
							echo "</select><br>[5.00 - 10.00]</td>";
echo "<td align=right><h4>Uniformidad</h4><br><select name=uniformidad>";
							for($i=5;$i<=10;$i=$i+0.25){
								echo "<option value=$i>$i</option>";
							}
							echo "</select><br>[5.00 - 10.00]</td></tr>";
echo "<tr><td align=right><h4>Cuerpo</h4><br><select name=cuerpo>";
							for($i=5;$i<=10;$i=$i+0.25){
								echo "<option value=$i>$i</option>";
							}
							echo "</select><br>[5.00 - 10.00]</td>";
echo "<td align=right><h4>Balance</h4><br><select name=balance>";
							for($i=5;$i<=10;$i=$i+0.25){
								echo "<option value=$i>$i</option>";
							}
							echo "</select><br>[5.00 - 10]</td></tr>";
echo "<tr><td align=right rowspan=2><h4>Puntaje<br>Catador</h4><br><select name=puntaje_catador>";
							for($i=5;$i<=10;$i=$i+0.25){
								echo "<option value=$i>$i</option>";
							}
							echo "</select><br>[5.00 - 10.00]</td>";
echo "<td align=right><h4>Taza<br>limpia</h4><br><select name=taza_limpia>";
							for($i=5;$i<=10;$i=$i+0.25){
								echo "<option value=$i>$i</option>";
							}
							echo "</select><br>[5.00 - 10.00]</td></tr>";
echo "<tr><td align=right><h4>Dulzor</h4><br><select name=dulzor>";
							for($i=5;$i<=10;$i=$i+0.25){
								echo "<option value=$i>$i</option>";
							}
							echo "</select><br>[5.00 - 10.00]</td></tr>";
echo "<tr><th colspan=2 align=left valign=top><h4>Nota Catador<br><textarea name='nota_catacion' rows=10 cols=18></textarea></td></tr>";
echo "</table>&nbsp";


echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h4>Defectos</th></tr>";

foreach($defectos as $key=>$defecto){
if($key<=11){		
	$defecto_texto=explode("_", $defecto);
	$defecto_texto=$defecto_texto[1];
echo "<tr><td align=right>".ucfirst($defecto_texto)."</th><td>
<input type='text' size=1 name='".$defecto."' id='$key' value='0'><br>
<input type='button' value='-' onClick='javascript:rest($key)' style='font-size: 8'>
<input type='button' value='+' onClick='javascript:add($key)' style='font-size: 8'>
</td></tr>";
}}

echo "</table>&nbsp&nbsp";

echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h4>Defectos ligeros</th></tr>";

foreach($defectos as $key=>$defecto){
if($key>11){	
	$defecto_texto=explode("_", $defecto);
	$defecto_texto=$defecto_texto[1];
echo "<tr><td align=right>".ucfirst($defecto_texto)."</th><td>
<input type='text' size=1 name='".$defecto."' id='$key' value='0'><br>
<input type='button' value='-' onClick='javascript:rest($key)' style='font-size: 8'>
<input type='button' value='+' onClick='javascript:add($key)' style='font-size: 8'>
</td></tr>";
}}

echo "<tr><th align=center colspan=2><h4>GENERAL</th></tr>";
echo "<tr><td align=right>DEFECTOS</th><td>
<input type='text' size=1 name='d_general' id='99' value='0'><br>
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