<?php
//$link = mysqli_connect("localhost", "root", "", "sig");
//mysqli_query($link, "SET NAMES 'utf8'");
include("catas_funciones.php");
include("uno.php");
require_once ('src/jpgraph.php');
require_once ('src/jpgraph_radar.php');



//$SQL="SELECT * FROM catas where lote='".$_GET["lote"]."'";
$resultado=catas_consultar('lote',$_GET["lote"]);
$cata = $resultado[0];

$sabor_r="Sabor\nResidual";
$frag="Fragancia/\nAroma";
 
$titles=array($frag,'Uniformidad','Cuerpo','Balance','Acidez',$sabor_r,'Sabor',);
$data=array($cata["fragancia"], $cata["uniformidad"], $cata["cuerpo"], $cata["balance"], $cata["acidez"], $cata["sabor_residual"], $cata["sabor"]);
 
$graph = new RadarGraph (650,600);

$titulo="Perfil Organoléptico del lote \n".$cata["lote"]."\nPuntuación: ".$cata["puntuacion"];
 
$graph->title->Set($titulo);
$graph->title->SetFont(FF_VERDANA,FS_NORMAL,16);
 
$graph->SetTitles($titles);
$graph->SetCenter(0.5,0.6);
$graph->HideTickMarks();
$graph->SetScale('lin',5,10);
$graph->yscale->ticks->Set(0.5,20);
$graph->SetColor('lightgreen@0.7');
$graph->axis->SetColor('darkgray');
$graph->grid->SetColor('darkgray');
$graph->grid->Show();
 
$graph->axis->title->SetFont(FF_ARIAL,FS_BOLD,10);
$graph->axis->title->SetMargin(1);
$graph->SetGridDepth(DEPTH_BACK);
$graph->SetSize(0.75);
 
$plot = new RadarPlot($data);
$plot->SetColor('red@0.2');
$plot->SetLineWeight(1);
$plot->SetFillColor('red@0.7');
 
$plot->mark->SetType(MARK_IMG_SBALL,'red');
 
$graph->Add($plot);
$gdImgHandler = $graph->Stroke(_IMG_HANDLER);
 
// Stroke image to a file and browser
 
// Default is PNG so use ".png" as suffix
 
// Send it back to browser
$graph->img->Headers();
$graph->img->Stream();
?>