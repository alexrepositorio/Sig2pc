<?php
include ("cabecera.php");
include ("catas_funciones.php");
$resultado=catas_consultar('lote',$_GET["lote"]);
$cata = $resultado[0];
echo "<div id=imprimir>";		 
echo "<div align=center><h1>CATA DEL LOTE ".$_GET["lote"]."</h1><br>";
echo "<table class=tablas>";
echo "<tr><th align=right><h4>Fecha</th><td>".$cata["fecha"]."</td>";
echo "<th align=right><h4>Catador</th><td>".$cata["catador"]."</td></tr></table><br><br>";
echo "<table class=index><tr><th align=right><h4><font color=red>NOTA DE CATA</th><td><h4><font color=red>".$cata["puntuacion"]." puntos</td></tr>";
echo "</table><br><br>";
echo "<table class=tablas><tr><td>";
echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h4>Nivel de Tostado</th></tr>";
echo "<tr><th align=right><h4>Nivel de <br>Tostado</th><td><h4>";
							echo $cata["tostado"]."</h4><br>[0.00 - 6.00]</td></tr>";
echo "<tr><td align=right>Nº Quaquers</th><td>
".$cata["d_quaquers"]."
</td></tr>";
echo "</table>&nbsp&nbsp";
echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h4>Aroma</th></tr>";
echo "<tr><th align=right><h4>Fragancia/Aroma</th><td><h4>";
							echo "".$cata["fragancia"]."</h4><br>[0.00 - 10.00]</td></tr>";				  						
echo "<tr><th align=right valign=top><h4>Tipo</th><td>";
foreach($tipos_aroma as $tipo_aroma){
	if(in_array($tipo_aroma, explode(",",$cata["tipo_aroma1"]))){$chi="<b><u>"; $chf="</u></b>";echo "$chi$tipo_aroma$chf <br>";}	
}
echo "							</td></tr>";
echo "<tr><th colspan=2 align=left valign=top><h4>Nota</h4><br><table width=100%><tr><td><h6>".$cata["nota_aroma"]."</h6></td></tr></table></td></tr>";
echo "</table>&nbsp&nbsp";
echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h4>Sabor</th></tr>";
echo "<tr><th align=right><h4>Sabor</th><td><h4>";
							echo $cata["sabor"]. " </h4><br>[0.00 - 10.00]</td></tr>";
echo "<tr><th align=right valign=top><h4>Tipo</th><td>";
foreach($tipos_sabor as $tipo_sabor){
	if(in_array($tipo_sabor, explode(",",$cata["tipo_sabor"]))){$chi="<b><u>"; $chf="</u></b>";echo "$chi$tipo_sabor$chf <br>";}	
}
echo "							</td></tr>";
echo "<tr><th colspan=2 align=left valign=top><h4>Nota</h4><br><table width=100%><tr><td><h6>".$cata["nota_sabor"]."</h6></td></tr></table></td></tr>";
echo "</table>&nbsp&nbsp";
echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h4>Sabor residual</th></tr>";
echo "<tr><th align=right><h4>Sabor residual</th><td><h4>";
							echo  $cata["sabor_residual"]." </h4><br>[0.00 - 10.00]</td></tr>";
echo "<tr><th align=right valign=top><h4>Tipo</th><td>";
foreach($tipos_sabor_res as $tipo_sabor_res){
	if(in_array($tipo_sabor_res, explode(",",$cata["tipo_sabor_residual"]))){$chi="<b><u>"; $chf="</u></b>";echo "$chi$tipo_sabor_res$chf <br>";}
}
echo "							</td></tr>";
echo "<tr><th colspan=2 align=left valign=top><h4>Nota</h4><br><table width=100%><tr><td><h6>".$cata["nota_sabor_residual"]."</h6></td></tr></table></td></tr>";
echo "</table>&nbsp&nbsp";
echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h4>Otros Parámetros</th></tr>";
echo "<tr><td width=50% align=right><h4>Acidez</h4><br><h4>";
							echo  $cata["acidez"]." </h4><br>[0.00 - 10.00]</td>";
echo "<td width=50% align=right><h4>Uniformidad</h4><br><h4>";
							echo  $cata["uniformidad"]." </h4><br>[0.00 - 10.00]</td></tr>";
echo "<tr><td align=right><h4>Cuerpo</h4><br><h4>";
							echo  $cata["cuerpo"]." </h4><br>[0.00 - 10.00]<br></td>";
echo "<td align=right><h4>Balance</h4><br><h4>";
							echo  $cata["balance"]." </h4><br>[0.00 - 10.00]</td></tr>";
echo "<tr><td align=right rowspan=2><h4>Puntaje Catador</h4><br><h4>";
							echo  $cata["puntaje_catador"]." </h4><br>[0.00 - 10.00]</td>";
echo "<td align=right><h4>Taza limpia</h4><br><h4>";
							echo  $cata["taza_limpia"]." </h4><br>[0.00 - 10.00]</td></tr>";
echo "<tr><td align=right><h4>Dulzor</h4><br><h4>";
							echo  $cata["dulzor"]." </h4><br>[0.00 - 10.00]</td></tr>";
echo "<tr><th colspan=2 align=left valign=top><h4>Nota Catador</h4><br><table width=100%><tr><td><h6>".$cata["nota_catacion"]."</h6></td></tr></table></td></tr>";
echo "</table>&nbsp&nbsp";

echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h4>Defectos</th></tr>";

foreach($defectos as $key=>$defecto){
	if($cata[$defecto]>0){
		if($key<=11){		
			$defecto_texto=explode("_", $defecto);
			$defecto_texto=$defecto_texto[1];
			echo "<tr><td align=right>".ucfirst($defecto_texto)."</th><td>
			".$cata[$defecto]."
			</td></tr>";
		}
	}
}

echo "</table>&nbsp&nbsp";

echo "<table class=tablas>";
echo "<tr><th align=center colspan=2><h4>Defectos ligeros</th></tr>";

foreach($defectos as $key=>$defecto){
	if($cata[$defecto]>0){
		if($key>11){	
			$defecto_texto=explode("_", $defecto);
			$defecto_texto=$defecto_texto[1];
		echo "<tr><td align=right>".ucfirst($defecto_texto)."</th><td>
		".$cata[$defecto]."
		</td></tr>";
		}
	}
}

echo "<tr><th align=center colspan=2><h4>GENERAL</th></tr>";
echo "<tr><td align=right>DEFECTOS</th><td>
".$cata["d_general"]."
</td></tr>";
echo "</table>";					
echo "</td></tr></table>";
echo "<br><br></div></div><br>";
?>
<div align=center><a href="javascript:imprimir('imprimir')"><img width=25 src=images/imprimir.png>Imprimir ficha</a>
<?php
if($cata["fragancia"]>0 && $cata["sabor"]>0 && $cata["acidez"]>0){
	echo "<a href=perfil_cata.php?lote=".$_GET["lote"]."><img width=35 src=images/radar.png>Ver Perfil</a><br><br>";
}else {
	echo "<br><br>";
}
echo "<table class=tablas><tr>";
if(in_array($_SESSION['acceso'],$permisos_administrativos)){
	echo "<td><a href=ficha_cata_editar.php?lote=".$_GET["lote"]."><h3>EDITAR</h3></a></td>";
}
if(in_array($_SESSION['acceso'],$permisos_administrativos)){
	echo "<td><a href=ficha_cata_borrar.php?cata=".$cata["id"]."><h3>ELIMINAR</h3></a></td>";
}
echo "</tr></table></div>";
include("pie.php");
?>