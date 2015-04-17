<?php
include ("cabecera.php");

if(isset($_POST["fecha"])){$andwhere=" AND date_format(fecha,'%Y-%m-%d') = '".$_POST["fecha"]."'";}
else{$andwhere="";}

$SQL="SELECT * FROM lotes WHERE calidad='A' $andwhere order by fecha desc";
$resultado=mysqli_query($link, $SQL);
$cuenta=mysqli_num_rows($resultado);
while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
	$lotes[]=$row;
	$pesos[]=$row["peso"];
	
	
$SQL_cata="SELECT * FROM catas where lote='".$row["codigo_lote"]."' order by fecha desc";
$r_p=mysqli_query($link, $SQL_cata);
$cuenta_p=mysqli_num_rows($r_p);
if($cuenta_p==0){$puntuacion[$row["codigo_lote"]]="<a href=ficha_cata_nuevo.php?lote=".$row["codigo_lote"]."><font color=blue><b>PENDIENTE</b></font></a>";}
else{
$cata[$row["codigo_lote"]]= mysqli_fetch_array($r_p,MYSQLI_ASSOC);
$puntuacion[$row["codigo_lote"]]=$cata[$row["codigo_lote"]]["puntuacion"];
$fragancia[$row["codigo_lote"]]=$cata[$row["codigo_lote"]]["fragancia"];
$sabor[$row["codigo_lote"]]=$cata[$row["codigo_lote"]]["sabor"];
$balance[$row["codigo_lote"]]=$cata[$row["codigo_lote"]]["balance"];



}
	
}
//if(!isset($pesos)){$pesos[]=0;}
//if(!isset($costos)){$costos[]=0;}


/*
if(isset($_GET["separa"])){
	foreach ($socios as $persona){
		$nombrescompletos="";
		echo "<b>".$persona["nombres"];
		$nombres=explode(" ",$persona["nombres"]);
		echo "&nbsp&nbsp&nbsp&nbsp&nbsp Apellidos : ".$nombres[0]." ".$nombres[1]." ";
		$apellidoscompletos=$nombres[0]." ".$nombres[1];
		foreach ($nombres as $key=>$partes){if($key>1){$nombrescompletos=$nombrescompletos." ".$partes;}}
		//$nombrescompletos=$nombres[2]." ".$nombres[3]." ".$nombres[4];
		echo "&nbsp&nbsp&nbsp&nbsp&nbsp Nombres : $nombrescompletos</b><br>";
		$apellidoscompletos=ucwords(strtolower($apellidoscompletos));
		$nombrescompletos=ucwords(strtolower($nombrescompletos));
		$SQL_update="UPDATE socios SET apellidos='$apellidoscompletos', nombres='$nombrescompletos' WHERE id_socio=".$persona["id_socio"];
		echo $SQL_update."<br>";
		$resultado=mysqli_query($link, $SQL_update);
	}	
}
*/

//muestra_array($socios); 
echo "<div align=center><h1>Listado de lotes para Cata</h1><br><br>";

/*
echo "<table width=700px border=0 cellpadding=0 cellspacing=0><tr>";
//echo "<td align=center></td><td align=center></td><td align=center></td></tr><tr>";

echo "<td align=center><h4>Socio<br><form name=form1 action=".$_SERVER['PHP_SELF']."?criterio=socio method='post'>";
echo "<select name=busca>";
$sql_socios="SELECT id_socio, nombres, apellidos, codigo FROM socios ORDER BY codigo ASC";
$r_socio=mysqli_query($link, $sql_socios);
while ($rowsocio = mysqli_fetch_array($r_socio,MYSQLI_ASSOC)){$socio_n=$rowsocio["codigo"]."-".$rowsocio["apellidos"].", ".$rowsocio["nombres"];echo "<option value='".$rowsocio["id_socio"]."'>$socio_n</option>";}
echo "</select><br>";
echo "<input type='submit' value='buscar'>";
echo "</form></td>";


echo "<td align=center><h4>Localidad<br><form name=form2 action=".$_SERVER['PHP_SELF']."?criterio=localidad method='post'>";
echo "<select name=busca>";
$sql_localidad="SELECT DISTINCT(poblacion) as pob FROM socios ORDER BY poblacion ASC";
$r_loc=mysqli_query($link, $sql_localidad);
while ($rowloc = mysqli_fetch_array($r_loc,MYSQLI_ASSOC)){$localidad=$rowloc["pob"];echo "<option value='$localidad'>$localidad</option>";}
echo "</select><br>";
echo "<input type='submit' value='filtrar'>";
echo "</form></td>";
*/
echo "<td align=center><h4>Fecha<br><form name=form3 action=".$_SERVER['PHP_SELF']." method='post'>";
echo "<select name=fecha>";
$sql_fecha="SELECT DISTINCT date_format(fecha,'%Y-%m-%d') as fecha FROM lotes WHERE calidad='A' ORDER BY fecha ASC";
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

echo "<td align=center><a href=ficha_lote_nuevo.php>";
echo "<img src=images/add.png width=50><br><h4>nuevo</a>";
echo "</td>";


//$sumatotal=array_sum($pesos);
//$costototal=array_sum($costos);

echo "</tr></table>";
*/
//echo "<br><br><div align=center>$criterio<br>";
echo "<table class=tablas>";
	echo "<tr><th width=500px>";
	echo "<h4>LOTES</h4>";
	echo "</th>";
	echo "<th width=20px><h6>cata</h6></th>";
	echo "<th width=20px><h6>opciones</h6></th></tr>";

if(isset($lotes))
{
	foreach ($lotes as $lote)
	{
		//$datos_socio=nombre_socio($lote["id_socio"]);
		
		echo "<tr>";
		echo "<td><h3>".$lote["codigo_lote"]."<br><h4>".date("d-m-Y H:i",strtotime($lote["fecha"]))."</td><td align=center><h4>".$puntuacion[$lote["codigo_lote"]]."<br>";
		echo "</td>";
		echo "<td>";
if($puntuacion[$lote["codigo_lote"]]>0)
				{
			echo "<a href=ficha_cata_editar.php?lote=".$lote["codigo_lote"]."><img title=editar src=images/pencil.png width=25></a>
				  <a href=ficha_cata_borrar.php?cata=".$lote["codigo_lote"]."><img title=borrar src=images/cross.png width=25></a>
				  <a href=ficha_cata.php?lote=".$lote["codigo_lote"]."><img title=ver src=images/ver.png width=25></a>";
			if($fragancia[$lote["codigo_lote"]]>0 && $sabor[$lote["codigo_lote"]]>0 && $balance[$lote["codigo_lote"]]>0){
			echo "<a href=perfil_cata.php?lote=".$lote["codigo_lote"]."><img width=25 src=images/radar.png></a><br><br>";}
			else {echo "<img width=25 title='perfil icompleto' src=images/uncompleted.png>";}
				  
				}
		else{
			echo "<a href=ficha_cata_nuevo.php?lote=".$lote["codigo_lote"]."><img title=editar src=images/add.png width=25></a>";
	
			}
		echo "</td></tr>";
	}
}
echo "</table></div>";


include("pie.php");

?>