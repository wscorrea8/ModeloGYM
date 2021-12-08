<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;700&display=swap" rel="stylesheet">
  <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">-->
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
  $dsn = 'mysql:host=' . $config['db']['$dbhost'] . ';dbname=' . $config['db']['$dbname'];
  $conexion = new PDO($dsn, $config['db']['$dbusername'], $config['db']['$dbuserpassword'], $config['db']['options']);

  $consultaSQL = "SELECT * FROM empleado";

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
      <a href="crear_empleado.php"  class="btn btn-primary mt-4">Nuevo Registro</a>
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
  $consultaSQL = "SELECT * FROM persona WHERE primerApellido LIKE '%" . $_POST['papellido'] . "%'";
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
                <td><?php echo escapar($fila["idEmpleado"]); ?></td>
                <td><?php echo escapar($fila["primerNombre"]); ?></td>
                <td><?php echo escapar($fila["segundoNombre"]); ?></td>
                <td><?php echo escapar($fila["primerApellido"]); ?></td>
                <td><?php echo escapar($fila["segundoApellido"]); ?></td>
                <td><?php echo escapar($fila["direccion"]); ?></td>
                <td><?php echo escapar($fila["telefono"]); ?></td>
                <td><?php echo escapar($fila["email"]); ?></td>
                <td>
                  <a href="<?='eliminar_empleado.php?documento=' . escapar($fila["idEmpleado"]) ?>" . ><strong> 🗑️Eliminar</strong></a>
                  <a href="<?='actualizar_empleado.php?documento=' . escapar($fila["idEmpleado"]) ?>" . ><strong>✏️Actualizar</strong></a>
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