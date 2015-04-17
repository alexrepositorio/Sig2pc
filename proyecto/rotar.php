<?php
include("cabecera.php");
//$id_historial=$_GET["id_historial"];
include('SimpleImage.php');
	
if(isset($_GET["rotar"]))
{
//la grande
$nombre_archivo = "gal/".$_GET["rotar"];
//echo "$nombre_archivo<br>";
$grados = 90;
$origen = imagecreatefromjpeg($nombre_archivo);
$rotate = imagerotate($origen, $grados, 0);
imagejpeg($rotate,$nombre_archivo."R.jpg");
//la pequeña
$nombre_archivo_p = "gal/th/small_".$_GET["rotar"];
//echo "$nombre_archivo_p<br>";
$origen_p = imagecreatefromjpeg($nombre_archivo_p);
$rotate_p = imagerotate($origen_p, $grados, 0);
imagejpeg($rotate_p,$nombre_archivo_p."R.jpg");
unlink($nombre_archivo);
unlink($nombre_archivo_p);
			echo "<div align=center><h1><font color=red size=6>ROTANDO, ESPERA...<meta http-equiv='Refresh' content='1;url=rotar.php#".$_GET["rotar"]."'></font></h1></div><br><br>";
}
else 
{
	

	
echo "<div align=center><h1>ROTADOR DE FOTOS</h1><br><a href=galery.php>VOLVER</a></div><br>";
echo "<div align=center><h3><font color=red>ATENCION, AL ROTAR UNA IMAGEN SE PERDERAN LOS COMENTARIOS</font></h1><br></div><hr>";

$archivos= array(); 
                    $ruta= "gal"; 
                    $directorio= opendir($ruta); 
                    while ($archivo= readdir($directorio)) 
                    { 
                              if ($archivo != '.' && $archivo != '..' && $archivo != 'pruebas' && $archivo != 'th') {$archivos[]= $archivo; $fechas[]=filemtime("gal/".$archivo);} 
                   } 
                    closedir($directorio); 
                     
                    if(isset($fechas) && count($fechas)>0){arsort($fechas);} 
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
			
			echo "<a name='$foto' title='Tomada el $fecha_s\n$comentariof' href=rotar.php?rotar=$foto><img height=200 src=gal/th/small_$foto border=5 hspace=5 vspace=5></a>";
		}
}echo "</div></p>";
}

include("pie.php");
?>