<?php
include ("cabecera.php");

$SQL="SELECT * FROM socios where codigo='".$_GET["socio"]."'";
$resultado=mysqli_query($link, $SQL);
$socio = mysqli_fetch_array($resultado,MYSQLI_ASSOC);

$estatus=certificacion($socio["codigo"]);
if(count($estatus)>0){$estatus_actual=max(array_keys($estatus));}else{$estatus_actual="00";}

$estimado=estimacion($socio["codigo"]);
if(count($estimado)>0){
	$estimado_actual=max(array_keys($estimado));
	$enlace_estimado="<a href=historial_estimacion.php?socio=".$_GET["socio"].">ver historial</a>";}
else{
	$estimado_actual="00";
	$enlace_estimado="<a href=historial_estimacion_nuevo.php?socio=".$_GET["socio"].">añadir</a>";}

$altas=altas_bajas($socio["codigo"]);
if(count($altas)>0){
	$ultimafecha=max(array_keys($altas));
	$enlace_altas="<a href=historial_altas.php?socio=".$_GET["socio"].">ver historial</a>";}
else{
	$ultimafecha=0;
	$enlace_altas="<a href=historial_altas_nuevo.php?socio=".$_GET["socio"].">añadir</a>";}
	if($altas[$ultimafecha]["year"]==0){
		$altas[$ultimafecha]["year"]="<i>\"fecha desconocida\"</i>";
		$altas[$ultimafecha]["estado"]="";}
	else{
		$altas[$ultimafecha]["year"]=date("d-m-Y",strtotime($altas[$ultimafecha]["year"]));}
	

		if ($estatus_actual=="00"){
		$estatus_t="Sin datos";
		$estatus[$estatus_actual]["estatus"]="";
		$estatus[$estatus_actual]["year"]="";
		$enlace_estatus="<a href=historial_certificacion_nuevo.php?socio=".$_GET["socio"].">añadir</a>";}
		else{
			$enlace_estatus="<a href=historial_certificacion.php?socio=".$_GET["socio"].">ver historial</a>";
			if($estatus[$estatus_actual]["estatus"]=="O"){$estatus_t="ORGANICO";$estatus[$estatus_actual]["estatus"]="(O)";}
			else{$estatus_t="CONVENCIONAL";$estatus[$estatus_actual]["estatus"]="(".$estatus[$estatus_actual]["estatus"].")";}
			}
		

//lotes entregados por el socio
$SQL_lotes="SELECT * FROM lotes where id_socio='".$socio["codigo"]."' and date_format(fecha,'%Y') = '".$estimado[$estimado_actual]["year"]."'";
$resultado_lotes=mysqli_query($link, $SQL_lotes);
$cuenta_lotes=mysqli_num_rows($resultado_lotes);
if($cuenta_lotes>0)
{
	while($lot = mysqli_fetch_array($resultado_lotes,MYSQLI_ASSOC)){
	$pesos_del_socio[]=$lot["peso"];	
	}
	$peso_entregado=array_sum($pesos_del_socio);
	$estimado_actual_max=$estimado[$estimado_actual]["estimados"]*(1+($config["margen_contrato"]/100));
	$peso_restante=$estimado_actual_max-$peso_entregado;
	$cuenta_lotes_t="(<font color=red><b>$cuenta_lotes</b></font>)";
}
else{
	$peso_entregado=0;
	$estimado_actual_max=$estimado[$estimado_actual]["estimados"]*(1+($config["margen_contrato"]/100));
	$peso_restante=$estimado_actual_max-$peso_entregado;
	$cuenta_lotes_t="";
	
}

