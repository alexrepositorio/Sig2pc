<?php
// catas pendientes
$SQL_catas_pendientes="SELECT codigo_lote FROM lotes WHERE calidad='A' AND codigo_lote NOT IN (SELECT lote FROM catas)";
$resultado=mysqli_query($link, $SQL_catas_pendientes);
$cuenta_catas=mysqli_num_rows($resultado);
if ($cuenta_catas>0){$cuenta_catas="(<font color=red><b>$cuenta_catas</b></font>)";}
//*****************************

// pagos pendientes
$SQL_pagos_pendientes="SELECT codigo_lote FROM lotes WHERE codigo_lote NOT IN (SELECT lote FROM pagos)";
$resultado2=mysqli_query($link, $SQL_pagos_pendientes);
$cuenta_pagos=mysqli_num_rows($resultado2);
if ($cuenta_pagos>0){$cuenta_pagos="(<font color=red><b>$cuenta_pagos</b></font>)";}
//*****************************

// estado de almacén
$SQL_estado_almacen_entradas="SELECT SUM(peso) FROM lotes";
$resultado3=mysqli_query($link, $SQL_estado_almacen_entradas);
$almacen_entradas=mysqli_fetch_row($resultado3);
$almacen_entradas=$almacen_entradas[0];
$SQL_estado_almacen_salidas="SELECT SUM(cantidad) FROM despachos";
$resultado4=mysqli_query($link, $SQL_estado_almacen_salidas);
$almacen_salidas=mysqli_fetch_row($resultado4);
$almacen_salidas=$almacen_salidas[0];
$stock_almacen=$almacen_entradas-$almacen_salidas;
$stock_almacen="(<font color=red><b>".$stock_almacen."qq</b></font>)";
//*****************************


$height=50;
$width=100;
echo"<div align=center>";
//inicio
if(in_array($_COOKIE['acceso'],$permisos_general)){	echo "<table class=menu><tr><td width=$width align=center><a href=index.php><img src=images/home.gif height=$height><br>INICIO</a></td></tr></table>";}
//socios
if(in_array($_COOKIE['acceso'],$permisos_general)){	echo "<table class=menu><tr><td width=$width align=center><a href=socios.php><img src=images/socios.png height=$height><br>SOCIOS</a></td></tr></table>";}
//parcelas
if(in_array($_COOKIE['acceso'],$permisos_general)){	echo "<table class=menu><tr><td width=$width align=center><a href=parcelas.php><img src=images/parcelas.png height=$height><br>PARCELAS</a></td></tr></table>";}
//lotes
if(in_array($_COOKIE['acceso'],$permisos_lotes)){	echo "<table class=menu><tr><td width=$width align=center><a href=lotes.php><img src=images/cafe.png height=$height><br>LOTES</td></tr></table>";}
//pagos
if(in_array($_COOKIE['acceso'],$permisos_pagos)){	echo "<table class=menu><tr><td width=$width align=center><a href=pagos.php><img src=images/money.png height=$height><br>PAGOS $cuenta_pagos</td></tr></table>";}
//calidad
if(in_array($_COOKIE['acceso'],$permisos_catador)){	echo "<table class=menu><tr><td width=$width align=center><a href=catas.php><img src=images/coffee.png height=$height><br>CATAS $cuenta_catas</td></tr></table>";}
//almacen
if(in_array($_COOKIE['acceso'],$permisos_lotes)){	echo "<table class=menu><tr><td width=$width align=center><a href=almacen.php><img src=images/almacen.png height=$height><br>ALMACEN $stock_almacen</td></tr></table>";}
//envios
if(in_array($_COOKIE['acceso'],$permisos_lotes)){	echo "<table class=menu><tr><td width=$width align=center><a href=envios.php><img src=images/camion.png height=$height><br>ENVIOS</td></tr></table>";}
//galeria
if(in_array($_COOKIE['acceso'],$permisos_general)){	echo "<table class=menu><tr><td width=$width align=center><a href=galery.php><img src=images/galery.png height=$height><br>GALERIA</td></tr></table>";}
//numeros
if(in_array($_COOKIE['acceso'],$permisos_general)){	echo "<table class=menu><tr><td width=$width align=center><a href=cifras.php><img src=images/numeros.png height=$height><br>CIFRAS</td></tr></table>";}
//usuarios
if(in_array($_COOKIE['acceso'],$permisos_admin)){	echo "<table class=menu><tr><td width=$width align=center><a href=usuarios.php><img src=images/users.png height=$height><br>USUARIOS</td></tr></table>";}
//historial
if(in_array($_COOKIE['acceso'],$permisos_admin)){	echo "<table class=menu><tr><td width=$width align=center><a href=historial.php><img src=images/spy.png height=$height><br>HISTORIAL</td></tr></table>";}
//configuracion
if(in_array($_COOKIE['acceso'],$permisos_admin)){	echo "<table class=menu><tr><td width=$width align=center><a href=configuracion.php><img src=images/configuracion.png height=$height><br>CONFIGURACIÓN</td></tr></table>";}
echo"</div><hr>";
?>
