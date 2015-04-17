<?php
include ("cabecera.php");
$res_cod=mysqli_query($link, "SELECT codigo_grupo FROM grupos");
while ($r=mysqli_fetch_array($res_cod,MYSQLI_ASSOC)){$codigos[]=$r["codigo_grupo"];}
//muestra_array($codigos);


if (isset($_GET["borra"])){
	$SQL_edit="DELETE FROM grupos WHERE id='".$_GET["borra"]."'";
	$resultado=mysqli_query($link, $SQL_edit);
	
	$cadena=str_replace("'", "", $SQL_edit);
	guarda_historial($cadena);
	//echo "$SQL_edit";
	
	echo "<div align=center><h1>BORRANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=grupos.php'></font></h1></div>";		
}

elseif (isset($_POST["grupo"]) & isset($_POST["codigo_grupo"])){

	if(!in_array(strtoupper($_POST["codigo_grupo"]),$codigos)){	
	$SQL_edit="INSERT INTO grupos VALUES('',
				'".$_POST["grupo"]."',
				'".strtoupper($_POST["codigo_grupo"])."')";

	$resultado=mysqli_query($link, $SQL_edit);
	$nuevo_id=mysqli_insert_id($link);
	
	
	$cadena=str_replace("'", "", $SQL_edit);
	guarda_historial($cadena);
	
	//echo "$SQL_edit";
	
	echo "<div align=center><h1>GUARDANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=grupos.php'></font></h1></div>";
	}
	else{
	echo "<div align=center><h1>EL CODIGO YA EXISTE, PRUEBA OTRA VEZ...
	<meta http-equiv='Refresh' content='4;url=grupos.php'></font></h1></div>";
	}
}

else{
	echo "<div align=center>";
	echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
	echo "<table class=tablas><tr><th colspan=2><h4>Nuevo Grupo</th></tr>";
	echo "<tr><th>Grupo</th><td><input type='text' name=grupo></td></tr>";
	echo "<tr><th>Codigo</th><td><input maxlength=2 size=1 type='text' name=codigo_grupo> *2 caracteres máx</td></tr>";
	echo "</table><br><input type='submit' value='Guardar'>";
	echo "</form>";
	
	$sql="SELECT * FROM grupos";
	//**********TABLA AUTOMATICA*****************************************************************
	$resultado=mysqli_query($link, $sql);
	while($object = mysqli_fetch_field($resultado)){
		$campos[]=$object->name;
	}
	
	echo "<table class=tablas><tr>";
	foreach ($campos as $columna){
		echo "<th><h4>$columna</th>";
	}
	echo "<th><h4>opciones</th>";
	echo "</tr>";
	
	while($datos = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
		echo "<tr>";
		foreach ($campos as $columna){
			echo "<td>".$datos[$columna]."</td>";
		}
		echo "<td><a href=?borra=".$datos["id"]."><img src=images/cross.png></a></td>";
		echo "</tr>";	
	}
	echo "</table></div>";
	//**********TABLA AUTOMATICA*****************************************************************
}









include("pie.php");

?>
