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

echo "Bienvenido ".$_SESSION["user"];

echo " <form name=form action=".$_SERVER['PHP_SELF']." method='post'>
<input type='submit' class='button' name='logout' value='logout' onclick='logout()'/>";
if (isset($_POST['logout'])) {
   logout();
}
?>

