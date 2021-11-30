<?php
include 'funcions.php';

$config = include 'config.php';

$resultado = [
  'error' => false,
  'mensaje' => ''
];

if (!isset($_GET['documento'])) {
  $resultado['error'] = true;
  $resultado['mensaje'] = 'El Registro no existe';
}

if (isset($_POST['submit'])) {
  try {
    $dsn = 'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['name'];
    $conexion = new PDO($dsn, $config['db']['user'], $config['db']['pass'], $config['db']['options']);

    $alumno = array(
      "documento" => $_GET['documento'],
      "pnombre"   => $_POST['pnombre'],
      "papellido" => $_POST['papellido'],
      "email"     => $_POST['email'],
      "telefono"  => $_POST['telefono']
    );
    
    $consultaSQL = "UPDATE persona SET
        PRIMER_NOMB = :pnombre,
        PRIMER_APELL = :papellido,
        EMAIL = :email,
        NUMERO_TELEFONO = :telefono,
        updated_at = NOW()
        WHERE ID_PERSONA = :documento";
    
    $consulta = $conexion->prepare($consultaSQL);
    $consulta->execute($alumno);

  } catch(PDOException $error) {
    $resultado['error'] = true;
    $resultado['mensaje'] = $error->getMessage();
  }
}

try {
  $dsn = 'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['name'];
  $conexion = new PDO($dsn, $config['db']['user'], $config['db']['pass'], $config['db']['options']);
    
  $documento = $_GET['documento'];
  $consultaSQL = "SELECT * FROM persona WHERE ID_PERSONA =" . $documento;

  $sentencia = $conexion->prepare($consultaSQL);
  $sentencia->execute();

  $registro = $sentencia->fetch(PDO::FETCH_ASSOC);

  if (!$registro) {
    $resultado['error'] = true;
    $resultado['mensaje'] = 'No se ha encontrado el registro';
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
          El registro ha sido actualizado correctamente
        </div>
      </div>
    </div>
  </div>
  <?php
}
?>

<?php
if (isset($registro) && $registro) {
  ?>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <h2 class="mt-4">Editando el registro <?= escapar($registro['PRIMER_NOMB']) . ' ' . escapar($registro['PRIMER_APELL'])  ?></h2>
        <hr>
        <form method="post">
          <div class="form-group">
            <label for="pnombre">Nombre</label>
            <input type="text" name="pnombre" id="pnombre" value="<?= escapar($registro['PRIMER_NOMB']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <label for="papellido">Apellido</label>
            <input type="text" name="papellido" id="papellido" value="<?= escapar($registro['PRIMER_APELL']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <label for="email">Email</label>
            <input type="email" name="email" id="email" value="<?= escapar($registro['EMAIL']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <label for="telefono">Telefono</label>
            <input type="number" name="telefono" id="telefono" value="<?= escapar($registro['NUMERO_TELEFONO']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <input type="submit" name="submit" class="btn btn-primary" value="Actualizar">
            <a class="btn btn-primary" href="index.php">Regresar al inicio</a>
          </div>
        </form>
      </div>
    </div>
  </div>
  <?php
}
?>

<?php require "Templates/footer.php"; ?>
