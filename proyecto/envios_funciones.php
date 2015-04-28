<?php
//Implementada en linea 10 de envios.php

	function busqueda_sin_criterios()
	{
		 require("conect.php");
		$SQL="SELECT * FROM envios order by fecha desc";
		 $result=mysqli_query($link,$SQL) or die(mysqli_error($link));
    	return ($result);
	}

	//Implementada en linea 18 de envios.php
	function busqueda_con_criterios($criterio,$post){
		switch ($criterio)
			{		
			case "fecha":
				$SQL="SELECT * FROM envios WHERE date_format(fecha,'%Y-%m-%d') = '".$post."' order by fecha desc";
				$_texto=$post;
				break;		
			}
		return array($SQL,$_texto);
	}
	//Implementada en linea 22 de envios.php

	function resultado_sentencias($link,$SQL){
			$resultado=mysqli_query($link, $SQL);
			$cuenta=mysqli_num_rows($resultado);
			while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
				$envios[]=$row;	
			}
			return array($resultado,$cuenta,$envios);
		}

	//Implementada en linea 35 de envios.php
	function catalogo_fechas($link){
		$sql_fecha="SELECT DISTINCT date_format(fecha,'%Y-%m-%d') as fecha FROM envios ORDER BY fecha ASC";
		$r_fec=mysqli_query($link, $sql_fecha);

		while ($rowfec = mysqli_fetch_array($r_fec,MYSQLI_ASSOC)){
			$fecha[]=$rowfec["fecha"];
		}
		return $fecha;
	}

	//Implementada en linea 65 de envios.php
	function presentacion_datos($envio,$link){
		$SQL="SELECT * FROM despachos WHERE envio='".$envio."' order by fecha desc";
		$resultado=mysqli_query($link, $SQL);
		$cuenta_despachos=mysqli_num_rows($resultado);
		if($cuenta_despachos==0){
			$contenido[]="ENVIO SIN CONTENIDO";$cantidades[]=0;
		}
		else{
		while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC))
				{$contenido[]=$row["cantidad"]." de ".$row["lote"];
				 $cantidades[]=$row["cantidad"];
				}
		}
		return array($contenido,$cantidades);			
	}

?>