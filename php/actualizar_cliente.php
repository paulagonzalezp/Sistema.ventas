<?php
require_once 'conexion_oracle.php'; 

$conexion = AbrirBaseDatos();

if (isset($_GET['id'])) {
    $id_cliente = $_GET['id'];

    try {
        $sql = "SELECT id_cliente, nombre, telefono, direccion, email, TO_CHAR(fecha_registro, 'YYYY-MM-DD HH24:MI:SS') AS fecha_registro 
                FROM usuario_contador.clientes WHERE id_cliente = :id_cliente";
        $stmt = $conexion->prepare($sql);
        $stmt->bindParam(':id_cliente', $id_cliente, PDO::PARAM_INT);
        $stmt->execute();
        $cliente = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$cliente) {
            echo "<p>Cliente no encontrado.</p>";
            exit;
        }
    } catch (PDOException $e) {
        echo "<p>Error en la consulta: " . $e->getMessage() . "</p>";
        exit;
    }
} else {
    echo "<p>ID de cliente no proporcionado.</p>";
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $nombre = $_POST['nombre'];
    $telefono = $_POST['telefono'];
    $direccion = $_POST['direccion'];
    $email = $_POST['email'];

    try {
        $sql = "UPDATE usuario_contador.clientes
                SET nombre = :nombre, telefono = :telefono, direccion = :direccion, email = :email
                WHERE id_cliente = :id_cliente";
        $stmt = $conexion->prepare($sql);
        $stmt->bindParam(':nombre', $nombre);
        $stmt->bindParam(':telefono', $telefono);
        $stmt->bindParam(':direccion', $direccion);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':id_cliente', $id_cliente, PDO::PARAM_INT);
        
        $stmt->execute();

        header("Location: index_clientes.php");
        exit;
    } catch (PDOException $e) {
        echo "<p>Error al actualizar el cliente: " . $e->getMessage() . "</p>";
    }
}

CerrarBaseDatos($conexion);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Actualizar Cliente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <h2 class="text-center mb-4">Actualizar Cliente</h2>
    <div class="card shadow">
        <div class="card-body">
            <form action="actualizar_cliente.php?id=<?php echo $cliente['ID_CLIENTE']; ?>" method="POST">
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" value="<?php echo htmlspecialchars($cliente['NOMBRE']); ?>" required>
                </div>
                <div class="mb-3">
                    <label for="telefono" class="form-label">Teléfono</label>
                    <input type="text" class="form-control" id="telefono" name="telefono" value="<?php echo htmlspecialchars($cliente['TELEFONO']); ?>" required>
                </div>
                <div class="mb-3">
                    <label for="direccion" class="form-label">Dirección</label>
                    <input type="text" class="form-control" id="direccion" name="direccion" value="<?php echo htmlspecialchars($cliente['DIRECCION']); ?>" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<?php echo htmlspecialchars($cliente['EMAIL']); ?>" required>
                </div>
                <div class="d-flex justify-left">
                <a href="index_clientes.php" class="btn btn-primary btn-sm me-2">Cancelar</a>
                    <button type="submit" class="btn btn-success btn-sm">Actualizar</button>
                   
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
