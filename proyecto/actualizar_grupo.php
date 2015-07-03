<?php
include ("cabecera.php");
include ("grupos_funciones.php");

$resultado=consultarGrupo('','');
foreach ($resultado as $res) {
	$codigos[]=$res["codigo_grupo"];
}

if (isset($_POST["grupo"]) & isset($_POST["codigo_grupo"])){
	actualizarGrupo($_POST["update"],strtoupper($_POST["grupo"]),strtoupper($_POST["codigo_grupo"]));
	echo "<div align=center><h1>ACTUALIZANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=grupos.php'></font></h1></div>";	
}else{
	$grupo=consultarGrupo('id',$_GET["id"]);
	$grupo=$grupo[0];

echo "<div align=center>";
	echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
	echo "<table class=tablas><tr><th colspan=2><h4>Actualizar Grupo</th></tr>";
	echo "<input type='hidden' name='update' value=".$grupo["id"].">";
	echo "<tr><th>Grupo</th><td><input type='text' name=grupo value='".$grupo["grupo"]."'></td></tr>";
	echo "<tr><th>Codigo</th><td><input maxlength=2 size=1 type='text' name=codigo_grupo value='".$grupo["codigo_grupo"]."'> *2 caracteres máx</td></tr>";
	echo "</table><br><input type='submit' value='Guardar'>";
	echo "</form>";

}	


include("pie.php");
?>