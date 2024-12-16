<?php
require_once 'conexion_oracle.php'; 

$conexion = AbrirBaseDatos();

try {
    $sql = "SELECT id_cliente, nombre, telefono, direccion, email, TO_CHAR(fecha_registro, 'YYYY-MM-DD HH24:MI:SS') AS fecha_registro 
            FROM usuario_contador.clientes";
    $stmt = $conexion->query($sql);
    $clientes = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    echo "<p>Error en la consulta: " . $e->getMessage() . "</p>";
} finally {
    CerrarBaseDatos($conexion);
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Clientes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style/style.css">
    <style>
        .titulo-lista-clientes {
            margin-top: 40px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="text-center mb-4 titulo-lista-clientes">Listado de Clientes</h2>
    <div class="d-flex justify-content-between mb-4">
        <a href="formulario_clientes.php" class="btn btn-success">Registrar un nuevo cliente</a>
    </div>
    
    <div class="card shadow">
    
        <div class="card-body">
        
            <table class="table table-hover table-bordered text-center">
                <thead class="table-dark">
                    <tr>
                        <th>ID Cliente</th>
                        <th>Nombre</th>
                        <th>Teléfono</th>
                        <th>Dirección</th>
                        <th>Email</th>
                        <th>Fecha de Registro</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    foreach ($clientes as $cliente) {
                        echo "<tr>";
                        echo "<td>{$cliente['ID_CLIENTE']}</td>";
                        echo "<td>{$cliente['NOMBRE']}</td>";
                        echo "<td>{$cliente['TELEFONO']}</td>";
                        echo "<td>{$cliente['DIRECCION']}</td>";
                        echo "<td>{$cliente['EMAIL']}</td>";
                        echo "<td>{$cliente['FECHA_REGISTRO']}</td>";
                        echo "<td>";
                        echo "<a href='actualizar_cliente.php?id={$cliente['ID_CLIENTE']}' class='btn btn-primary btn-sm me-2'>Actualizar</a>";
                        echo "<a href='eliminar_cliente.php?id={$cliente['ID_CLIENTE']}' class='btn btn-danger btn-sm'>Eliminar</a>";
                        echo "</td>";
                        echo "</tr>";
                    }
                    ?>
                </tbody>
            </table>
        </div>
    
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
