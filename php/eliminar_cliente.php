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

        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $sql_delete = "DELETE FROM usuario_contador.clientes WHERE id_cliente = :id_cliente";
            $stmt_delete = $conexion->prepare($sql_delete);
            $stmt_delete->bindParam(':id_cliente', $id_cliente, PDO::PARAM_INT);
            $stmt_delete->execute();

            header("Location: index_clientes.php"); 
            exit();
        }
    } catch (PDOException $e) {
        echo "<p>Error en la consulta: " . $e->getMessage() . "</p>";
        exit;
    }
} else {
    echo "<p>ID de cliente no proporcionado.</p>";
    exit;
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar Cliente</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
   
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
            padding: 20px;
        }

        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: auto;
        }

        .client-info {
            margin-bottom: 20px;
        }

        .client-info p {
            font-size: 16px;
            margin: 5px 0;
        }

        .client-info p strong {
            color: #333;
        }

        .confirmation {
            margin-top: 30px;
            font-size: 18px;
            font-weight: bold;
            color: #d9534f;
        }

        .btn-danger {
            margin-top: 20px;
            width: 100%;
            padding: 15px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center">Eliminar Cliente</h2>
    <p class="text-center">¿Estás seguro de que deseas eliminar al cliente?</p>

    <div class="client-info">
        <p><strong>Nombre:</strong> <?php echo htmlspecialchars($cliente['NOMBRE']); ?></p>
        <p><strong>Teléfono:</strong> <?php echo htmlspecialchars($cliente['TELEFONO']); ?></p>
        <p><strong>Dirección:</strong> <?php echo htmlspecialchars($cliente['DIRECCION']); ?></p>
        <p><strong>Email:</strong> <?php echo htmlspecialchars($cliente['EMAIL']); ?></p>
        <p><strong>Fecha de registro:</strong> <?php echo htmlspecialchars($cliente['FECHA_REGISTRO']); ?></p>
    </div>

    <form action="eliminar_cliente.php?id=<?php echo $cliente['ID_CLIENTE']; ?>" method="POST">
  
        <a href="index_clientes.php" class="btn btn-primary btn-sm me-2">Cancelar</a>
        <button type="submit" class="btn btn-danger  btn-sm">Eliminar Cliente</button>
</form>
  
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
