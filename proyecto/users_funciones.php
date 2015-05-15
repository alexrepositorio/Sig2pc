<?php

function consultarCriterio(){
    require("conect.php");
    $SQL="call SP_lista_usuarios_con( )";
    $resultado=mysqli_query($link,$SQL) or die(mysqli_error($link)); 
    while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
				$usuarios[]=$row;

			}  
    return($usuarios);
}

function obtenerNombres(){

    require("conect.php");
    $sql="SELECT nombres, apellidos FROM persona ORDER BY nombres ASC";
    $resultado=mysqli_query($link,$sql) or die(mysqli_error($link));
      while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
                $nombress[]=$row; 
            }  
    return ($nombress);
}

function obtenerNiveles(){

    require("conect.php");
    $sql="SELECT nivel FROM niveles";
    $resultado=mysqli_query($link,$sql) or die(mysqli_error($link));
      while ($row = mysqli_fetch_array($resultado,MYSQLI_ASSOC)){
                $niveless[]=$row; 
            }  
    return ($niveless);
}

function insertar_Usuarios($user,$pass,$nivel,$persona){
	require ("conect.php");
	$SQL="call SP_usuarios_ins('".$user."','".$pass."','".$nivel."','".$persona."')";
	mysqli_query($link,$SQL) or die(mysqli_error($link));
}
?>