CREATE DATABASE ModeloGYMV4 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE ModeloGYMV4;
DROP database ModeloGYMV4;



			--- TIPO DE DOCUMENTO # 1---

CREATE TABLE TIPO_DOCUMENTO
	(
		ID_TIPODOCUMENTO INT(2) NOT NULL,-- cambio tipo de dato
        NOMBRE VARCHAR(5) NOT NULL,-- nuevo campo
		DESCRIPCION_DOCU VARCHAR(50) NOT NULL,
		PRIMARY KEY (ID_TIPODOCUMENTO)
		)engine=InnoDB;
        
        		--- EMPLEADO # 2---

CREATE TABLE EMPLEADO
	(
		ID_EMPLEADO INT(4) NOT NULL,-- cambio tipo de dato
        CARGO_EMPLEADO VARCHAR(30) NOT NULL,-- nuevo campo
        DESCRIPCION_CARGO TEXT NULL,-- nuevo campo
		FECHA_CONTRATACION DATE NOT NULL,
        SALARIO decimal(9,2) NOT NULL,-- nuevo campo
		PRIMARY KEY (ID_EMPLEADO)
	)engine=InnoDB;
            
            		--- FACTOR RH # 3---
CREATE TABLE FACTOR_RH
	(
		ID_RH INT(2) NOT NULL, -- cambio tipo de dato
        FACTOR_RH VARCHAR(10) NOT NULL, -- nuevo campo
		PRIMARY KEY (ID_RH)
	)engine=InnoDB;
    
    --- GRUPO SANGUINEO # 4---
    
    CREATE TABLE GRUPO_SANGUINEO
    (
	  ID_GRUPO INT(2) NOT NULL,
      GRUPO_SANGUINEO VARCHAR(2) NOT NULL,
      PRIMARY KEY(ID_GRUPO)
	)engine=InnoDB;
    
			--- GENERO # 5---

CREATE TABLE GENERO
	(	
		ID_GENERO INT(2) NOT NULL, -- cambio tipo de dato
        NOMBRE VARCHAR(5) NOT NULL, -- nuevo campo
		DESCRIPCION_GENE VARCHAR(10) NOT NULL, -- nuevo campo
		PRIMARY KEY (ID_GENERO)
		)engine=InnoDB;
            
               		--- USUARIO # 6---

CREATE TABLE USUARIOS
	(
		ID_USUARIO INT AUTO_INCREMENT NOT NULL,
        NOMBRE VARCHAR(30) NOT NULL,
		PASWORD VARCHAR(20) NOT NULL,
		PRIMARY KEY (ID_USUARIO)
	)engine=InnoDB;
       
  ALTER TABLE USUARIOS AUTO_INCREMENT=7000;
  			--- PERSONA # 7---

CREATE TABLE PERSONA
	(
		ID_PERSONA INT(15) NOT NULL,
		PRIMER_NOMB VARCHAR(15) NOT NULL,
		SEGUNDO_NOMB VARCHAR(15) NULL,
		PRIMER_APELL VARCHAR(15) NOT NULL,
		SEGUNDO_APELL VARCHAR(15) NULL,
		DIRECCION VARCHAR(35) NULL,
		NUMERO_TELEFONO BIGINT(15) NOT NULL,
		EMAIL VARCHAR(35) NOT NULL,
		PRIMARY KEY (ID_PERSONA),
        ID_TIPODOCUMENTO INT(2) NOT NULL,
        ID_GENERO INT(2) NOT NULL,
        ID_GRUPO INT(2) NOT NULL,
        ID_EMPLEADO INT(4) NOT NULL,
        ID_USUARIO INT(4) NOT NULL,
        CONSTRAINT PERS_TDOC FOREIGN KEY (ID_TIPODOCUMENTO) REFERENCES TIPO_DOCUMENTO (ID_TIPODOCUMENTO) ON UPDATE CASCADE,
        CONSTRAINT PERS_GENE FOREIGN KEY (ID_GENERO) REFERENCES GENERO (ID_GENERO) ON UPDATE CASCADE,
        CONSTRAINT PERS_GSAN FOREIGN KEY (ID_GRUPO) REFERENCES GRUPO_SANGUINEO (ID_GRUPO) ON UPDATE CASCADE,
        CONSTRAINT PERS_EMPLEADO FOREIGN KEY (ID_EMPLEADO) REFERENCES EMPLEADO (ID_EMPLEADO) ON UPDATE CASCADE,
        CONSTRAINT PERS_USUA FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS (ID_USUARIO) ON UPDATE CASCADE
	)engine=InnoDB;


			--- CLIENTE # 8---

