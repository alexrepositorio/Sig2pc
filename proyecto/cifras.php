<?php
include ("cabecera.php");

if(!isset($_POST["criterio"]))
{
$sql="SELECT CONCAT_WS(' ',socios.nombres,socios.apellidos) as socio, socios.codigo as codigo, socios.poblacion as zona, SUM(lotes.peso) as entregado FROM lotes LEFT JOIN socios ON lotes.id_socio=socios.codigo GROUP BY socios.codigo order by entregado desc LIMIT 10";
$_POST["criterio"]="produccion";
$_POST["orden"]="desc";
$_POST["limit"]="top10";
$_POST["agrupacion"]="socio";
$_POST["operador"]="MAX";
$_POST["grafica"]="tabla";
$_texto=$_POST["limit"]." ".$_POST["agrupacion"]." ".$_POST["criterio"]." ".$_POST["operador"]." ".$_POST["orden"];

}else{
	
	switch ($_POST["limit"])
		{
		case "top10":
			$limit= "LIMIT 10";
			$limite= "Top 10";
			break;
		case "todos":
			$limit="";
			$limite="Todos";
		}
$_texto="$limite ".$_POST["agrupacion"]." ".$_POST["criterio"]." ".$_POST["operador"]." ".$_POST["orden"];
		
	switch ($_POST["criterio"])
		{
		case "produccion":
			if($_POST["agrupacion"]=="socio")
			{
			$sql="SELECT CONCAT_WS(' ',socios.nombres,socios.apellidos) as socio, socios.codigo as codigo, socios.poblacion as zona, ROUND(".$_POST["operador"]."(lotes.peso),2) as produccion, parcelas.coorX as coorX, parcelas.coorY as coorY FROM lotes LEFT JOIN socios ON lotes.id_socio=socios.codigo LEFT JOIN parcelas ON parcelas.id_socio=socios.codigo GROUP BY socios.codigo order by produccion ".$_POST["orden"]." $limit";
			}
			if($_POST["agrupacion"]=="zona")
			{
			$sql="SELECT socios.poblacion as zona, ROUND(".$_POST["operador"]."(lotes.peso),2) as produccion FROM lotes LEFT JOIN socios ON lotes.id_socio=socios.codigo GROUP BY socios.poblacion order by produccion ".$_POST["orden"]." $limit";
			}
			break;

		case "cata":	
			if($_POST["agrupacion"]=="socio")
			{
			$sql="SELECT CONCAT_WS(' ',socios.nombres,socios.apellidos) as socio, socios.codigo as codigo, socios.poblacion as zona, ROUND(".$_POST["operador"]."(catas.puntuacion),2) as cata, parcelas.coorX as coorX, parcelas.coorY as coorY FROM catas LEFT JOIN lotes ON catas.lote=lotes.codigo_lote LEFT JOIN socios ON lotes.id_socio=socios.codigo LEFT JOIN parcelas ON parcelas.id_socio=socios.codigo GROUP BY socios.codigo ORDER BY cata ".$_POST["orden"]." $limit";
			}
			if($_POST["agrupacion"]=="zona")
			{
			$sql="SELECT socios.poblacion as zona, ROUND(".$_POST["operador"]."(catas.puntuacion),2) as cata FROM catas LEFT JOIN lotes ON catas.lote=lotes.codigo_lote LEFT JOIN socios ON lotes.id_socio=socios.codigo GROUP BY socios.poblacion ORDER BY cata ".$_POST["orden"]." $limit";
			}
			break;

		case "humedad":	
			if($_POST["agrupacion"]=="socio")
			{
			$sql="SELECT CONCAT_WS(' ',socios.nombres,socios.apellidos) as socio, socios.codigo as codigo, socios.poblacion as zona, ROUND(".$_POST["operador"]."(lotes.humedad),2) as humedad, parcelas.coorX as coorX, parcelas.coorY as coorY FROM lotes LEFT JOIN socios ON lotes.id_socio=socios.codigo LEFT JOIN parcelas ON parcelas.id_socio=socios.codigo GROUP BY socios.codigo order by humedad ".$_POST["orden"]." $limit";
			}
			if($_POST["agrupacion"]=="zona")
			{
			$sql="SELECT socios.poblacion as zona, ROUND(".$_POST["operador"]."(lotes.humedad),2) as humedad FROM lotes LEFT JOIN socios ON lotes.id_socio=socios.codigo GROUP BY socios.poblacion order by humedad ".$_POST["orden"]." $limit";
			}
			break;
									
		case "descarte_prc":	
			if($_POST["agrupacion"]=="socio")
			{
			$sql="SELECT CONCAT_WS(' ',socios.nombres,socios.apellidos) as socio, socios.codigo as codigo, socios.poblacion as zona, ROUND(".$_POST["operador"]."(100*lotes.rto_descarte/(lotes.rto_descarte+lotes.rto_exportable)),2) as descarte_prc, parcelas.coorX as coorX, parcelas.coorY as coorY FROM lotes LEFT JOIN socios ON lotes.id_socio=socios.codigo LEFT JOIN parcelas ON parcelas.id_socio=socios.codigo GROUP BY socios.codigo order by descarte_prc ".$_POST["orden"]." $limit";
			}
			if($_POST["agrupacion"]=="zona")
			{
			$sql="SELECT socios.poblacion as zona, ROUND(".$_POST["operador"]."(100*lotes.rto_descarte/(lotes.rto_descarte+lotes.rto_exportable)),2) as descarte_prc FROM lotes LEFT JOIN socios ON lotes.id_socio=socios.codigo GROUP BY socios.poblacion order by descarte_prc ".$_POST["orden"]." $limit";
			}
			break;
									
		case "exportable_prc":	
			if($_POST["agrupacion"]=="socio")
			{
			$sql="SELECT CONCAT_WS(' ',socios.nombres,socios.apellidos) as socio, socios.codigo as codigo, socios.poblacion as zona, ROUND(".$_POST["operador"]."(100*lotes.rto_exportable/(lotes.rto_descarte+lotes.rto_exportable)),2) as exportable_prc, parcelas.coorX as coorX, parcelas.coorY as coorY FROM lotes LEFT JOIN socios ON lotes.id_socio=socios.codigo LEFT JOIN parcelas ON parcelas.id_socio=socios.codigo GROUP BY socios.codigo order by exportable_prc ".$_POST["orden"]." $limit";
			}
			if($_POST["agrupacion"]=="zona")
			{
			$sql="SELECT socios.poblacion as zona, ROUND(".$_POST["operador"]."(100*lotes.rto_exportable/(lotes.rto_descarte+lotes.rto_exportable)),2) as exportable_prc FROM lotes LEFT JOIN socios ON lotes.id_socio=socios.codigo GROUP BY socios.poblacion order by exportable_prc ".$_POST["orden"]." $limit";
			}
			break;
									
		case "rto_trillado":	
			if($_POST["agrupacion"]=="socio")
			{
			$sql="SELECT CONCAT_WS(' ',socios.nombres,socios.apellidos) as socio, socios.codigo as codigo, socios.poblacion as zona, ROUND(".$_POST["operador"]."(100*(lotes.rto_descarte+lotes.rto_exportable)/".$config["gr_muestra"]."),2) as rto_trillado, parcelas.coorX as coorX, parcelas.coorY as coorY FROM lotes LEFT JOIN socios ON lotes.id_socio=socios.codigo LEFT JOIN parcelas ON parcelas.id_socio=socios.codigo GROUP BY socios.codigo order by rto_trillado ".$_POST["orden"]." $limit";
			}
			if($_POST["agrupacion"]=="zona")
			{
			$sql="SELECT socios.poblacion as zona, ROUND(".$_POST["operador"]."(100*(lotes.rto_descarte+lotes.rto_exportable)/".$config["gr_muestra"]."),2) as rto_trillado FROM lotes LEFT JOIN socios ON lotes.id_socio=socios.codigo GROUP BY socios.poblacion order by rto_trillado ".$_POST["orden"]." $limit";
			}
			break;
									
		}

}

