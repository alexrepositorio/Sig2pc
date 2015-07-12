<html>
  <head>
    <title>SIG2PC</title>
    <link rel="stylesheet" type="text/css" href="style.css">
	<link rel="shortcut icon" href="images/cafetico.ico" />
	<link rel="icon" type="image/vnd.microsoft.icon" href="images/cafetico.ico" />
<meta http-equiv=" pragma" content=" no-cache" > 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

<?php
include("titulo.html");
include("uno.php");
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
echo"</div><hr>";
?>

