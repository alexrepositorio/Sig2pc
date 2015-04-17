<html>
  <head>
    <title>SIG2PC</title>
    <link rel="stylesheet" type="text/css" href="style.css">
	<link rel="stylesheet" type="text/css" href="styleprint.css" media="print">
	<link rel="shortcut icon" href="images/cafetico.ico" />
	<link rel="icon" type="image/vnd.microsoft.icon" href="images/cafetico.ico" />
<meta http-equiv=" pragma" content=" no-cache" > 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

    <!-- Arquivos utilizados pelo jQuery lightBox plugin -->
    <!--<script type="text/javascript" src="LB/js/jquery.js"></script>-->
    <script type="text/javascript" src="LB/js/jquery-1.7.2.min.js"></script>
    <!--<script type="text/javascript" src="LB/js/jquery.lightbox-0.5.js"></script>-->
    <script type="text/javascript" src="LB/js/lightbox.js"></script>
    <!--<link rel="stylesheet" type="text/css" href="LB/css/jquery.lightbox-0.5.css" media="screen" />-->
    <link rel="stylesheet" type="text/css" href="LB/css/lightbox.css" media="screen" />
    <!-- / fim dos arquivos utilizados pelo jQuery lightBox plugin -->

<script type="text/javascript">
function imprimir(id)
    {
<?php
//****************PARAMETROS DE CONFIGURACION************************
$link = mysqli_connect("localhost", "root", "", "sig");
$SQL_conf="SELECT * FROM configuracion";
$res_conf=mysqli_query($link, $SQL_conf);
while($configuraciones = mysqli_fetch_array($res_conf,MYSQLI_ASSOC)){
	$parametro=$configuraciones["parametro"];
	$config[$parametro]=$configuraciones["valor"];
	}
//*******************************************************************
?>

        var div, imp;
        div = document.getElementById(id);//seleccionamos el objeto
        imp = window.open(" ","Formato de Impresion"); //damos un titulo
        imp.document.open();     //abrimos
        imp.document.write('<title>SIG2PC v0.2</title>'); //tambien podriamos agregarle un <link ...
        imp.document.write('<link rel="stylesheet" type="text/css" href="styleprint.css">'); //tambien podriamos agregarle un <link ...
		imp.document.write('<div align=center><titulo>SIG2PC</titulo><font size=2><i>V0.2beta</i></font><br><subtitulo>Sistema Integrado de Gestión Productiva Cafetalera</subtitulo></div>');
		imp.document.write('<div align=center><subtitulo><font color=red><?php echo $config["nombre_asociacion"];?></font></subtitulo></div><hr>');
        imp.document.write(div.innerHTML);//agregamos el objeto
        imp.document.write('<hr><div align=center><table border=0><tr>');
		imp.document.write('<td><img height=30 src=images/apecap.png></td>');
		imp.document.write('<td><img height=30 src=images/utpl.jpg></td>');
		imp.document.write('<td><img height=30 src=images/prometeo.png></td>');
		imp.document.write('<td><img height=30 src=images/swiss.jpg></td>');
		imp.document.write('</tr></table><hr>');//agregamos el objeto
        imp.document.close();
        imp.print();   //Abrimos la opcion de imprimir
        imp.close(); //cerramos la ventana nueva
    }</script>

<?php
include("titulo.html");
ini_set('error_reporting', E_ALL);
error_reporting(E_ALL);
ini_set('display_errors', '1');
include("uno.php");

if (isset($_COOKIE['username']) && isset($_COOKIE['password']) && isset($_COOKIE["acceso"])) 
{
echo "<div align=left><h4><font size=2>¡Bienvenido ". $_COOKIE['username']."! </font><font size=1>(".nivel($_COOKIE['acceso']).")</font></h4> <a title=salir href=logout.php><img src=images/exit.png width=15></a></div><hr>";
}

include("menu.php");

if (empty($_COOKIE['username']) || empty($_COOKIE['password']) || empty($_COOKIE["acceso"])) 
{
header('Location: login.php');
}

?>