//parcelas del socio
$sql_par="SELECT * FROM parcelas WHERE id_socio='".$socio["codigo"]."'";
$r_par=mysqli_query($link, $sql_par);
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
if($socio["foto"]==""){$socio["foto"]="sinfoto.png";}
echo "<br><img src=fotos/".$socio["foto"]." width=150><br><br>";
echo "<table class=tablas>";
echo "<tr><th><h4>Nombres</th><td><h4>".$socio["nombres"]."</td></tr>";
echo "<tr><th><h4>Apellidos</th><td><h4>".$socio["apellidos"]."</td></tr>";
echo "<tr><th><h4>Código</th><td><h4>".$socio["codigo"]."</td></tr>";
echo "<tr><th><h4>Grupo</th><td><h4>".$socio["poblacion"]."</td></tr>";
echo "<tr><th><h4>Cédula</th><td><h4>".$socio["cedula"]."</td></tr>";
echo "<tr><th><h4>Celular</th><td><h4>".$socio["celular"]."</td></tr>";
echo "<tr><th><h4>Fecha de nacimiento</th><td><h4>".$socio["f_nacimiento"]."</td></tr>";
echo "<tr><th><h4>email</th><td><h4>".$socio["email"]."</td></tr>";
echo "<tr><th><h4>Dirección</th><td><h4>".$socio["direccion"]."</td></tr>";
echo "<tr><th><h4>Cantón</th><td><h4>".$socio["canton"]."</td></tr>";
echo "<tr><th><h4>Provincia</th><td><h4>".$socio["provincia"]."</td></tr>";
echo "<tr><th><h4>Género</th><td><h4>".$socio["genero"]."</td></tr>";
echo "</table>";

echo "<br><br>";


		echo "
		<table class=tablas><tr>
		<td width=33% valign=top><div align=center><h3>Estatus Certificación ".$estatus[$estatus_actual]["year"]."</h3><br>$enlace_estatus<hr><h4>$estatus_t ".$estatus[$estatus_actual]["estatus"]."</div></td>
		<td width=33% valign=top><div align=center><h3>Estimacion ".$estimado[$estimado_actual]["year"]."</h3><br>$enlace_estimado</div><hr>";
				
		if($estimado_actual=="00"){
			echo "<div align=center><h4>Sin datos</h4></div>";
		}else{
		echo "		
				<table><tr><th><h4>Estimado<br>".$estimado[$estimado_actual]["estimados"]."qq<br><h6> (max $estimado_actual_max qq)</h4></th>
						   <th><h4>Entregado<br>$peso_entregado qq</h4></th>
						   <th><h4>Restante<br>$peso_restante qq</h4></th>
				</tr></table>";
		}
		echo "		
		</td>
		<td width=33% valign=top><div align=center><h3>Estado actual</h3><br>$enlace_altas<hr><h4>".$altas[$ultimafecha]["estado"]." el<br>".$altas[$ultimafecha]["year"]."</div></td>
		</tr></table><br><br>";



echo "</div></div><br><br>";
?>
<div align=center><a href="javascript:imprimir('imprimir')"><img width=25 src=images/imprimir.png>Imprimir ficha</a></div><br><br>
<?php

echo "<div align=center>
<table class=tablas><tr>";




if(in_array($_SESSION['acceso'],$permisos_administrativos)){echo "<td><a href=ficha_socio_editar.php?socio=".$_GET["socio"]."><h3>EDITAR</h3></a></td>";}
//if(in_array($_COOKIE['acceso'],$permisos_administrativos)){echo "<td><a href=ficha_socio_borrar.php?socio=".$_GET["socio"]."><h3>ELIMINAR</h3></a></td>";}
if(in_array($_SESSION['acceso'],$permisos_lotes) && $estatus_t<>"Sin datos" || $ultimafecha>0){echo "<td><a href=ficha_lote_nuevo.php?socio=".$socio["codigo"]."><h3>AÑADIR LOTE</h3></a></td>";}
else{echo "<td align=center><h3><font color=red>NO SE PUEDE AÑADIR LOTE</font></h3><br>*Primero añada certificación y estado actual</td>";}
if(in_array($_SESSION['acceso'],$permisos_general) && $cuenta_lotes>0){echo "<td><a href=lotes.php?criterio=socio&socio=".$socio["codigo"]."><h3>VER LOTES $cuenta_lotes_t</h3></a></td>";}
if(in_array($_SESSION['acceso'],$permisos_general) && $cuenta_parcelas>0){echo "<td><a href=parcelas.php?criterio=socio&socio=".$socio["codigo"]."><h3>VER PARCELAS $cuenta_parcelas_t</h3></a></td>";}
echo "</tr></table></div>";
include("pie.php");
?>