<?php

function AbrirBaseDatos()
{

    $host="localhost";
    $port="1521";
    $dbname="orcl";
    $user="usuario_administrador";
    $passwrod="usuario_administrador";

    $dsn = "oci:dbname=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=$host)(PORT=$port)))(CONNECT_DATA=(SID=$dbname)))";

    try{
        $conexion=new PDO($dsn, $user, $passwrod);
        $conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        echo "Conexión exitosa";
    }catch (PDOException $e){
        echo "No se estableció la conexión: ".$e->getMessage();
    }
        return $conexion;
    }

function CerrarBaseDatos($conexion)
{
    $conexion = null;
}



