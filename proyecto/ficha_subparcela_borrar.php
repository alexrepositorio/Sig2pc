<?php
include ("cabecera.php");
include ("subparcelas_funciones.php");

if(isset($_GET["subparcela"]) AND isset($_GET["borra"])){
	$resultado=subparcela_borrar($_GET["subparcela"]);
	echo "<div align=center><h1>BORRANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=ficha_parcela.php?parcela=".$_GET["parcela"]."'></font></h1></div>";	
}


else{
	


//muestra_array($socio);
$resultado=consultarSubparcelas('id',$_GET["subparcela"]);
$lote = $resultado[0];

echo "<div align=center><h1>Borrar la subparcela ".$_GET["subparcela"]."</h1><br><h2>".$lote["superficie"]." ha <br> de la parcela ".$lote["id_parcela"]."<br></h2><br><br>";

echo "<notif>¿ESTA SEGURO?</notif><br><br>";

echo "<table class=tablas><tr>";
echo "<td width=50%><a href=ficha_subparcela_borrar.php?subparcela=".$_GET["subparcela"]."&borra=".$_GET["subparcela"]."&parcela=".$_GET["parcela"]."><notifsi>SI</notifsi></a></td>";
echo "<td width=50%><a href=ficha_parcela.php?parcela=".$_GET["parcela"]."><notifno>NO</notifno></a></td>";
echo "</tr></table>";

}
include("pie.php");
?>