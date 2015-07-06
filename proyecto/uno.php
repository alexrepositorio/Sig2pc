<?php
$marcos=Array("Regular","Medio","Aleatorio");
$hierbas=Array("Limpio","Medio","Muchas");
$sombreados=Array("Poco","Medio","Mucho");
$meses=Array("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre");
$valores=Array(0,25,50,75,100);
$certificados=Array(Array("Organico","O"),array("Convencional T1","T1"),array("Convencional T2","T2"),array("Convencional T3","T3"),array("Nuevo","N"));
$altas_estados=Array("Ingreso","Salida");
$fecha=date('Y-m-d');
$texturas=Array("arenoso","franco arenoso","franco","franco limoso","limoso","franco arcilloso","franco arenoso arcilloso","franco limoso arcilloso","arcilloso arenoso","arcilloso limoso","arcilloso");
$estructuras=Array("angular","sub-angular","granular");
$grados=Array("débil","moderado","fuerte");
$riegos=Array("Aspersión","Goteo","Gravedad","Ninguno");
$defectos=array('d_fermento','d_metalico','d_quimico','d_vinagre','d_stinker',
				'd_fenol','d_reposo','d_moho','d_terroso','d_extrano','d_sucio',
				'd_astringente','dl_cereal','dl_fermento','dl_reposo','dl_moho',
				'dl_astringencia');
$tipos_sabor_res=array('Refrescante',
					'Limpio',
					'Dulce',
					'Picante',
					'Delicado',
					'Suave',
					'Duro',
					'Astringente',
					'Amargo',
					'Seco',
					'Agrio',
					'Vinoso',
					'Áspero',
					'Salado');
$tipos_sabor=array('Floral',
					'Frutal',
					'Herbal',
					'Anuesado',
					'Picante',
					'Caramelo',
					'Chocolate dulce',
					'Chocolate amargo',
					'Articulado',
					'Vainilla',
					'Cítrico',
					'Melón',
					'Mora',
					'Vinoso',
					'Carbonoso',									
					'Madera',
					'Resinoso',
					'Neutral');
$tipos_aroma=array('Floral',
				  'Frutal',
				  'Herbal',
				  'Anuesado',
				  'Picante',
				  'Caramelo',
				  'Chocolate dulce',
				  'Chocolate amargo',
				  'Vainilla',
				  'Cítrico',
				  'Neutral',
				  'Resinoso',
				  'Carbonoso');

$tipos_aroma=array('Floral',
				  'Frutal',
				  'Herbal',
				  'Anuesado',
				  'Picante',
				  'Caramelo',
				  'Chocolate dulce',
				  'Chocolate amargo',
				  'Vainilla',
				  'Cítrico',
				  'Neutral',
				  'Resinoso',
				  'Carbonoso');
$tipos_sabor=array('Floral',
					'Frutal',
					'Herbal',
					'Anuesado',
					'Picante',
					'Caramelo',
					'Chocolate dulce',
					'Chocolate amargo',
					'Articulado',
					'Vainilla',
					'Cítrico',
					'Melón',
					'Mora',
					'Vinoso',
					'Carbonoso',									
					'Madera',
					'Resinoso',
					'Neutral');
$tipos_sabor_res=array('Refrescante',
					'Limpio',
					'Dulce',
					'Picante',
					'Delicado',
					'Suave',
					'Duro',
					'Astringente',
					'Amargo',
					'Seco',
					'Agrio',
					'Vinoso',
					'Áspero',
					'Saldo');

