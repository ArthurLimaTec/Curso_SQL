SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| comercio           |
| exemplo            |
| exercício          |
| livraria           |
| mysql              |
| performance_schema |
| projeto            |
| projeto_2          |
| sakila             |
| sys                |
| tera_ti            |
| world              |
+--------------------+

USE information_schema;
SHOW TABLES;
+---------------------------------------+
| Tables_in_information_schema          |
+---------------------------------------+
| CHARACTER_SETS                        |
| COLLATIONS                            |
| COLLATION_CHARACTER_SET_APPLICABILITY |
| COLUMNS                               |
| COLUMN_PRIVILEGES                     |
| ENGINES                               |
| EVENTS                                |
| FILES                                 |
| GLOBAL_STATUS                         |
| GLOBAL_VARIABLES                      |
| KEY_COLUMN_USAGE                      |
| OPTIMIZER_TRACE                       |
| PARAMETERS                            |
| PARTITIONS                            |
| PLUGINS                               |
| PROCESSLIST                           |
| PROFILING                             |
| REFERENTIAL_CONSTRAINTS               |
| ROUTINES                              |
| SCHEMATA                              |
| SCHEMA_PRIVILEGES                     |
| SESSION_STATUS                        |
| SESSION_VARIABLES                     |
| STATISTICS                            |
| TABLES                                |
| TABLESPACES                           |
| TABLE_CONSTRAINTS                     |
| TABLE_PRIVILEGES                      |
| TRIGGERS                              |
| USER_PRIVILEGES                       |
| VIEWS                                 |
| INNODB_LOCKS                          |
| INNODB_TRX                            |
| INNODB_SYS_DATAFILES                  |
| INNODB_FT_CONFIG                      |
| INNODB_SYS_VIRTUAL                    |
| INNODB_CMP                            |
| INNODB_FT_BEING_DELETED               |
| INNODB_CMP_RESET                      |
| INNODB_CMP_PER_INDEX                  |
| INNODB_CMPMEM_RESET                   |
| INNODB_FT_DELETED                     |
| INNODB_BUFFER_PAGE_LRU                |
| INNODB_LOCK_WAITS                     |
| INNODB_TEMP_TABLE_INFO                |
| INNODB_SYS_INDEXES                    |
| INNODB_SYS_TABLES                     |
| INNODB_SYS_FIELDS                     |
| INNODB_CMP_PER_INDEX_RESET            |
| INNODB_BUFFER_PAGE                    |
| INNODB_FT_DEFAULT_STOPWORD            |
| INNODB_FT_INDEX_TABLE                 |
| INNODB_FT_INDEX_CACHE                 |
| INNODB_SYS_TABLESPACES                |
| INNODB_METRICS                        |
| INNODB_SYS_FOREIGN_COLS               |
| INNODB_CMPMEM                         |
| INNODB_BUFFER_POOL_STATS              |
| INNODB_SYS_COLUMNS                    |
| INNODB_SYS_FOREIGN                    |
| INNODB_SYS_TABLESTATS                 |
+---------------------------------------+

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------


CREATE DATABASE AULA40;

CREATE TABLE USUARIO(
	IDUSUARIO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	LOGIN VARCHAR(30),
	SENHA VARCHAR(100)
	);

CREATE TABLE BKP_USUARIO(
	IDBACKUP INT PRIMARY KEY AUTO_INCREMENT,
	IDUSUARIO INT,
	NOME VARCHAR(30),
	LOGIN VARCHAR(30)
	);

/*CRIANDO A TRIGGER: BACKUP DO USUÁRIO QUE FOR DELETADO*/

DELIMITER $


CREATE TRIGGER BACKUP_USER
BEFORE DELETE ON USUARIO
FOR EACH ROW
BEGIN 
	
	INSERT INTO BKP_USUARIO VALUES(NULL,OLD.IDUSUARIO,OLD.NOME,OLD.LOGIN);

END$


DELIMITER ;


INSERT INTO USUARIO VALUES(NULL,'ANDRADE','ANDRADE2009','HEXACAMPEAO');

SELECT* FROM USUARIO;
+-----------+---------+-------------+-------------+
| IDUSUARIO | NOME    | LOGIN       | SENHA       |
+-----------+---------+-------------+-------------+
|         1 | ANDRADE | ANDRADE2009 | HEXACAMPEAO |
+-----------+---------+-------------+-------------+

DELETE FROM USUARIO WHERE IDUSUARIO = 1;

SELECT * FROM USUARIO;
Empty set (0.00 sec)

SELECT * FROM BKP_USUARIO; /*AUTOMATICAMENTE ELE INSERE NA QUE FOI PROGRAMADA*/
+----------+-----------+---------+-------------+
| IDBACKUP | IDUSUARIO | NOME    | LOGIN       |
+----------+-----------+---------+-------------+
|        1 |         1 | ANDRADE | ANDRADE2009 |
+----------+-----------+---------+-------------+


