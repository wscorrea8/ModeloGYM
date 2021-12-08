<?php 
	session_start();
	if (!isset($_SESSION['usuario'])) {
		header('Location: index.php');
	}
?>

<!DOCTYPE html>
<html>
<head>
	<title>Tu cuenta</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
	<!-- Latest compiled and minified CSS -->
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
   <!-- jQuery library -->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   <!-- Popper JS -->
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
   <!-- Latest compiled JavaScript -->
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<header>
	    <div class="container p-3 my-3 bg-primary text-white">
	    	<!-- Inicio Barra Menu -->

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <ul class="navbar-nav">
    <li class="nav-item active">
      <a class="nav-link" href="procesos/crear_empleado.php">EMPLEADO |</a>
    </li>
    <li class="nav-item active">
      <a class="nav-link" href="procesos/crear_cliente.php">CLIENTE |</a>
    </li>
    <li class="nav-item active">
      <a class="nav-link" href="procesos/crear_productos.php">PRODUCTO |</a>
    </li>
    <li class="nav-item active">
      <a class="nav-link" href="#">ROLES USUARIO</a>
    </li>
  </ul>
</nav>
	        <!-- Fin Barra Menu -->
	
		
			<h3>CUENTA ADMINISTRADOR Modelo GYM</h3>
			<img src="images/logo.png" width="1110" height="300">

		
		<p></p>
		<form action="controller_login.php" method="post">
			<input type="hidden" name="salir" value="salir">
			<button type="submit" class="btn btn-danger">Salir del Sistema</button>
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