function transformar_a_lista($resultado){
	if (mysqli_num_rows($resultado)>0) {
    	$lista=mysqli_fetch_all($resultado,MYSQLI_ASSOC);     			   		
   		return(utf8_convertidor($lista));
    }else{
    	return 0;
    }
}
function utf8_convertidor($array)
{
    array_walk_recursive($array, function(&$item, $key){
        if(!mb_detect_encoding($item, 'utf-8', true)){
                $item = utf8_encode($item);
        }
    });
    return $array;
}
/*
function nombre_socio($id)
{
	include ("conect.php");
	mysqli_query($link, "SET NAMES 'utf8'");
	$SQL="SELECT * FROM socios WHERE codigo='$id'";
	$resultado=mysqli_query($link, $SQL);
	$socio = mysqli_fetch_array($resultado,MYSQLI_ASSOC);
	$datos_socio["nombres"]=$socio["nombres"];
	$datos_socio["apellidos"]=$socio["apellidos"];
	$datos_socio["codigo"]=$socio["codigo"];
	$datos_socio["poblacion"]=$socio["poblacion"];
	$datos_socio["id"]=$socio["id_socio"];
	$datos_socio["foto"]=$socio["foto"];
	return ($datos_socio);
}

function muestra_array($array)
{
	echo "<pre>";
	print_r($array);
	echo "</pre><br>";
}
*/

function guarda_historial($comentario)
{
	$link = mysqli_connect("localhost", "root", "", "sig");
	mysqli_query($link, "SET NAMES 'utf8'");
	$SQL_historial="INSERT INTO acciones VALUES ('','".$_COOKIE['username']."','".date("Y-m-d H:i:s",time())."','$comentario')";
	mysqli_query($link, $SQL_historial);		
}

function yes_no($valor)
{
	switch ($valor){
		case 0:
			$tic="<img width=20 src=images/no.png>";
			break;
		case 1:
			$tic="<img width=20 src=images/yes.png>";
			break;
			}
return ($tic);	
}
function nivel($nivel){
	switch ($nivel){
		case 1:
			$nivel_t="Administrador";
			break;
		case 2:
			$nivel_t="Contable";
			break;
		case 3:
			$nivel_t="Bodeguero";
			break;
		case 4:
			$nivel_t="Socio";
			break;
		case 5:
			$nivel_t="Catador";
			break;
	}
return ($nivel_t);
}
function logout(){

session_start();
session_unset();
session_destroy();

header ('Location: login.php');
	exit (0); 
}

function Vactuales(){

require("lote_funciones.php");
require("pagos_funciones.php");
require("despachos_funciones.php");
// catas pendientes
//$SQL_catas_pendientes="SELECT codigo_lote FROM lotes WHERE calidad='A' AND codigo_lote NOT IN (SELECT lote FROM catas)";
$resultado=LotesConsultarCriterio('v_actuales','');
if (is_array($resultado)) {
	$cuenta_catas=count($resultado);
}else{
	$cuenta_catas=0;
}
$cuenta_catas="<font size=6>(<font color=red><b>$cuenta_catas</b></font>)</font>";

// pagos pendientes
$resultado2=pagos_consultar_criterio('v_actuales','');
if (is_array($resultado2)) {
	$cuenta_pagos=count($resultado2);
}else{
	$cuenta_pagos=0;
}
$cuenta_pagos="<font size=6>(<font color=red><b>$cuenta_pagos</b></font>)</font>";
	
//*****************************
// estado de almacén

$resultado3=LotesConsultarCriterio('entradas_almacen','');
$almacen_entradas=$resultado3[0]["entradas"];
$resultado4=despachos_consultar_criterio('salidas_almacen','');
$almacen_salidas=$resultado4[0]["salidas"];
$stock_almacen=$almacen_entradas-$almacen_salidas;
$stock_almacen="<font size=6>(<font color=red><b>".$stock_almacen."qq</b></font>)</font>";
//*****************************
return array($cuenta_pagos,$cuenta_catas,$stock_almacen);
}


$permisos_admin=array(1);
$permisos_administrativos=array(1,2);
$permisos_lotes=array(1,3);
$permisos_pagos=array(1,2);
$permisos_general=array(1,2,3,4,5);
$permisos_catador=array(1,5);
?>
