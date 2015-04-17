<?php
include ("cabecera.php");
$marcos=Array("Regular","Medio","Aleatorio");
$hierbas=Array("Limpio","Medio","Muchas");
$sombreados=Array("Poco","Medio","Mucho");
$valores=Array(0,25,50,75,100);


if(isset($_GET["asociacion"])){
$SQL_insert="INSERT INTO asociaciones VALUES ('','".$_POST["concepto"]."',
												 '".$_POST["valor"]."',
												 '".$_GET["asociacion"]."',
												 'subparcela',
												 '".$_GET["subparcela"]."')";

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
$SQL_edit="UPDATE subparcelas SET 
				id_parcela='".$_POST["id_parcela"]."',
				superficie='".$_POST["superficie"]."',
				variedad='".$_POST["variedad"]."',
				variedad2='".$_POST["variedad2"]."',
				siembra='".$_POST["siembra"]."',
				densidad='".$_POST["densidad"]."',
				marco='".$_POST["marco"]."',
				hierbas='".$_POST["hierbas"]."',
				sombreado='".$_POST["sombreado"]."',
				roya='".$_POST["roya"]."',
				broca='".$_POST["broca"]."',
				ojo_pollo='".$_POST["ojo_pollo"]."',
				mes_inicio_cosecha='".$_POST["mes_inicio_cosecha"]."',
				duracion_cosecha='".$_POST["duracion_cosecha"]."'
				WHERE id=".$_GET["editar"];

$resultado=mysqli_query($link, $SQL_edit);

$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);


echo "<div align=center><h1>ACTUALIZANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=ficha_parcela.php?parcela=".$_POST["id_parcela"]."'></font></h1></div>";
	
}


else{
$sql="SELECT * FROM subparcelas WHERE id=".$_GET["subparcela"];

//**********TABLA AUTOMATICA*****************************************************************
$resultado=mysqli_query($link, $sql);

echo "<div align=center><h2>EDITAR LA SUBPARCELA</h2><br><table class=tablas>";
echo "<form name=form action=".$_SERVER['PHP_SELF']."?editar=".$_GET["subparcela"]." method='post'>";

while($datos = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
	$parcela=$datos["id_parcela"];
echo "<tr><th align=right><h4>Id Parcela</th><td><h4><input type=text name=id_parcela size=3 value=".$datos["id_parcela"]."></td></tr>";	
echo "<tr><th align=right><h4>Superficie</th><td><h4><input type=text name=superficie size=3 value=".$datos["superficie"]."></h4>ha</td></tr>";	
echo "<tr><th align=right><h4>Variedad</th><td><h4><select name=variedad>";
	foreach(explode(",",$config["variedades"]) as $variedad){
		if($variedad==$datos["variedad"]){$sel="selected";}else{$sel="";}
		echo "<option $sel value=$variedad>$variedad</option>";
	}
echo "</select></h4></td></tr>";
echo "<tr><th align=right><h4>Variedad secundaria</th><td><h4><select name=variedad2>";
	foreach(explode(",",$config["variedades"]) as $variedad){
		if($variedad==$datos["variedad2"]){$sel="selected";}else{$sel="";}
		echo "<option $sel value=$variedad>$variedad</option>";
	}
echo "</select></h4></td></tr>";
echo "<tr><th align=right><h4>Año de siembra</th><td><h4><input type=text name=siembra size=5 value=".$datos["siembra"]."></td></tr>";	
echo "<tr><th align=right><h4>Densidad</th><td><h4><input type=text name=densidad size=4 value=".$datos["densidad"]."></h4>pl/ha</td></tr>";	
echo "<tr><th align=right><h4>Marco de plantación</th><td><h4><select name=marco>";
	foreach($marcos as $marco){
		if($marco==$datos["marco"]){$sel="selected";}else{$sel="";}
		echo "<option $sel value=$marco>$marco</option>";
	}
echo "</select></h4></td></tr>";
echo "<tr><th align=right><h4>Malas hierbas</th><td><h4><select name=hierbas>";
	foreach($hierbas as $hierba){
		if($hierba==$datos["hierbas"]){$sel="selected";}else{$sel="";}
		echo "<option $sel value=$hierba>$hierba</option>";
	}
echo "</select></h4></td></tr>";
echo "<tr><th align=right><h4>Sombreado</th><td><h4><select name=sombreado>";
	foreach($sombreados as $sombreado){
		if($sombreado==$datos["sombreado"]){$sel="selected";}else{$sel="";}
		echo "<option $sel value=$sombreado>$sombreado</option>";
	}
echo "</select></h4></td></tr>";
echo "<tr><th align=right><h4>Roya</th><td><h4><select name=roya>";
	foreach($valores as $valor){
		if($valor==$datos["roya"]){$sel="selected";}else{$sel="";}
		echo "<option $sel value=$valor>$valor</option>";
	}
echo "</select></h4>%</td></tr>";
echo "<tr><th align=right><h4>Broca</th><td><h4><select name=broca>";
	foreach($valores as $valor){
		if($valor==$datos["broca"]){$sel="selected";}else{$sel="";}
		echo "<option $sel value=$valor>$valor</option>";
	}
echo "</select></h4>%</td></tr>";
echo "<tr><th align=right><h4>Ojo de pollo</th><td><h4><select name=ojo_pollo>";
	foreach($valores as $valor){
		if($valor==$datos["ojo_pollo"]){$sel="selected";}else{$sel="";}
		echo "<option $sel value=$valor>$valor</option>";
	}
echo "</select></h4>%</td></tr>";
echo "<tr><th align=right><h4>Mes de inicio de cosecha</th><td><h4><input type=text name=mes_inicio_cosecha value=".$datos["mes_inicio_cosecha"]."></td></tr>";	
echo "<tr><th align=right><h4>Duración cosecha</th><td><h4><input type=text size=3 name=duracion_cosecha value=".$datos["duracion_cosecha"]."></h4>meses</td></tr>";		
}
echo "</table><br>";
//**********TABLA AUTOMATICA*****************************************************************
echo "<input type='submit' value='Guardar'>";
echo "</form></div>";

//*****************************ASOCIACIONES*********************************************
$sql_asoc="SELECT * FROM asociaciones WHERE elemento='subparcela' AND elemento_id=".$_GET["subparcela"];
$resultado_asoc=mysqli_query($link, $sql_asoc);

while($asoc = mysqli_fetch_array($resultado_asoc,MYSQLI_ASSOC)){
	$asociaciones[]=$asoc;
	$asoc_cultivos[]=$asoc["concepto"];
}
echo "<br><br><div align=center><table class=tablas><tr><th colspan=3><h4>Asociaciones con el café</th></tr>";

echo "<tr><th><h4>Cultivos</td>";
echo "<td>";
if(isset($asociaciones)){
	foreach($asociaciones as $key=>$asociacion){
	if($asociacion["tipo"]=="cultivo"){
		echo $asociacion["concepto"]." (".$asociacion["valor"].")<a title=borrar href=?borrar_asoc=".$asociacion["id"]."&subparcela=".$_GET["subparcela"]."><img valign=top src=images/cross.png></a><br>";}
}}else{echo"No existen";}
echo "</td>";
echo "<td>";
echo "<form name=form1 action=".$_SERVER['PHP_SELF']."?asociacion=cultivo&subparcela=".$_GET["subparcela"]." method='post'>";
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


echo "</table><br>";
//muestra_array($asoc_cultivos);
echo "<a href=ficha_parcela.php?parcela=$parcela><button class=boton>volver</button></a>";


}
include("pie.php");

?>