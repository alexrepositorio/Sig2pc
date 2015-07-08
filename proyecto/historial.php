<?php
	include ("cabecera.php");
	include ("conect.php");
	if(!isset($_GET["criterio"]))
	{
	$_POST["busca"]="";
	$criterio="";
	$encontrados="";
	$SQL="SELECT * FROM historial order by fecha desc";

	}else{
		if(isset($_GET["socio"])){$_POST["busca"]=$_GET["socio"];}
		$encontrados="ENCONTRADAS";
		switch ($_GET["criterio"])
			{
			case "usuario":
				$SQL="SELECT * FROM historial WHERE usuario = '".$_POST["busca"]."' order by fecha desc";
				$_texto=$_POST["busca"];
				break;
			case "fecha":
				$SQL="SELECT * FROM historial WHERE date_format(fecha,'%Y-%m-%d') = '".$_POST["busca"]."' order by fecha asc";
				$_texto=$_POST["busca"];
				break;		
			}
	$criterio="<h4>Criterio de búsqueda: <b>".$_GET["criterio"]."</b> es <i>''$_texto''</i></h4>";}
                       
	$resultado=mysqli_query($link, $SQL);
	$cuenta=mysqli_num_rows($resultado);
	while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
		$acciones[]=$row;
	}

	echo "<div align=center><h1>Historial de acciones</h1><br><br>";
	echo "<table width=700px border=0 cellpadding=0 cellspacing=0><tr>";
	
	echo "<td align=center><h4>Usuario<br><form name=form1 action=".$_SERVER['PHP_SELF']."?criterio=usuario method='post'>";
	echo "<select name=busca>";
	$sql_socios="SELECT user FROM usuarios ORDER BY user ASC";
	$r_socio=mysqli_query($link, $sql_socios);
	while ($rowsocio = mysqli_fetch_array($r_socio,MYSQLI_ASSOC)){;echo "<option value='".$rowsocio["user"]."'>".$rowsocio["user"]."</option>";}
	echo "</select><br>";
	echo "<input type='submit' value='buscar'>";
	echo "</form></td>";

	echo "<td align=center><h4>Fecha<br><form name=form3 action=".$_SERVER['PHP_SELF']."?criterio=fecha method='post'>";
	echo "<select name=busca>";
	$sql_fecha="SELECT DISTINCT date_format(fecha,'%Y-%m-%d') as fecha FROM historial ORDER BY fecha ASC";
	$r_fec=mysqli_query($link, $sql_fecha);
	while ($rowfec = mysqli_fetch_array($r_fec,MYSQLI_ASSOC)){$fecha=$rowfec["fecha"];echo "<option value='$fecha'>$fecha</option>";}
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
	}
	echo "</table></div>";
	include("pie.php");

?>