<?php
include ("cabecera.php");


if(!isset($_GET["criterio"]))
{
$_POST["busca"]="";
$criterio="";
$encontrados="";
$SQL="SELECT * FROM envios order by fecha desc";

}else{
	if(isset($_GET["socio"])){$_POST["busca"]=$_GET["socio"];}
	$encontrados="ENCONTRADOS";
	switch ($_GET["criterio"])
		{
		case "socio":
			$SQL="SELECT * FROM envios WHERE id_socio = '".$_POST["busca"]."' order by fecha desc";
			$datos_del_socio=nombre_socio($_POST["busca"]);
			$_texto=$datos_del_socio["apellidos"].", ".$datos_del_socio["nombres"];
			break;
		case "localidad":
			$SQL="SELECT * FROM envios INNER JOIN socios on lotes.id_socio=socios.id_socio WHERE socios.poblacion = '".$_POST["busca"]."' order by fecha desc";
			$_texto=$_POST["busca"];
			break;
		case "fecha":
			$SQL="SELECT * FROM envios WHERE date_format(fecha,'%Y-%m-%d') = '".$_POST["busca"]."' order by fecha desc";
			$_texto=$_POST["busca"];
			break;		
		}
$criterio="<h4>Criterio de búsqueda: <b>".$_GET["criterio"]."</b> es <i>''$_texto''</i></h4>";

}

//echo "$SQL";                         
$resultado=mysqli_query($link, $SQL);
$cuenta=mysqli_num_rows($resultado);
while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
	$envios[]=$row;
	
}
if(!isset($pesos)){$pesos[]=0;}
//if(!isset($costos)){$costos[]=0;}

//muestra_array($socios); 
echo "<div align=center><h1>Listado de envíos</h1><br><br>";
echo "<table border=0 cellpadding=15 cellspacing=0><tr>";
//echo "<td align=center></td><td align=center></td><td align=center></td></tr><tr>";
/*
echo "<td align=center><h4>Socio<br><form name=form1 action=".$_SERVER['PHP_SELF']."?criterio=socio method='post'>";
echo "<select name=busca>";
$sql_socios="SELECT id_socio, nombres, apellidos, codigo FROM socios ORDER BY codigo ASC";
$r_socio=mysqli_query($link, $sql_socios);
while ($rowsocio = mysqli_fetch_array($r_socio,MYSQLI_ASSOC)){$socio_n=$rowsocio["codigo"]."-".$rowsocio["apellidos"].", ".$rowsocio["nombres"];echo "<option value='".$rowsocio["id_socio"]."'>$socio_n</option>";}
echo "</select><br>";
echo "<input type='submit' value='buscar'>";
echo "</form></td>";
*/
/*
echo "<td align=center><h4>Grupo<br><form name=form2 action=".$_SERVER['PHP_SELF']."?criterio=localidad method='post'>";
echo "<select name=busca>";
$sql_localidad="SELECT grupo as pob, codigo_grupo as cod FROM grupos ORDER BY codigo_grupo ASC";
$r_loc=mysqli_query($link, $sql_localidad);
while ($rowloc = mysqli_fetch_array($r_loc,MYSQLI_ASSOC)){echo "<option value='".$rowloc["pob"]."'>(".$rowloc["cod"].")  ".$rowloc["pob"]."</option>";}
echo "</select><br>";
echo "<input type='submit' value='filtrar'>";
echo "</form></td>";
*/
echo "<td align=center><h4>Fecha<br><form name=form3 action=".$_SERVER['PHP_SELF']."?criterio=fecha method='post'>";
echo "<select name=busca>";
$sql_fecha="SELECT DISTINCT date_format(fecha,'%Y-%m-%d') as fecha FROM envios ORDER BY fecha ASC";
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
echo "<td align=center><a href=ficha_envio_nuevo.php>";
echo "<img src=images/add.png width=50><br><h4>nuevo</a>";
echo "</td>";


//$sumatotal=array_sum($pesos);
//$costototal=array_sum($costos);

echo "</tr></table>";

echo "<div align=center>$criterio<br>";
echo "<table class=tablas>";
	echo "<tr><th>";
	echo "<h4>ENVIOS $encontrados</h4> ($cuenta)";
	echo "</th>";
	echo "<th width=20px><h6>opciones</h6></th>";
	echo "<th width=20px><h6>contenido</h6></th></tr>";

if(isset($envios))
{
	foreach ($envios as $envio)
	{
		//$datos_socio=nombre_socio($lote["id_socio"]);
		
		//despachos del envio
		unset($contenido);
		unset($cantidades);
		$SQL="SELECT * FROM despachos WHERE envio='".$envio["id"]."' order by fecha desc";
		$resultado=mysqli_query($link, $SQL);
		$cuenta_despachos=mysqli_num_rows($resultado);
		if($cuenta_despachos==0){$contenido[]="ENVIO SIN CONTENIDO";$cantidades[]=0;}
		else{
		while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC))
				{$contenido[]=$row["cantidad"]." de ".$row["lote"];
				 $cantidades[]=$row["cantidad"];
				}
		}				
		
		echo "<tr>";
		echo "<td><a href=ficha_envio.php?envio=".$envio["id"]."><h3>".$envio["destino"]."<br><h4>".date("d-m-Y H:i",strtotime($envio["fecha"]))."<br>Chófer: ".$envio["chofer"]."<br>Responsable: ".$envio["responsable"]."</td>";
		echo "</td>";
		echo "<td align=center><a href=ficha_envio_editar.php?envio=".$envio["id"]."><img title='editar los datos del envio' src=images/pencil.png width=25></a></td>";
		echo "<td align=center>".implode("<br>",$contenido)."<hr>Total: ".array_sum($cantidades)."qq</td>";

		echo "</tr>";	
}
}
echo "</table></div>";


include("pie.php");

?>