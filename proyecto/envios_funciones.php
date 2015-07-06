<?php
	//Implementada en linea 12 y 20 de envios.php
	function busquedas($criterio,$post){		
		require("conect.php");   				
    	$SQL="call SP_envios_con('".$criterio."','".$post."')";//Procedimiento Almacenado
    	$result=mysqli_query($link,$SQL);   		
    	$_texto=$post;
		return array($result,$_texto);    	
	}
	//Implementada en linea 23 de envios.php

	function resultado_sentencias($SQL){	
			require("conect.php");   	
			$cuenta=mysqli_num_rows($SQL);
			while ($row = mysqli_fetch_array($SQL,MYSQLI_ASSOC)){
				$envios[]=$row;	
			}
			return array($SQL,$cuenta,$envios);
		}

	//Implementada en linea 32 de envios.php
	function catalogo_fechas(){		
		require("conect.php");   				
		$sql_fecha="call SP_envios_fechas_con()";
		$r_fec=mysqli_query($link, $sql_fecha);
		while ($rowfec = mysqli_fetch_array($r_fec,MYSQLI_ASSOC)){
			$fecha[]=$rowfec["fecha"];
		}
		return $fecha;
	}

	//Implementada en linea 63 de envios.php
	function presentacion_datos($envio){			
		require("conect.php");   
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

	//Implementada en linea 6 de ficha_envio_nuevo.php
	function ingresar_nuevo_envio($fecha,$destino,$chofer,$responsable)
		{	
			require("conect.php");   				
			$SQL_edit="call SP_envios_ins(
				'".$fecha."',
				'".$destino."',
				'".$chofer."',
				'".$responsable."')";//Procedimientos Almacenado;
			$resultado=mysqli_query($link, $SQL_edit);
			$nuevo_id=mysqli_insert_id($link);
			$cadena=str_replace("'", "", $SQL_edit);
			return array($cadena, $resultado, $nuevo_id);
		}

	//Implementada en linea 5 de ficha_envio_editar.php
	function editar_envio_presentar($envio)
		{	
			require("conect.php");   
			$SQL="SELECT * FROM envios WHERE id='".$envio."' order by fecha desc";
			$resultado=mysqli_query($link, $SQL);
			$cuenta=mysqli_num_rows($resultado);
			$envio = mysqli_fetch_array($resultado,MYSQLI_ASSOC);

			return array($resultado,$cuenta,$envio);
		}

	//Implementada en linea 8 de ficha_envio_editar.php REVISAR NO FUNCIONA¡¡¡¡ss
	function editar_envio_actualizar($fecha,$destino,$chofer,$responsable,$envio)
		{	
			echo "hola ".$envio;
			require("conect.php"); 
			$SQL_edit="call SP_envios_upd(
				'".$fecha."',
				'".$destino."',
				'".$chofer."',
				'".$responsable."',
				'".$envio."')";//Procedimientos Almacenado;

			$resultado=mysqli_query($link, $SQL_edit) or die(mysqli_error($link));
			$nuevo_id=mysqli_insert_id($link);
			$cadena=str_replace("'", "", $SQL_edit);
			return array($resultado,$nuevo_id,$cadena);
		}

	//FALTA¡¡¡¡¡Implementada en linea 8 de ficha_envio.php
	function ficha_envio_presentar($link)
		{				
			
		}

?>