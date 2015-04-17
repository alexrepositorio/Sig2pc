<?php
include ("cabecera.php");

if(!isset($_GET["criterio"]))
{
	$_POST["busca"]="";
	$criterio="";
	$encontrados="";
	$SQL="SELECT `nombres`, `apellidos`, `codigo`, `cedula`, `genero`,grupo FROM socios,persona,grupos
	 WHERE socios.id_persona=persona.id_persona and socios.id_grupo=grupos.id 
	 order by apellidos";

}else{
	
		switch ($_GET["criterio"])
			{
			case "nombres":
				$SQL="SELECT * FROM socios WHERE nombres like '%".$_POST["busca"]."%' OR apellidos like '%".$_POST["busca"]."%' order by apellidos asc";
				break;
			case "localidad":
				$SQL="SELECT * FROM socios WHERE poblacion = '".$_POST["busca"]."' order by apellidos asc";
				break;
			case "canton":
				$SQL="SELECT * FROM socios WHERE canton like '%".$_POST["busca"]."%' order by apellidos asc";
				break;		
			case "organico":
				if($_GET["opcion"]=="si"){
				$SQL="SELECT * FROM socios LEFT JOIN (SELECT id_socio, year, estatus FROM certificacion WHERE year=(SELECT MAX(year) FROM certificacion i WHERE i.id_socio = certificacion.id_socio)) t on socios.codigo=t.id_socio WHERE t.estatus='O'";
				$_POST["busca"]="CON certificación Orgánica";
				}
				elseif($_GET["opcion"]=="no"){
				$SQL="SELECT * FROM socios LEFT JOIN (SELECT id_socio, year, estatus FROM certificacion WHERE year=(SELECT MAX(year) FROM certificacion i WHERE i.id_socio = certificacion.id_socio)) t on socios.codigo=t.id_socio WHERE t.estatus<>'O'";
				$_POST["busca"]="SIN certificación Orgánica";
				}
				break;		
			}
	$encontrados="ENCONTRADOS";
	$criterio="<h4>Criterio de búsqueda <b>".$_GET["criterio"]."</b> es <i>\"".$_POST["busca"]."\"</i></h4>";
	
}

                            
$resultado=mysqli_query($link, $SQL);
$cuenta=mysqli_num_rows($resultado);
while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
$socios_altas[$row["codigo"]]=altas_bajas($row["codigo"]);

if(count($socios_altas[$row["codigo"]])>0){$ultimokey=max(array_keys($socios_altas[$row["codigo"]]));}else{$ultimokey="";}

if($socios_altas[$row["codigo"]][$ultimokey]["estado"]=="ingreso"){$row["estado"]="ingreso";$socios_activos[]=$row;}
	$socios[]=$row;

}
if(isset($socios_activos)){
$socios_activos_cuenta=count($socios_activos);}else{$socios_activos_cuenta=0;}
//muestra_array($socios_altas);

//muestra_array($socios);
/*
if(isset($_GET["separa"])){
	foreach ($socios as $persona){
		$nombrescompletos="";
		echo "<b>".$persona["nombres"];
		$nombres=explode(" ",$persona["nombres"]);
		echo "&nbsp&nbsp&nbsp&nbsp&nbsp Apellidos : ".$nombres[0]." ".$nombres[1]." ";
		$apellidoscompletos=$nombres[0]." ".$nombres[1];
		foreach ($nombres as $key=>$partes){if($key>1){$nombrescompletos=$nombrescompletos." ".$partes;}}
		//$nombrescompletos=$nombres[2]." ".$nombres[3]." ".$nombres[4];
		echo "&nbsp&nbsp&nbsp&nbsp&nbsp Nombres : $nombrescompletos</b><br>";
		$apellidoscompletos=ucwords(strtolower($apellidoscompletos));
		$nombrescompletos=ucwords(strtolower($nombrescompletos));
		$SQL_update="UPDATE socios SET apellidos='$apellidoscompletos', nombres='$nombrescompletos' WHERE id_socio=".$persona["id_socio"];
		echo $SQL_update."<br>";
		$resultado=mysqli_query($link, $SQL_update);
	}	
}
*/

echo "<div align=center><h1>Listado de socios</h1><br><br>";
echo "<table border=0 cellpadding=15 cellspacing=0><tr>";

echo "<td align=center><a href=socios.php?criterio=organico&opcion=si>";
echo "<img src=images/organico.png width=50><br><h4>Orgánicos</a>";
echo "</td>";

echo "<td align=center><a href=socios.php?criterio=organico&opcion=no>";
echo "<img src=images/noorganico.png width=50><br><h4>No Orgánicos</a>";
echo "</td>";



echo "<td align=center><h4>Nombre y apellidos<br>

<form name=form1 action=".$_SERVER['PHP_SELF']."?criterio=nombres method='post'>";
echo "<input type='text' name=busca><br>";
echo "<input type='submit' value='buscar'>";
echo "</form></td>";

