<?php
include ("cabecera.php");
include ("configuracion_funciones.php");
//******************************************
if(isset ($_POST["editar"])){

	configuracion_actualizar($_POST["descripcion"],$_POST["valor"],$_POST["editar"]);
echo "<div align=center><h1>ACTUALIZANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=configuracion.php'></font></h1></div>";
	
}else{
//******************************************
$resultado=configuracion_cons('id',$_GET["id"]);
$resultado=$resultado[0];

//**********TABLA AUTOMATICA*****************************************************************
echo "<div align=center><h1>Formulario de edicion para el parámetro</h1><br><br><br>";
echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
echo "<table class=tablas>";
echo "<input type='hidden' name='editar' value=".$_GET["id"].">";
echo "​<tr><th align=right><h4>Descripcion</td><td><textarea name='descripcion' rows='3' cols='70'>".$resultado['descripcion']."</textarea>";
echo "​<tr><th align=right><h4>Descripcion</td><td><textarea name='valor'  rows='2' cols='70'>".$resultado['valor']."</textarea>";
echo "</table><br>";
echo "<input type='submit' value='Guardar'>";
echo "</form></div>";
}
//**********TABLA AUTOMATICA*****************************************************************
include("pie.php");

?>

