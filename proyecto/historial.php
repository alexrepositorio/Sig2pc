<?php
	include ("cabecera.php");
	include ("users_funciones.php");
	if(!isset($_GET["criterio"]))
	{
	$_POST["busca"]="";
	$criterio="";
	$encontrados="";
	$resultado=historial_cons('','');
	}else{
		if(isset($_GET["socio"])){
			$_POST["busca"]=$_GET["socio"];
		}
		if (isset($_POST["busca"])) {
			$resultado=historial_cons($_GET["criterio"],$_POST["busca"]);
			$encontrados="ENCONTRADAS";
			$_texto=$_POST["busca"];
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
	
	echo "<td align=center><h4>Usuario<br><form name=form1 action=".$_SERVER['PHP_SELF']."?criterio=usuario method='post'>";
	echo "<select name=busca>";
	$r_socio=consultarCriterio('');
	foreach ($r_socio as $rowsocio) {
		echo "<option value='".$rowsocio["user"]."'>".$rowsocio["user"]."</option>";
	}
	echo "</select><br>";
	echo "<input type='submit' value='buscar'>";
	echo "</form></td>";

	echo "<td align=center><h4>Fecha<br><form name=form3 action=".$_SERVER['PHP_SELF']."?criterio=fecha method='post'>";
	echo "<select name=busca>";
	$r_fec=consultarCriterio('fecha');
	foreach ($r_fec as $rowfec) {
		$fecha=$rowfec["fecha"];echo "<option value='$fecha'>$fecha</option>";
	}
	echo "</select><br>";
	echo "<input type='submit' value='filtrar'>";
	echo "</form></td>";

	echo "</tr></table>";
	echo "<br><br><div align=center>$criterio<br>";
	echo "<br><br><div align=center>TOTAL $encontrados ($cuenta)<br>";
	
	echo "<table class=tablas width=60%>";
	
		echo "<tr><th>";
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
		echo "</th>
		</tr>";
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