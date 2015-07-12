<?php
function catas_consultar($criterio,$valor)
{
	require("conect.php");
	$SQL="CALL SP_catas_cons('".$criterio."','".$valor."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
    require("config_disconnect.php");
	return(transformar_a_lista($resultado));
}
function catas_insertar($p_lote,$p_fecha,$p_catador,$p_tostado,$p_fragancia,$p_tipo_aroma1,$p_nota_aroma,
	$p_sabor,$p_tipo_sabor,$p_nota_sabor,$p_sabor_residual,$p_tipo_sabor_residual,$p_nota_sabor_residual,
	$p_acidez,$p_cuerpo,$p_uniformidad,$p_balance,$p_puntaje_catador,$p_taza_limpia,$p_nota_catacio,$p_dulzor,
	$p_puntuacionç,$p_d_fermento,$p_d_metalico,$p_d_quimico,$p_d_vinagre,$p_d_stinker,$p_d_fenol,$p_d_reposo,
	$p_d_moho,$p_d_terroso,	$p_d_extrano,$p_d_sucio,$p_d_astringente,$p_d_quaquers,$p_dl_cereal,
	$p_dl_fermento,$p_dl_reposo,$p_dl_moho,	$p_dl_astringencia,$p_d_general
	){
	require("conect.php");
	$SQL="CALL SP_catas_ins('".$p_lote."','".$p_fecha."','".$p_catador."','".$p_tostado."','".$p_fragancia."',
		'".$p_tipo_aroma1."','".$p_nota_aroma."','".$p_sabor."','".$p_tipo_sabor."','".$p_nota_sabor."','".$p_sabor_residual."',
		'".$p_tipo_sabor_residual."','".$p_nota_sabor_residual."','".$p_acidez."','".$p_cuerpo."','".$p_uniformidad."','".$p_balance."',
		'".$p_puntaje_catador."','".$p_taza_limpia."','".$p_nota_catacio."','".$p_dulzor."','".$p_puntuacionç."','".$p_d_fermento."',
		'".$p_d_metalico."','".$p_d_quimico."','".$p_d_vinagre."','".$p_d_stinker."','".$p_d_fenol."','".$p_d_reposo."','".$p_d_moho."',
		'".$p_d_terroso."','".$p_d_extrano."','".$p_d_sucio."','".$p_d_astringente."','".$p_d_quaquers."',
		'".$p_dl_cereal."','".$p_dl_fermento."','".$p_dl_reposo."','".$p_dl_moho."','".$p_dl_astringencia."','".$p_d_general."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"], $operaciones_constantes["I"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["catas"], gethostname()); 
    require("config_disconnect.php");
}
function catas_actualizar($p_id,$p_lote,$p_fecha,$p_catador,$p_tostado,$p_fragancia,$p_tipo_aroma1,$p_nota_aroma,
	$p_sabor,$p_tipo_sabor,$p_nota_sabor,$p_sabor_residual,$p_tipo_sabor_residual,$p_nota_sabor_residual,
	$p_acidez,$p_cuerpo,$p_uniformidad,$p_balance,$p_puntaje_catador,$p_taza_limpia,$p_nota_catacio,$p_dulzor,
	$p_puntuacionç,$p_d_fermento,$p_d_metalico,$p_d_quimico,$p_d_vinagre,$p_d_stinker,$p_d_fenol,$p_d_reposo,
	$p_d_moho,$p_d_terroso,	$p_d_extrano,$p_d_sucio,$p_d_astringente,$p_d_quaquers,$p_dl_cereal,
	$p_dl_fermento,$p_dl_reposo,$p_dl_moho,	$p_dl_astringencia,$p_d_general
	){
	require("conect.php");
	$SQL="CALL SP_catas_upd('".$p_id."','".$p_lote."','".$p_fecha."','".$p_catador."','".$p_tostado."','".$p_fragancia."',
		'".$p_tipo_aroma1."','".$p_nota_aroma."','".$p_sabor."','".$p_tipo_sabor."','".$p_nota_sabor."','".$p_sabor_residual."',		
		'".$p_tipo_sabor_residual."','".$p_nota_sabor_residual."','".$p_acidez."','".$p_cuerpo."','".$p_uniformidad."','".$p_balance."',
		'".$p_puntaje_catador."','".$p_taza_limpia."','".$p_nota_catacio."','".$p_dulzor."','".$p_puntuacionç."','".$p_d_fermento."',
		'".$p_d_metalico."','".$p_d_quimico."','".$p_d_vinagre."','".$p_d_stinker."','".$p_d_fenol."','".$p_d_reposo."','".$p_d_moho."',
		'".$p_d_terroso."','".$p_d_extrano."','".$p_d_sucio."','".$p_d_astringente."','".$p_d_quaquers."',
		'".$p_dl_cereal."','".$p_dl_fermento."','".$p_dl_reposo."','".$p_dl_moho."','".$p_dl_astringencia."','".$p_d_general."')";
	$resultado=mysqli_query($link,$SQL) or die(mysqli_error($link));
	global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"], $operaciones_constantes["U"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["catas"], gethostname()); 
    require("config_disconnect.php");
}
function catas_del($id){
	require("conect.php");
	$SQL="CALL SP_catas_del('".$id."')";
	mysqli_query($link,$SQL) or die(mysqli_error($link));
	global $operaciones_constantes,$tabla_constantes;
    guarda_historia($_SESSION["user"], $operaciones_constantes["U"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["catas"], gethostname()); 
    require("config_disconnect.php");
}


?>