<?php
	function guarda_historia($usuario, $accion, $fecha, $datos, $tabla, $maquina)
	{
		require("conect.php");   				
		$SQL="call SP_historial_ins('".$usuario."','".$accion."','".$fecha."','".$datos."','".$tabla."','".$maquina."')";//Procedimiento Almacenado
		$result=mysqli_query($link,$SQL) or die(mysqli_error($link));
		require("config_disconnect.php"); 		
	}	
	function historial_cons($criterio,$valor,$valor2){
		require("conect.php");   				
		$SQL="call SP_historial_cons('".$criterio."','".$valor."','".$valor2."')";
		$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 	
		require("config_disconnect.php");	
		return(transformar_a_lista($resultado));
	}	
?>