<?php
	$config = include 'config.php';

	try {
	$conexion= new PDO('mysql:host' . $config['db']['host'],$config['db']['user'],$config['db']['pass'],$config['db']['options']);
	$sql = file_get_contents("data/migracion.sql");

	$conexion->exec($sql);
	echo "La Bd y las tablas se crearon correctamente";
}   catcha(PDOException $error){
	echo $error->getMessage();
}
?>