echo "<td align=center><h4>Localidad<br><form name=form2 action=".$_SERVER['PHP_SELF']."?criterio=localidad method='post'>";
echo "<select name=busca>";
$sql_localidad="SELECT DISTINCT(grupo) as grupo FROM GRUPOS ORDER BY grupo ASC";
$r_loc=mysqli_query($link, $sql_localidad);
while ($rowloc = mysqli_fetch_array($r_loc,MYSQLI_ASSOC)){$localidad=$rowloc["grupo"];echo "<option value='$localidad'>$localidad</option>";}
echo "</select><br>";
echo "<input type='submit' value='filtrar'>";
echo "</form></td>";

if(in_array($_COOKIE['acceso'],$permisos_administrativos)){
echo "<td align=center><a href=ficha_socio_nuevo.php>";
echo "<img src=images/user_new.png width=50><br><h4>nuevo</a>";
echo "</td>";
}

if(in_array($_COOKIE['acceso'],$permisos_administrativos)){
echo "<td align=center><a href=actualizar_entregados.php>";
echo "<img src=images/refresh.png width=30><br><h4>Actualizar<br>todos<br>entregados</a>";
echo "</td>";
}

if(in_array($_COOKIE['acceso'],$permisos_administrativos)){
echo "<td align=center><a href=grupos.php>";
echo "<img src=images/grupos_admin.png width=40><br><h4>Administrar<br>grupos</a>";
echo "</td>";
}

echo "</tr></table>";

echo "<br><br><div align=center>$criterio<br>";
echo "<table class=tablas>";
	echo "<tr><th colspan=2 width=500px>";
	echo "<h4>SOCIOS $encontrados ($socios_activos_cuenta activos)</h4>";
	echo "</th>";
															echo "<th width=20px><h6>estados</h6></th>";
if(in_array($_COOKIE['acceso'],$permisos_administrativos)){	echo "<th width=20px><h6>opciones</h6></th>";}
if(in_array($_COOKIE['acceso'],$permisos_administrativos)){	echo "<th width=20px><h6>avisos</h6></th></tr>";}

if(isset($socios))
{
	foreach ($socios as $socio)
	{
//aviso de falta de información
if($socio["nombres"]=="" || 
   $socio["apellidos"]=="" || 
   $socio["codigo"]=="" || 
   $socio["cedula"]=="" || 
   $socio["celular"]=="" || 
   $socio["f_nacimiento"]=="" || 
   $socio["email"]=="" || 
   $socio["direccion"]=="" || 
   $socio["poblacion"]=="" || 
   $socio["canton"]=="" || 
   $socio["provincia"]=="")	{$aviso="<img title='Información incompleta del socio&#13;edite para completar' width=20 src=images/info.png>";}else{$aviso="";}
if($socio["foto"]=="")		{$aviso_f="<a href=galery2.php?socio=".$socio["id_socio"]."><img title='Socio sin fotografía &#13;click para agregar' width=20 src=images/no_foto.png></a>";}else{$aviso_f="";}


//ultimo estado de alta y ultima certificacion


$estatus=certificacion($socio["codigo"]);
if(isset($estatus)){
	$estatus_actual=max(array_keys($estatus));
	if($estatus[$estatus_actual]["estatus"]=="O"){$estatus_t="<img title='socio CON certificación orgánica' src=images/organico.png width=25>";}else{$estatus_t="<img title='socio SIN certificación orgánica' src=images/noorganico.png width=25>";}
}else{$estatus_t="<img title='datos de certificación desconocidos' src=images/interrogacion.png width=25>";}
$altas=altas_bajas($socio["codigo"]);
//muestra_array($altas);
if(isset($altas)){$ultimafecha=max(array_keys($altas));
		if($altas[$ultimafecha]["year"]==0){$altas[$ultimafecha]["year"]="<i>\"fecha desconocida\"</i>";}else{$altas[$ultimafecha]["year"]=date("d-m-Y",strtotime($altas[$ultimafecha]["year"]));}
		if($altas[$ultimafecha]["estado"]=="salida"){$altas_t="<img title='socio con salida el ".$altas[$ultimafecha]["year"]."' src=images/denied.png width=25>";}else{$altas_t="";}
}
else{$altas_t="<img title='datos de ingreso desconocidos' src=images/interrogacion.png width=25>";}


															echo "<tr><th>".$socio["codigo"]."</th>";
															echo "<td><a href=ficha_socio.php?socio=".$socio["codigo"]."><h4>".$socio["apellidos"]. ", " .$socio["nombres"];
															echo "</td>";
															echo "<td align=center>$estatus_t $altas_t</td>";
if(in_array($_COOKIE['acceso'],$permisos_administrativos)){	echo "<td align=center>";}
if(in_array($_COOKIE['acceso'],$permisos_administrativos)){	echo "<a href=ficha_socio_editar.php?socio=".$socio["id_socio"]."><img title=editar src=images/user_edit.png width=25></a>";}
		//echo "<a href=ficha_socio_borrar.php?socio=".$socio["id_socio"]."><img title=borrar src=images/user_delete.png width=25></a>";
if(in_array($_COOKIE['acceso'],$permisos_administrativos)){	echo "</td>";}
if(in_array($_COOKIE['acceso'],$permisos_administrativos)){	echo "<td>$aviso $aviso_f</td></tr>";}
	}
}
echo "</table></div>";


include("pie.php");

?>