<?php 
	class Db{
		private static $conexion=null;
		private function __construct(){}

		public static function conectar(){
			$pdo_options[PDO::ATTR_ERRMODE]=PDO::ERRMODE_EXCEPTION;
			self::$conexion=new PDO('mysql:host=localhost;dbname=id16114407_modelogymv5','id16114407_root','K1|=)!lm7Y2yH)7s',$pdo_options);
			return self::$conexion;
		}
	}
?>