<?php
list ($cuenta_pagos,$cuenta_catas,$stock_almacen) = Vactuales();
$cuenta_pagos="<font size=3>$cuenta_pagos </font>";
$cuenta_catas="<font size=3>$cuenta_catas </font>";
$stock_almacen="<font size=3>$stock_almacen </font>";
$height=50;
$width=100;
echo"<div align=center>";
//inicio
if(in_array($_SESSION['acceso'],$permisos_general)){	echo "<table class=menu><tr><td width=$width align=center><a href=index.php><img src=images/home.gif height=$height><br>INICIO</a></td></tr></table>";}
//socios
if(in_array($_SESSION['acceso'],$permisos_general)){	echo "<table class=menu><tr><td width=$width align=center><a href=socios.php><img src=images/socios.png height=$height><br>SOCIOS</a></td></tr></table>";}
//parcelas
if(in_array($_SESSION['acceso'],$permisos_general)){	echo "<table class=menu><tr><td width=$width align=center><a href=parcelas.php><img src=images/parcelas.png height=$height><br>PARCELAS</a></td></tr></table>";}
//lotes
if(in_array($_SESSION['acceso'],$permisos_lotes)){	echo "<table class=menu><tr><td width=$width align=center><a href=lotes.php><img src=images/cafe.png height=$height><br>LOTES</td></tr></table>";}
//pagos
if(in_array($_SESSION['acceso'],$permisos_pagos)){	echo "<table class=menu><tr><td width=$width align=center><a href=pagos.php><img src=images/money.png height=$height><br>PAGOS $cuenta_pagos</td></tr></table>";}
//calidad
if(in_array($_SESSION['acceso'],$permisos_catador)){	echo "<table class=menu><tr><td width=$width align=center><a href=catas.php><img src=images/coffee.png height=$height><br>CATAS $cuenta_catas</td></tr></table>";}
//almacen
if(in_array($_SESSION['acceso'],$permisos_lotes)){	echo "<table class=menu><tr><td width=$width align=center><a href=almacen.php><img src=images/almacen.png height=$height><br>ALMACEN $stock_almacen</td></tr></table>";}
//envios
if(in_array($_SESSION['acceso'],$permisos_lotes)){	echo "<table class=menu><tr><td width=$width align=center><a href=envios.php><img src=images/camion.png height=$height><br>ENVIOS</td></tr></table>";}
//galeria
//numeros
//usuarios
if(in_array($_SESSION['acceso'],$permisos_admin)){	echo "<table class=menu><tr><td width=$width align=center><a href=users.php><img src=images/users.png height=$height><br>USUARIOS</td></tr></table>";}
//historial
if(in_array($_SESSION['acceso'],$permisos_admin)){	echo "<table class=menu><tr><td width=$width align=center><a href=historial.php><img src=images/spy.png height=$height><br>HISTORIAL</td></tr></table>";}
//configuracion
if(in_array($_SESSION['acceso'],$permisos_admin)){	echo "<table class=menu><tr><td width=$width align=center><a href=configuracion.php><img src=images/configuracion.png height=$height><br>CONFIGURACIÓN</td></tr></table>";}
echo"</div><hr>";
?>