CREATE TABLE CLIENTE
	(
		ID_CLIENTE INT(4) NOT NULL,
		PRIMARY KEY (ID_CLIENTE),
        ID_PERSONA INT(15) NOT NULL,
	    CONSTRAINT CLIE_PERS FOREIGN KEY (ID_PERSONA) REFERENCES PERSONA (ID_PERSONA) ON UPDATE CASCADE
	)engine=InnoDB;
            
            
               --- PREGUNTA DE SEGURIDAD # 9---

CREATE TABLE PREGUNTA_SEGURIDAD	
	(
		ID_PSEGURIDAD INT(4) NOT NULL,
		PREGUNTA_SEGURIDAD VARCHAR(25) NOT NULL,
        RESPUESTA_SEGURIDAD VARCHAR(25) NOT NULL,
		PRIMARY KEY (ID_PSEGURIDAD),
        ID_USUARIO INT(4) NOT NULL,
        CONSTRAINT PSEGURIDAD_USU FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS (ID_USUARIO)ON UPDATE CASCADE
		)engine=InnoDB;

			--- ROLES # 10---
            
  CREATE TABLE ROLES
  (
	ID_ROL INT(4) NOT NULL,
    DESCRIPCION VARCHAR(25) NOT NULL,
    PRIMARY KEY(ID_ROL),
    ID_USUARIO INT(4) NOT NULL,
    CONSTRAINT ROLES_USU FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS(ID_USUARIO)ON UPDATE CASCADE
  )engine=InnoDB;

	
			--- PROVEEDOR # 11---

CREATE TABLE PROVEEDOR
	(
		ID_PROVEEDOR INT(4) NOT NULL,
		NOMBRE_PROVEEDOR VARCHAR(35) NOT NULL,
		PRIMARY KEY (ID_PROVEEDOR)
		)engine=InnoDB;

			--- TIPO DE PRODUCTO # 12---

CREATE TABLE TIPO_PRODUCTO
	(
		ID_TPRODUCTO INT(4) NOT NULL,
        CATEGORIA VARCHAR(30) NOT NULL,
		PRIMARY KEY (ID_TPRODUCTO)
		)engine=InnoDB;

			--- PRODUCTO # 13---

CREATE TABLE PRODUCTO
	(
		ID_PRODUCTO INT(4) NOT NULL,
		NOMBRE_PRODUCTO VARCHAR(30) NOT NULL,
		DESCRIPCION_PRODUCTO TEXT NOT NULL,
		CANTIDAD INT NOT NULL,
		VALOR FLOAT(6,2) NOT NULL,
		STOCK_MAXIMO INT NOT NULL,
		STOCK_MINIMO INT NOT NULL,
		PRIMARY KEY (ID_PRODUCTO),
        ID_TPRODUCTO INT(4) NOT NULL,
			CONSTRAINT PROD_TPROD FOREIGN KEY (ID_TPRODUCTO) REFERENCES TIPO_PRODUCTO (ID_TPRODUCTO) ON UPDATE CASCADE,
            CONSTRAINT CH_STOCK_MAXIMO CHECK (STOCK_MAXIMO > 100), -- Stock mayor de 100 unidades en adelante
            CONSTRAINT CH_STOCK_MINIMO CHECK (STOCK_MINIMO < 10) -- Stock menor de 10 Unidades  
			)engine=InnoDB;

			--- FACTURA # 14---

