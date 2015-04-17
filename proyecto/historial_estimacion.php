<?php
include ("cabecera.php");

if(isset($_GET["actualiza"]) && isset($_GET["entregados"])){
$SQL_edit="UPDATE estimacion SET
				entregados='".$_GET["entregados"]."'
				WHERE id='".$_GET["actualiza"]."'";

$resultado=mysqli_query($link, $SQL_edit);
$nuevo_id=mysqli_insert_id($link);


$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);

//echo "$SQL_edit";

echo "<div align=center><h1>ACTUALIZANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=?socio=".$_GET["socio"]."'></font></h1></div>";

//echo "$SQL_edit";
	
}
else{

$SQL="SELECT * FROM socios WHERE codigo='".$_GET["socio"]."'";
$resultado=mysqli_query($link, $SQL);
$socio = mysqli_fetch_array($resultado,MYSQLI_ASSOC);

$estatus=estimacion($_GET["socio"]);
$estimado_actual=max(array_keys($estatus));
//muestra_array($estatus);

echo "<div align=center><h1>Historial de estimados y entregados del socio</h1><br><h2>".$socio["nombres"]." ".$socio["apellidos"]."</h2><br>";

echo "<br><table class=tablas><tr><th colspan=4><h2>Historial</h2></th></tr>";
echo "<tr><th>Año</th><th>Estimado (qq)</th><th>Entregado (qq)</th><th>Borrar</th></tr>";
foreach ($estatus as $id=>$estado)
	{
		if($estado["year"]==0){$estado["year"]="fecha desconocida";}
	echo "<tr><td align=center>";	
	echo "<h4>".$estado["year"]."</h4>";
	echo "<td align=center>";	
	echo "<h4>".$estado["estimados"]."</h4></td>";
	echo "<td align=center>";	
	echo "<h4>".$estado["entregados"]."</h4></td>";
	echo "<td align=center>";	
	echo "<h4>";
if(in_array($_COOKIE['acceso'],$permisos_admin)){echo "<a href=historial_estimacion_borrar.php?id=".$id."&socio=".$_GET["socio"]."><img title='borrar este estado' src=images/cross.png width=25></a>";}
	echo "</h4></td></tr>";
		}
echo "</table>";

echo "<br><br>";


//***************************************************************************************************
//lotes entregados por el socio
$SQL_lotes="SELECT * FROM lotes where id_socio='".$_GET["socio"]."' and date_format(fecha,'%Y') = '".$estatus[$estimado_actual]["year"]."'";
$resultado_lotes=mysqli_query($link, $SQL_lotes);
$cuenta_lotes=mysqli_num_rows($resultado_lotes);
while($lot = mysqli_fetch_array($resultado_lotes,MYSQLI_ASSOC)){
$pesos_del_socio[]=$lot["peso"];	
}
$peso_entregado=array_sum($pesos_del_socio);
$peso_restante=$estatus[$estimado_actual]["estimados"]-$peso_entregado;
//*******************************************************************************************************
$diferencia=round($peso_entregado,2)-$estatus[$estimado_actual]["entregados"];

if(in_array($_COOKIE['acceso'],$permisos_admin) && $diferencia<>0){echo "<h4>Entregado en ".$estatus[$estimado_actual]["year"].": $peso_entregado qq <br><br>";}


echo "<table class=tablas><tr>";
if(in_array($_COOKIE['acceso'],$permisos_general)){echo "<td><a href=ficha_socio.php?socio=".$_GET["socio"]."><h3>VOLVER</h3></a></td>";}
if(in_array($_COOKIE['acceso'],$permisos_admin)){echo "<td><a href=historial_estimacion_nuevo.php?socio=".$_GET["socio"]."><h3>AÑADIR</h3></a></td>";}
if(in_array($_COOKIE['acceso'],$permisos_admin) && $diferencia<>0){echo "<td><a href=historial_estimacion.php?actualiza=$estimado_actual&entregados=$peso_entregado&socio=".$_GET["socio"]."><h3>ACTUALIZAR ENTREGADO EN ".$estatus[$estimado_actual]["year"]."</h3></a></td>";}
if(in_array($_COOKIE['acceso'],$permisos_general)){echo "<td><a href=grafica_entregas_anuales.php?socio=".$socio["codigo"]."><img width=25 src=images/graf.png></a></td>";}
echo "</tr></table>";
	
}

include("pie.php");
?>