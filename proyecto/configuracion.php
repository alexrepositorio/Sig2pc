
<?php
include ("cabecera.php");
include ("socio_funciones.php");
include ("configuracion_funciones.php");

$resultado=configuracion_cons('','');
if (is_array($resultado)) {
	$campos=array_keys($resultado[0]);
	echo "<div align=center><h2>TABLA DE CONFIGURACIONES</h2><br><h4>* las listas deben estar separadas por comas y sin espacios</h6><br><table class=tablas><tr>";
	for ($i=0; $i < count($campos); $i++) { 
		if($campos[$i]!="id" && $campos[$i]!="parametro"){
			echo "<th align=center><h4>$campos[$i]</th>";
		}
	}
	echo "<th align=center><h4>editar</td>";
	echo "</tr>";
	foreach ($resultado as $dato) {
		for ($i=0; $i < count($campos); $i++) { 
			if($campos[$i]!="id" && $campos[$i]!="parametro"){
				echo "<th align=center><h4>".$dato[$campos[$i]]."</th>";				
			}						
		}
		echo "<td align=center><a href=configuracion_editar.php?id=".$dato["id"]."><img title=editar src=images/pencil.png width=20></a></td>";
		echo "</tr>";	
	}
	echo "</table></div>";
}else{
	echo "no data";
}
include("pie.php");
?>