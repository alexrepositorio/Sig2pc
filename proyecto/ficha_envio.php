<?php
	include ("cabecera.php");	
	include ("envios_funciones.php");
	include ("certificaciones_funciones.php");
	require("conect.php");
	$criterio='editar';
	//funcion
	$envios=ficha_envio_presentar($_GET["envio"],$criterio);
	echo "<div id='imprimir'>";
	echo "<div align=center><h1>GUÍA DE CARGA DEL ENVÍO ".$_GET["envio"]."</h1><br><br>";

	echo "<h3>Destino: ".$envios["destino"]."<br><h4>".date("d-m-Y H:i",strtotime($envios["fecha"]))."<br>Chófer: ".$envios["chofer"]."<br>Responsable: ".$envios["responsable"]. "<br><br>";
			$criterio2='descripcion';
			unset($contenido);
			unset($cantidades);
			//funcion
			list($ids,$contenido,$cantidades,$puntuaciones,$humedades)=ficha_envio_presentar2($envios["id"],$criterio2);			
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
			$estatus=certificacion('socio',$contenido[$id]["codigo"]);
			if(isset($estatus)){
				$estatus_actual=$estatus;
				if($estatus[$estatus_actual]["estatus"]=="O"){$estatus_t="<img title='socio CON certificación orgánica' src=images/organico.png width=25>";}else{$estatus_t="<img title='socio SIN certificación orgánica' src=images/noorganico.png width=25>";}
			}
			else{
				$estatus_t="desconocido";
			}			
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
		//funcion
		list ($media_humedades,$media_puntuaciones)=ficha_envio_calculo($puntuaciones,$humedades);
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