-----------------------------------------------------------------------------------------------
/*FAZENDO UM BD SE COMUNICAR COM O OUTRO UTILIZANDO TRIGGER*/

CREATE DATABASE LOJA;
USE LOJA;

CREATE TABLE PRODUTO(
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	VALOR FLOAT(10,2)
	);

--------

CREATE DATABASE BACKUP;
USE BACKUP;

CREATE TABLE BKP_PRODUTO(
	IDBKP INT PRIMARY KEY AUTO_INCREMENT, 
	IDPRODUTO INT,
	NOME VARCHAR(30),
	VALOR FLOAT(10,2)
	);
-----------

USE LOJA;

INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL,1000,'TESTE',0.0);

SELECT * FROM BACKUP.BKP_PRODUTO;
+-------+-----------+-------+-------+
| IDBKP | IDPRODUTO | NOME  | VALOR |
+-------+-----------+-------+-------+
|     1 |      1000 | TESTE |  0.00 |
+-------+-----------+-------+-------+


DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO
BEFORE INSERT ON PRODUTO
FOR EACH ROW
BEGIN 

	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL,NEW.IDPRODUTO,NEW.NOME,NEW.VALOR);

END$

DELIMITER ;

INSERT INTO PRODUTO VALUES(NULL,'LIVRO MODELAGEM',50.00);
INSERT INTO PRODUTO VALUES(NULL,'LIVRO BI',80.00);
INSERT INTO PRODUTO VALUES(NULL,'LIVRO ORACLE',70.00);
INSERT INTO PRODUTO VALUES(NULL,'LIVRO SQL SERVER',100.00);
+-----------+------------------+--------+
| IDPRODUTO | NOME             | VALOR  |
+-----------+------------------+--------+
|         1 | LIVRO MODELAGEM  |  50.00 |
|         2 | LIVRO BI         |  80.00 |
|         3 | LIVRO ORACLE     |  70.00 |
|         4 | LIVRO SQL SERVER | 100.00 |
+-----------+------------------+--------+

SELECT* FROM BACKUP.BKP_PRODUTO; 
+-------+-----------+------------------+--------+
| IDBKP | IDPRODUTO | NOME             | VALOR  |
+-------+-----------+------------------+--------+
|     1 |      1000 | TESTE            |   0.00 |
|     2 |         0 | LIVRO MODELAGEM  |  50.00 |
|     3 |         0 | LIVRO BI         |  80.00 |
|     4 |         0 | LIVRO ORACLE     |  70.00 |
|     5 |         0 | LIVRO SQL SERVER | 100.00 |
+-------+-----------+------------------+--------+

----


DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO_DEL
BEFORE DELETE ON PRODUTO
FOR EACH ROW
BEGIN 

	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL,OLD.IDPRODUTO,OLD.NOME,OLD.VALOR);

END$


DELIMITER ;


DELETE FROM PRODUTO WHERE IDPRODUTO = 2;
SELECT* FROM BACKUP.BKP_PRODUTO;
+-------+-----------+------------------+--------+
| IDBKP | IDPRODUTO | NOME             | VALOR  |
+-------+-----------+------------------+--------+
|     1 |      1000 | TESTE            |   0.00 |
|     2 |         0 | LIVRO MODELAGEM  |  50.00 |
|     3 |         0 | LIVRO BI         |  80.00 |
|     4 |         0 | LIVRO ORACLE     |  70.00 |
|     5 |         0 | LIVRO SQL SERVER | 100.00 |
|     6 |         2 | LIVRO BI         |  80.00 |
+-------+-----------+------------------+--------+

/*CORRIGINDO A PRIMEIRA TRIGGER*/

DROP TRIGGER BACKUP_PRODUTO;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO
AFTER INSERT ON PRODUTO
FOR EACH ROW
BEGIN 

	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL,NEW.IDPRODUTO,NEW.NOME,NEW.VALOR);

END$

DELIMITER ;

INSERT INTO PRODUTO VALUES(NULL,'LIVRO C#',100.00);

SELECT* FROM PRODUTO;
+-----------+------------------+--------+
| IDPRODUTO | NOME             | VALOR  |
+-----------+------------------+--------+
|         1 | LIVRO MODELAGEM  |  50.00 |
|         3 | LIVRO ORACLE     |  70.00 |
|         4 | LIVRO SQL SERVER | 100.00 |
|         5 | LIVRO C#         | 100.00 |
+-----------+------------------+--------+

