<?php
include ("cabecera.php");
include("analisis_funciones.php");

if(isset ($_POST["id_parcela"])){
	
if(isset($_POST["lombrices"])){$_POST["lombrices"]=1;
}else{
	$_POST["lombrices"]=0;
}



/*
$SQL_edit="UPDATE analisis SET
				id_subparcela='".$_POST["id_subparcela"]."',
				fecha='".$_POST["fecha"]."',
				muestra='".$_POST["muestra"]."',
				submuestras='".$_POST["submuestras"]."',
				estructura='".$_POST["estructura"]."',
				grado='".$_POST["grado"]."',
				rocas='".$_POST["rocas"]."',
				rocas_size='".$_POST["rocas_size"]."',
				profundidad='".$_POST["profundidad"]."',
				pendiente='".$_POST["pendiente"]."',
				lombrices='".$_POST["lombrices"]."',
				densidad_aparente='".$_POST["densidad_aparente"]."',
				observaciones='".$_POST["observaciones"]."',
				s_ph='".$_POST["s_ph"]."',
				s_n='".$_POST["s_n"]."',
				s_p='".$_POST["s_p"]."',
				s_k='".$_POST["s_k"]."',
				s_ca='".$_POST["s_ca"]."',
				s_mg='".$_POST["s_mg"]."',
				s_mo='".$_POST["s_mo"]."',
				s_textura='".$_POST["s_textura"]."',
				f_n='".$_POST["f_n"]."',
				f_p='".$_POST["f_p"]."',
				f_k='".$_POST["f_k"]."'
				
				WHERE id_analisis=".;
*/
analisis_actualizar($_POST["id_subparcela"],$_POST["fecha"],$_POST["muestra"],$_POST["submuestras"],
	$_POST["estructura"],$_POST["grado"],$_POST["rocas"],$_POST["rocas_size"],$_POST["profundidad"],
	$_POST["pendiente"],$_POST["lombrices"],$_POST["densidad_aparente"],$_POST["observaciones"],
	$_POST["s_ph"],$_POST["s_n"],$_POST["s_p"],$_POST["s_k"],$_POST["s_ca"],$_POST["s_mg"],
	$_POST["s_mo"],$_POST["s_textura"],$_POST["f_n"],$_POST["f_p"],$_POST["f_k"],$_GET["actualiza"]);	
//$nuevo_id=mysqli_insert_id($link);
echo "<div align=center><h1>ACTUALIZANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=analisis.php?subparcela=".$_POST["id_subparcela"]."&parcela=".$_POST["id_parcela"]."'></font></h1></div>";
	
}


