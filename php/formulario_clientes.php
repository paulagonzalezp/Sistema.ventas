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
    <title>Registro Cliente</title>
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- CSS Personalizado -->
    <link rel="stylesheet" href="style/style.css">
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h2 class="text-center">Registro de Clientes</h2>
            <form action="" method="POST">
                <div class="mb-3">
                    <label for="id_cliente" class="form-label">ID Cliente</label>
                    <input type="number" id="id_cliente" name="id_cliente" class="form-control" placeholder="Ingrese ID" required>
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" id="nombre" name="nombre" class="form-control" placeholder="Ingrese nombre" required>
                </div>
                <div class="mb-3">
                    <label for="telefono" class="form-label">Teléfono</label>
                    <input type="text" id="telefono" name="telefono" class="form-control" placeholder="Ingrese teléfono" required>
                </div>
                <div class="mb-3">
                    <label for="direccion" class="form-label">Dirección</label>
                    <input type="text" id="direccion" name="direccion" class="form-control" placeholder="Ingrese dirección" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" name="email" class="form-control" placeholder="Ingrese email" required>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-success me-2">Registrar</button>
                    
                </div>
            </form>
        </div>
    </div>
</body>
</html>

