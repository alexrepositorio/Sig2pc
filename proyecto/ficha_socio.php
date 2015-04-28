<?php
include ("cabecera.php");
include ("socio.php");



$socio = obtenerSocio($_GET["user"]);


$estatus=certificacion($_GET["user"]);
if(count($estatus)>0){
	$estatus_actual=max(array_keys($estatus));
}else{
	$estatus_actual="00";
}
$estimado=estimacion($socio["id_socio"]);
if(count($estimado)>0){
	$estimado_actual=max(array_keys($estimado));
	$enlace_estimado="<a href=historial_estimacion.php?socio=".$_GET["user"].">ver historial</a>";}
else{
	$estimado_actual="00";
	$enlace_estimado="<a href=historial_estimacion_nuevo.php?socio=".$_GET["user"].">añadir</a>";
}
$altas=altas_bajas($socio["id_socio"]);
if(count($altas)>0){
	$ultimafecha=max(array_keys($altas));
	$enlace_altas="<a href=historial_altas.php?socio=".$_GET["user"].">ver historial</a>";}
else{
	$ultimafecha=0;
	$enlace_altas="<a href=historial_altas_nuevo.php?socio=".$_GET["user"].">añadir</a>";}
	if($altas[$ultimafecha]["year"]==0){
		$altas[$ultimafecha]["year"]="<i>\"fecha desconocida\"</i>";
		$altas[$ultimafecha]["estado"]="";}
	else{
		$altas[$ultimafecha]["year"]=date("d-m-Y",strtotime($altas[$ultimafecha]["year"]));}
	

		if ($estatus_actual=="00"){
		$estatus_t="Sin datos";
		$estatus[$estatus_actual]["estatus"]="";
		$estatus[$estatus_actual]["year"]="";
		$enlace_estatus="<a href=historial_certificacion_nuevo.php?socio=".$_GET["user"].">añadir</a>";}
		else{
			$enlace_estatus="<a href=historial_certificacion.php?socio=".$_GET["user"].">ver historial</a>";
			if($estatus[$estatus_actual]["estatus"]=="O"){$estatus_t="ORGANICO";$estatus[$estatus_actual]["estatus"]="(O)";}
			else{$estatus_t="CONVENCIONAL";$estatus[$estatus_actual]["estatus"]="(".$estatus[$estatus_actual]["estatus"].")";}
			}
			$resultado_lotes=obtenerLotes($socio["id_socio"]);
$cuenta_lotes=mysqli_num_rows($resultado_lotes);;

if($cuenta_lotes>0)
{
	while($lot = mysqli_fetch_array($resultado_lotes)){
	$pesos_del_socio[]=$lot["peso"];	
	}
	$peso_entregado=array_sum($pesos_del_socio);
	$estimado_actual_max=$estimado[$estimado_actual]["estimados"]*(1+(obtener_configuracion_parametro('margen_contrato')/100));
	$peso_restante=$estimado_actual_max-$peso_entregado;
	$cuenta_lotes_t="(<font color=red><b>$cuenta_lotes</b></font>)";
}
else{
	$peso_entregado=0;
	$estimado_actual_max="";
	$peso_restante=$estimado_actual_max-$peso_entregado;	
	$cuenta_lotes_t="";
}

$r_par=parcelas($socio["id_socio"]);
$cuenta_parcelas=mysqli_num_rows($r_par);
if($cuenta_parcelas>0)
{
	$cuenta_parcelas_t="(<font color=red><b>$cuenta_parcelas</b></font>)";
}
else{
	$cuenta_parcelas_t="";
}


echo "<div id=imprimir>";
echo "<div align=center><h1>Ficha del socio</h1><br><h2>".$socio["nombres"]." ".$socio["apellidos"]."</h2><br>";
		

//muestra_array($socio);
echo "<table class=tablas>";
echo "<tr><th><h4>Nombres</th><td><h4>".$socio["nombres"]."</td></tr>";
echo "<tr><th><h4>Apellidos</th><td><h4>".$socio["apellidos"]."</td></tr>";
echo "<tr><th><h4>Código</th><td><h4>".$socio["codigo"]."</td></tr>";
echo "<tr><th><h4>Grupo</th><td><h4>".$socio["poblacion"]."</td></tr>";
echo "<tr><th><h4>Cédula</th><td><h4>".$socio["cedula"]."</td></tr>";
echo "<tr><th><h4>Fecha de nacimiento</th><td><h4>".$socio["f_nacimiento"]."</td></tr>";
echo "<tr><th><h4>email</th><td><h4>".$socio["email"]."</td></tr>";
echo "<tr><th><h4>Dirección</th><td><h4>".$socio["direccion"]."</td></tr>";
echo "<tr><th><h4>Cantón</th><td><h4>".$socio["canton"]."</td></tr>";
echo "<tr><th><h4>Provincia</th><td><h4>".$socio["provincia"]."</td></tr>";
echo "<tr><th><h4>Género</th><td><h4>".$socio["genero"]."</td></tr>";
echo "</table>";

echo "<br><br>";

echo "<div align=center>
<table class=tablas><tr>";

if(in_array($_SESSION['acceso'],$permisos_administrativos))
	{echo "<td><a href=ficha_socio_editar.php?user=".$_GET["user"]."><h3>EDITAR</h3></a></td>";
}
//if(in_array($_COOKIE['acceso'],$permisos_administrativos)){echo "<td><a href=ficha_socio_borrar.php?socio=".$_GET["socio"]."><h3>ELIMINAR</h3></a></td>";}
if(in_array($_SESSION['acceso'],$permisos_lotes) && $estatus_t<>"Sin datos" || $ultimafecha>0){
	echo "<td><a href=ficha_lote_nuevo.php?socio=".$socio["id_socio"]."><h3>AÑADIR LOTE</h3></a></td>";
}
else{echo "<td align=center><h3><font color=red>NO SE PUEDE AÑADIR LOTE</font></h3><br>*Primero añada certificación y estado actual</td>";}
if(in_array($_SESSION['acceso'],$permisos_general) && $cuenta_lotes>0){
	echo "<td><a href=lotes.php?criterio=socio&socio=".$socio["id_socio"]."><h3>VER LOTES $cuenta_lotes_t</h3></a></td>";
}
if(in_array($_SESSION['acceso'],$permisos_general) && $cuenta_parcelas>0){
	echo "<td><a href=parcelas.php?criterio=socio&socio=".$socio["id_socio"]."><h3>VER PARCELAS $cuenta_parcelas_t</h3></a></td>";
}
echo "</tr></table></div>";

		
include("pie.php");
?>