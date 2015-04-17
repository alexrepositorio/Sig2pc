<?php
include ("cabecera.php");


$SQL_estimaciones="SELECT estimacion.*, l.pesosum FROM estimacion
				LEFT JOIN (SELECT id_socio, date_format(fecha,'%Y') as ano, SUM(peso) as pesosum FROM lotes GROUP BY id_socio, ano) l 
				on (estimacion.id_socio=l.id_socio AND estimacion.year=l.ano) ORDER BY year desc";
		$resultado_estimaciones=mysqli_query($link, $SQL_estimaciones);
		while($estimaciones[] = mysqli_fetch_array($resultado_estimaciones,MYSQLI_ASSOC)){}
//muestra_array($estimaciones);
foreach ($estimaciones as $key=>$estimacion)
{
if(!is_null($estimacion["pesosum"])){
			echo $estimacion["id"]." ".$estimacion["id_socio"]."-".$estimacion["year"]." (".$estimacion["estimados"].")=".$estimacion["entregados"].">>".$estimacion["pesosum"]."<br>";
			$SQL_edit="UPDATE estimacion SET
							entregados=".$estimacion["pesosum"]."
							WHERE id=".$estimacion["id"];
			//echo "$SQL_edit<br>";
			$resultado=mysqli_query($link, $SQL_edit);
			$cadena=str_replace("'", "", $SQL_edit);
			guarda_historial($cadena);
			
			}
}
echo "<div align=center><h1>ACTUALIZANDO LOS TOTALES ENTREGADOS, ESPERA... <meta http-equiv='Refresh' content='2;url=socios.php'></font></h1></div>";

include("pie.php");

?>
