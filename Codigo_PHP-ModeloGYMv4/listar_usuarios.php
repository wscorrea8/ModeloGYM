<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="css/styles.css">
  <title>Listar Registros</title>
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
  $dsn = 'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['name'];
  $conexion = new PDO($dsn, $config['db']['user'], $config['db']['pass'], $config['db']['options']);

  $consultaSQL = "SELECT * FROM persona";

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
      <a href="crear.php"  class="btn btn-primary mt-4">Nuevo Registro</a>
      <hr>

      <form method="post" class="form-inline">
        <div class="form-group mr-3">
          <input type="text" id="papellido" name="papellido" placeholder="Buscar por apellido" class="form-control">
        </div>
        <button type="submit" name="submit" class="btn btn-primary">Filtar</button>
      </form>
    </div>
  </div>
</div>

<?php

if (isset($_POST['papellido'])) {
  $consultaSQL = "SELECT * FROM persona WHERE PRIMER_APELL LIKE '%" . $_POST['papellido'] . "%'";
} else {
  $consultaSQL = "SELECT * FROM persona";
}
?>

<div class="container">
  <div class="row">
    <div class="col-md-12">
      <h2 class="mt-3">Lista de Registros</h2>
      <table class="table">
        <thead>
          <tr>
            <th>N° Documento</th>
            <th>P. Nombre</th>
            <th>S. Nombre</th>
            <th>P. Apellido</th>
            <th>S. Apellido</th>
            <th>Direccion</th>
            <th>Telefono</th>
            <th>Email</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          <?php
          if ($registro && $sentencia->rowCount() > 0) {
            foreach ($registro as $fila) {
              ?>
              <tr>
                <td><?php echo escapar($fila["ID_PERSONA"]); ?></td>
                <td><?php echo escapar($fila["PRIMER_NOMB"]); ?></td>
                <td><?php echo escapar($fila["SEGUNDO_NOMB"]); ?></td>
                <td><?php echo escapar($fila["PRIMER_APELL"]); ?></td>
                <td><?php echo escapar($fila["SEGUNDO_APELL"]); ?></td>
                <td><?php echo escapar($fila["DIRECCION"]); ?></td>
                <td><?php echo escapar($fila["NUMERO_TELEFONO"]); ?></td>
                <td><?php echo escapar($fila["EMAIL"]); ?></td>
                <td>
                  <a href="<?= 'eliminar.php?documento=' . escapar($fila["ID_PERSONA"]) ?>" . >🗑️Eliminar</a>
                  <a href="<?= 'actualizar.php?documento=' . escapar($fila["ID_PERSONA"]) ?>" . >✏️Actualizar</a>
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