SELECT* FROM BACKUP.BKP_PRODUTO;
+-------+-----------+------------------+--------+
| IDBKP | IDPRODUTO | NOME             | VALOR  |
+-------+-----------+------------------+--------+
|     1 |      1000 | TESTE            |   0.00 |
|     2 |         0 | LIVRO MODELAGEM  |  50.00 |
|     3 |         0 | LIVRO BI         |  80.00 |
|     4 |         0 | LIVRO ORACLE     |  70.00 |
|     5 |         0 | LIVRO SQL SERVER | 100.00 |
|     6 |         2 | LIVRO BI         |  80.00 |
|     7 |         5 | LIVRO C#         | 100.00 |
+-------+-----------+------------------+--------+
----------------------------------------------

ALTER TABLE BACKUP.BKP_PRODUTO
ADD EVENTO CHAR(1);

DROP TRIGGER BACKUP_PRODUTO_DEL;

DELIMITER $

CREATE TRIGGER BACKUP_PRODUTO_DEL
BEFORE DELETE ON PRODUTO
FOR EACH ROW
BEGIN 

	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL,OLD.IDPRODUTO,OLD.NOME,OLD.VALOR,'D');

END$

DELIMITER ;

DELETE FROM PRODUTO WHERE IDPRODUTO = 1;
+-----------+------------------+--------+
| IDPRODUTO | NOME             | VALOR  |
+-----------+------------------+--------+
|         3 | LIVRO ORACLE     |  70.00 |
|         4 | LIVRO SQL SERVER | 100.00 |
|         5 | LIVRO C#         | 100.00 |
+-----------+------------------+--------+

SELECT * FROM BACKUP.BKP_PRODUTO;
+-------+-----------+------------------+--------+--------+
| IDBKP | IDPRODUTO | NOME             | VALOR  | EVENTO |
+-------+-----------+------------------+--------+--------+
|     1 |      1000 | TESTE            |   0.00 | NULL   |
|     2 |         0 | LIVRO MODELAGEM  |  50.00 | NULL   |
|     3 |         0 | LIVRO BI         |  80.00 | NULL   |
|     4 |         0 | LIVRO ORACLE     |  70.00 | NULL   |
|     5 |         0 | LIVRO SQL SERVER | 100.00 | NULL   |
|     6 |         2 | LIVRO BI         |  80.00 | NULL   |
|     7 |         5 | LIVRO C#         | 100.00 | NULL   |
|     8 |         1 | LIVRO MODELAGEM  |  50.00 | D      |
+-------+-----------+------------------+--------+--------+

-----------------------------------------------------------------------------------------------
/*AUDITANDO A TABELA COM TRIGGER: QUEM MEXEU NOS DADOS?*/

DROP DATABASE LOJA;

DROP DATABASE BACKUP;

CREATE DATABASE LOJA;

USE LOJA;

CREATE TABLE PRODUTO(
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	VALOR FLOAT(10,2)
	);

INSERT INTO PRODUTO VALUES(NULL,'LIVRO MODELAGEM',50.00);
INSERT INTO PRODUTO VALUES(NULL,'LIVRO BI',80.00);
INSERT INTO PRODUTO VALUES(NULL,'LIVRO ORACLE',70.00);
INSERT INTO PRODUTO VALUES(NULL,'LIVRO SQL SERVER',100.00);

SELECT NOW(); /*QUANDO*/
+---------------------+
| NOW()               |
+---------------------+
| 2023-10-04 15:47:00 |
+---------------------+
SELECT CURRENT_USER(); /*QUEM*/
+----------------+
| CURRENT_USER() |
+----------------+
| root@localhost |
+----------------+


-------------------------------
CREATE DATABASE BACKUP;
USE BACKUP;

CREATE TABLE BKP_PRODUTO(
	IDBACKUP INT PRIMARY KEY AUTO_INCREMENT,
	IDPRODUTO INT,
	NOME VARCHAR(30),
	VALOR_ORIGINAL FLOAT(10,2),
	VALOR_ALTERADO FLOAT(10,2),
	DATA DATETIME,
	USUARIO VARCHAR(30),
	EVENTO CHAR(1)
	);

USE LOJA;

SELECT* FROM PRODUTO;
+-----------+------------------+--------+
| IDPRODUTO | NOME             | VALOR  |
+-----------+------------------+--------+
|         1 | LIVRO MODELAGEM  |  50.00 |
|         2 | LIVRO BI         |  80.00 |
|         3 | LIVRO ORACLE     |  70.00 |
|         4 | LIVRO SQL SERVER | 100.00 |
+-----------+------------------+--------+


DELIMITER $

CREATE TRIGGER AUDIT_PROD
AFTER UPDATE ON PRODUTO
FOR EACH ROW
BEGIN 

	INSERT INTO BACKUP.BKP_PRODUTO VALUES(NULL,OLD.IDPRODUTO,OLD.NOME,OLD.VALOR,NEW.VALOR,
							NOW(),CURRENT_USER(),'U');

END$

DELIMITER ;

