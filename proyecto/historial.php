<?php
include ("cabecera.php");


if(!isset($_GET["criterio"]))
{
$_POST["busca"]="";
$criterio="";
$encontrados="";
$SQL="SELECT * FROM acciones order by fecha desc";

}else{
	if(isset($_GET["socio"])){$_POST["busca"]=$_GET["socio"];}
	$encontrados="ENCONTRADAS";
	switch ($_GET["criterio"])
		{
		case "usuario":
			$SQL="SELECT * FROM acciones WHERE user = '".$_POST["busca"]."' order by fecha desc";
			$_texto=$_POST["busca"];
			break;
		case "localidad":
			$SQL="SELECT * FROM lotes INNER JOIN socios on lotes.id_socio=socios.id_socio WHERE socios.poblacion = '".$_POST["busca"]."' order by fecha desc";
			$_texto=$_POST["busca"];
			break;
		case "fecha":
			$SQL="SELECT * FROM acciones WHERE date_format(fecha,'%Y-%m-%d') = '".$_POST["busca"]."' order by fecha asc";
			$_texto=$_POST["busca"];
			break;		
		}
$criterio="<h4>Criterio de búsqueda: <b>".$_GET["criterio"]."</b> es <i>''$_texto''</i></h4>";

}

//echo "$SQL";                         
$resultado=mysqli_query($link, $SQL);
$cuenta=mysqli_num_rows($resultado);
while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
	$acciones[]=$row;
}

//muestra_array($socios); 
echo "<div align=center><h1>Historial de acciones</h1><br><br>";
echo "<table width=700px border=0 cellpadding=0 cellspacing=0><tr>";
//echo "<td align=center></td><td align=center></td><td align=center></td></tr><tr>";

echo "<td align=center><h4>Usuario<br><form name=form1 action=".$_SERVER['PHP_SELF']."?criterio=usuario method='post'>";
echo "<select name=busca>";
$sql_socios="SELECT user FROM usuarios ORDER BY user ASC";
$r_socio=mysqli_query($link, $sql_socios);
while ($rowsocio = mysqli_fetch_array($r_socio,MYSQLI_ASSOC)){;echo "<option value='".$rowsocio["user"]."'>".$rowsocio["user"]."</option>";}
echo "</select><br>";
echo "<input type='submit' value='buscar'>";
echo "</form></td>";

/*
echo "<td align=center><h4>Localidad<br><form name=form2 action=".$_SERVER['PHP_SELF']."?criterio=localidad method='post'>";
echo "<select name=busca>";
$sql_localidad="SELECT DISTINCT(poblacion) as pob FROM socios ORDER BY poblacion ASC";
$r_loc=mysqli_query($link, $sql_localidad);
while ($rowloc = mysqli_fetch_array($r_loc,MYSQLI_ASSOC)){$localidad=$rowloc["pob"];echo "<option value='$localidad'>$localidad</option>";}
echo "</select><br>";
echo "<input type='submit' value='filtrar'>";
echo "</form></td>";
*/
echo "<td align=center><h4>Fecha<br><form name=form3 action=".$_SERVER['PHP_SELF']."?criterio=fecha method='post'>";
echo "<select name=busca>";
$sql_fecha="SELECT DISTINCT date_format(fecha,'%Y-%m-%d') as fecha FROM acciones ORDER BY fecha ASC";
$r_fec=mysqli_query($link, $sql_fecha);
while ($rowfec = mysqli_fetch_array($r_fec,MYSQLI_ASSOC)){$fecha=$rowfec["fecha"];echo "<option value='$fecha'>$fecha</option>";}
echo "</select><br>";
echo "<input type='submit' value='filtrar'>";
echo "</form></td>";

/*
echo "<td align=center><h4>Cantón<br><form name=form3 action=".$_SERVER['PHP_SELF']."?criterio=canton method='post'>";
echo "<input type='text' name=busca><br>";
echo "<input type='submit' value='filtrar'>";
echo "</form></td>";
*/


echo "</tr></table>";

echo "<br><br><div align=center>$criterio<br>";
echo "<table class=tablas width=60%>";
	echo "<tr><th>";
	echo "<h4>ACCIONES $encontrados ($cuenta)</h4>";
	echo "</th></tr>";

if(isset($acciones))
{
	foreach ($acciones as $accion)
	{
		echo "<tr>";
		echo "<td><a href=ficha_lote.php?lote=".$accion["id"]."><h4>".date("d-m-Y H:i",strtotime($accion["fecha"]))."<br>".$accion["user"]."<br><font size=2>" .$accion["accion"]."<br>";
		echo "</td></tr>";
	}
}
echo "</table></div>";


include("pie.php");

?>