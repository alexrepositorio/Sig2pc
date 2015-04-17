<?php

include ("cabecera.php");

$SQL="SELECT * FROM envios WHERE id = '".$_GET["envio"]."'";
//echo "$SQL";                         
$resultado=mysqli_query($link, $SQL);
$row = mysqli_fetch_array($resultado,MYSQLI_ASSOC);
$envios=$row;
echo "<div id='imprimir'>";
echo "<div align=center><h1>GUÍA DE CARGA DEL ENVÍO ".$_GET["envio"]."</h1><br><br>";

echo "<h3>Destino: ".$envios["destino"]."<br><h4>".date("d-m-Y H:i",strtotime($envios["fecha"]))."<br>Chófer: ".$envios["chofer"]."<br>Responsable: ".$envios["responsable"]. "<br><br>";

		unset($contenido);
		unset($cantidades);
		$SQL="SELECT despachos.*, catas.puntuacion, lotes.*, socios.* FROM despachos 
		LEFT JOIN catas on despachos.lote=catas.lote 
		LEFT JOIN lotes on despachos.lote=lotes.codigo_lote 
		LEFT JOIN socios on lotes.id_socio=socios.codigo
		WHERE despachos.envio='".$envios["id"]."' order by despachos.fecha desc";
		$resultado=mysqli_query($link, $SQL);
		$cuenta_despachos=mysqli_num_rows($resultado);
		if($cuenta_despachos==0){$contenido[]="ENVIO SIN CONTENIDO";$cantidades[]=0;}
		else{
		while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC))
				{
				 $ids[]=$row["id"];
				 $contenido[$row["id"]]["lote"]=$row["codigo_lote"];
				 $contenido[$row["id"]]["cantidad"]=$row["cantidad"];
				 $contenido[$row["id"]]["codigo"]=$row["codigo"];
				 $contenido[$row["id"]]["nombres"]=$row["nombres"];
				 $contenido[$row["id"]]["apellidos"]=$row["apellidos"];
 				 $contenido[$row["id"]]["poblacion"]=$row["poblacion"];
 				 $contenido[$row["id"]]["humedad"]=$row["humedad"];
 				 $contenido[$row["id"]]["puntuacion"]=$row["puntuacion"];
				 $cantidades[]=$row["cantidad"];
				 $puntuaciones[]=$row["puntuacion"];
				 $humedades[]=$row["humedad"];
				}
		}				
if(isset($ids)){
		
	echo "<table class=tablas>";
	echo "<tr>";
	echo "<th><h4>Lote</h4></th>";
	echo "<th><h4>Socio</h4></th>";
	echo "<th><h4>Orgánico</h4></th>";
	echo "<th><h4>Grupo</h4></th>";
	echo "<th><h4>Humedad</h4></th>";
	echo "<th><h4>Cata</h4></th>";
	echo "<th><h4>Cantidad</h4></th>";
	echo "</tr>";
	
			foreach($ids as $id){
				
			
			$estatus=certificacion($contenido[$id]["codigo"]);
			if(isset($estatus)){
				$estatus_actual=max(array_keys($estatus));
				if($estatus[$estatus_actual]["estatus"]=="O"){$estatus_t="<img title='socio CON certificación orgánica' src=images/organico.png width=25>";}else{$estatus_t="<img title='socio SIN certificación orgánica' src=images/noorganico.png width=25>";}
			}else{$estatus_t="desconocido";}
			
		
			
		
		echo "<tr>";
		echo "<td>".$contenido[$id]["lote"]."</td>";
		echo "<td>".$contenido[$id]["nombres"]." ".$contenido[$id]["apellidos"]."</td>";
		echo "<td align=center>".$estatus_t."</td>";
		echo "<td align=center>".$contenido[$id]["poblacion"]."</td>";
		echo "<td align=center>".$contenido[$id]["humedad"]." %</td>";
		echo "<td align=center>".$contenido[$id]["puntuacion"]."</td>";
		echo "<td align=center>".$contenido[$id]["cantidad"]." qq</td>";
		echo "</tr>";
	}		


if(count(array_filter($puntuaciones))>0){$media_puntuaciones=round(array_sum($puntuaciones)/count(array_filter($puntuaciones)),2);}else{$media_puntuaciones=$puntuaciones[0];}
if(count(array_filter($humedades))>0){$media_humedades=round(array_sum($humedades)/count(array_filter($humedades)),2);}else{$media_humedades=$humedades[0];}
echo "<tr>";
	echo "<th align=right colspan=4><b>TOTAL</b></td>";
	echo "<th align=center><b>".$media_humedades." %</b></td>";
	echo "<th align=center><b>".$media_puntuaciones."</b></td>";
	echo "<th align=center><b>".round(array_sum($cantidades),2)." qq</b></td>";
	echo "</tr>";


echo "</table></div></div><br><br>";
?>
<div align=center><a href="javascript:imprimir('imprimir')"><img width=25 src=images/imprimir.png>Imprimir ficha</a></div>
<?php
}
else{echo "<br><br><h3><font color=red>NO HAY CONTENIDO</font></h3><br><br><br>";}

include("pie.php");

?>