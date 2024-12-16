<?php
require_once 'conexion_oracle.php'; 

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_cliente = $_POST['id_cliente']; 
    $nombre = $_POST['nombre'];
    $telefono = $_POST['telefono'];
    $direccion = $_POST['direccion'];
    $email = $_POST['email'];

    if (!empty($id_cliente) && !empty($nombre) && !empty($telefono) && !empty($direccion) && !empty($email)) {
   
        $conexion = AbrirBaseDatos(); 

        $sql = "INSERT INTO usuario_contador.clientes (id_cliente, nombre, telefono, direccion, email) 
        VALUES (:id_cliente, :nombre, :telefono, :direccion, :email)";

        try {
            $stmt = $conexion->prepare($sql);

            $stmt->bindParam(':id_cliente', $id_cliente);
            $stmt->bindParam(':nombre', $nombre);
            $stmt->bindParam(':telefono', $telefono);
            $stmt->bindParam(':direccion', $direccion);
            $stmt->bindParam(':email', $email);

            $stmt->execute();

            header("Location: index_clientes.php");
            exit(); 
        } catch (PDOException $e) {
            echo "<p class='alert alert-danger'>Error al insertar cliente: " . $e->getMessage() . "</p>";
        } finally {
            CerrarBaseDatos($conexion);
        }
    } else {
        echo "<p class='alert alert-warning'>Por favor, complete todos los campos, incluyendo el ID del cliente.</p>";
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro Cliente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  
    <link rel="stylesheet" href="style/style.css">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card p-4 shadow-sm">
                    <h2 class="text-center mb-4">Registro de Cliente</h2>
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
                        <div class="d-flex justify-content-between">
                            <a href="index_clientes.php" class="btn btn-primary">Volver</a>
                            <button type="submit" class="btn btn-success">Registrar nuevo Cliente</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
