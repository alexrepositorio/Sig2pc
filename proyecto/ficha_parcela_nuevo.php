<?php
include ("cabecera.php");
$riegos=Array("Aspersión","Goteo","Gravedad","Ninguno");
if(isset ($_POST["id_socio"])){
$SQL_edit="INSERT INTO parcelas VALUES ('','".$_POST["id_socio"]."','".$_POST["coorX"]."','".$_POST["coorY"]."','".$_POST["alti"]."',
				'".$_POST["sup_total"]."','".$_POST["MOcontratada"]."','".$_POST["MOfamiliar"]."','".$_POST["Miembros_familia"]."',
				'".$_POST["riego"]."')";
				
$resultado=mysqli_query($link, $SQL_edit);
$nuevo_id=mysqli_insert_id($link);

$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);


echo "<div align=center><h1>GUARDANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=ficha_parcela.php?parcela=".$nuevo_id."'></font></h1></div>";
	
}


else{

//**********TABLA AUTOMATICA*****************************************************************

echo "<div align=center><h2>NUEVA PARCELA</h2><br><table class=tablas>";
echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";

echo "<tr><th align=right><h4>Socio</th><td><h4>";
echo "<select name=id_socio>";
		//$sql_socios="SELECT socios.id_socio, socios.nombres, socios.apellidos, socios.codigo, COUNT(lotes.id) FROM socios LEFT JOIN lotes ON socios.codigo=lotes.id_socio GROUP BY socios.id_socio ORDER BY codigo ASC";
		$sql_socios="SELECT socios.*, COUNT(parcelas.id) as parcelas FROM socios
		LEFT JOIN parcelas on socios.codigo=parcelas.id_socio
		GROUP BY socios.codigo ORDER BY socios.codigo";
		$r_socio=mysqli_query($link, $sql_socios);
		while ($rowsocio = mysqli_fetch_array($r_socio,MYSQLI_ASSOC))
		{
			if($rowsocio["parcelas"]>0){
				if($rowsocio["parcelas"]>1){$lotes_t="parcelas";}else{$lotes_t="parcela";}
				$lotess="(".$rowsocio["parcelas"]." $lotes_t)";
				$mark="style='background-color:skyblue; color:blue;'";
			}else{$mark="";$lotess="";}
			$socio_n=$rowsocio["codigo"]."-".$rowsocio["apellidos"].", ".$rowsocio["nombres"]." $lotess";
			echo "<option $mark value='".$rowsocio["codigo"]."'>$socio_n</option>";
		}
echo "</select><br>";


echo "<tr><th align=right><h4>Superficie Finca</th><td><h4><input type=text name=sup_total size=3></h4>ha</td></tr>";	
echo "<tr><th align=right><h4>Coordenada X</th><td><h4><input type=text name=coorX size=10></h4></td></tr>";	
echo "<tr><th align=right><h4>Coordenada Y</th><td><h4><input type=text name=coorY size=10></h4></td></tr>";	
echo "<tr><th align=right><h4>Altitud</th><td><h4><input type=text name=alti size=3></h4>msnm</td></tr>";	
echo "<tr><th align=right><h4>Riego</th><td><h4><select name=riego>";
	foreach($riegos as $riego){
		echo "<option value=$riego>$riego</option>";
	}
echo "</select></h4></td></tr>";
echo "<tr><th align=right><h4>Mano de Obra Contratada</th><td><h4><input type=text name=MOcontratada size=3></h4></td></tr>";	
echo "<tr><th align=right><h4>Mano de Obra Familiar</th><td><h4><input type=text name=MOfamiliar size=3></h4></td></tr>";	
echo "<tr><th align=right><h4>Miembros de la Familia</th><td><h4><input type=text name=Miembros_familia size=3></h4></td></tr>";	

echo "</table><br>";
//**********TABLA AUTOMATICA*****************************************************************
echo "<input type='submit' value='Guardar'>";
echo "</form></div>";

}
include("pie.php");

?>