<?php
include ("cabecera.php");

		$SQL="SELECT * FROM despachos WHERE id='".$_GET["despacho"]."'";
		$resultado=mysqli_query($link, $SQL);
		$despacho = mysqli_fetch_array($resultado,MYSQLI_ASSOC);

if(isset ($_POST["despacho"])){

if($_POST["cantidad"]>$_POST["restante"]){
	echo "<div align=center><notif>no es posible despachar esa cantidad <br>
	pues sólo quedan ".$_POST["restante"]."qq</notif><br><br><br>
	<a href=ficha_despacho_editar.php?despacho=".$_POST["despacho"]."&lote=".$_POST["lote"]."&cantidad=".$_POST["cantidad"]."><h2>VOLVER</h2></a></div><br>";
}
else{

	
$SQL_edit="UPDATE despachos SET
				fecha='".$_POST["fecha"]."',
				cantidad='".$_POST["cantidad"]."',
				envio='".$_POST["envio"]."'
				WHERE id='".$_POST["despacho"]."'";

$resultado=mysqli_query($link, $SQL_edit);
$nuevo_id=mysqli_insert_id($link);


$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);

//echo "$SQL_edit";

echo "<div align=center><h1>GUARDANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=almacen.php'></font></h1></div>";

//echo "$SQL_edit";
}
}

else{
	
		$SQL="SELECT SUM(cantidad) as sum FROM despachos WHERE lote='".$_GET["lote"]."' GROUP BY lote";
		$resultado=mysqli_query($link, $SQL);
		$despachado = mysqli_fetch_array($resultado,MYSQLI_ASSOC);

echo "<div align=center><h1>EDITAR EL DESPACHO DEL LOTE ".$_GET["lote"]."</h1><br>";

//muestra_array($socio);

$maximo=$_GET["cantidad"]-($despachado["sum"]-$despacho["cantidad"]);

echo "<form name=form action=".$_SERVER['PHP_SELF']."?despacho=".$_GET["despacho"]." method='post'>";
echo "<table class=tablas>";
echo "<tr><th><h4>Fecha</th><td><input type='text' name=fecha value='".$despacho["fecha"]."'></td></tr>";
echo "<tr><th><h4>Cantidad</th><td><input type='text' name=cantidad value='".$despacho["cantidad"]."'>qq<br>*max.".round($maximo,2)."qq</td></tr>";
//echo "<tr><th><h4>Envío</th><td><input type='text' name=envio></td></tr>";
echo "<tr><th align=right><h4>Envío</th><td><select name=envio>";
$sql_envios="SELECT * FROM envios ORDER BY fecha ASC";
$r_envios=mysqli_query($link, $sql_envios);
while ($rowenvio = mysqli_fetch_array($r_envios,MYSQLI_ASSOC))
{
	$envio_n=date("d-m-Y",strtotime($rowenvio["fecha"]))." a ".$rowenvio["destino"];
	$envio_codigo=$rowenvio["id"];
	if ($envio_codigo==$despacho["envio"]){$sel="selected";}else{$sel="";}
	echo "<option $sel value='".$envio_codigo."'>$envio_n</option>";
}
echo "</select><br>";
echo "</table><br>";
echo "<input type='hidden' name=despacho value='".$_GET["despacho"]."'>";
echo "<input type='hidden' name=lote value='".$_GET["lote"]."'>";
echo "<input type='hidden' name=restante value='".$maximo."'>";
echo "<input type='hidden' name=cantidad value='".$_GET["cantidad"]."'>";
echo "<input type='submit' value='Guardar'>";
echo "</form>";
}


include("pie.php");
?>