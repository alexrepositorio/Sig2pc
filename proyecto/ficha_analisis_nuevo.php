<?php
include ("cabecera.php");
include ("analisis_funciones.php");
if(isset ($_POST["id_parcela"])){
	
	if(isset($_POST["lombrices"])){
		$_POST["lombrices"]=1;
	}else{
		$_POST["lombrices"]=0;
	}
	analisis_insertar($_POST["id_subparcela"],$_POST["fecha"],$_POST["muestra"],$_POST["submuestras"],
	$_POST["estructura"],$_POST["grado"],$_POST["rocas"],$_POST["rocas_size"],$_POST["profundidad"],
	$_POST["pendiente"],$_POST["lombrices"],$_POST["densidad_aparente"],$_POST["observaciones"],
	$_POST["s_ph"],$_POST["s_n"],$_POST["s_p"],$_POST["s_k"],$_POST["s_ca"],$_POST["s_mg"],
	$_POST["s_mo"],$_POST["s_textura"],$_POST["f_n"],$_POST["f_p"],$_POST["f_k"]);	
	echo "<div align=center><h1>ACTUALIZANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=ficha_parcela.php?parcela=".$_POST["id_parcela"]."'></font></h1></div>";
	
}else{
	echo "<div align=center><h2>NUEVO ANÁLISIS</h2><br><table class=tablas>";
	echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
	echo "<tr><th colspan=2><h3>Datos generales</h3></th></tr>";
	echo "<input type=hidden name=id_parcela value=".$_GET["parcela"]." size=3>".$_GET["parcela"]."";	
	echo "<input type=hidden name=id_subparcela value=".$_GET["subparcela"]." size=3>".$_GET["subparcela"]."";	
	echo "<tr><th align=right><h4>Fecha</th><td><h4><input type=date name=fecha size=10 value=".date("Y-m-d",strtotime('now'))."></h4></td></tr>";	
	echo "<tr><th align=right><h4>Muestra</th><td><h4><input type=number name=muestra size=3></h4></td></tr>";	
	echo "<tr><th align=right><h4>Número de submuestras</th><td><h4><input type=number name=submuestras size=3></h4></td></tr>";	
	echo "<tr><th align=right><h4>Estructura</th><td><h4><select name=estructura>";
		foreach($estructuras as $estructura){
			echo "<option value=$estructura>$estructura</option>";
		}
	echo "</select></h4></td></tr>";
	echo "<tr><th align=right><h4>Grado</th><td><h4><select name=grado>";
		foreach($grados as $grado){
			echo "<option value=$grado>$grado</option>";
		}
	echo "</select></h4></td></tr>";
	echo "<tr><th align=right><h4>Rocas</th><td><h4><input type=number name=rocas size=5></h4>%</td></tr>";	
	echo "<tr><th align=right><h4>Tamaño rocas</th><td><h4><input type=number name=rocas_size size=4></h4>cm</td></tr>";	
	echo "<tr><th align=right><h4>Profundidad de suelo</th><td><h4><input type=number name=profundidad size=4></h4>cm</td></tr>";	
	echo "<tr><th align=right><h4>Pendiente</th><td><h4><input type=number name=pendiente size=4></h4>%</td></tr>";	
	echo "<tr><th align=right><h4>Presencia de lombrices</th><td><h4><input type=checkbox name=lombrices size=4></h4></td></tr>";	
	echo "<tr><th align=right><h4>Densidad aparente</th><td><h4><input type=number step=0.01 min=0 name=densidad_aparente size=4></h4>gr/cm<sup>3</sup></td></tr>";	
	echo "<tr><th align=right><h4>Observaciones</th><td><h4><textarea name=observaciones rows=7 cols=15></textarea></h4></td></tr>";	
	echo "<tr><th colspan=2><h3>Análisis de suelo</h3></th></tr>";
	echo "<tr><th align=right><h4>pH</th><td><h4><input type=number step=0.01 min=0 name=s_ph size=4></h4></td></tr>";	
	echo "<tr><th align=right><h4>N</th><td><h4><input type=number step=0.01 min=0 name=s_n size=4></h4>%</td></tr>";	
	echo "<tr><th align=right><h4>P</th><td><h4><input type=number step=0.01 min=0 name=s_p size=4></h4>ppm</td></tr>";	
	echo "<tr><th align=right><h4>K</th><td><h4><input type=number step=0.01 min=0 name=s_k size=4></h4>cmol/kg</td></tr>";	
	echo "<tr><th align=right><h4>Ca</th><td><h4><input type=number step=0.01 min=0 name=s_ca size=4></h4>cmol/kg</td></tr>";	
	echo "<tr><th align=right><h4>Mg</th><td><h4><input type=number step=0.01 min=0 name=s_mg size=4></h4>cmol/kg</td></tr>";	
	echo "<tr><th align=right><h4>Materia Orgánica</th><td><h4><input type=number step=0.01 min=0 name=s_mo size=4></h4>%</td></tr>";	
	echo "</select></h4></td></tr>";
	echo "<tr><th align=right><h4>Textura</th><td><h4><select name=s_textura>";
		foreach($texturas as $textura){
			echo "<option value='$textura'>$textura</option>";
		}
	echo "</select></h4></td></tr>";
	echo "<tr><th colspan=2><h3>Análisis foliar</h3></th></tr>";
	echo "<tr><th align=right><h4>N</th><td><h4><input type=number step=0.01 min=0 name=f_n size=4></h4>%</td></tr>";	
	echo "<tr><th align=right><h4>P</th><td><h4><input type=number step=0.01 min=0 name=f_p size=4></h4>ppm</td></tr>";	
	echo "<tr><th align=right><h4>K</th><td><h4><input type=number step=0.01 min=0 name=f_k size=4></h4>cmol/kg</td></tr>";	
	echo "</table><br>";
	echo "<input type='submit' value='Guardar'>";
	echo "</form></div>";

}
include("pie.php");
?>