CREATE TABLE FACTURA
	(
		ID_FACTURA INT(4) NOT NULL,
		FECHA_FACTURA DATE NOT NULL,
        VALOR_FACTURA DECIMAL(9,2) NOT NULL,
        PRIMARY KEY (ID_FACTURA),
		ID_EMPLEADO INT(4) NOT NULL,
		ID_CLIENTE INT(4) NOT NULL,
		    CONSTRAINT FACT_EMPL FOREIGN KEY (ID_EMPLEADO) REFERENCES EMPLEADO (ID_EMPLEADO) ON UPDATE CASCADE,
			CONSTRAINT FACT_CLIE FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID_CLIENTE) ON UPDATE CASCADE
			)engine=InnoDB;

--- AUDITORIA # 14---
			
            CREATE TABLE AUDITORIA
            (
            cod_auditoria INT NOT NULL AUTO_INCREMENT,
            usuario_aud VARCHAR(200) NOT NULL,
            descripcion_aud TEXT NOT NULL,
            fecha_aud DATETIME NOT NULL,
            PRIMARY KEY(cod_auditoria)
            )engine=InnoDB;
            
      ---  RELACION ENTRE FACTOR_RH Y GRUPO_SANGUINEO # 15---
      
    CREATE TABLE FACRH_GRUPOSAN
    (
	  	ID_RH INT(2) NOT NULL,
        ID_GRUPO INT(2) NOT NULL,
        PRIMARY KEY(ID_RH,ID_GRUPO),
        FOREIGN KEY (ID_RH) REFERENCES  FACTOR_RH(ID_RH) ON UPDATE CASCADE,
        FOREIGN KEY (ID_GRUPO) REFERENCES  GRUPO_SANGUINEO(ID_GRUPO) ON UPDATE CASCADE
    )engine=InnoDB; 


			--- RELACION ENTRE PRODUCTO Y FACTURA # 16---

CREATE TABLE FACTURA_PRODUCTO
	(
		ID_FACTURA INT(4) NOT NULL,
		ID_PRODUCTO INT(4) NOT NULL,
        PRIMARY KEY(ID_FACTURA,ID_PRODUCTO),
			FOREIGN KEY (ID_FACTURA) REFERENCES FACTURA (ID_FACTURA), -- ACTUALIZACION EN CASACDA  
			FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTO (ID_PRODUCTO)  -- ACTUALIZACION EN CASACDA
			)engine=InnoDB;

			--- RELACION ENTRE PRODUCTO Y PROVEEDOR # 17---

CREATE TABLE PROVEEDOR_PRODUCTO -- se cambia orden para facil recordacion
	(
		ID_PRODUCTO INT(4) NOT NULL,
		ID_PROVEEDOR INT(4) NOT NULL,
        PRIMARY KEY (ID_PRODUCTO,ID_PROVEEDOR),
			FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTO (ID_PRODUCTO) ON UPDATE CASCADE,
			FOREIGN KEY (ID_PROVEEDOR) REFERENCES PROVEEDOR (ID_PROVEEDOR) ON UPDATE CASCADE
			)engine=InnoDB;


                 --- INSERTS ---

			--- TIPO DE DOCUMENTO # 1---

INSERT INTO TIPO_DOCUMENTO (ID_TIPODOCUMENTO,NOMBRE,DESCRIPCION_DOCU)
 VALUES (01,"CC", "CEDULA DE CIUDADANIA"),(02,"TI", "TARJETA DE IDENTIDAD"),(03,"RUT", "REGISTRO UNICO TRIBUTARIO"),(04,'CE','CEDULA DE EXTRANGERIA');
 
   				-- FACTOR RH # 3---

		INSERT INTO FACTOR_RH (ID_RH,FACTOR_RH)	VALUES (01,'POSITIVO'),(02,'NEGATIVO');	

			 -- GRUPO SANGUINEO # 4--
		 INSERT INTO GRUPO_SANGUINEO(ID_GRUPO,GRUPO_SANGUINEO) VALUES (10,'O'),(11,'A'),(12,'B'),(13,'AB');
         
			-- FACRH_GRUPOSAN # 5--   
         
         INSERT INTO FACRH_GRUPOSAN(ID_RH,ID_GRUPO) VALUES (01,10),(02,11),(01,13);
         
             -- GENERO # 6 
		INSERT INTO GENERO (ID_GENERO,NOMBRE,DESCRIPCION_GENE)
		VALUES (01,'M',"MASCULINO"),(02,'F',"FEMENINO"),(03,'O',"OTRO");
         
         
         		--- EMPLEADO # 7---
		INSERT INTO EMPLEADO (ID_EMPLEADO,CARGO_EMPLEADO,DESCRIPCION_CARGO,FECHA_CONTRATACION,SALARIO)
        VALUES (2001,'ADMINISTRADOR','PERSONAL MANEJO CONFIANZA','2018-10-03',1800000),(2002,'INSTRUCTOR','INSTRUCTOR PILATES','2019-12-06',1000000),
               (2003,'CONTADOR','PROFESIONAL CONTADURIA PUBLICA','2020-01-16',1500000);
               
               
                                                    --- USUARIOS # 8---