//**********SELECTORES************************************************************************
$criterios=Array("produccion","cata","rto_trillado","humedad","descarte_prc","exportable_prc");
$criterios_t=Array("Produción","Cata","Rto.Trillado","Humedad","% Descarte","% Exportable");
$operadores=Array("MAX","MIN","AVG","SUM","COUNT");
$operadores_t=Array("max","min","media","suma","cuenta");
$agrupaciones=Array("socio","zona");
$agrupaciones_t=Array("Por Socio","Por Zona");
$limites=Array("top10","todos");
$limites_t=Array("Top10","Todos");
$ordenes=Array("asc","desc");
$ordenes_t=Array("ascendente","descendente");
$graficaciones=Array("tabla","barras","circular");
$graficaciones_t=Array("Tabla","Barras","Circular");

echo "<div align=center>";
echo "<form name=form1 action=".$_SERVER['PHP_SELF']." method='post'>";
echo "<table class=tablas><tr><th colspan=5>";
foreach ($criterios as $key=>$crit)
	{
	if(isset($_POST["criterio"]) && $_POST["criterio"]==$crit){$ch="checked";}else{$ch="";}	
	echo "<input type=radio $ch name=criterio value=".$crit.">".$criterios_t[$key];
	}
echo "</th></tr>";
echo "<tr><th>";
foreach ($operadores as $key2=>$oper)
	{
	if(isset($_POST["operador"]) && $_POST["operador"]==$oper){$ch2="checked";}else{$ch2="";}	
	echo "<input type=radio $ch2 name=operador value=".$oper.">".$operadores_t[$key2];
	}
