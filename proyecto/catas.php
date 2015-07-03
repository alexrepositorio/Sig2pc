<?php
include ("cabecera.php");
include ("conect.php");
include ("catas_funciones.php");
include ("lote_funciones.php");

if(isset($_POST["fecha"])){
	$resultado=LotesConsultarCriterio('fecha_catas',$_POST["fecha"]);
}else{
	$resultado=LotesConsultarCriterio('','');
}
//$SQL="SELECT * FROM lotes WHERE calidad='A' $andwhere order by fecha desc";
if (is_array($resultado)) {
	foreach ($resultado as $row) {
		$lotes[]=$row;
		$pesos[]=$row["peso"];
		$r_p=catas_consultar('lote',$row["id"]);
		//print_r($r_p);
		if (is_array($r_p)) {
			$cata=$r_p[0];
			$fragancia[$row["id"]]=$cata["fragancia"];
			$sabor[$row["id"]]=$cata["sabor"];
			$balance[$row["id"]]=$cata["balance"];
			$puntuacion[$row["id"]]=$cata["puntuacion"];
		}else{
			$puntuacion[$row["id"]]="<a href=ficha_cata_nuevo.php?lote=".$row["codigo_lote"]."><font color=blue><b>PENDIENTE</b></font></a>";
		}
	}		
}
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
echo "<td align=center><h4>Fecha<br><form name=form3 action=".$_SERVER['PHP_SELF']."?criterio=fecha method='post'>";
echo "<select name=fecha>";
//$sql_fecha="SELECT DISTINCT date_format(fecha,'%Y-%m-%d') as fecha FROM lotes WHERE calidad='A' ORDER BY fecha ASC";
$r_fec=LotesConsultarCriterio('fechas','');
if (is_array($r_fec)) {
	foreach ($r_fec as $rowfec) {
		echo "<option value='$fecha'>".$rowfec["fecha"]."</option>";
	}
}
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
echo "<table id='table_id' style='width: 60%' class='tablas' posicion>";
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
		echo "<td><h3>".$lote["codigo_lote"]."<br><h4>".date("d-m-Y H:i",strtotime($lote["fecha"]))."</td><td align=center><h4>".$puntuacion[$lote["id"]]."<br>";
		echo "</td>";
		echo "<td>";
	if($puntuacion[$lote["id"]]>0){
			echo "<a href=ficha_cata_editar.php?lote=".$lote["id"]."><img title=editar src=images/pencil.png width=25></a>
				  <a href=ficha_cata_borrar.php?cata=".$lote["id"]."><img title=borrar src=images/cross.png width=25></a>
				  <a href=ficha_cata.php?lote=".$lote["id"]."><img title=ver src=images/ver.png width=25></a>";
			if($fragancia[$lote["id"]]>0 && $sabor[$lote["id"]]>0 && $balance[$lote["id"]]>0){
				echo "<a href=perfil_cata.php?lote=".$lote["id"]."><img width=25 src=images/radar.png></a><br><br>";
		}else{
				echo "<img width=25 title='perfil incompleto' src=images/uncompleted.png>";
			}
	}else{
			echo "<a href=ficha_cata_nuevo.php?lote=".$lote["id"]."><img title=editar src=images/add.png width=25></a>";
			}
		echo "</td></tr>";
	}
}
echo "</table></div>";


include("pie.php");

?>