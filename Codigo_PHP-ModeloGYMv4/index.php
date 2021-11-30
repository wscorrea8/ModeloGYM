<?php include 'config.php';
      include "Templates/header.php";
    ?>
<?php
  require 'PHPMailer/PHPMailerAutoload.php';
  
  $mail = new PHPMailer();
  
  $mail->isSMTP();
  $mail->SMTPAuth = true;
  $mail->SMTPSecure = 'tls';
  $mail->Host = 'smtp.gmail.com';
  $mail->Port = 587;
  
  $mail->Username = 'sercorrea30@gmail.com'; //Correo de donde enviaremos los correos
  $mail->Password = 'ANOhJ7iwD'; // Password de la cuenta de envío
  
  $mail->setFrom('sercorrea30@gmail.com', 'Emisor');
  $mail->addAddress('wscorrea8@misena.edu.co', 'Receptor'); //Correo receptor,
  
  
  $mail->Subject = 'Titulo de correo';
  $mail->Body    = 'Contenido del correo';
  $mail->IsHTML(true);
  
  if($mail->send()) {
    echo 'Envio de Correo Exitoso!!!';
    } else {
    echo 'Error al enviar correo';
  }
?>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/styles.css">
	<title>Inicio de Sesion</title>
</head>
<body>
 <form action="validar.php" method="POST">
  	<div class="container p-3 my-3 bg-primary text-white">
  		<h2>Login Usuario</h2>
  		 <img src="https://previews.123rf.com/images/peshkova/peshkova1709/peshkova170900033/85047503-manos-femeninas-que-sostienen-el-holograma-abstracto-del-candado-en-fondo-borroso-concepto-de-protec.jpg" width="600" height="300" ><br><br>
       <form>
    <div class="row">
      <div class="col">
        <input type="text" class="form-control" id="id_usuario" placeholder="Enter Usuario" name="id_usuario">
      </div>
      <div class="col">
        <input type="password" class="form-control" placeholder="Enter password" name="pwd" id="pwd"><br>
      </div>
    </div>
     <div class="btn-group">
    <button type="submit">Ingresar</button>
    <a type="button" class="btn btn-primary" href="crear.php">Registrarse</a>
    <a type="button" class="btn btn-primary" href="recupera.php">Olvido su Contraseña</a>
    </div> 
</form>
    </div>

     <?php include "Templates/footer.php"; ?>
</form> 
</body>
</html>


  