<?php
	include("config.php");
	//cadena de conexion al mysql
	
	if(!($link=mysqli_connect($db_host,$db_user,$db_pass,$db_name))){
		echo "Error:".mysql_error();
		exit();
	}	
?>