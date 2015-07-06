<?php
include ("cabecera.php");
include ("subparcelas_funciones.php");
include ("configuracion_funciones.php");


if(isset ($_POST["id_parcela"])){
	subparcelas_insertar($_POST["id_parcela"],$_POST["superficie"],$_POST["variedad"],$_POST["variedad2"],$_POST["siembra"]
	,$_POST["densidad"],$_POST["marco"],$_POST["hierbas"],$_POST["sombreado"],$_POST["roya"],$_POST["broca"],$_POST["ojo_pollo"]
	,$_POST["mes_inicio_cosecha"],$_POST["duracion_cosecha"]);	
	echo "<div align=center><h1>ACTUALIZANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=ficha_parcela.php?parcela=".$_POST["id_parcela"]."'></font></h1></div>";	
}
else{
echo "<div align=center><h2>NUEVA SUBPARCELA</h2><br><table class=tablas>";
echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";

echo "<input type=hidden name=id_parcela value=".$_GET["parcela"]." size=3></td></tr>";	
echo "<tr><th align=right><h4>Superficie</th><td><h4><input type=text name=superficie size=3></h4>ha</td></tr>";	
echo "<tr><th align=right><h4>Variedad</th><td><h4><select name=variedad>";
	foreach(explode(",",configuracion_cons('parametro','variedades')[0]["valor"]) as $variedad){
		echo "<option value=$variedad>$variedad</option>";
	}
echo "</select></h4></td></tr>";
echo "<tr><th align=right><h4>Variedad secundaria</th><td><h4><select name=variedad2>";
	foreach(explode(",",configuracion_cons('parametro','variedades')[0]["valor"]) as $variedad){
		echo "<option value=$variedad>$variedad</option>";
	}
echo "</select></h4></td></tr>";
echo "<tr><th align=right><h4>Año de siembra</th><td><h4><input type=date name=siembra size=5></td></tr>";	
echo "<tr><th align=right><h4>Densidad</th><td><h4><input type=text name=densidad size=4></h4>pl/ha</td></tr>";	
echo "<tr><th align=right><h4>Marco de plantación</th><td><h4><select name=marco>";
	foreach($marcos as $marco){
		echo "<option value=$marco>$marco</option>";
	}
echo "</select></h4></td></tr>";
echo "<tr><th align=right><h4>Malas hierbas</th><td><h4><select name=hierbas>";
	foreach($hierbas as $hierba){
		echo "<option value=$hierba>$hierba</option>";
	}
echo "</select></h4></td></tr>";
echo "<tr><th align=right><h4>Sombreado</th><td><h4><select name=sombreado>";
	foreach($sombreados as $sombreado){
		echo "<option value=$sombreado>$sombreado</option>";
	}
echo "</select></h4></td></tr>";
echo "<tr><th align=right><h4>Roya</th><td><h4><select name=roya>";
	foreach($valores as $valor){
		echo "<option value=$valor>$valor</option>";
	}
echo "</select></h4>%</td></tr>";
echo "<tr><th align=right><h4>Broca</th><td><h4><select name=broca>";
	foreach($valores as $valor){
		echo "<option value=$valor>$valor</option>";
	}
echo "</select></h4>%</td></tr>";
echo "<tr><th align=right><h4>Ojo de pollo</th><td><h4><select name=ojo_pollo>";
	foreach($valores as $valor){
		echo "<option value=$valor>$valor</option>";
	}
echo "</select></h4>%</td></tr>";

echo "<tr><th align=right><h4>Mes de inicio de cosecha</th><td><h4><select name=mes_inicio_cosecha>";
foreach($meses as $mes){
		echo "<option value=$mes>$mes</option>";
	}
echo "</select></h4>%</td></tr>";



echo "<tr><th align=right><h4>Duración cosecha</th><td><h4><input type=text size=3 name=duracion_cosecha></h4>meses</td></tr>";		

echo "</table><br>";
//**********TABLA AUTOMATICA*****************************************************************
echo "<input type='submit' value='Guardar'>";
echo "</form></div>";

}
include("pie.php");

?>