<?php
include ("cabecera.php");

if(isset ($_GET["user"]) AND isset($_GET["borra"])){
	
$SQL_edit="DELETE FROM usuarios WHERE id='".$_GET["borra"]."'";
$resultado=mysqli_query($link, $SQL_edit);

$cadena=str_replace("'", "", $SQL_edit);
guarda_historial($cadena);
//echo "$SQL_edit";

echo "<div align=center><h1>BORRANDO, ESPERA...
<meta http-equiv='Refresh' content='2;url=usuarios.php'></font></h1></div>";
	
}


else{
	

$tipos=array(1=>"Administrador",2=>"Contable",3=>"Bodeguero",4=>"Socio",5=>"Catador");

//muestra_array($socio);
$SQL="SELECT * FROM usuarios where id='".$_GET["user"]."'";
$resultado=mysqli_query($link, $SQL);
$user = mysqli_fetch_array($resultado,MYSQLI_ASSOC);

echo "<div align=center><h1>Borrar el usuario</h1><br><h2>".$user["user"]."<br> tipo:".$tipos[$user["nivel"]]."<br><br>";

echo "<notif>¿ESTA SEGURO?</notif><br><br>";

echo "<table class=tablas><tr>";
echo "<td width=50%><a href=ficha_user_borrar.php?user=".$_GET["user"]."&borra=".$_GET["user"]."><notifsi>SI</notifsi></a></td>";
echo "<td width=50%><a href=usuarios.php><notifno>NO</notifno></a></td>";
echo "</tr></table>";

}
include("pie.php");
?>