<?php 
	session_start();
	unset($_SESSION['usuario']);
?>
<!DOCTYPE html>
<html>
<head>
	<title></title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<header>
	<div class="container p-3 my-3 bg-primary text-white">
		<h1>Bienvenido a Modelo GYM</h1>
		<img src="images/login-img.png" width="500" height="350" >
	    <h2>Login</h2>
	<form action="controller_login.php" method="post">
	<div class="row">
		   <div class="col">
	        <input class="form-control" type="text" name="usuario" placeholder="Usuario">
	   	   </div>

	       <div class="col">
		   <input class="form-control" type="password" name="pas" placeholder="Password">
		   </div>
		   </div> <br> 
		    <div class="btn-group">
			<input type="hidden" name="entrar" value="entrar">
			<button type="submit" class="btn btn-success">Ingresar</button>
			<a type="button" class="btn btn-primary" href="registrarse.php">Registrate Aquí</a>
		    <a type="button" class="btn btn-primary" href="#">Olvido su Contraseña</a>
		   </div>
	</form>
	<br>
<footer>
	<div class="w3-container w3-black">
	<h4>Modelo GYM 2021 &copy; </h4>
	</div>
</footer>
	</div>
</header>
</body>
</html>