INSERT INTO USUARIOS (ID_USUARIO,NOMBRE,PASWORD) VALUES (7001,'JUAN',"pZyke2003"),(7002,'PEPE',"Fall1234");
/*
INSERT INTO USUARIOS (ID_USUARIO, PASWORD, RESPUESTA_SEGURIDAD, ID_PERSONA, ID_PSEGURIDAD,ID_ROL)
VALUES (7001, "pZyke2003", "LAURA", 1001219731, 1001,21),(7002, "Fall1234", 102391742, 1002,21);*/

         
                             --- PERSONA EMPLEADO # 9---

INSERT INTO PERSONA (ID_PERSONA, PRIMER_NOMB, SEGUNDO_NOMB, PRIMER_APELL, SEGUNDO_APELL, DIRECCION, NUMERO_TELEFONO, EMAIL,ID_TIPODOCUMENTO,ID_GENERO,ID_GRUPO,ID_EMPLEADO,ID_USUARIO)
VALUES (1001219731, "Paula", "Valentina", "Ardila", "Hernandez", "Calle 170 #7-20", 3223873251, "ejemplo@sincorreo.com", 01,02,10,'2001',7001),
		(102391742, "Andres", "Camilo", "Vega", "Rodriguez", "Calle 22sur #4-20", 3123824832, "camilo99@gmail.com", 04,01,13,'2003',7002);
        
        

        
        
        --- PREGUNTAS DE SEGURIDAD # 10---
		INSERT INTO PREGUNTA_SEGURIDAD (ID_PSEGURIDAD, PREGUNTA_SEGURIDAD,RESPUESTA_SEGURIDAD,ID_USUARIO)	VALUES (1001, "¿COLOR FAVORITO?","Verde",7001),(1002, "¿NOMBRE DE MADRE?","MARGOTH",7002);
        
        
                        	--- ROLES # 11---
   INSERT INTO ROLES (ID_ROL,DESCRIPCION,ID_USUARIO) VALUES (21,'ADMINISTRADOR',7001),(22,'INSTRUCTOR',7001);
                        

 -- (7003, "Gillta999", "RAUL", 5123546, 1002),(7004, "Andre1998", "Azul", 102320483, 1001),(7005, "CV20091999", "Rojo", 120497239, 1001);
 
                                    --- PERSONA CLIENTE # 12---

INSERT INTO PERSONA (ID_PERSONA, PRIMER_NOMB, SEGUNDO_NOMB, PRIMER_APELL, SEGUNDO_APELL, DIRECCION, NUMERO_TELEFONO, EMAIL,ID_TIPODOCUMENTO, ID_GENERO,ID_GRUPO,ID_EMPLEADO,ID_USUARIO)
VALUES (1003828639,'Roberto','De Jesus','Zapata','Montero','Calle 63a #23-84',3285769,'zariguellafeliz@nbc.com',01,01,11,'2002',7003),
(1002399872,'Ana','','La Forcade','','carrera 125N # 17-100',7846532,'nosebiencuales@donde.com.co',01,02,12,'2002',7004);


                          --- CLIENTE # 12---
        INSERT INTO CLIENTE (ID_CLIENTE,ID_PERSONA) VALUES (4001,1003828639),(4002,1002399872);
         
           -- FACTURA # 13 --
         INSERT INTO FACTURA(ID_FACTURA,FECHA_FACTURA,VALOR_FACTURA,ID_EMPLEADO,ID_CLIENTE) VALUES (3001,'2020-09-25',200000,2002,4001),(3002,'2020-08-03',150000,2002,4002);
         
         --- TIPO DE PRODUCTOS # 14---
		INSERT INTO TIPO_PRODUCTO (ID_TPRODUCTO, CATEGORIA) VALUES (5001, "BEBIDA ENERGISANTE"),(5002, "PROTEINA"),(5003, "COMIDA ENERGISANTE");
    
               
		   	---- PRODUCTOS # 15----

