<?php


	include ("socio.php");
	include ("estimaciones_funciones.php");
	require_once ('src/jpgraph.php');
	require_once ('src/jpgraph_bar.php');

	$socio = consultarCriterio('id',$_GET["socio"]);
	$datos_socio["nombres"]=$socio["nombres"];
	$datos_socio["apellidos"]=$socio["apellidos"];
	$resultado= estimacion($_GET["socio"]);
	echo count($resultado);
	if (is_array($resultado)) {
		if (count($resultado)>1) {
			foreach ($resultado as $socio) {
				$estimados["year"][]=$socio["year"];		
				$estimados["estimados"][]=$socio["estimados"];		
				$estimados["entregados"][]=$socio["entregados"];
			}
			
		}else{
				$estimados["year"][]=$socio["year"];		
				$estimados["estimados"][]=$socio["estimados"];		
				$estimados["entregados"][]=$socio["entregados"];
		}
	}else{
		echo "NO DATA";
	}

$graph = new Graph(600,450,'auto');
$graph->SetScale("textlin");

 
$titulo="Entregas del socio \n".$datos_socio["nombres"]." ".$datos_socio["apellidos"]."\nCódigo: ".$_GET["socio"];
 
$graph->title->Set($titulo);
$graph->title->SetFont(FF_VERDANA,FS_NORMAL,16);
 
// Create the graph. These two calls are always required

//$graph->yaxis->SetTickPositions(array(0,30,60,90,120,150), array(15,45,75,105,135));
$graph->SetBox(false);

$graph->ygrid->SetFill(false);
$graph->xaxis->SetTickLabels($estimados["year"]);
$graph->yaxis->HideLine(false);
$graph->yaxis->HideTicks(false,false);
 
$b1plot = new BarPlot($estimados["estimados"]);
$b2plot = new BarPlot($estimados["entregados"]);

$gbplot = new GroupBarPlot(array($b1plot,$b2plot));
// ...and add it to the graPH
$graph->Add($gbplot);

$b1plot->SetColor("white");
$b1plot->SetFillColor("#cc1111");
$b1plot->SetLegend("Estimados");

$b2plot->SetColor("white");
$b2plot->SetFillColor("#11cccc");
$b2plot->SetLegend("Entregados"); 
 
$graph->Stroke();
?>