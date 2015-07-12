<html>
  <head>
    <title>SIG2PC</title>
    <link rel="stylesheet" type="text/css" href="style.css">
	 <link rel="stylesheet" type="text/css" href="styleprint.css" media="print">
	<link rel="shortcut icon" href="images/cafetico.ico" />
	<link rel="icon" type="image/vnd.microsoft.icon" href="images/cafetico.ico" />
<meta http-equiv=" pragma" content=" no-cache" > 
<meta http-equiv="Content-Type" content="text/html;" />
<meta charset="UTF-8">
</head>

    <!-- Arquivos utilizados pelo jQuery lightBox plugin -->
    <!--<script type="text/javascript" src="LB/js/jquery.js"></script>-->
    <script type="text/javascript" src="LB/js/jquery-1.7.2.min.js"></script>
    <!--<script type="text/javascript" src="LB/js/jquery.lightbox-0.5.js"></script>-->
    <script type="text/javascript" src="LB/js/lightbox.js"></script>
    <!--<link rel="stylesheet" type="text/css" href="LB/css/jquery.lightbox-0.5.css" media="screen" />-->
    <link rel="stylesheet" type="text/css" href="LB/css/lightbox.css" media="screen" />
    <!-- / fim dos arquivos utilizados pelo jQuery lightBox plugin -->
    <script src="jquery.min.js"></script>
    <script src="pag.js"></script>
<script>
        $(document).ready(function() {
            $('#table_id').oneSimpleTablePagination({ rowsPerPage:10, topNav:false, floatingHeader: false});
        });
    </script>



<script type="text/javascript">
function imprimir(id)
    {

        var div, imp;
        div = document.getElementById(id);//seleccionamos el objeto
        imp = window.open(" ","Formato de Impresion"); //damos un titulo
        imp.document.open();     //abrimos
        imp.document.write('<title>SIG2PC v0.2</title>'); //tambien podriamos agregarle un <link ...
        imp.document.write('<link rel="stylesheet" type="text/css" href="styleprint.css">'); //tambien podriamos agregarle un <link ...
		imp.document.write('<div align=center><titulo>SIG2PC</titulo><font size=2><i>V0.2beta</i></font><br><subtitulo>Sistema Integrado de Gestión Productiva Cafetalera</subtitulo></div>');
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
include ("uno.php");
include ("historial_funciones.php");
session_start();
if (empty($_SESSION)) {
   header ('Location: login.php');
    exit (0); 
}
echo " <form name=form action=".$_SERVER['PHP_SELF']." method='post'>
<div align=left><h4><font size=2>¡Bienvenido ". $_SESSION['user']."! </font><font size=1>(".nivel($_SESSION['acceso']).")</font>
<button type='submit' name='logout' value='salir'>
  <img src=images/exit.png width=15>
</button>";
if (isset($_POST['logout'])) {
   logout();
}
echo "</form>";
echo"</div><hr>";
include ("menu.php");
?>