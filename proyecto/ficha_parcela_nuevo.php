<?php
include ("cabecera.php");
include ("parcelas_funciones.php");
include ("socio_funciones.php");
$riegos=Array("Aspersión","Goteo","Gravedad","Ninguno");

if(isset ($_POST["id_socio"])){

	insertar_parcela($_POST["id_socio"],$_POST["coorX"],$_POST["coorY"],$_POST["alti"],$_POST["sup_total"],$_POST["MOcontratada"],
		$_POST["MOfamiliar"],$_POST["Miembros_familia"],$_POST["riego"]);
echo "<div align=center><h1>ACTUALIZANDO, ESPERA...
	<meta http-equiv='Refresh' content='2;url=parcelas.php'></font></h1></div>";	

}else{

//**********TABLA AUTOMATICA*****************************************************************

echo "<div align=center><h2>NUEVA PARCELA</h2><br><table class=tablas>";
echo "<form name=form action=".$_SERVER['PHP_SELF']." method='post'>";
echo "<tr><th align=right><h4>Socio</th><td><h4>";
echo "<select name=id_socio>";
$lista=consultarCriterio('parcelas','');
		foreach ($lista as $elemento) {
			if($elemento["parcelas"]>0){
				if($elemento["parcelas"]>1){
					$lotes_t="parcelas";}
					else{
						$lotes_t="parcela";
					}
				$lotess="(".$elemento["parcelas"]." $lotes_t)";
				$mark="style='background-color:skyblue; color:blue;'";
			}else{$mark="";$lotess="";
		}
			$socio_n=$elemento["codigo"]."-".$elemento["apellidos"].", ".$elemento["nombres"]." $lotess";
			echo "<option value=".$elemento["id_socio"].">$socio_n</option>";
			
	}
	echo "</select><br>";


	echo "<tr><th align=right><h4>Superficie Finca</th><td><h4><input type=number step=0.01 min=0 name=sup_total size=3></h4>ha</td></tr>";	
	echo "<tr><th align=right><h4>Coordenada X</th><td><h4><input type=number name=coorX size=10></h4></td></tr>";	
	echo "<tr><th align=right><h4>Coordenada Y</th><td><h4><input type=number name=coorY size=10></h4></td></tr>";	
	echo "<tr><th align=right><h4>Altitud</th><td><h4><input type=number name=alti size=3></h4>msnm</td></tr>";	
	echo "<tr><th align=right><h4>Riego</th><td><h4><select name=riego>";
		foreach($riegos as $riego){
			echo "<option value=$riego>$riego</option>";
		}
	echo "</select></h4></td></tr>";
	echo "<tr><th align=right><h4>Mano de Obra Contratada</th><td><h4><input type=number name=MOcontratada size=3></h4></td></tr>";	
	echo "<tr><th align=right><h4>Mano de Obra Familiar</th><td><h4><input type=number name=MOfamiliar size=3></h4></td></tr>";	
	echo "<tr><th align=right><h4>Miembros de la Familia</th><td><h4><input type=number name=Miembros_familia size=3></h4></td></tr>";	

	echo "</table><br>";
	//**********TABLA AUTOMATICA*****************************************************************
	echo "<input type='submit' value='Guardar'>";
	echo "</form></div>";

}
include("pie.php");

?>