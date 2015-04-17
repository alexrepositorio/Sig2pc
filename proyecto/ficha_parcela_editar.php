<?php
include ("cabecera.php");
$riegos=Array("Aspersión","Goteo","Gravedad","Ninguno");
if(isset($_GET["asociacion"])){
$SQL_insert="INSERT INTO asociaciones VALUES ('','".$_POST["concepto"]."',
												 '".$_POST["valor"]."',
												 '".$_GET["asociacion"]."',
												 'parcela',
												 '".$_GET["parcela"]."')";

$resultado=mysqli_query($link, $SQL_insert);

$cadena=str_replace("'", "", $SQL_insert);
guarda_historial($cadena);
//echo "$SQL_insert<br>";
}

if(isset($_GET["borrar_asoc"])){
$SQL_insert="DELETE FROM asociaciones WHERE id=".$_GET["borrar_asoc"];

$resultado=mysqli_query($link, $SQL_insert);

$cadena=str_replace("'", "", $SQL_insert);
guarda_historial($cadena);
//echo "$SQL_insert<br>";
}


if(isset ($_GET["editar"])){
$SQL_edit="UPDATE parcelas SET 
				sup_total='".$_POST["sup_total"]."',
				coorX='".$_POST["coorX"]."',
				coorY='".$_POST["coorY"]."',
				alti='".$_POST["alti"]."',
				id_socio='".$_POST["id_socio"]."',
				MOcontratada='".$_POST["MOcontratada"]."',
				MOfamiliar='".$_POST["MOfamiliar"]."',
				Miembros_familia='".$_POST["Miembros_familia"]."',
				riego='".$_POST["riego"]."'
				WHERE id=".$_GET["editar"];

$resultado=mysqli_query($link, $SQL_edit);

$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);


echo "<div align=center><h1>ACTUALIZANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=ficha_parcela.php?parcela=".$_GET["editar"]."'></font></h1></div>";
	
}


else{
$sql="SELECT * FROM parcelas WHERE id=".$_GET["parcela"];

//**********TABLA AUTOMATICA*****************************************************************
$resultado=mysqli_query($link, $sql);

echo "<div align=center><h2>EDITAR LA PARCELA</h2><br><table class=tablas>";
echo "<form name=form action=".$_SERVER['PHP_SELF']."?editar=".$_GET["parcela"]." method='post'>";

while($datos = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
echo "<tr><th align=right><h4>Socio</th><td><h4>";
echo "<select name=id_socio>";
//$sql_socios="SELECT socios.id_socio, socios.nombres, socios.apellidos, socios.codigo, COUNT(lotes.id) FROM socios LEFT JOIN lotes ON socios.codigo=lotes.id_socio GROUP BY socios.id_socio ORDER BY codigo ASC";
$sql_socios="SELECT socios.*, COUNT(parcelas.id) as parcelas FROM socios
LEFT JOIN parcelas on socios.codigo=parcelas.id_socio
GROUP BY socios.codigo ORDER BY socios.codigo";
$r_socio=mysqli_query($link, $sql_socios);
while ($rowsocio = mysqli_fetch_array($r_socio,MYSQLI_ASSOC))
{
	if($rowsocio["parcelas"]>0){
		if($rowsocio["parcelas"]>1){$lotes_t="parcelas";}else{$lotes_t="parcela";}
		$lotess="(".$rowsocio["parcelas"]." $lotes_t)";
		$mark="style='background-color:skyblue; color:blue;'";
	}else{$mark="";$lotess="";}
	if($rowsocio["codigo"]==$datos["id_socio"]){$sel="selected";}else{$sel="";}
	$socio_n=$rowsocio["codigo"]."-".$rowsocio["apellidos"].", ".$rowsocio["nombres"]." $lotess";
	echo "<option $sel $mark value='".$rowsocio["codigo"]."'>$socio_n</option>";
}
echo "</select><br>";


echo "<tr><th align=right><h4>Superficie Finca</th><td><h4><input type=text name=sup_total size=3 value=".$datos["sup_total"]."></h4>ha</td></tr>";	
echo "<tr><th align=right><h4>Coordenada X</th><td><h4><input type=text name=coorX size=10 value=".$datos["coorX"]."></h4></td></tr>";	
echo "<tr><th align=right><h4>Coordenada Y</th><td><h4><input type=text name=coorY size=10 value=".$datos["coorY"]."></h4></td></tr>";	
echo "<tr><th align=right><h4>Altitud</th><td><h4><input type=text name=alti size=3 value=".$datos["alti"]."></h4>msnm</td></tr>";	
echo "<tr><th align=right><h4>Riego</th><td><h4><select name=riego>";
	foreach($riegos as $riego){
		if($riego==$datos["riego"]){$sel="selected";}else{$sel="";}
		echo "<option $sel value=$riego>$riego</option>";
	}
echo "</select></h4></td></tr>";
echo "<tr><th align=right><h4>Mano de Obra Contratada</th><td><h4><input type=text name=MOcontratada size=3 value=".$datos["MOcontratada"]."></h4></td></tr>";	
echo "<tr><th align=right><h4>Mano de Obra Familiar</th><td><h4><input type=text name=MOfamiliar size=3 value=".$datos["MOfamiliar"]."></h4></td></tr>";	
echo "<tr><th align=right><h4>Miembros de la Familia</th><td><h4><input type=text name=Miembros_familia size=3 value=".$datos["Miembros_familia"]."></h4></td></tr>";	
}
echo "</table><br>";
//**********TABLA AUTOMATICA*****************************************************************
echo "<input type='submit' value='Guardar'>";
echo "</form></div>";


//*****************************ASOCIACIONES*********************************************
$sql_asoc="SELECT * FROM asociaciones WHERE elemento='parcela' AND elemento_id=".$_GET["parcela"];
$resultado_asoc=mysqli_query($link, $sql_asoc);

while($asoc = mysqli_fetch_array($resultado_asoc,MYSQLI_ASSOC)){
	$asociaciones[]=$asoc;
	$asoc_cultivos[]=$asoc["concepto"];
}
echo "<br><br><div align=center><table class=tablas><tr><th colspan=3><h4>Producciones de la Finca</th></tr>";

echo "<tr><th><h4>Cultivos</td>";
echo "<td>";
if(isset($asociaciones)){
	foreach($asociaciones as $key=>$asociacion){
	if($asociacion["tipo"]=="cultivo"){
		echo $asociacion["concepto"]." (".$asociacion["valor"].")<a title=borrar href=?borrar_asoc=".$asociacion["id"]."&parcela=".$_GET["parcela"]."><img valign=top src=images/cross.png></a><br>";}
}}else{echo"No existen";}
echo "</td>";
echo "<td>";
echo "<form name=form1 action=".$_SERVER['PHP_SELF']."?asociacion=cultivo&parcela=".$_GET["parcela"]." method='post'>";
echo "<select name=concepto>";
	foreach(explode(",",$config["cultivos"]) as $cultivo){
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
		echo $asociacion["concepto"]." (".$asociacion["valor"].")<a title=borrar href=?borrar_asoc=".$asociacion["id"]."&parcela=".$_GET["parcela"]."><img valign=top src=images/cross.png></a><br>";}
}}else{echo"No existen";}
echo "</td>";
echo "<td>";
echo "<form name=form2 action=".$_SERVER['PHP_SELF']."?asociacion=animales&parcela=".$_GET["parcela"]." method='post'>";
echo "<select name=concepto>";
	foreach(explode(",",$config["animales"]) as $animal){
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