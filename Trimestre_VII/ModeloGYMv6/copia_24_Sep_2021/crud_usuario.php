<?php 
	require_once('conexion.php');
	require_once('usuario.php');
	
	class CrudUsuario{

		public function __construct(){}

		//inserta los datos del usuario
		public function insertar($usuario){
			$db=DB::conectar();
			$insert=$db->prepare('INSERT INTO usuarios VALUES(NULL,:nombre, :pwd)');
			$insert->bindValue('nombre',$usuario->getNombre());
			//encripta la clave
			$pass=password_hash($usuario->getClave(),PASSWORD_DEFAULT);
			$insert->bindValue('pwd',$pass);
			$insert->execute();
		}

		//obtiene el usuario para el login
		public function obtenerUsuario($nombre, $clave){
			$db=Db::conectar();
			$select=$db->prepare('SELECT * FROM usuarios WHERE nombre=:nombre');//AND clave=:clave
			$select->bindValue('nombre',$nombre);
			$select->execute();
			$registro=$select->fetch();
			$usuario=new Usuario();
			//verifica si la clave es conrrecta
			if (password_verify($clave, $registro['pwd'])) {				
				//si es correcta, asigna los valores que trae desde la base de datos
				$usuario->setId($registro['idUsuario']);
				$usuario->setNombre($registro['nombre']);
				$usuario->setClave($registro['pwd']);
			}			
			return $usuario;
		}

		//busca el nombre del usuario si existe
		public function buscarUsuario($nombre){
			$db=Db::conectar();
			$select=$db->prepare('SELECT * FROM usuarios WHERE nombre=:nombre');
			$select->bindValue('nombre',$nombre);
			$select->execute();
			$registro=$select->fetch();
			if($registro['idUsuario']!=NULL){
				$usado=False;
			}else{
				$usado=True;
			}	
			return $usado;
		}
	}
?>