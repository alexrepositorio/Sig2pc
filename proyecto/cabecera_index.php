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

if (isset($_COOKIE['username']) && isset($_COOKIE['password']) && isset($_COOKIE["acceso"])) 
{
echo "<div align=left><h4><font size=2>¡Bienvenido ". $_COOKIE['username']."! </font><font size=1>(".nivel($_COOKIE['acceso']).")</font></h4> <a title=salir href=logout.php><img src=images/exit.png width=15></a></div><hr>";
}



if (empty($_COOKIE['username']) || empty($_COOKIE['password']) || empty($_COOKIE["acceso"])) 
{
header('Location: login.php');
}
//compruebo la cookie y si no, include ("login.php") o redirect a index
?>

