<?php
session_start();
include("cabecera_index.php");
list ($cuenta_pagos,$cuenta_catas,$stock_almacen) = Vactuales();
$cuenta_pagos="<font size=6.5>$cuenta_pagos </font>";
$cuenta_catas="<font size=6.5>$cuenta_catas </font>";
$stock_almacen="<font size=6.5>$stock_almacen </font>";
$height=150;
$width=300;
echo "<div align=center>";
echo "
<div align=center>";
		
if(in_array($_SESSION['acceso'],$permisos_general)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=socios.php><menuindex>SOCIOS</menuindex><img src=images/socios.png height=$height></a></td></tr></table></td></tr></table>";}
if(in_array($_SESSION['acceso'],$permisos_general)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=parcelas.php><menuindex>PARCELAS</menuindex><img src=images/parcelas.png height=$height></a></td></tr></table></td></tr></table>";}
if(in_array($_SESSION['acceso'],$permisos_lotes)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=lotes.php><menuindex>LOTES</menuindex><img src=images/cafe.png height=$height></td></tr></table></td></tr></table>";}
if(in_array($_SESSION['acceso'],$permisos_pagos)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=pagos.php><menuindex>PAGOS</menuindex>$cuenta_pagos<img src=images/money.png height=$height></td></tr></table></td></tr></table>";}
if(in_array($_SESSION['acceso'],$permisos_catador)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=catas.php><menuindex>CATAS</menuindex>$cuenta_catas<img src=images/coffee.png height=$height></td></tr></table></td></tr></table>";}
if(in_array($_SESSION['acceso'],$permisos_lotes)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=almacen.php><menuindex>ALMACEN</menuindex>$stock_almacen<br><img src=images/almacen.png height=$height></td></tr></table></td></tr></table>";}
if(in_array($_SESSION['acceso'],$permisos_lotes)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=envios.php><menuindex>ENVIOS</menuindex><img src=images/camion.png height=$height></td></tr></table></td></tr></table>";}
//if(in_array($_SESSION['acceso'],$permisos_general)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=cifras.php><menuindex>CIFRAS</menuindex><img src=images/numeros.png height=$height></td></tr></table></td></tr></table>";}if(in_array($_SESSION['acceso'],$permisos_general)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=galery.php><menuindex>GALERIA</menuindex><img src=images/galery.png height=$height></td></tr></table></td></tr></table>";}
if(in_array($_SESSION['acceso'],$permisos_admin)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=users.php><menuindex>USUARIOS</menuindex><img src=images/users.png height=$height></td></tr></table></td></tr></table>";}
if(in_array($_SESSION['acceso'],$permisos_admin)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=historial.php><menuindex>HISTORIAL</menuindex><img src=images/spy.png height=$height></td></tr></table></td></tr></table>";}
if(in_array($_SESSION['acceso'],$permisos_admin)){	echo "<table cellpadding=4 style='display: inline-table'><tr><td><table class=index><tr><td width=$width align=center><a href=configuracion.php><menuindex>CONFIGURACIÓN</menuindex><img src=images/configuracion.png height=$height></td></tr></table></td></tr></table>";}

 
/*echo "	<tr>
			<td align=center><menuindex>Opción4</td>
			<td align=center><menuindex>Opción5</td>
			<td align=center><menuindex>Opción6</td>
		</tr>";
*/

echo "<br></div>";
include("pie.php");
?>
