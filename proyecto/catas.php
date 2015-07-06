<?php
include ("cabecera.php");
include ("conect.php");
include ("catas_funciones.php");
include ("lote_funciones.php");
if(isset($_POST["fecha"])){
	$resultado=LotesConsultarCriterio('fecha_catas',$_POST["fecha"]);
}else{
	$resultado=LotesConsultarCriterio('','');
}
if (is_array($resultado)) {
	foreach ($resultado as $row) {
		$lotes[]=$row;
		$pesos[]=$row["peso"];
		$r_p=catas_consultar('lote',$row["id"]);
		if (is_array($r_p)) {
			$cata=$r_p[0];
			$fragancia[$row["id"]]=$cata["fragancia"];
			$sabor[$row["id"]]=$cata["sabor"];
			$balance[$row["id"]]=$cata["balance"];
			$puntuacion[$row["id"]]=$cata["puntuacion"];
		}else{
			$puntuacion[$row["id"]]="<a href=ficha_cata_nuevo.php?lote=".$row["codigo_lote"]."><font color=blue><b>PENDIENTE</b></font></a>";
		}
	}		
}
echo "<div align=center><h1>Listado de lotes para Cata</h1><br><br>";
echo "<td align=center><h4>Fecha<br><form name=form3 action=".$_SERVER['PHP_SELF']."?criterio=fecha method='post'>";
echo "<select name=fecha>";
$r_fec=LotesConsultarCriterio('fechas','');
if (is_array($r_fec)) {
	foreach ($r_fec as $rowfec) {
		echo "<option value='$fecha'>".$rowfec["fecha"]."</option>";
	}
}
echo "</select><br>";
echo "<input type='submit' value='filtrar'>";
echo "</form></td>";
echo "<table id='table_id' style='width: 60%' class='tablas' posicion>";
	echo "<tr><th width=500px>";
	echo "<h4>LOTES</h4>";
	echo "</th>";
	echo "<th width=20px><h6>cata</h6></th>";
	echo "<th width=20px><h6>opciones</h6></th></tr>";

if(isset($lotes))
{
	foreach ($lotes as $lote)
	{
		echo "<tr>";
		echo "<td><h3>".$lote["codigo_lote"]."<br><h4>".date("d-m-Y H:i",strtotime($lote["fecha"]))."</td><td align=center><h4>".$puntuacion[$lote["id"]]."<br>";
		echo "</td>";
		echo "<td>";
	if($puntuacion[$lote["id"]]>0){
			echo "<a href=ficha_cata_editar.php?lote=".$lote["id"]."><img title=editar src=images/pencil.png width=25></a>
				  <a href=ficha_cata_borrar.php?cata=".$lote["id"]."><img title=borrar src=images/cross.png width=25></a>
				  <a href=ficha_cata.php?lote=".$lote["id"]."><img title=ver src=images/ver.png width=25></a>";
			if($fragancia[$lote["id"]]>0 && $sabor[$lote["id"]]>0 && $balance[$lote["id"]]>0){
				echo "<a href=perfil_cata.php?lote=".$lote["id"]."><img width=25 src=images/radar.png></a><br><br>";
		}else{
				echo "<img width=25 title='perfil incompleto' src=images/uncompleted.png>";
			}
	}else{
			echo "<a href=ficha_cata_nuevo.php?lote=".$lote["id"]."><img title=editar src=images/add.png width=25></a>";
			}
		echo "</td></tr>";
	}
}
echo "</table></div>";
include("pie.php");
?>