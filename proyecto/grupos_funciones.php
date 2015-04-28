<?php
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

function eliminarGrupo($id_grupo){
	 require("conect.php");
    $sql="DELETE FROM grupos WHERE id='".$id_grupo."'";
    $result=mysqli_query($link,$sql) or die(mysqli_error($link));
}
function insertarGrupo($grupo,$codigo){
	require("conect.php");
    $sql="INSERT INTO grupos(grupo,codigo_grupo)  VALUES ('".$grupo."','".$codigo."')";
    $result=mysqli_query($link,$sql) or die(mysqli_error($link));
}
function actualizarGrupo($id,$grupo,$codigo){
	require("conect.php");
    $sql="UPDATE grupos SET grupo ='".$grupo."',codigo_grupo = '".$codigo."'
    	WHERE id='".$id."'";
    $result=mysqli_query($link,$sql) or die(mysqli_error($link));
}


?>