<?php
include("cabecera_login.php");
include("conect.php");

$sql_listar="select validar('jnperez','12345') as estado;";
$res_sql=mysql_query($sql_listar,$link);
$row = mysql_fetch_array($res_sql);
							if ($row['estado']==1) {
								echo "logeo exitoso";
							}else{
								echo "incorrecto";
							}

							
							echo "</table";
?>

	