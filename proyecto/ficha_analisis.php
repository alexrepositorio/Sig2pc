<?php
include ("cabecera.php");

$sql="SELECT * FROM analisis WHERE id_analisis=".$_GET["id_analisis"];
$resultado=mysqli_query($link, $sql);
while($datos = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){

			//datos del socio
			$sql_parcela="SELECT id_socio FROM parcelas WHERE id=".$_GET["parcela"];
			$res=mysqli_query($link,$sql_parcela);
			$codigo_socio=mysqli_fetch_array($res,MYSQLI_ASSOC);

$datos_socio=nombre_socio($codigo_socio["id_socio"]);
echo "<div id=imprimir><div align=center>";
//echo "<div align=center><h2>ANÁLISIS</h2><br>";
echo "<table class=tablas>";
echo "<tr><th colspan=4><h3>Datos generales</h3></th></tr>";

//echo "<tr><th align=right><h4>Id Parcela</th><td><h4>".$_GET["parcela"]."</td></tr>";	
//echo "<tr><th align=right><h4>Id SubParcela</th><td><h4>".$datos["id_subparcela"]."</td></tr>";	

echo "<tr><th align=right><h4>Socio</th><td colspan=3><h4>".$datos_socio["nombres"]." ".$datos_socio["apellidos"]." (".$codigo_socio["id_socio"].")</h4></td></tr>";	
echo "<tr><th align=right><h4>Fecha</th><td colspan=3><h4>".$datos["fecha"]."</h4></td></tr>";	
echo "<tr><th align=right><h4>Muestra</th><td><h4>".$datos["muestra"]."</h4></td>";	
echo "<th align=right><h4>Número de submuestras</th><td><h4>".$datos["submuestras"]."</h4></td></tr>";	
echo "<tr><th align=right><h4>Estructura</th><td><h4>".$datos["estructura"]."</h4></td>";
echo "<th align=right><h4>Grado</th><td><h4>".$datos["grado"]."</h4></td></tr>";
echo "<tr><th align=right><h4>Rocas</th><td colspan=3><h4>".$datos["rocas"]."</h4>%</td></tr>";	
echo "<tr><th align=right><h4>Tamaño rocas</th><td colspan=3><h4>".$datos["rocas_size"]."</h4>cm</td></tr>";	
echo "<tr><th align=right><h4>Profundidad de suelo</th><td colspan=3><h4>".$datos["profundidad"]."</h4>cm</td></tr>";	
echo "<tr><th align=right><h4>Pendiente</th><td colspan=3><h4>".$datos["pendiente"]."</h4>%</td></tr>";	
echo "<tr><th align=right><h4>Presencia de lombrices</th><td colspan=3><h4>".yes_no($datos["lombrices"])."</h4></td></tr>";	
echo "<tr><th align=right><h4>Densidad aparente</th><td colspan=3><h4>".$datos["densidad_aparente"]."</h4>gr/cm<sup>3</sup></td></tr>";	
echo "<tr><th align=right><h4>Observaciones</th><td colspan=3><h4>".$datos["observaciones"]."</h4></td></tr>";	

echo "<tr><th colspan=4><h3>Análisis de suelo</h3></th></tr>";
echo "<tr><th align=right><h4>pH</th><td colspan=3><h4>".$datos["s_ph"]."</h4></td></tr>";	
echo "<tr><th align=right><h4>N</th><td colspan=3><h4>".$datos["s_n"]."</h4>%</td></tr>";	
echo "<tr><th align=right><h4>P</th><td colspan=3><h4>".$datos["s_p"]."</h4>ppm</td></tr>";	
echo "<tr><th align=right><h4>K</th><td colspan=3><h4>".$datos["s_k"]."</h4>cmol/kg</td></tr>";	
echo "<tr><th align=right><h4>Ca</th><td colspan=3><h4>".$datos["s_ca"]."</h4>cmol/kg</td></tr>";	
echo "<tr><th align=right><h4>Mg</th><td colspan=3><h4>".$datos["s_mg"]."</h4>cmol/kg</td></tr>";	
echo "<tr><th align=right><h4>Materia Orgánica</th><td colspan=3><h4>".$datos["s_mo"]."</h4>%</td></tr>";	
echo "<tr><th align=right><h4>Textura</th><td colspan=3><h4>".$datos["s_textura"]."</h4></td></tr>";


echo "<tr><th colspan=4><h3>Análisis foliar</h3></th></tr>";
echo "<tr><th align=right><h4>N</th><td colspan=3><h4>".$datos["f_n"]."</h4>%</td></tr>";	
echo "<tr><th align=right><h4>P</th><td colspan=3><h4>".$datos["f_p"]."</h4>ppm</td></tr>";	
echo "<tr><th align=right><h4>K</th><td colspan=3><h4>".$datos["f_k"]."</h4>cmol/kg</td></tr>";	

echo "</table><br>";
//**********TABLA AUTOMATICA*****************************************************************

echo "</div>";
echo "</div>";
?>
<div align=center><a href="javascript:imprimir('imprimir')"><img width=25 src=images/imprimir.png><br><h6>Imprimir ficha</a></div>
<?php
echo "<div align=center>";

echo "<a href=analisis.php?subparcela=".$datos["id_subparcela"]."&parcela=".$_GET["parcela"]."><button class=boton>volver</button></a>";
echo "</div>";
}

include("pie.php");

?>