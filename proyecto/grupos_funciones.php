<?php
function consultarGrupo($criterio,$valor){
     require("conect.php");
    $sql="call SP_grupos_cons('".$criterio."','".$valor."')";
    $resultado=mysqli_query($link,$sql) or die(mysqli_error($link));
    return (transformar_a_lista($resultado));
}

function eliminarGrupo($id_grupo){
	 require("conect.php");
    $sql="call SP_grupos_del('".$id_grupo."')";
    $result=mysqli_query($link,$sql) or die(mysqli_error($link));
}
function insertarGrupo($grupo,$codigo){
	require("conect.php");
    $sql="call SP_grupos_ins('".$grupo."','".$codigo."')";
    $result=mysqli_query($link,$sql) or die(mysqli_error($link));
}
function actualizarGrupo($id,$grupo,$codigo){
	require("conect.php");
    $sql="call SP_grupos_upd('".$grupo."','".$codigo."','".$id."')";
    $result=mysqli_query($link,$sql) or die(mysqli_error($link));
}


?>