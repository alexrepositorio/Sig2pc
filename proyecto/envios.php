<?php
	include ("cabecera.php");
	include ("envios_funciones.php");
	
	if(!isset($_GET["criterio"]))
	{
		$_POST["busca"]="";
		$criterio="";
		$encontrados="";	
		$vacio="";
		//FUNCION
		list($SQL,$_texto)=busquedas($criterio,$vacio) ;
	}else{
		if(isset($_GET["socio"])){
			$_POST["busca"]=$_GET["socio"];
		}	
		if (isset($_POST["busca2"])) {
			list($SQL,$_texto)=enviosConsultarfecha($_POST["busca"],$_POST["busca2"]);
		}else{

			list($SQL,$_texto)=busquedas($_POST["criterio"],$_POST["busca"]) ;
		}
		$encontrados="ENCONTRADOS";
		//FUNCION
		$criterio="<h4>Criterio de búsqueda: <b>".$_GET["criterio"]."</b> es <i> $_texto</i></h4>";
	}
	//FUNCION
	list($resultado,$cuenta,$envios)=resultado_sentencias($SQL);
	//$criterio='fecha2';
	$post='';
	echo "<div align=center><h1>Listado de envíos</h1><br><br>";
	echo "<table border=0 cellpadding=15 cellspacing=0><tr>";
	echo "<td align=center><h4>Fecha<br><form name=form1 action=".$_SERVER['PHP_SELF']."?criterio=fecha method='post'>";
	echo "
		<label for='desde'>Desde:</label>
		<input type='date' name='busca' id='desde' >
		<label for='hasta'>Hasta:</label>
		<input type='date' name='busca2' id='hasta'>
	";
	echo "<input type='submit' value='filtrar'>";
	echo "</form></td>";
	
	echo "<td align=center><a href=ficha_envio_nuevo.php>";
	echo "<img src=images/add.png width=50><br><h4>nuevo</a>";
	echo "</td>";
	echo "</tr></table>";
	echo "<h4> Total envios: $cuenta</h4>";
	echo "<div align=center>$criterio<br>";
	echo "<table id='table_id' style='width: 40%' class='tablas' posicion>";
		echo "<tr><th>";
		echo "<h4>ENVIOS </h4>";
		echo "</th>";
		echo "<th width=20px><h6>opciones</h6></th>";
		echo "<th width=20px><h6>contenido</h6></th></tr>";

	if(is_array($envios))
	{
		foreach ($envios as $envio)
		{
			unset($contenido);
			unset($cantidades);			
			$criterio="despac";
			//FUNCION
			list ($contenido,$cantidades)=presentacion_datos($envio["id"],$criterio);		
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