INSERT INTO PRODUCTO (ID_PRODUCTO, NOMBRE_PRODUCTO, DESCRIPCION_PRODUCTO, CANTIDAD, VALOR, STOCK_MAXIMO, STOCK_MINIMO, ID_TPRODUCTO)
VALUES  (6001, "CookEnergy", "Lorem ipsum dolor sit amet consectetur adipisicing elit. Rem nostrum neque necessitatibus ad explicabo accusantium tempora.", 300, 2000, 101, 8, 5003),
		(6002, "Red Bull", "Lorem ipsum dolor sit amet consectetur adipisicing elit. Rem nostrum neque necessitatibus ad explicabo accusantium tempora.", 205, 5000, 102, 7, 5001),
		 (6003, "TNT", "Lorem ipsum dolor sit amet consectetur adipisicing elit. Rem nostrum neque necessitatibus ad explicabo accusantium tempora.", 500, 15000, 103, 6, 5002),
          (6004, "Speed", "Lorem ipsum dolor sit amet consectetur adipisicing elit. Rem nostrum neque necessitatibus ad explicabo accusantium tempora.", 500, 2500, 103, 7, 5001);
         
               -- FACTURA  PRODUCTO # 16--
         INSERT INTO FACTURA_PRODUCTO(ID_FACTURA,ID_PRODUCTO) VALUES (3001,6001),(3002,6002);
         
         
    -- PROVEEDOR # 17--

		INSERT INTO PROVEEDOR(ID_PROVEEDOR,NOMBRE_PROVEEDOR) VALUES (8001,'FIRTS NUTRITION'),(8002,'GYMATIZE'),(8003,'BE ONE');

				
		-- PROVEEDOR # 18--
            INSERT INTO PROVEEDOR_PRODUCTO(ID_PRODUCTO,ID_PROVEEDOR) VALUES (6001,8001),(6002,8002);
            
            
/*****************************************************CONSULTAS A LA BASE DE DATOS DE MODELO GYM************************************************************************************************************************************************************/

select * from empleado;
select * from persona;

/* UTILIZANDO EL JOIN */
/* muestra el nombre del empleado,cargo, fecha de contrato y su salario */
select persona.ID_PERSONA,persona.PRIMER_NOMB,persona.SEGUNDO_APELL,empleado.CARGO_EMPLEADO,roles.DESCRIPCION AS ROLES,empleado.FECHA_CONTRATACION,empleado.SALARIO
from persona
left join cliente on persona.ID_PERSONA=cliente.ID_PERSONA
right join empleado on persona.ID_EMPLEADO=empleado.ID_EMPLEADO
left join usuarios on persona.id_persona=usuarios.id_persona
left join roles on usuarios.id_rol=roles.id_rol
order by 1;

/*************************** Joins ModeloGYMv4*************************************************************************/
create view VistaRegistros as
select persona.ID_PERSONA as CEDULA,persona.PRIMER_NOMB AS P_NOMBRE,persona.SEGUNDO_NOMB AS S_NOMBRE,persona.PRIMER_APELL AS P_APELLIDO,
persona.SEGUNDO_APELL AS S_APELLIDO,persona.DIRECCION AS DIRECCION,persona.NUMERO_TELEFONO AS TELEFONO,persona.EMAIL AS EMAIL,
empleado.CARGO_EMPLEADO AS CARGO from persona
left join empleado on persona.ID_EMPLEADO=empleado.ID_EMPLEADO
order by 2;
select * from VistaRegistros;

/****************************************************************************************************************/

