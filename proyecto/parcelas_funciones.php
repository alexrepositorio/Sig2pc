<?php
function parcelas_consultarCriterio($criterio,$valor){
    require("conect.php");
    $SQL="call sp_parcelas_cons('".$criterio."','".$valor."')";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    return (transformar_a_lista($resultado));
}
function insertar_parcela($id_socio,$coorX,$coorY,$altitud,$superficie,
    $Mocontratada,$Mofamiliar,$miembros_familia,$riego){
    require("conect.php");
    $SQL="call SP_parcelas_ins(".$id_socio.",".$coorX.",".$coorY.",".$altitud."
        ,".$superficie.",".$Mocontratada.",".$Mofamiliar.",".$miembros_familia.",'".$riego."')";
    mysqli_query($link,$SQL) or die(mysqli_error($link)); 
}
function parcela_editar($sup_total,$coorX,$coorY,$alti,$id_socio,$MOcontratada,$MOfamiliar,$Miembros_familia,
    $riego,$id){
      require("conect.php");
    $SQL="call SP_parcelas_update('".$sup_total."','".$coorX."','".$coorY."','".$alti."','".$id_socio."','".$MOcontratada."',
        '".$MOfamiliar."','".$Miembros_familia."','".$riego."','".$id."'";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
}
?>