echo "</th>";
echo "<th>";
foreach ($agrupaciones as $key3=>$agrup)
	{
	if(isset($_POST["agrupacion"]) && $_POST["agrupacion"]==$agrup){$ch3="checked";}else{$ch3="";}	
	echo "<input type=radio $ch3 name=agrupacion value=".$agrup.">".$agrupaciones_t[$key3];
	}
echo "</th>";
echo "<th>";
foreach ($limites as $key4=>$lim)
	{
	if(isset($_POST["limit"]) && $_POST["limit"]==$lim){$ch4="checked";}else{$ch4="";}	
	echo "<input type=radio $ch4 name=limit value=".$lim.">".$limites_t[$key4];
	}
echo "</th>";
echo "<th>";
foreach ($ordenes as $key5=>$ord)
	{
	if(isset($_POST["orden"]) && $_POST["orden"]==$ord){$ch5="checked";}else{$ch5="";}	
	echo "<input type=radio $ch5 name=orden value=".$ord.">".$ordenes_t[$key5];
	}
	echo "</th>";
echo "</th>";
echo "<th>";
foreach ($graficaciones as $key6=>$graf)
	{
	if(isset($_POST["grafica"]) && $_POST["grafica"]==$graf){$ch6="checked";}else{$ch6="";}	
	echo "<input type=radio $ch6 name=grafica value=".$graf.">".$graficaciones_t[$key6];
	}
	echo "</th></tr>";
	echo "</table><br>";
echo "<input type='submit' value='Ejecutar'>";
echo "</form>";
echo "<hr>";


echo "<h2>$_texto</h2><br>";

if(isset($_POST["grafica"]) && $_POST["grafica"]=="tabla"){
//**********TABLA AUTOMATICA*****************************************************************

if(isset($_POST["limit"]) && $_POST["limit"]=="todos" && isset($_POST["agrupacion"]) && $_POST["agrupacion"]=="socio"){
	echo "<h4>Exportar CSV</h4><br>";
}



$resultado=mysqli_query($link, $sql);
while($object = mysqli_fetch_field($resultado)){
	$campos[]=$object->name;
}

echo "<table class=tablas><tr>";
foreach ($campos as $columna){
	echo "<th>$columna</th>";
}
echo "</tr>";

while($datos = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
	echo "<tr>";
	foreach ($campos as $columna){
		echo "<td>".$datos[$columna]."</td>";
	}
	echo "</tr>";	
}
echo "</table></div>";
//**********TABLA AUTOMATICA*****************************************************************


}

if(isset($_POST["grafica"]) && $_POST["grafica"]=="barras"){
//**********Grafica AUTOMATICA*****************************************************************
echo "<div align=center><table class=tablas><tr><td align=center>
<img src=SIC_barras.php?criterio=".$_POST["criterio"]."&orden=".$_POST["orden"]."&limit=".$_POST["limit"]."&agrupacion=".$_POST["agrupacion"]."&operador=".$_POST["operador"].">";
echo "<br><br></td></tr></table><br>";
//**********Grafica AUTOMATICA*****************************************************************

}

if(isset($_POST["grafica"]) && $_POST["grafica"]=="circular"){
//**********Grafica AUTOMATICA*****************************************************************
echo "<div align=center><table class=tablas><tr><td align=center>
<img src=SIC_pie.php?criterio=".$_POST["criterio"]."&orden=".$_POST["orden"]."&limit=".$_POST["limit"]."&agrupacion=".$_POST["agrupacion"]."&operador=".$_POST["operador"].">";
echo "<br><br></td></tr></table><br>";
//**********Grafica AUTOMATICA*****************************************************************

}

include("pie.php");

?>
