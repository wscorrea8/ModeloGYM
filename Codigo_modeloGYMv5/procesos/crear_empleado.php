<?php include "funcions.php"; ?>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/styles.css">
	<title>Registro Empleado</title>
</head>
<body>

  	<div class="container p-3 my-3 bg-primary text-white">
<?php
if (isset($_POST['submit'])) {
  $resultado = [
    'error' => false,
    'mensaje' => 'Se Registro el Empleado ||  ' . escapar($_POST['pnombre']) . " ".escapar($_POST['papellido']).' || con éxito!!!' 
  ];
  $config = include 'config.php';

  try {
    $dsn = 'mysql:host=' . $config['db']['$dbhost'] . ';dbname=' . $config['db']['$dbname'];
    $conexion = new PDO($dsn, $config['db']['$dbusername'], $config['db']['$dbuserpassword'], $config['db']['options']);

    $registro = array(
      "documento" => $_POST['documento'],
      "pnombre"   => $_POST['pnombre'],
      "snombre"   => $_POST['snombre'],
      "papellido" => $_POST['papellido'],
      "sapellido" => $_POST['sapellido'],
      "direccion" => $_POST['direccion'],
      "telefono"  => $_POST['telefono'],
      "email"     => $_POST['email'],
      
    );
    
    $consultaSQL = "INSERT INTO empleado (idEmpleado,primerNombre,segundoNombre,primerApellido,segundoApellido, direccion,telefono,email)";
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
      <h2 class="mt-4">Registrar Empleado ModeloGYM</h2>
      <hr>
      <form method="post">

      	<div class="form-group">
          <label for="documento">Documento</label>
          <input type="number" name="documento" id="documento" class="form-control" placeholder="Número Documento">
        </div>

        <div class="form-group">
          <!--<label for="pnombre">Primer Nombre</label>-->
          <input type="text" name="pnombre" id="pnombre" style="text-transform: uppercase" class="form-control" placeholder="primer nombre">
        </div>
        <div class="form-group">
         <!-- <label for="snombre">Segundo Nombre</label>-->
          <input type="text" name="snombre" id="snombre" style="text-transform: uppercase" class="form-control" placeholder="Segundo Nombre">
        </div>
        <div class="form-group">
          <!--<label for="papellido">Primer Apellido</label>-->
          <input type="text" name="papellido" id="papellido" style="text-transform: uppercase" class="form-control" placeholder="primer apellido">
        </div>
        <div class="form-group">
          <!--<label for="sapellido">Segundo Apellido</label>-->
          <input type="text" name="sapellido" id="sapellido" style="text-transform: uppercase" class="form-control" placeholder="segundo apellido">
        </div>
        <div class="form-group">
          <!--<label for="direccion">Dirección</label>-->
          <input type="text" name="direccion" id="direccion" class="form-control" placeholder="DIRECCION">
        </div>
        <div class="form-group">
          <!--<label for="telefono">Telefono</label>-->
          <input type="number" name="telefono" id="telefono" class="form-control" placeholder="TELEFONO">
        </div>
        <div class="form-group">
         <!-- <label for="email">Email</label>-->
          <input type="email" name="email" id="email" class="form-control" placeholder="EMAIL">
        </div>
              
        <div class="form-group">
          <input type="submit" name="submit" class="btn btn-primary" value="Enviar">
          <a class="btn btn-primary" href="listar_empleado.php"><strong>Listar Registros</strong></a>
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