SELECT * FROM USUARIOS
RIGHT JOIN PERSONA ON USUARIOS.ID_PERSONA=PERSONA.ID_PERSONA
INNER JOIN ROLES ON USUARIOS.ID_ROL=ROLES.ID_ROL
WHERE ID_USUARIO=7001;

SELECT * FROM USUARIOS 
LEFT JOIN ROLES ON USUARIOS.ID_ROL=ROLES.ID_ROL
LEFT JOIN PERSONA ON USUARIOS.ID_PERSONA=PERSONA.ID_PERSONA
WHERE ID_USUARIO=7001;


SELECT DESCRIPCION AS DESCRIPCION FROM USUARIOS 
LEFT JOIN ROLES ON USUARIOS.ID_ROL=ROLES.ID_ROL
WHERE ID_USUARIO = 7001;


/* CREANDO VISTA*/
create view VistaDatosEmpleado as
select persona.ID_PERSONA,persona.PRIMER_NOMB,persona.SEGUNDO_APELL,empleado.CARGO_EMPLEADO,empleado.FECHA_CONTRATACION,empleado.SALARIO from persona
left join cliente on persona.ID_PERSONA=cliente.ID_PERSONA
right join empleado on persona.ID_EMPLEADO=empleado.ID_EMPLEADO;

/* MODIFICANDO VISTA */
/* muestra el nombre del empleado,cargo, fecha de contrato, su salario, tipo de documento y email  */
create or replace view VistaDatosEmpleado as
select tipo_documento.nombre,persona.ID_PERSONA,persona.PRIMER_NOMB,persona.SEGUNDO_APELL,persona.email,empleado.CARGO_EMPLEADO,empleado.FECHA_CONTRATACION,empleado.SALARIO from persona
left join cliente on persona.ID_PERSONA=cliente.ID_PERSONA
right join empleado on persona.ID_EMPLEADO=empleado.ID_EMPLEADO
inner join tipo_documento on persona.ID_TIPODOCUMENTO=tipo_documento.ID_TIPODOCUMENTO;

/* CONSULTANDO LA VISTA */
select * from vistadatosempleado;
select * from vistadatoscliente;

/* ELIMINADO LA VISTA */
drop view VistaDatosEmpleado;
drop view Vistadatoscliente;

/* CONSULTA CLIENTES*/
select tipo_documento.nombre,cliente.id_persona,persona.PRIMER_NOMB,persona.PRIMER_APELL,factura.ID_FACTURA,factura.VALOR_FACTURA from persona
left join tipo_documento on persona.id_tipodocumento=tipo_documento.id_tipodocumento
right join cliente on persona.ID_PERSONA=cliente.ID_PERSONA
inner join factura on cliente.ID_CLIENTE=factura.ID_CLIENTE;

/* CREANDO VISTA CLIENTES*/
CREATE VIEW vistaDatosCliente as
select tipo_documento.nombre,cliente.id_persona,persona.PRIMER_NOMB,persona.PRIMER_APELL,factura.ID_FACTURA,factura.VALOR_FACTURA from persona
left join tipo_documento on persona.id_tipodocumento=tipo_documento.id_tipodocumento
right join cliente on persona.ID_PERSONA=cliente.ID_PERSONA
inner join factura on cliente.ID_CLIENTE=factura.ID_CLIENTE;

/* CONSULTA UTILIZANDO EL CASE */
-- Consulta los empleados que ganan mas de 1M mostrando un mensaje de los mayores y los menores en el rango
select persona.primer_nomb as NOMBRE,persona.primer_apell as APELLIDO,empleado.cargo_empleado as CARGO,empleado.salario as SALARIO,
case 
	when salario >= 1000001 then 'Mayores a $ 1.000.000'
	else 'Menores a $ 1.000.000'
end as 'GANACIAS'
from empleado
left join persona on empleado.id_empleado=persona.id_empleado;

/*PROCEDIMIENTO ALMACENADO INSERT*/

DELIMITER // 
	 CREATE PROCEDURE  SP_InsertarUsuarios
	(
	IN Nombre VARCHAR(30),
	IN Pasword VARCHAR(20)
	)
	BEGIN
	INSERT INTO usuarios(NOMBRE,PASWORD) VALUES ('Pedro',3214567);
