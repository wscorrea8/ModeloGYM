<?php
include 'funcions.php';

$config = include 'config.php';

$resultado = [
  'error' => false,
  'mensaje' => ''
];

if (!isset($_GET['producto'])) {
  $resultado['error'] = true;
  $resultado['mensaje'] = 'El producto no existe';
}

if (isset($_POST['submit'])) {
  try {
    $dsn = 'mysql:host=' . $config['db']['$dbhost'] . ';dbname=' . $config['db']['$dbname'];
    $conexion = new PDO($dsn, $config['db']['$dbusername'], $config['db']['$dbuserpassword'], $config['db']['options']);

    $product = [
      "producto" => $_GET['producto'],
      "nproducto"   => $_POST['nproducto'],
      "descripcion" => $_POST['descripcion'],
      "cantidad"  => $_POST['cantidad'],
      "valor"     => $_POST['valor']
      
    ];
    
    $consultaSQL = "UPDATE producto SET
        nombreProducto = :nproducto,
        descripcion = :descripcion,
        cantidad = :cantidad,
        valor = :valor
        WHERE idProducto = :producto";
    
    $consulta = $conexion->prepare($consultaSQL);
    $consulta->execute($product);

  } catch(PDOException $error) {
    $resultado['error'] = true;
    $resultado['mensaje'] = $error->getMessage();
  }
}

try {
  $dsn = 'mysql:host=' . $config['db']['$dbhost'] . ';dbname=' . $config['db']['$dbname'];
  $conexion = new PDO($dsn, $config['db']['$dbusername'], $config['db']['$dbuserpassword'], $config['db']['options']);
    
  $producto = $_GET['producto'];
  $consultaSQL = "SELECT * FROM producto WHERE idProducto =" . $producto;

  $sentencia = $conexion->prepare($consultaSQL);
  $sentencia->execute();

  $product = $sentencia->fetch(PDO::FETCH_ASSOC);

  if (!$product) {
    $resultado['error'] = true;
    $resultado['mensaje'] = 'No se ha encontrado el Producto';
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
          El Producto ha sido actualizado correctamente
        </div>
      </div>
    </div>
  </div>
  <?php
}
?>

<?php
if (isset($product) && $product) {
  ?>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <h2 class="mt-4">Editando el producto <?= escapar($product['nombreProducto']) . ' $' . escapar($product['valor']) ?></h2>
        <hr>
        <form method="post">
          <div class="form-group">
            <label for="nproducto">Nombre Producto</label>
            <input type="text" name="nproducto" id="nproducto" value="<?= escapar($product['nombreProducto']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <label for="descripcion">Descripción</label>
            <input type="text" name="descripcion" id="descripcion" value="<?= escapar($product['descripcion']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <label for="cantidad">Cantidad</label>
            <input type="number" name="cantidad" id="cantidad" value="<?= escapar($product['cantidad']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <label for="valor">Valor</label>
            <input type="number" name="valor" id="valor" value="<?= escapar($product['valor']) ?>" class="form-control">
          </div>
          <div class="form-group">
            <input type="submit" name="submit" class="btn btn-primary" value="Actualizar">
            <a class="btn btn-primary" href="listar_productos.php">Regresar al Listar</a>
          </div>
        </form>
      </div>
    </div>
  </div>
  <?php
}
?>

<?php require "Templates/footer.php"; ?>