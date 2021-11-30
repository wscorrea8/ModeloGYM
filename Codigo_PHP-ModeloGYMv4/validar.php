
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/styles.css">
	<title>Bienvenidos!!!</title>
</head>
<body>
<div class="container p-3 my-3 bg-primary text-white">

			
<?php

// Grab User submitted information
$id_usuario = $_POST["id_usuario"];
$pwd = $_POST["pwd"];

// Connect to the database
$pdo = mysqli_connect("localhost","root","","modelogymv4");
// Make sure we connected successfully
if(! $pdo)
{
    die('Connection Failed'.mysql_error());
}

$query = "SELECT * FROM usuarios WHERE ID_USUARIO = '$id_usuario' and PASWORD = '$pwd'";
$result = mysqli_query($pdo, $query);
$row = mysqli_fetch_array($result);


// query eka variable ekata aran passe execute karaon 
if($row["ID_USUARIO"]==$id_usuario && $row["PASWORD"]==$pwd)
    echo"<h2>Bienvenidos a Modelo GYM</h2>.";
else
    echo"<h3>Lo siento, sus credenciales no son válidas, Por favor inténtelo de nuevo.</h3>";
?>

 <img src="https://previews.123rf.com/images/peshkova/peshkova1709/peshkova170900033/85047503-manos-femeninas-que-sostienen-el-holograma-abstracto-del-candado-en-fondo-borroso-concepto-de-protec.jpg" width="600" height="300"><br

</div>

</body>
</html>



<!--
<?php /*
	require_once '../conexion.php';
	$id_usuario=$_POST["id_usuario"];
	$pwd=$_POST["pwd"];

	echo "$id_usuario","<br>";
	echo "$pwd";

class login
		{

			    public function login_user($id_usuario,$pwd){
				session_start();
				$db = database::conectar();

				$cont=0;

				$sql2="SELECT * FROM usuarios WHERE ID_USUARIO ='$id_usuario' AND PASWORD ='$pwd'";
				$query = $db->query($sql2);


				echo $sql2;exit();// muestra la consulta a BD

				while ($row2=$query->fetch(PDO::FETCH_ASSOC))
				 {
					$usuario2 = stripslashes($row2["ID_USUARIO"]);
					$pwd2 = stripslashes($row2["PASWORD"]);
				$cont=$cont+1;
				}
				if ($cont==0) {
				
					print "<script>alert(\"Usuario y/o Password Incorrectos.\");window.location='../index.php';</script>";
		}
	}
 }
 		 $nuevo = new login();
         $nuevo->login_user($_POST["$id_usuario"],$_POST["$pwd"]);*/
?>
-->