<?php
include("cabecera.php");
//$id_historial=$_GET["id_historial"];
include('SimpleImage.php');

$archivos_prev= array(); 
                    $ruta= "gal"; 
                    $directorio= opendir($ruta); 
                    while ($archivo= readdir($directorio)) 
                    { 
                              if ($archivo != '.' && $archivo != '..' && $archivo != 'pruebas' && $archivo != 'th') {$archivos_prev[]= $archivo; } 
                    } 
                    closedir($directorio); 
                     
                    sort($archivos_prev); 
                    reset($archivos_prev); 


if(isset($_GET['enviar'])) 
		 {
			$nombre_archivo = $_FILES['file']['name']; 
			$array_nombre=explode(".",$nombre_archivo);
			$nombre_archivo=$array_nombre[0].rand(0,100).".".$array_nombre[1];
			  while(in_array($nombre_archivo,$archivos_prev)==true)
			  {
					$nombre_archivo=$array_nombre[0].rand(0,100).".".$array_nombre[1];
			  }
		      $image = new SimpleImage();
		      $image->load($_FILES['file']['tmp_name']);
		      $image->resizeToWidth(900);
		   	  $image->save('gal/'.$nombre_archivo);
		      $image->resizeToWidth(300);
		   	  $image->save('gal/th/small_'.$nombre_archivo);
			echo "<div align=center><h1><font color=red size=6>GUARDANDO, ESPERA...<meta http-equiv='Refresh' content='2;url=galery.php'></font></h1></div><br><br>";
		 }	 

else
{

echo "<div align=center><h4>SUBIR UNA FOTO</h4>
  <form action='galery.php?enviar=1' method='post' enctype='multipart/form-data'>
  <input name='file' type='file'>
  <input type='submit' value='submit'>
    </form></div><hr>";
	
	
$archivos= array(); 
                    $ruta= "gal"; 
                    $directorio= opendir($ruta); 
                    while ($archivo= readdir($directorio)) 
                    { 
                              if ($archivo != '.' && $archivo != '..' && $archivo != 'pruebas' && $archivo != 'th') 
                              				{
                              				$archivos[]= $archivo; 
                              				$exif=exif_read_data("gal/".$archivo);
                              					if($exif['FileDateTime']==0)
                              						 {$fechas[]=filectime("gal/".$archivo);}
												else {$fechas[]=$exif['FileDateTime'];}
							  				} 
                   } 
                    closedir($directorio); 
                     
                    if(isset($fechas) && count($fechas)>0){arsort($fechas);} 
                    //reset($archivos); 


echo "<div align=center><h1>GALERIA DE FOTOS (".count($archivos).")</h1><br><a href=rotar.php>ROTAR</a>&nbsp&nbsp&nbsp<a href=delete_foto.php>BORRAR</a>&nbsp&nbsp&nbsp<a href=comentarios_fotos.php>COMENTAR</a></div><hr>";

echo "<div align=center>";
if(isset($fechas))
{
	foreach ($fechas as $id=>$fecha)
		{
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
								echo "<a title='Tomada el $fecha_s\n$comentariof' rel=lightbox[gal] href=gal/$foto><img height=200 src=gal/th/small_$foto border=5 hspace=5 vspace=5></a>";
		}			
}
echo "</div>";
}
include("pie.php");
?>