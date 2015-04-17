<?php
	$host="localhost"; 
	$user="root"; 
	$password=""; 
	$database="sig"; 
	$conexion = @mysqli_connect($host, $user, $password, $database) or die(mysqli_error()); 
	//$db = @mysql_select_db($database, $conexion) or die(mysqli_error());
?>