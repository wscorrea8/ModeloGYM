<?php 

 class database{
 	private static $dbhost = "localhost";
 	private static $dbname = "modelogymv4";
 	private static $dbusername = "root";
 	private static $dbuserpassword = "";

 	public static function conectar(){
 	try {

$pdo = new PDO("mysql:host=".self::$dbhost.";dbname=".self::$dbname,self::$dbusername,self::$dbuserpassword);
$pdo->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
	return $pdo;
 	} catch(Exception $e){
 		die($e->getMessage());
 		}
	 }
}
?>


<!--+++++++++++++++++++++Conexion por Msqli ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

	<!--	
		<?php  /*
					$host="localhost";
					$user="root";
					$pass="";
					$db="modelogymv4";

					$conexion = new mysqli($host,$user,$pass,$db);
					
    //PERMITE VISUALIZAR POR PANTALLA LA CONEXION A LA BASE DE DATOS MOSTRANDO UN MENSAJE

					if ($conexion -> connect_error){
					  echo "la conexion fallo";// MENSAJE DE FALLO
					} else
					  echo "conexion establecida!!"; // MENSAJE DE CONEXION
			*/	 ?>
-->
