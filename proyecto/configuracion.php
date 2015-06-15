
<?php
include ("cabecera.php");
include ("socio.php");
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


/*
if (is_array($resultado)) {
	if (is_array($resultado[0])) {
			$campos[]= array_keys($resultado[0]);
	}else{
			$campos[]= array_keys($resultado);
	}
}

$campo=$campos[0];
echo "<div align=center><h2>TABLA DE CONFIGURACIONES</h2><br><h4>* las listas deben estar separadas por comas y sin espacios</h6><br><table class=tablas><tr>";
for ($i=0; $i < count($campo); $i++) { 
		if($campo[$i]!="id" && $campo[$i]!="parametro"){
	echo "<th align=center><h4>$campo[$i]</th>";}
}
echo "<th align=center><h4>editar</td>";
echo "</tr>";
if (is_array($resultado)) {
	if (is_array($resultado[0])) {
		foreach ($resultado as $dato) {
			for ($i=0; $i < count($campo); $i++) { 
				if($campo[$i]!="id" && $campo[$i]!="parametro"){
					echo "<th align=center><h4>".$dato[$campo[$i]]."</th>";
				}				
			}
			echo "<td align=center><a href=configuracion_editar.php?id=".$dato["id"]."><img title=editar src=images/pencil.png width=20></a></td>";
			echo "</tr>";	
		}
	}else{
		for ($i=0; $i < count($campo); $i++) { 
				if($campo[$i]!="id" && $campo[$i]!="parametro"){
					echo "<th align=center><h4>".$resultado[$campo[$i]]."</th>";
				}				
			}
			echo "<td align=center><a href=configuracion_editar.php?id=".$resultado["id"]."><img title=editar src=images/pencil.png width=20></a></td>";
			echo "</tr>";	
	}
}
echo "</table></div>";
*/
include("pie.php");

?>