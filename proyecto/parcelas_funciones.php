<?php
function parcelas_consultarCriterio($criterio,$valor){
    require("conect.php");
    $SQL="call sp_parcelas_cons('".$criterio."','".$valor."')";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    require("config_disconnect.php"); 
    return (transformar_a_lista($resultado));
}
function insertar_parcela($id_socio,$coorX,$coorY,$altitud,$superficie,
    $Mocontratada,$Mofamiliar,$miembros_familia,$riego){
    require("conect.php");
    $SQL="call SP_parcela_ins(".$id_socio.",".$coorX.",".$coorY.",".$altitud."
        ,".$superficie.",".$Mocontratada.",".$Mofamiliar.",".$miembros_familia.",'".$riego."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    global $operaciones_constantes,$tabla_constantes;
            guarda_historia($_SESSION["user"], $operaciones_constantes["I"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["parcelas"], gethostname()); 
            require("config_disconnect.php"); 
}
function parcela_editar($sup_total,$coorX,$coorY,$alti,$id_socio,$MOcontratada,$MOfamiliar,$Miembros_familia,
    $riego,$id){
      require("conect.php");
    $SQL="call SP_parcelas_update('".$sup_total."','".$coorX."','".$coorY."','".$alti."','".$id_socio."','".$MOcontratada."',
        '".$MOfamiliar."','".$Miembros_familia."','".$riego."','".$id."')";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
     global $operaciones_constantes,$tabla_constantes;
            guarda_historia($_SESSION["user"], $operaciones_constantes["U"], date("Y-m-d H:i:s",time()), str_replace("'"," ",$SQL) ,$tabla_constantes["parcelas"], gethostname()); 
            require("config_disconnect.php"); 
}
?>