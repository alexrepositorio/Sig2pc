<?php
/*
function obtenerGrupos(){

    require("conect.php");
    $sql="SELECT DISTINCT(grupo)  FROM GRUPOS ORDER BY grupo ASC";
    $resultado=mysqli_query($link,$sql) or die(mysqli_error($link));
      while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
                $grupos[]=$row; 
            }  
    return ($grupos);
}
function obtenerGrupo($id){
	 require("conect.php");
    $sql_localidad="SELECT * FROM GRUPOS WHERE id='".$id."'";
    $result=mysqli_query($link,$sql_localidad) or die(mysqli_error($link));
    return ($result);

}

function consultarGrupos(){
	 require("conect.php");
    $sql_localidad="SELECT * FROM GRUPOS ORDER BY grupo ASC";
    $result=mysqli_query($link,$sql_localidad) or die(mysqli_error($link));
    return ($result);
}
*/
function consultarGrupo($criterio,$valor){
     require("conect.php");
     echo "llego";
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