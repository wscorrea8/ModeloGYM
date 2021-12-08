<?php
include 'funcions.php';

csrf();

if (isset($_POST['submit']) && !hash_equals($_SESSION['csrf'], $_POST['csrf'])) {
  die();
}

$config = include 'config.php';

$resultado = [
  'error' => false,
  'mensaje' => ''
];

try {
  $dsn = 'mysql:host=' . $config['db']['$dbhost'] . ';dbname=' . $config['db']['$dbname'];
  $conexion = new PDO($dsn, $config['db']['$dbusername'], $config['db']['$dbuserpassword'], $config['db']['options']);
    
  $documento = $_GET['documento'];
  $consultaSQL = "DELETE FROM cliente WHERE idCliente =" . $documento;

  $sentencia = $conexion->prepare($consultaSQL);
  $sentencia->execute();
 header("Location:listar_cliente.php");

} catch(PDOException $error) {
  $resultado['error'] = true;
  $resultado['mensaje'] = $error->getMessage();
}
?>

<?php require "Templates/header.php"; ?>

<div class="container mt-2">
  <div class="row">
    <div class="col-md-12">
      <div class="alert alert-danger" role="alert">
        <?= $resultado['mensaje'] ?>
      </div>
    </div>
  </div>
</div>

<?php require "Templates/footer.php"; ?>