END //
 CALL SP_InsertarUsuarios('Pedro',3214567);

DELIMITER //
	create procedure SPproducto_idproducto (IN PRODUC INT)
    BEGIN
    select * from producto where id_producto=PRODUC;
    END //

/* ELIMINAR SP (STORED PROCEDURES) */
DROP PROCEDURE SP_producto_idproducto;

/*CREAR INSERTAR SP (STORED PROCEDURES)*/
DELIMITER //
	CREATE PROCEDURE SP_InsertarProducto 
    (IN CODIGO INT(4),NOMBRE VARCHAR(30),DESCRIPCION TEXT,CANTIDAD INT(11),IN VALOR FLOAT(6,2),STMAX INT(11),STMIN INT(11),IDTP INT(4))
    BEGIN
    INSERT INTO PRODUCTO(ID_PRODUCTO,NOMBRE_PRODUCTO,DESCRIPCION_PRODUCTO,CANTIDAD,VALOR,STOCK_MAXIMO,STOCK_MINIMO,ID_TPRODUCTO)
    VALUES (6005,'Bio','Lorem Ipsum',120,1200,120,9,5001);
    END //

/*INSERTAR SP (STORED PROCEDURES)*/
CALL SP_InsertarProducto(6005,'Bio','Lorem Ipsum',120,1200,120,9,5001);

/* SP ELIMINAR (STORED PROCEDURES)*/
DELIMITER //
CREATE PROCEDURE SP_EliminarProducto 
(IN CODPEODUCTO INT(4))
BEGIN
DELETE FROM PRODUCTO WHERE ID_PRODUCTO = 6005;
END //

CALL SP_EliminarProducto(6005);

/* SP ACTUALIZAR (STORED PROCEDURES)*/

DELIMITER //
CREATE PROCEDURE SP_ActualizarProducto
(IN NOMBRE VARCHAR(30),IN DESCRIPCION TEXT)
BEGIN
UPDATE PRODUCTO SET NOMBRE_PRODUCTO = 'BioEnergy', DESCRIPCION_PRODUCTO = 'Lorem ipsum dolor sit amet consectetur adipisicing elit.'
WHERE ID_PRODUCTO = 6005;
END //

CALL SP_ActualizarProducto('BioEnergy','Lorem ipsum dolor sit amet consectetur adipisicing elit.');


/* TRIGGER ACTUALIZAR (PRODUCTOS)*/

DELIMITER //
CREATE TRIGGER actualizarDescripcionProducto
AFTER UPDATE ON PRODUCTO FOR EACH ROW
BEGIN
  IF (OLD.DESCRIPCION_PRODUCTO <> NEW.DESCRIPCION_PRODUCTO)
    THEN INSERT INTO AUDITORIA(usuario_aud,descripcion_aud,fecha_aud) 
    VALUES (user(),
    CONCAT('Se modifico el producto',OLD.DESCRIPCION_PRODUCTO,'nombre del producto',(NEW.DESCRIPCION_PRODUCTO)),NOW());
  END IF;
END//

/*MUESTRA LOS TRIGGERS*/
SHOW triggers;
UPDATE PRODUCTO SET NOMBRE_PRODUCTO = 'Bio' WHERE ID_PRODUCTO = 6005;
SELECT * FROM modelogymv4.auditoria;
DROP TRIGGER actualizarDescripcionProducto;

/* TRIGGER INSERTAR (PRODUCTOS)*/
DELIMITER //
CREATE TRIGGER InsertarDescripcionProducto
AFTER UPDATE ON PRODUCTO FOR EACH ROW
BEGIN
  IF (OLD.DESCRIPCION_PRODUCTO <> NEW.DESCRIPCION_PRODUCTO)
    THEN INSERT INTO AUDITORIA(usuario_aud,descripcion_aud,fecha_aud) 
    VALUES (user(),
    CONCAT('Se modifico el producto',OLD.DESCRIPCION_PRODUCTO,'valor anterior',OLD.DESCRIPCION_PRODUCTO,'Nuevo valor',NEW.DESCRIPCION_PRODUCTO),NOW());
  END IF;
END//
 show tables;
 select count(*) from usuarios;