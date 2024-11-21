<?php
// Configuración de la conexión
$username = 'usuario_administrador'; // Usuario de Oracle
$password = 'TU_CONTRASEÑA';         // Contraseña del usuario
$connection_string = '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))(CONNECT_DATA=(SID=ORCL)))';

// Establecer conexión
$connection = oci_connect($username, $password, $connection_string);

if (!$connection) {
    $error = oci_error();
    echo "Error al conectar a Oracle: " . $error['message'];
    exit;
}

echo "Conexión exitosa a Oracle!";
?>
