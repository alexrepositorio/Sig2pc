<?php
include ("cabecera.php");

if(isset ($_POST["lote"])){
	
if($_POST["cantidad"]>$_POST["restante"]){
	echo "<div align=center><notif>no es posible despachar esa cantidad <br>
	pues sólo quedan ".$_POST["restante"]."qq</notif><br><br><br>
	<a href=ficha_despacho_nuevo.php?lote=".$_POST["lote"]."&restante=".$_POST["restante"]."><h2>VOLVER</h2></a></div><br>";
}
else{
$SQL_edit="INSERT INTO despachos VALUES('',
				'".$_POST["lote"]."',
				'".$_POST["fecha"]."',
				'".$_POST["cantidad"]."',
				'".$_POST["envio"]."')";

$resultado=mysqli_query($link, $SQL_edit);
$nuevo_id=mysqli_insert_id($link);


$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);

//echo "$SQL_edit";

echo "<div align=center><h1>GUARDANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=envios.php'></font></h1></div>";

//echo "$SQL_edit";
}}


else{
	

echo "<div align=center><h1>NUEVO DESPACHO DEL LOTE ".$_GET["lote"]."</h1><br>";

//muestra_array($socio);

echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
echo "<table class=tablas>";
echo "<tr><th><h4>Fecha</th><td><input type='text' name=fecha value='".date("Y-m-d H:i:s",time())."'></td></tr>";
echo "<tr><th><h4>Cantidad</th><td><input type='text' name=cantidad>qq<br>*max.".round($_GET["restante"],2)."qq</td></tr>";
//echo "<tr><th><h4>Envío</th><td><input type='text' name=envio></td></tr>";
echo "<tr><th align=right><h4>Envío</h4><br>
<br><a href=ficha_envio_nuevo.php>*nuevo envío</a></th><td><select name=envio>";
$sql_envios="SELECT * FROM envios ORDER BY fecha ASC";
$r_envios=mysqli_query($link, $sql_envios);
while ($rowenvio = mysqli_fetch_array($r_envios,MYSQLI_ASSOC)){
	$envio_n=date("d-m-Y",strtotime($rowenvio["fecha"]))." a ".$rowenvio["destino"];
	$envio_codigo=$rowenvio["id"];
	//if ($rowsocio["id_socio"]==$_GET["socio"]){$sel="selected";}else{$sel="";}
	echo "<option value='".$envio_codigo."'>$envio_n</option>";}
echo "</select></td></tr>";
echo "</table><br>";
echo "<input type='hidden' name=lote value='".$_GET["lote"]."'>";
echo "<input type='hidden' name=restante value='".$_GET["restante"]."'>";
echo "<input type='submit' value='Guardar'>";
echo "</form>";
}


include("pie.php");
?>