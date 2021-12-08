<?php include "funcions.php"; ?>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/styles.css">
	<title>Registro Productos</title>
</head>
<body>

  	<div class="container p-3 my-3 bg-primary text-white">
<?php
if (isset($_POST['submit'])) {
  $resultado = [
    'error' => false,
    'mensaje' => 'Se Registro el Producto ||  ' . escapar($_POST['nombreProducto']) . ", $".escapar($_POST['valor']).' ||pesos, con éxito!!!' 
  ];
  $config = include 'config.php';

  try {
    $dsn = 'mysql:host=' . $config['db']['$dbhost'] . ';dbname=' . $config['db']['$dbname'];
    $conexion = new PDO($dsn, $config['db']['$dbusername'], $config['db']['$dbuserpassword'], $config['db']['options']);

    $registro = array(
      "producto" => $_POST['idProducto'],
      "nombreProducto" => $_POST['nombreProducto'],
      "descripcion" => $_POST['descripcion'],
      "cantidad" => $_POST['cantidad'],
      "valor" => $_POST['valor'],    
    );
    
    $consultaSQL = "INSERT INTO producto (idProducto,nombreProducto,descripcion,cantidad,valor)";
    $consultaSQL .= "values (:" . implode(", :", array_keys($registro)) . ")";
    
    $sentencia = $conexion->prepare($consultaSQL);
    $sentencia->execute($registro);

  } catch(PDOException $error) {
    $resultado['error'] = true;
    $resultado['mensaje'] = $error->getMessage();
  }
}
?>

<?php include "Templates/header.php"; ?>

<?php
if (isset($resultado)) {
  ?>
  <div class="container mt-3">
    <div class="row">
      <div class="col-md-12">
        <div class="alert alert-<?= $resultado['error'] ? 'danger' : 'success' ?>" role="alert">
          <?= $resultado['mensaje'] ?>
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
      <h2 class="mt-4">Registrar Productos ModeloGYM</h2>
      <hr>
      <form method="post">

     

      	<div class="form-group">
          <label for="idProducto">IdProducto</label>
          <input type="number" name="idProducto" id="idProducto" class="form-control" placeholder="Código Producto">
        </div>

        <div class="form-group">
          <!--<label for="pnombre">Primer Nombre</label>-->
          <input type="text" name="nombreProducto" id="nombreProducto" style="text-transform: uppercase" class="form-control" placeholder="Nombre Producto">
        </div>
        <div class="form-group">
         <!-- <label for="snombre">Segundo Nombre</label>-->
          <input type="text" name="descripcion" id="descripcion" style="text-transform: uppercase" class="form-control" placeholder="Descripción">
        </div>
        <div class="form-group">
          <!--<label for="papellido">Primer Apellido</label>-->
          <input type="number" name="cantidad" id="cantidad" style="text-transform: uppercase" class="form-control" placeholder="Cantidad">
        </div>
        <div class="form-group">
          <!--<label for="sapellido">Segundo Apellido</label>-->
          <input type="number" name="valor" id="valor" style="text-transform: uppercase" class="form-control" placeholder="Valor">
        </div>
                    
        <div class="form-group">
          <input type="submit" name="submit" class="btn btn-primary" value="Enviar">
          <a class="btn btn-primary" href="listar_productos.php"><strong>Listar Productos</strong></a>
          <a class="btn btn-primary"  href="../cuenta.php"><strong>Inicio</strong></a>
        </div>
     
        </form>
          
      </div>
  </div>
</div>

<?php include "Templates/footer.php"; ?>
</div>
</body>
</html>