else{
			
$resultado=analisis_cons_id($_GET["analisis"]);
$datos=$resultado[0];	


	
echo "<div align=center><h2>EDITAR ANÁLISIS</h2><br><table class=tablas>";
echo "<form name=form action=".$_SERVER['PHP_SELF']."?actualiza=".$_GET["analisis"]." method='post'>";
echo "<tr><th colspan=2><h3>Datos generales</h3></th></tr>";

echo "<input type=hidden name=id_parcela value=".$_GET["parcela"]." size=3>".$_GET["parcela"]."";	
echo "<input type=hidden name=id_subparcela value=".$datos["id_subparcela"]." size=3>".$datos["id_subparcela"]."";	
echo "<tr><th align=right><h4>Fecha</th><td><h4><input type=date name=fecha size=10 value=".date("Y-m-d",strtotime('now'))."></h4></td></tr>";	
echo "<tr><th align=right><h4>Muestra</th><td><h4><input type=number name=muestra value=".$datos["muestra"]." size=3></h4></td></tr>";	
echo "<tr><th align=right><h4>Número de submuestras</th><td><h4><input type=number name=submuestras value=".$datos["submuestras"]." size=3></h4></td></tr>";	
echo "<tr><th align=right><h4>Estructura</th><td><h4><select name=estructura>";
	foreach($estructuras as $estructura){
		if($estructura==$datos["estructura"]){$sel="selected";}else{$sel="";}		
		echo "<option $sel value=$estructura>$estructura</option>";
	}
echo "</select></h4></td></tr>";
echo "<tr><th align=right><h4>Grado</th><td><h4><select name=grado>";
	foreach($grados as $grado){
		if($grado==$datos["grado"]){$sel="selected";}else{$sel="";}
		echo "<option $sel value=$grado>$grado</option>";
	}
echo "</select></h4></td></tr>";
echo "<tr><th align=right><h4>Rocas</th><td><h4><input type=number name=rocas value=".$datos["rocas"]." size=5></h4>%</td></tr>";	
echo "<tr><th align=right><h4>Tamaño rocas</th><td><h4><input type=number name=rocas_size value=".$datos["rocas_size"]." size=4></h4>cm</td></tr>";	
echo "<tr><th align=right><h4>Profundidad de suelo</th><td><h4><input type=number name=profundidad value=".$datos["profundidad"]." size=4></h4>cm</td></tr>";	
echo "<tr><th align=right><h4>Pendiente</th><td><h4><input type=number name=pendiente value=".$datos["pendiente"]." size=4></h4>%</td></tr>";	
if($datos["lombrices"]==1){$chek="checked";}else{$chek="";}
echo "<tr><th align=right><h4>Presencia de lombrices</th><td><h4><input type=checkbox $chek name=lombrices size=4></h4></td></tr>";	
echo "<tr><th align=right><h4>Densidad aparente</th><td><h4><input type=number name=densidad_aparente value=".$datos["densidad_aparente"]." size=4></h4>gr/cm<sup>3</sup></td></tr>";	
echo "<tr><th align=right><h4>Observaciones</th><td><h4><textarea name=observaciones rows=7 cols=15>".$datos["observaciones"]."</textarea></h4></td></tr>";	

echo "<tr><th colspan=2><h3>Análisis de suelo</h3></th></tr>";
echo "<tr><th align=right><h4>pH</th><td><h4><input type=number step=0.01 min=0 name=s_ph value=".$datos["s_ph"]." size=4></h4></td></tr>";	
echo "<tr><th align=right><h4>N</th><td><h4><input type=number step=0.01 min=0 name=s_n value=".$datos["s_n"]." size=4></h4>%</td></tr>";	
echo "<tr><th align=right><h4>P</th><td><h4><input type=number step=0.01 min=0 name=s_p value=".$datos["s_p"]." size=4></h4>ppm</td></tr>";	
echo "<tr><th align=right><h4>K</th><td><h4><input type=number step=0.01 min=0 name=s_k value=".$datos["s_k"]." size=4></h4>cmol/kg</td></tr>";	
echo "<tr><th align=right><h4>Ca</th><td><h4><input type=number step=0.01 min=0 name=s_ca value=".$datos["s_ca"]." size=4></h4>cmol/kg</td></tr>";	
echo "<tr><th align=right><h4>Mg</th><td><h4><input type=number step=0.01 min=0 name=s_mg value=".$datos["s_mg"]." size=4></h4>cmol/kg</td></tr>";	
echo "<tr><th align=right><h4>Materia Orgánica</th><td><h4><input type=number step=0.01 min=0 name=s_mo value=".$datos["s_mo"]." size=4></h4>%</td></tr>";	
echo "</select></h4></td></tr>";
echo "<tr><th align=right><h4>Textura</th><td><h4><select name=s_textura>";
	foreach($texturas as $textura){
		if($textura==$datos["s_textura"]){$sel="selected";}else{$sel="";}
		echo "<option $sel value='$textura'>$textura</option>";
	}
echo "</select></h4></td></tr>";


echo "<tr><th colspan=2><h3>Análisis foliar</h3></th></tr>";
echo "<tr><th align=right><h4>N</th><td><h4><input type=number step=0.01 min=0 name=f_n value=".$datos["f_n"]." size=4></h4>%</td></tr>";	
echo "<tr><th align=right><h4>P</th><td><h4><input type=number step=0.01 min=0 name=f_p value=".$datos["f_p"]." size=4></h4>ppm</td></tr>";	
echo "<tr><th align=right><h4>K</th><td><h4><input type=number step=0.01 min=0 name=f_k value=".$datos["f_k"]." size=4></h4>cmol/kg</td></tr>";	

echo "</table><br>";
//**********TABLA AUTOMATICA*****************************************************************
echo "<input type='submit' value='Guardar'>";
echo "</form></div>";

}
include("pie.php");

?>