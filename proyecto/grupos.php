<?php
include ("cabecera.php");
include ("grupos_funciones.php");
$resultado=consultarGrupo('','');

foreach ($resultado as $res) {
	$codigos[]=$res["codigo_grupo"];
}


if (isset($_POST["grupo"]) & isset($_POST["codigo_grupo"])){
	if(!in_array(strtoupper($_POST["codigo_grupo"]),$codigos)){	
		insertarGrupo(strtoupper($_POST["grupo"]),strtoupper($_POST["codigo_grupo"]));
		echo "<div align=center><h1>GUARDANDO, ESPERA...
		<meta http-equiv='Refresh' content='2;url=grupos.php'></font></h1></div>";
	}
	else{
	echo "<div align=center><h1>EL CODIGO YA EXISTE, PRUEBA OTRA VEZ...
	<meta http-equiv='Refresh' content='4;url=grupos.php'></font></h1></div>";
	}
}else{
	echo "<div align=center>";
	echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
	echo "<table class=tablas>
	<tr><th colspan=2><h4>Nuevo Grupo</th></tr>";
	echo "<tr><th>Grupo</th><td><input type='text' name=grupo></td></tr>";
	echo "<tr><th>Codigo</th><td><input maxlength=2 size=1 type='text' name=codigo_grupo> *2 caracteres máx</td></tr>";
	echo "</table><br><input type='submit' value='Guardar'>";
	echo "</form>";
	echo "<br> <br> ";
	echo "<table  class='tablas' cellspacing=1 cellspadding=1 align=center border=2>";
	echo "<tr>   
			<th>Grupo</th>
			<th>Codigo</th>
			<th>opciones</th>
	</tr>";
	$res=consultarGrupo('','');
	foreach ($res as $row) {
		echo "<tr> ";
		echo "<td>".$row['grupo']."</td>";
		echo "<td>".$row['codigo_grupo']."</td>";
		echo "<td>  <a href=actualizar_grupo.php?id=".$row["id"]."><img src=images/pencil.png></a></td>";
		echo "</tr>";	
	}
	
	
	echo "</table></div>";
}
include("pie.php");
?>
