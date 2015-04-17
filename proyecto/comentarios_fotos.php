<?php
include("cabecera.php");
//$id_historial=$_GET["id_historial"];
//include('SimpleImage.php');

if(isset($_GET["borrar"]))
{
	$res_borra=mysqli_query($link,"DELETE FROM comentarios_fotos WHERE id=".$_GET["borrar"]);
	echo "<div align=center><h1><font color=red size=6>BORRANDO, ESPERA...<meta http-equiv='Refresh' content='2;url=comentarios_fotos.php'></font></h1></div>";
}

	
if(isset($_POST["foto"]))
{
	if(isset($_POST["update"])){$sql_foto="UPDATE comentarios_fotos SET comentario='".$_POST["comentario"]."' WHERE foto='".$_POST["foto"]."'";}
	else{$sql_foto="INSERT INTO comentarios_fotos VALUES ('','".$_POST["foto"]."','".$_POST["comentario"]."')";}
	//echo "$sql_foto<br>";
	$res_actualiza=mysqli_query($link,$sql_foto);
	echo "<div align=center><h1><font color=red size=6>GUARDANDO, ESPERA...<meta http-equiv='Refresh' content='2;url=comentarios_fotos.php#".$_POST["foto"]."'></font></h1></div><br><br>";
}
else
{
		if(isset($_GET["comentar"]))
		{
		
						$sql_foto="SELECT * FROM comentarios_fotos WHERE foto='".$_GET["comentar"]."' LIMIT 1";
						$resultado_foto=mysqli_query($link,$sql_foto);
						$cuenta_com=mysqli_num_rows($resultado_foto);
						if($cuenta_com>0)
										{
										while($row=mysqli_fetch_array($resultado_foto))
											{
												$comentario=$row["comentario"];
												$idcom=$row["id"];
											}
										}
						else{$comentario="";$idcom="";}
						if($comentario!=""){$update="<input type='hidden' name='update' value='SI'>";}else{$update="";}
		
						echo "<div align=center><table border=0><tr><td>";
						echo "<img align=left height=200 src=gal/th/small_".$_GET["comentar"]." border=5 hspace=5 vspace=5></td><td>";
						echo "<div align=center><a href=comentarios_fotos.php?borrar=$idcom><h2>Borrar Comentario</h2></a></div><br>";
						echo"<form name=form1 action=comentarios_fotos.php method='post'>
						<table width=90% border=0 cellpadding=5 cellspacing=5>
						<tr><td width=50% align=right><h4><font size=6>Foto</td><td><h4><font size=6 color=red>".$_GET["comentar"]."</font></h4></td></tr><tr>
						<tr><td width=50% align=right><h4><font size=6>Comentario</td><td><textarea name=comentario style='font-size: 28' cols='30' rows='5'>$comentario</textarea></h4></td></tr><tr>
						</td></tr><tr>
						</table><br>
						<div align=center>
						<input type='hidden' name='foto' value='".$_GET["comentar"]."'>
						$update
						<input type='submit' value='guardar' style='font-size: 28'>
						</div>
						</form></td></tr></table></div><hr>";
		}
else{
	
		echo "<div align=center><h1>COMENTAR FOTOS</h1><br><a href=galery.php>VOLVER</a></div><br>";
		echo "<div align=center><h3><font color=red>ATENCION, AL ROTAR UNA IMAGEN SE PERDERAN LOS COMENTARIOS (1º rotar y 2º comentar)</font></h1><br></div><hr>";
		
$archivos= array(); 
                    $ruta= "gal"; 
                    $directorio= opendir($ruta); 
                    while ($archivo= readdir($directorio)) 
                    { 
                              if ($archivo != '.' && $archivo != '..' && $archivo != 'pruebas' && $archivo != 'th') {$archivos[]= $archivo; $fechas[]=filemtime("gal/".$archivo);} 
                   } 
                    closedir($directorio); 
                     
                    arsort($fechas); 
                    //reset($archivos); 





echo "<div align=center>";
if(isset($fechas))
{

foreach ($fechas as $id=>$fecha){
							$foto=$archivos[$id];
							$fecha_s=date("d-m-Y H:i",$fecha);
						unset($comentariof);	
						$sql_f="SELECT * FROM comentarios_fotos WHERE foto='$foto' LIMIT 1";
								$resultado_f=mysqli_query($link,$sql_f);
										$cuenta_p=mysqli_num_rows($resultado_f);
										if($cuenta_p>0)
										{
										while($rowf=mysqli_fetch_array($resultado_f))
											{
												$comentariof=$rowf["comentario"];
											}
										}else{$comentariof="";}
			
			
		
	
			echo "<a name='$foto' title='Tomada el $fecha_s\n$comentariof' href=comentarios_fotos.php?comentar=$foto><img height=200 src=gal/th/small_$foto border=5 hspace=5 vspace=5></a>";
		}
		echo "</div></p>";

}

}
}
include("pie.php");
?>