UPDATE PRODUTO
SET VALOR = 110.00
WHERE IDPRODUTO = 4;

SELECT * FROM PRODUTO;
+-----------+------------------+--------+
| IDPRODUTO | NOME             | VALOR  |
+-----------+------------------+--------+
|         1 | LIVRO MODELAGEM  |  50.00 |
|         2 | LIVRO BI         |  80.00 |
|         3 | LIVRO ORACLE     |  70.00 |
|         4 | LIVRO SQL SERVER | 110.00 |
+-----------+------------------+--------+

SELECT * FROM BACKUP.BKP_PRODUTO;
+----------+-----------+------------------+----------------+----------------+---------------------+----------------+--------+
| IDBACKUP | IDPRODUTO | NOME             | VALOR_ORIGINAL | VALOR_ALTERADO | DATA                | USUARIO        | EVENTO |
+----------+-----------+------------------+----------------+----------------+---------------------+----------------+--------+
|        1 |         4 | LIVRO SQL SERVER |         100.00 |         110.00 | 2023-10-04 16:01:10 | root@localhost | U      |
+----------+-----------+------------------+----------------+----------------+---------------------+----------------+--------+

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------


CREATE DATABASE AULA_44;

CREATE TABLE CURSOS(
	IDCURSO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	HORAS INT,
	VALOR FLOAT(10,2),
	ID_PREREQ INT
	);

ALTER TABLE CURSOS ADD CONSTRAINT FK_PREREQ
FOREIGN KEY(ID_PREREQ) REFERENCES CURSOS(IDCURSO);

INSERT INTO CURSOS VALUES(NULL,'BD RELACIONAL',20,400.00,NULL);
INSERT INTO CURSOS VALUES(NULL,'BUSINESS INTELIGENCE',40,800.00,1);
INSERT INTO CURSOS VALUES(NULL,'BD RELATÓRIOS AVANÇADOS',20,600.00,2);
INSERT INTO CURSOS VALUES(NULL,'LÓGICA DE PROGRAMAÇÃO',20,400.00,NULL);
INSERT INTO CURSOS VALUES(NULL,'RUBY',30,500.00,4);

SELECT* FROM CURSOS;
+---------+---------------------------+-------+--------+-----------+
| IDCURSO | NOME                      | HORAS | VALOR  | ID_PREREQ |
+---------+---------------------------+-------+--------+-----------+
|       1 | BD RELACIONAL             |    20 | 400.00 |      NULL |
|       2 | BUSINESS INTELIGENCE      |    40 | 800.00 |         1 |
|       3 | BD RELATÓRIOS AVANÇADOS   |    20 | 600.00 |         2 |
|       4 | LÓGICA DE PROGRAMAÇÃO     |    20 | 400.00 |      NULL |
|       5 | RUBY                      |    30 | 500.00 |         4 |
+---------+---------------------------+-------+--------+-----------+

SELECT NOME,VALOR,HORAS, IFNULL(ID_PREREQ,'SEM REQ') REQUISITO
FROM CURSOS;
+---------------------------+--------+-------+-----------+
| NOME                      | VALOR  | HORAS | REQUISITO |
+---------------------------+--------+-------+-----------+
| BD RELACIONAL             | 400.00 |    20 | SEM REQ   |
| BUSINESS INTELIGENCE      | 800.00 |    40 | 1         |
| BD RELATÓRIOS AVANÇADOS   | 600.00 |    20 | 2         |
| LÓGICA DE PROGRAMAÇÃO     | 400.00 |    20 | SEM REQ   |
| RUBY                      | 500.00 |    30 | 4         |
+---------------------------+--------+-------+-----------+

/*CONSULTA DE NOME,VALOR, HORAS E O NOME DO PRÉ REQUISITO DO CURSO COM 'LEFT JOIN':*/

SELECT 	C.NOME AS CURSO,
		C.VALOR AS VALOR,
		C.HORAS AS HORAS, 
		IFNULL(P.NOME,'----') AS PREREQ 
FROM CURSOS C
LEFT JOIN CURSOS P
ON P.IDCURSO = C.ID_PREREQ;
+---------------------------+--------+-------+--------------------------+
| CURSO                     | VALOR  | HORAS | PREREQ                   |
+---------------------------+--------+-------+--------------------------+
| BD RELACIONAL             | 400.00 |    20 | ----                     |
| BUSINESS INTELIGENCE      | 800.00 |    40 | BD RELACIONAL            |
| BD RELATÓRIOS AVANÇADOS   | 600.00 |    20 | BUSINESS INTELIGENCE     |
| LÓGICA DE PROGRAMAÇÃO     | 400.00 |    20 | ----                     |
| RUBY                      | 500.00 |    30 | LÓGICA DE PROGRAMAÇÃO    |
+---------------------------+--------+-------+--------------------------+

