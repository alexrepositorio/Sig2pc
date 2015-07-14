<?php
	include ("cabecera.php");
	include ("users_funciones.php");
	if(!isset($_GET["criterio"]))
	{
	$_POST["busca"]="";
	$criterio="";
	$encontrados="";
	$resultado=historial_cons('','','');
	}else{
		if(isset($_GET["socio"])){
			$_POST["busca"]=$_GET["socio"];
		}
		if (isset($_POST["busca"])) {
			if (isset($_POST["busca2"])) {
				$resultado=historial_cons($_GET["criterio"],$_POST["busca"],$_POST["busca2"]);
				$encontrados="ENCONTRADAS";
				$_texto= "Desde: ".$_POST["busca"]."  Hasta:".$_POST["busca2"]."";
			}else{
				$resultado=historial_cons($_GET["criterio"],$_POST["busca"],'');
				$encontrados="ENCONTRADAS";
				$_texto=$_POST["busca"];
			}
			
		}

	$criterio="<h4>Criterio de búsqueda: <b>".$_GET["criterio"]."</b> es <i>''$_texto''</i></h4>";}
                       
	if (is_array($resultado)) {
		$cuenta=count($resultado);
		foreach ($resultado as $row) {
			$acciones[]=$row;
		}
	}else{
		$cuenta=$resultado;
	}

	echo "<div align=center><h1>Historial de acciones</h1><br><br>";
	echo "<table width=700px border=0 cellpadding=0 cellspacing=0><tr>";
	echo "<td align=center><h4>Fecha<br>
	<form name=form3 action=".$_SERVER['PHP_SELF']."?criterio=fecha method='post'>";
	echo "
		<label for='desde'>Desde:</label>
		<input type='date' name='busca' id='desde' >
		<label for='hasta'>Hasta:</label>
		<input type='date' name='busca2' id='hasta'>
	";
	echo "<input type='submit' value='filtrar'>";
	echo "</form></td>";
	echo "<td align=center><h4>Usuario<br><form name=form1 action=".$_SERVER['PHP_SELF']."?criterio=usuario method='post'>";
	echo "<select name=busca>";
	$r_socio=consultarCriterio('');
	foreach ($r_socio as $rowsocio) {
		echo "<option value='".$rowsocio["user"]."'>".$rowsocio["user"]."</option>";
	}
	echo "</select><br>";
	echo "<input type='submit' value='buscar'>";
	echo "</form></td>";

	echo "</tr></table>";
	echo "<br><br><div align=center>$criterio<br>";
	echo "<br><br><div align=center><h4>TOTAL $encontrados ($cuenta)</h4><br>";
	
	echo "<table id='table_id' style='width: 80%' class='tablas' posicion>";
	echo "<thead>";
	echo "<th>";
		echo "<h4>Fecha</h4>";
		echo "</th>
		<th>";
		echo "<h4>Usuario</h4>";
		echo "</th>
		<th>";
		echo "<h4>Accion</h4>";
		echo "</th>";
		echo "<th>";
		echo "<h4>Datos </h4>";
		echo "</th>";
		echo "<th>";
		echo "<h4>Tabla</h4>";
		echo "</th>";
		echo "<th>";
		echo "<h4>Maquina</h4>";
		echo "</th>";
	echo "</thead>";
	echo "<tbody>";
		
	if(isset($acciones))
	{
		foreach ($acciones as $accion)
		{
			echo "<tr>";
				echo "<td><h4>".date("d-m-Y H:i",strtotime($accion["fecha"]))."</td>";
				echo "<td><h4><b><font size=4>".$accion["usuario"]."</b></font><br></td>";
				echo "<td><br><font size=3>".$accion["accion"]."<br></font><br></td>";
				echo "<td><br><font size=3>".$accion["datos"]."</font><br></td>";
				echo "<td><br><font size=3>".$accion["tabla"]."</font><br></td>";
				echo "<td><br><font size=3>".$accion["maquina"]."</font><br></td>";
			echo "</tr>";
		}
	}else{
		echo "<tr>";		
				echo "<td><br><font size=3>SIN DATOS<br></font><br></td>";		
			echo "</tr>";
	}
	echo "</table></div>";
	include("pie.php");

?>