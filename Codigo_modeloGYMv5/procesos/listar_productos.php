<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="css/styles.css">
  <title>Listar Productos</title>
</head>
<body>
    <div class="container p-3 my-3 bg-primary text-white">

<?php
include 'funcions.php';

csrf();

if (isset($_POST['submit']) && !hash_equals($_SESSION['csrf'], $_POST['csrf'])) {
  die();
}

$error = false;
$config = include 'config.php';

try {
  $dsn = 'mysql:host=' . $config['db']['$dbhost'] . ';dbname=' . $config['db']['$dbname'];
  $conexion = new PDO($dsn, $config['db']['$dbusername'], $config['db']['$dbuserpassword'], $config['db']['options']);

  $consultaSQL = "SELECT * FROM producto";

  $sentencia = $conexion->prepare($consultaSQL);
  $sentencia->execute();

  $registro = $sentencia->fetchAll();

} catch(PDOException $error) {
  $error= $error->getMessage();
}
?>

<?php include "templates/header.php"; ?>

<?php
if ($error) {
  ?>
  <div class="container mt-2">
    <div class="row">
      <div class="col-md-12">
        <div class="alert alert-danger" role="alert">
          <?= $error ?>
        </div>
      </div>
    </div>
  </div>
  <?php
}
?>

<div class="container">
  <div class="row">
    <div class="col-md-12">
      <a href="crear_productos.php"  class="btn btn-primary mt-4">Nuevo Producto</a>
      <hr>

      <form method="post" class="form-inline">
        <div class="form-group mr-3">
          <input type="text" id="nombreProducto" name="nombreProducto" placeholder="Buscar por nombreProducto" class="form-control">
        </div>
        <button type="submit" name="submit" class="btn btn-primary">Filtar</button>
      </form>
    </div>
  </div>
</div>

<?php

if (isset($_POST['nombreProducto'])) {
  $consultaSQL = "SELECT * FROM producto WHERE nombreProducto LIKE '%" . $_POST['nombreProducto'] . "%'";
} else {
  $consultaSQL = "SELECT * FROM producto";
}
?>

<div class="container">
  <div class="row">
    <div class="col-md-12">
      <h2 class="mt-3">Lista de Productos</h2>
      <table class="table">
        <thead>
          <tr>
            <th>Código Producto</th>
            <th>Nombre Producto</th>
            <th>Descripción</th>
            <th>Cantidad</th>
            <th>Valor</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          <?php
          if ($registro && $sentencia->rowCount() > 0) {
            foreach ($registro as $fila) {
              ?>
              <tr>
                <td><?php echo escapar($fila["idProducto"]); ?></td>
                <td><?php echo escapar($fila["nombreProducto"]); ?></td>
                <td><?php echo escapar($fila["descripcion"]); ?></td>
                <td><?php echo escapar($fila["cantidad"]); ?></td>
                <td><?php echo escapar($fila["valor"]); ?></td>
                <td>
                  <a href="<?= 'eliminar_producto.php?producto=' . escapar($fila["idProducto"]) ?>" . >🗑️Eliminar</a>
                  <a href="<?= 'actualizar_producto.php?producto=' . escapar($fila["idProducto"]) ?>" . >✏️Actualizar</a>
                </td>
              </tr>
              <?php
            }
          }
          ?>
        </tbody>
      </table>
    </div>
  </div>
</div>

<?php include "templates/footer.php"; ?>
</div>
</body>
</html>

?>
