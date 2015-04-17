<?php
include("cabecera_index.php");
$height=150;
$width=300;

// catas pendientes
$SQL_catas_pendientes="SELECT codigo_lote FROM lotes WHERE calidad='A' AND codigo_lote NOT IN (SELECT lote FROM catas)";
$resultado=mysqli_query($conexion, $SQL_catas_pendientes);
$cuenta_catas=mysqli_num_rows($resultado);
if ($cuenta_catas>0){$cuenta_catas="<font size=6>(<font color=red><b>$cuenta_catas</b></font>)</font>";}
//*****************************

// pagos pendientes
$SQL_pagos_pendientes="SELECT codigo_lote FROM lotes WHERE codigo_lote NOT IN (SELECT lote FROM pagos)";
$resultado2=mysqli_query($conexion, $SQL_pagos_pendientes);
$cuenta_pagos=mysqli_num_rows($resultado2);
if ($cuenta_pagos>0){$cuenta_pagos="<font size=6>(<font color=red><b>$cuenta_pagos</b></font>)</font>";}
//*****************************

// estado de almacén
$SQL_estado_almacen_entradas="SELECT SUM(peso) FROM lotes";
$resultado3=mysqli_query($conexion, $SQL_estado_almacen_entradas);
$almacen_entradas=mysqli_fetch_row($resultado3);
$almacen_entradas=$almacen_entradas[0];
$SQL_estado_almacen_salidas="SELECT SUM(cantidad) FROM despachos";
$resultado4=mysqli_query($conexion, $SQL_estado_almacen_salidas);
$almacen_salidas=mysqli_fetch_row($resultado4);
$almacen_salidas=$almacen_salidas[0];
$stock_almacen=$almacen_entradas-$almacen_salidas;
$stock_almacen="<font size=6>(<font color=red><b>".$stock_almacen."qq</b></font>)</font>";
//*****************************


echo "<div align=center>";
echo "
<div align=center>";
		
if(in_array($_COOKIE['acceso'],$permisos_general)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=socios.php><menuindex>SOCIOS</menuindex><img src=images/socios.png height=$height></a></td></tr></table></td></tr></table>";}
if(in_array($_COOKIE['acceso'],$permisos_general)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=parcelas.php><menuindex>PARCELAS</menuindex><img src=images/parcelas.png height=$height></a></td></tr></table></td></tr></table>";}
if(in_array($_COOKIE['acceso'],$permisos_lotes)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=lotes.php><menuindex>LOTES</menuindex><img src=images/cafe.png height=$height></td></tr></table></td></tr></table>";}
if(in_array($_COOKIE['acceso'],$permisos_pagos)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=pagos.php><menuindex>PAGOS</menuindex>$cuenta_pagos<img src=images/money.png height=$height></td></tr></table></td></tr></table>";}
if(in_array($_COOKIE['acceso'],$permisos_catador)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=catas.php><menuindex>CATAS</menuindex>$cuenta_catas<img src=images/coffee.png height=$height></td></tr></table></td></tr></table>";}
if(in_array($_COOKIE['acceso'],$permisos_lotes)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=almacen.php><menuindex>ALMACEN</menuindex>$stock_almacen<br><img src=images/almacen.png height=$height></td></tr></table></td></tr></table>";}
if(in_array($_COOKIE['acceso'],$permisos_lotes)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=envios.php><menuindex>ENVIOS</menuindex><img src=images/camion.png height=$height></td></tr></table></td></tr></table>";}
if(in_array($_COOKIE['acceso'],$permisos_general)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=cifras.php><menuindex>CIFRAS</menuindex><img src=images/numeros.png height=$height></td></tr></table></td></tr></table>";}
if(in_array($_COOKIE['acceso'],$permisos_general)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=galery.php><menuindex>GALERIA</menuindex><img src=images/galery.png height=$height></td></tr></table></td></tr></table>";}
if(in_array($_COOKIE['acceso'],$permisos_admin)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=usuarios.php><menuindex>USUARIOS</menuindex><img src=images/users.png height=$height></td></tr></table></td></tr></table>";}
if(in_array($_COOKIE['acceso'],$permisos_admin)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=historial.php><menuindex>HISTORIAL</menuindex><img src=images/spy.png height=$height></td></tr></table></td></tr></table>";}
if(in_array($_COOKIE['acceso'],$permisos_admin)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=configuracion.php><menuindex>CONFIGURACIÓN</menuindex><img src=images/configuracion.png height=$height></td></tr></table></td></tr></table>";}

 
/*echo "	<tr>
			<td align=center><menuindex>Opción4</td>
			<td align=center><menuindex>Opción5</td>
			<td align=center><menuindex>Opción6</td>
		</tr>";
*/

echo "<br></div>";
include("pie.php");
?>
