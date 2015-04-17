<?php
include("cabecera.php");
//$id_historial=$_GET["id_historial"];
include('SimpleImage.php');
	
if(isset($_GET["borrar"]))
{
//la grande
$nombre_archivo = "gal/".$_GET["borrar"];
$nombre_archivo_p = "gal/th/small_".$_GET["borrar"];
unlink($nombre_archivo);
unlink($nombre_archivo_p);
			echo "<div align=center><h1><font color=red size=6>BORRANDO, ESPERA...<meta http-equiv='Refresh' content='1;url=delete_foto.php'></font></h1></div><br><br>";
}

else {
	
	
echo "<div align=center><h1>BORRAR</h1><br><a href=galery.php>VOLVER</a></div><hr>";

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
					
			
			echo "<a name='$foto' title='Tomada el $fecha_s\n$comentariof' href=delete_foto.php?borrar=$foto><img height=200 src=gal/th/small_$foto border=5 hspace=5 vspace=5></a>";
		}
}echo "</div></p>";

}include("pie.php");
?>