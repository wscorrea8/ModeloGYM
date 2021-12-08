<?php
include 'funcions.php';

$config = include 'config.php';

$resultado = [
  'error' => false,
  'mensaje' => ''
];

if (!isset($_GET['documento'])) {
  $resultado['error'] = true;
  $resultado['mensaje'] = 'El Cliente no existe';
}

if (isset($_POST['submit'])) {
  try {
    $dsn = 'mysql:host=' . $config['db']['$dbhost'] . ';dbname=' . $config['db']['$dbname'];
    $conexion = new PDO($dsn, $config['db']['$dbusername'], $config['db']['$dbuserpassword'], $config['db']['options']);

    $cliente = [
      "documento" => $_GET['documento'],
      "pnombre"   => $_POST['pnombre'],
      "papellido" => $_POST['papellido'],
      "telefono"  => $_POST['telefono'],
      "email"     => $_POST['email']
      
    ];
    
    $consultaSQL = "UPDATE cliente SET
        primerNombre = :pnombre,
        primerApellido = :papellido,
        telefono = :telefono,
        email = :email
        WHERE idCliente = :documento";
    
    $consulta = $conexion->prepare($consultaSQL);
    $consulta->execute($cliente);

  } catch(PDOException $error) {
    $resultado['error'] = true;
    $resultado['mensaje'] = $error->getMessage();
  }
}

try {
  $dsn = 'mysql:host=' . $config['db']['$dbhost'] . ';dbname=' . $config['db']['$dbname'];
  $conexion = new PDO($dsn, $config['db']['$dbusername'], $config['db']['$dbuserpassword'], $config['db']['options']);
    
  $documento = $_GET['documento'];
  $consultaSQL = "SELECT * FROM cliente WHERE idCliente =" . $documento;

  $sentencia = $conexion->prepare($consultaSQL);
  $sentencia->execute();

  $cliente = $sentencia->fetch(PDO::FETCH_ASSOC);

  if (!$cliente) {
    $resultado['error'] = true;
    $resultado['mensaje'] = 'No se ha encontrado el Cliente';
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
          El Cliente ha sido actualizado correctamente
        </div>
      </div>
    </div>
  </div>
  <?php
}
?>

<?php
if (isset($cliente) && $cliente) {
  ?>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <h2 class="mt-4">Editando el cliente <?= escapar($cliente['primerNombre']) . ' ' . escapar($cliente['primerApellido']) ?></h2>
        <hr>
        <form method="post">
          <div class="form-group">
            <label for="pnombre">Nombre</label>
            <input type="text" name="pnombre" id="pnombre" value="<?= escapar($cliente['primerNombre']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <label for="papellido">Apellido</label>
            <input type="text" name="papellido" id="papellido" value="<?= escapar($cliente['primerApellido']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <label for="email">Email</label>
            <input type="email" name="email" id="email" value="<?= escapar($cliente['email']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <label for="telefono">telefono</label>
            <input type="number" name="telefono" id="telefono" value="<?= escapar($cliente['telefono']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <input type="submit" name="submit" class="btn btn-primary" value="Actualizar">
            <a class="btn btn-primary" href="listar_cliente.php">Regresar al Listar</a>
          </div>
        </form>
      </div>
    </div>
  </div>
  <?php
}
?>

<?php require "Templates/footer.php"; ?>