<?php
// Parámetros de conexión a Oracle
$host = 'localhost';  // O el host de tu servidor Oracle
$puerto = '1521';     // El puerto de Oracle (usualmente 1521)
$dbname = 'orcl';
$user = '';
$password = '1234';

// Crear la conexión
$conn = oci_connect($usuario, $contraseña, "//{$host}:{$puerto}/{$nombre_bd}");

if (!$conn) {
    $e = oci_error();
    die("No se pudo conectar a Oracle: " . $e['message']);
}

// Obtener los datos del formulario
$nombre_empresa = $_POST['nombre_empresa'];
$correo = $_POST['correo'];
$telefono = $_POST['telefono'];

// Crear la consulta SQL para insertar los datos
$sql = "INSERT INTO proveedores (nombre_empresa, correo, telefono) VALUES (:nombre_empresa, :correo, :telefono)";

// Preparar la consulta
$stid = oci_parse($conn, $sql);

// Asignar los valores a los parámetros
oci_bind_by_name($stid, ":nombre_empresa", $nombre_empresa);
oci_bind_by_name($stid, ":correo", $correo);
oci_bind_by_name($stid, ":telefono", $telefono);

// Ejecutar la consulta
$result = oci_execute($stid);

if ($result) {
    echo "Proveedor registrado exitosamente.";
} else {
    $e = oci_error($stid);
    echo "Error al registrar proveedor: " . $e['message'];
}

// Cerrar la conexión
oci_free_statement($stid);
oci_close($conn);
?>
