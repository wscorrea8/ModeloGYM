<?php
include 'funcions.php';

$config = include 'config.php';

$resultado = [
  'error' => false,
  'mensaje' => ''
];

if (!isset($_GET['documento'])) {
  $resultado['error'] = true;
  $resultado['mensaje'] = 'El Empleado no existe';
}

if (isset($_POST['submit'])) {
  try {
    $dsn = 'mysql:host=' . $config['db']['$dbhost'] . ';dbname=' . $config['db']['$dbname'];
    $conexion = new PDO($dsn, $config['db']['$dbusername'], $config['db']['$dbuserpassword'], $config['db']['options']);

    $empleado = [
      "documento" => $_GET['documento'],
      "pnombre"   => $_POST['pnombre'],
      "papellido" => $_POST['papellido'],
      "telefono"  => $_POST['telefono'],
      "email"     => $_POST['email']
      
    ];
    
    $consultaSQL = "UPDATE empleado SET
        primerNombre = :pnombre,
        primerApellido = :papellido,
        telefono = :telefono,
        email = :email
        WHERE idEmpleado = :documento";
    
    $consulta = $conexion->prepare($consultaSQL);
    $consulta->execute($empleado);

  } catch(PDOException $error) {
    $resultado['error'] = true;
    $resultado['mensaje'] = $error->getMessage();
  }
}

try {
  $dsn = 'mysql:host=' . $config['db']['$dbhost'] . ';dbname=' . $config['db']['$dbname'];
  $conexion = new PDO($dsn, $config['db']['$dbusername'], $config['db']['$dbuserpassword'], $config['db']['options']);
    
  $documento = $_GET['documento'];
  $consultaSQL = "SELECT * FROM empleado WHERE idEmpleado =" . $documento;

  $sentencia = $conexion->prepare($consultaSQL);
  $sentencia->execute();

  $empleado = $sentencia->fetch(PDO::FETCH_ASSOC);

  if (!$empleado) {
    $resultado['error'] = true;
    $resultado['mensaje'] = 'No se ha encontrado el empleado';
  }

} catch(PDOException $error) {
  $resultado['error'] = true;
  $resultado['mensaje'] = $error->getMessage();
}
?>

<?php require "Templates/header.php"; ?>

<?php
if ($resultado['error']) {
  ?>
  <div class="container mt-2">
    <div class="row">
      <div class="col-md-12">
        <div class="alert alert-danger" role="alert">
          <?= $resultado['mensaje'] ?>
        </div>
      </div>
    </div>
  </div>
  <?php
}
?>

<?php
if (isset($_POST['submit']) && !$resultado['error']) {
  ?>
  <div class="container mt-2">
    <div class="row">
      <div class="col-md-12">
        <div class="alert alert-success" role="alert">
          El empleado ha sido actualizado correctamente
        </div>
      </div>
    </div>
  </div>
  <?php
}
?>

<?php
if (isset($empleado) && $empleado) {
  ?>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <h2 class="mt-4">Editando el empleado <?= escapar($empleado['primerNombre']) . ' ' . escapar($empleado['primerApellido']) ?></h2>
        <hr>
        <form method="post">
          <div class="form-group">
            <label for="pnombre">Nombre</label>
            <input type="text" name="pnombre" id="pnombre" value="<?= escapar($empleado['primerNombre']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <label for="papellido">Apellido</label>
            <input type="text" name="papellido" id="papellido" value="<?= escapar($empleado['primerApellido']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <label for="email">Email</label>
            <input type="email" name="email" id="email" value="<?= escapar($empleado['email']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <label for="telefono">telefono</label>
            <input type="number" name="telefono" id="telefono" value="<?= escapar($empleado['telefono']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <input type="submit" name="submit" class="btn btn-primary" value="Actualizar">
            <a class="btn btn-primary" href="listar_empleado.php">Regresar al Listar</a>
          </div>
        </form>
      </div>
    </div>
  </div>
  <?php
}
?>

<?php require "Templates/footer.php"; ?>