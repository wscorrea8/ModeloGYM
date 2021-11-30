<!DOCTYPE html>
<html>
<head>
	<title>Registrarse</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
</head>
<body>
<header>
	<div class="container p-3 my-3 bg-primary text-white">
		<h1>Bienvenido a Modelo GYM</h1>
		<img src="images/login.png" width="256" height="256" >
			<h1>Registre su Usuario</h1>
	<form action="controller_login.php" method="post">
		<div class="row">
			<div class="col">
				<label>Nombre de usuario o correo electrónico</label>
				<input class="form-control" type="text" name="usuario">
			</div>

		    <div class="col">
				<label>Password</label>
				<input class="form-control" type="password" name="pas">
			</div>
		</div> <br>
		<div class="btn-group">
			<input type="hidden" name="registrarse" value="registrarse">
			<button type="submit" class="btn btn-success">Registrarse</button>
			<a type="button" class="btn btn-primary" href="index.php">Ahora no</a>
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