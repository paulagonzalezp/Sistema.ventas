<?php
require_once 'conexion_oracle.php'; // archivo de conexión

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Obtener los datos del formulario
    $id_cliente = $_POST['id_cliente']; // ID manual desde el formulario
    $nombre = $_POST['nombre'];
    $telefono = $_POST['telefono'];
    $direccion = $_POST['direccion'];
    $email = $_POST['email'];

    // Validar que los datos no estén vacíos
    if (!empty($id_cliente) && !empty($nombre) && !empty($telefono) && !empty($direccion) && !empty($email)) {
        // Abrir la conexión a la base de datos
        $conexion = AbrirBaseDatos();

        // Preparar la sentencia SQL
        $sql = "INSERT INTO usuario_contador.clientes (id_cliente, nombre, telefono, direccion, email) 
        VALUES (:id_cliente, :nombre, :telefono, :direccion, :email)";


        try {
            $stmt = $conexion->prepare($sql);

            // Vincular los parámetros
            $stmt->bindParam(':id_cliente', $id_cliente);
            $stmt->bindParam(':nombre', $nombre);
            $stmt->bindParam(':telefono', $telefono);
            $stmt->bindParam(':direccion', $direccion);
            $stmt->bindParam(':email', $email);

            // Ejecutar la consulta
            $stmt->execute();

            echo "<p>Cliente insertado exitosamente.</p>";
        } catch (PDOException $e) {
            echo "<p>Error al insertar cliente: " . $e->getMessage() . "</p>";
        } finally {
            // Cerrar la conexión
            CerrarBaseDatos($conexion);
        }
    } else {
        echo "<p>Por favor, complete todos los campos, incluyendo el ID del cliente.</p>";
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulario Cliente</title>
</head>
<body>
    <h1>Registrar Cliente</h1>
    <form action="" method="POST"> <!-- La acción está vacía, procesa en este mismo archivo -->
        <label for="id_cliente">ID Cliente:</label><br>
        <input type="number" id="id_cliente" name="id_cliente" required><br><br>

        <label for="nombre">Nombre:</label><br>
        <input type="text" id="nombre" name="nombre" required><br><br>

        <label for="telefono">Teléfono:</label><br>
        <input type="text" id="telefono" name="telefono" required><br><br>

        <label for="direccion">Dirección:</label><br>
        <input type="text" id="direccion" name="direccion" required><br><br>

        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" required><br><br>

        <button type="submit">Registrar Cliente</button>
    </form>
</body>
</html>
