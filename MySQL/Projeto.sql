/*PROCEDURES COM QUERYS*/

CREATE DATABASE PROJETO_2;

USE DATABASE PROJETO_2;

CREATE TABLE CURSOS(
	IDCURSO INT PRIMARY KEY AUTO_INCREMENT, 
	NOME VARCHAR(30) NOT NULL,
	HORAS INT(3) NOT NULL,
	VALOR FLOAT(10,2) NOT NULL
	);

INSERT INTO CURSOS VALUES(NULL,'JAVA',30,500.00);
INSERT INTO CURSOS VALUES(NULL,'FUNDAMENTOS DE BANCOS DE DADOS',40,700.00);

SELECT * FROM CURSOS;
+---------+--------------------------------+-------+--------+
| IDCURSO | NOME                           | HORAS | VALOR  |
+---------+--------------------------------+-------+--------+
|       1 | JAVA                           |    30 | 500.00 |
|       2 | FUNDAMENTOS DE BANCOS DE DADOS |    40 | 700.00 |
+---------+--------------------------------+-------+--------+

DELIMITER #

CREATE PROCEDURE CAD_CURSO(	P_NOME VARCHAR(30),
							P_HORAS INT(3),
							P_PREÇO FLOAT(10,2))
BEGIN
	
	INSERT INTO CURSOS VALUES(NULL,P_NOME,P_HORAS,P_PREÇO);

END#

DELIMITER ;

CALL CAD_CURSO('BI SQL SERVER',35,3000.00);
CALL CAD_CURSO('POWER BI',20,1000.00);
CALL CAD_CURSO('BI SQL SERVER',30,1200.00);

SELECT* FROM CURSOS;
+---------+--------------------------------+-------+---------+
| IDCURSO | NOME                           | HORAS | VALOR   |
+---------+--------------------------------+-------+---------+
|       1 | JAVA                           |    30 |  500.00 |
|       2 | FUNDAMENTOS DE BANCOS DE DADOS |    40 |  700.00 |
|       3 | BI SQL SERVER                  |    35 | 3000.00 |
|       4 | POWER BI                       |    20 | 1000.00 |
|       5 | BI SQL SERVER                  |    30 | 1200.00 |
+---------+--------------------------------+-------+---------+

/*CRIAR UMA PROCEDURE PARA CONSULTAR CURSOS*/

DELIMITER #
------------
CREATE PROCEDURE CONSULTA_CURSO(P_IDCURSO INT)
BEGIN
	
	SELECT IDCURSO,NOME,HORAS,VALOR FROM CURSOS
	WHERE IDCURSO = P_IDCURSO;

END#
------------
DELIMITER ;

CALL CONSULTA_CURSO(3);
+---------+---------------+-------+---------+
| IDCURSO | NOME          | HORAS | VALOR   |
+---------+---------------+-------+---------+
|       3 | BI SQL SERVER |    35 | 3000.00 |
+---------+---------------+-------+---------+

-------------------------------------------------------------------------------------------------
/*FUNÇÕES DE AGREGAÇÃO NUMÉRICAS*/

CREATE TABLE VENDEDORES(
	IDVENDEDOR INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	SEXO CHAR(1),
	JANEIRO FLOAT(10,2),
	FEVEREIRO FLOAT(10,2),
	MARÇO FLOAT(10,2)
);

INSERT INTO VENDEDORES VALUES(NULL,'CARLOS','M',15648.46,1564.57,7548.25);
INSERT INTO VENDEDORES VALUES(NULL,'MARIA','F',15288.46,17894.57,79154.25);
INSERT INTO VENDEDORES VALUES(NULL,'ANTONIO','M',15157.99,1145.57,8457.25);
INSERT INTO VENDEDORES VALUES(NULL,'CLARA','F',17849.48,1333.75,7856.25);
INSERT INTO VENDEDORES VALUES(NULL,'ANDERSON','M',15648.46,17574.57,73256.25);
INSERT INTO VENDEDORES VALUES(NULL,'IVONE','F',1565848.46,17854.57,73692.25);
INSERT INTO VENDEDORES VALUES(NULL,'JOAO','M',17777.46,12524.57,74545.25);
INSERT INTO VENDEDORES VALUES(NULL,'CELIA','F',100458.46,19999.57,74874.25);



/*MÁXIMO, MÍNIMO E MÉDIA*/

SELECT MAX(FEVEREIRO) AS MAIOR_FEV
FROM VENDEDORES;
+-----------+
| MAIOR_FEV |
+-----------+
|  88888.57 |
+-----------+

SELECT MIN(FEVEREIRO) AS MENOR_FEV
FROM VENDEDORES;
+-----------+
| MENOR_FEV |
+-----------+
|   1145.57 |
+-----------+

SELECT AVG(FEVEREIRO) AS MÉDIA_FEV 
FROM VENDEDORES;
+--------------+
| MÉDIA_FEV    |
+--------------+
| 19433.588208 |
+--------------+

SELECT 	MAX(JANEIRO) AS MAX_JAN,
		MIN(JANEIRO) AS MENOR_JAN,
		TRUNCATE(AVG(JANEIRO),2) AS MÉDIA_JAN /*ARREDONDANDO O VALOR*/
		FROM VENDEDORES;
+------------+-----------+------------+
| MAX_JAN    | MENOR_JAN | MÉDIA_JAN  |
+------------+-----------+------------+
| 1565848.50 |  14444.46 |  196324.01 |
+------------+-----------+------------+



/*SOMA*/

SELECT 	SUM(JANEIRO) AS TOTAL_JAN,
		SUM(FEVEREIRO) AS TOTAL_FEV,
		SUM(MARÇO) AS TOTAL_MAR
FROM VENDEDORES;
+------------+-----------+-----------+
| TOTAL_JAN  | TOTAL_FEV | TOTAL_MAR |
+------------+-----------+-----------+
| 1963240.19 | 194335.88 | 480595.50 |
+------------+-----------+-----------+

SELECT SEXO, SUM(MARÇO) AS TOTAL_MAR
FROM VENDEDORES
GROUP BY SEXO;
+------+-----------+
| SEXO | TOTAL_MAR |
+------+-----------+
| F    | 235577.00 |
| M    | 245018.50 |
+------+-----------+

-------------------------------------------------------------------------------------------------

/*QUEM MENOS VENDEU NO MÊS DE MARÇO*/

SELECT MIN(MARÇO) FROM VENDEDORES
+-------------+
| MIN(MARÇO)  |
+-------------+
|     7548.25 |
+-------------+

SELECT NOME,MARÇO FROM VENDEDORES
WHERE MARÇO = (SELECT MIN(MARÇO) FROM VENDEDORES);
+--------+---------+
| NOME   | MARÇO   |
+--------+---------+
| CARLOS | 7548.25 |
+--------+---------+

/*QUEM MAIS VENDEU EM MARÇO*/

SELECT NOME,MARÇO FROM VENDEDORES
WHERE MARÇO = (SELECT MAX(MARÇO) FROM VENDEDORES);
+-------+----------+
| NOME  | MARÇO    |
+-------+----------+
| MARIA | 79154.25 |
+-------+----------+

/*QUEM VENDEU MAIS DO QUE O VALOR MÉDIO DE FEVEREIRO*/

SELECT TRUNCATE(AVG(FEVEREIRO),2) AS VALOR_MÉDIO FROM VENDEDORES;
+--------------+
| VALOR_MÉDIO  |
+--------------+
|     11236.46 |
+--------------+


SELECT NOME,MARÇO FROM VENDEDORES
WHERE FEVEREIRO > (SELECT AVG(FEVEREIRO) FROM VENDEDORES);
+----------+----------+
| NOME     | MARÇO    |
+----------+----------+
| MARIA    | 79154.25 |
| ANDERSON | 73256.25 |
| IVONE    | 73692.25 |
| JOAO     | 74545.25 |
| CELIA    | 74874.25 |
+----------+----------+

-------------------------------------------------------------------------------------------------
/*OPERAÇÕES ARITMÉTICAS EM SUBQUERIES*/

SELECT* FROM VENDEDORES;

+------------+----------+------+------------+-----------+----------+
| IDVENDEDOR | NOME     | SEXO | JANEIRO    | FEVEREIRO | MARÇO    |
+------------+----------+------+------------+-----------+----------+
|          1 | CARLOS   | M    |   15648.46 |   1564.57 |  7548.25 |
|          2 | MARIA    | F    |   15288.46 |  17894.57 | 79154.25 |
|          3 | ANTONIO  | M    |   15157.99 |   1145.57 |  8457.25 |
|          4 | CLARA    | F    |   17849.48 |   1333.75 |  7856.25 |
|          5 | ANDERSON | M    |   15648.46 |  17574.57 | 73256.25 |
|          6 | IVONE    | F    | 1565848.50 |  17854.57 | 73692.25 |
|          7 | JOAO     | M    |   17777.46 |  12524.57 | 74545.25 |
|          8 | CELIA    | F    |  100458.46 |  19999.57 | 74874.25 |
+------------+----------+------+------------+-----------+----------+

SELECT 	NOME,
		JANEIRO,
		FEVEREIRO,
		MARÇO,
		(JANEIRO+FEVEREIRO+MARÇO) AS 'TOTAL',
		TRUNCATE((JANEIRO+FEVEREIRO+MARÇO)/3,2) AS 'MÉDIA'
		FROM VENDEDORES;

+----------+------------+-----------+----------+------------+-----------+
| NOME     | JANEIRO    | FEVEREIRO | MARÇO    | TOTAL      | MÉDIA     |
+----------+------------+-----------+----------+------------+-----------+
| CARLOS   |   15648.46 |   1564.57 |  7548.25 |   24761.28 |   8253.75 |
| MARIA    |   15288.46 |  17894.57 | 79154.25 |  112337.28 |  37445.76 |
| ANTONIO  |   15157.99 |   1145.57 |  8457.25 |   24760.81 |   8253.60 |
| CLARA    |   17849.48 |   1333.75 |  7856.25 |   27039.48 |   9013.16 |
| ANDERSON |   15648.46 |  17574.57 | 73256.25 |  106479.28 |  35493.09 |
| IVONE    | 1565848.50 |  17854.57 | 73692.25 | 1657395.32 | 552465.10 |
| JOAO     |   17777.46 |  12524.57 | 74545.25 |  104847.28 |  34949.09 |
| CELIA    |  100458.46 |  19999.57 | 74874.25 |  195332.28 |  65110.76 |
+----------+------------+-----------+----------+------------+-----------+

SELECT 	NOME,
		JANEIRO,
		FEVEREIRO,
		MARÇO,
		(JANEIRO+FEVEREIRO+MARÇO) AS 'TOTAL',
		(JANEIRO+FEVEREIRO+MARÇO)* .25 AS 'DESCONTO',
		TRUNCATE((JANEIRO+FEVEREIRO+MARÇO)/3,2) AS 'MÉDIA'
		FROM VENDEDORES;

+----------+------------+-----------+----------+------------+-----------+-----------+
| NOME     | JANEIRO    | FEVEREIRO | MARÇO    | TOTAL      | DESCONTO  | MÉDIA     |
+----------+------------+-----------+----------+------------+-----------+-----------+
| CARLOS   |   15648.46 |   1564.57 |  7548.25 |   24761.28 |   6190.32 |   8253.75 |
| MARIA    |   15288.46 |  17894.57 | 79154.25 |  112337.28 |  28084.32 |  37445.76 |
| ANTONIO  |   15157.99 |   1145.57 |  8457.25 |   24760.81 |   6190.20 |   8253.60 |
| CLARA    |   17849.48 |   1333.75 |  7856.25 |   27039.48 |   6759.87 |   9013.16 |
| ANDERSON |   15648.46 |  17574.57 | 73256.25 |  106479.28 |  26619.82 |  35493.09 |
| IVONE    | 1565848.50 |  17854.57 | 73692.25 | 1657395.32 | 414348.83 | 552465.10 |
| JOAO     |   17777.46 |  12524.57 | 74545.25 |  104847.28 |  26211.82 |  34949.09 |
| CELIA    |  100458.46 |  19999.57 | 74874.25 |  195332.28 |  48833.07 |  65110.76 |
+----------+------------+-----------+----------+------------+-----------+-----------+


--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

/*ALTERANDO A ESTRUTURA DE TABELAS*/

CREATE TABLE TABELA(
	COLUNA1 VARCHAR(30),
	COLUNA2 VARCHAR(30),
	COLUNA3 VARCHAR(30)
	);

/*ADICIONANDO UMA PRIMARY KEY:*/

ALTER TABLE TABELA
ADD PRIMARY KEY (COLUNA1);

/*ADICIONANDO COLUNA SEM E COM POSIÇÃO:*/

ALTER TABLE TABELA
ADD COLUNA VARCHAR(30);
+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| COLUNA1 | varchar(30) | NO   | PRI | NULL    |       |
| COLUNA2 | varchar(30) | YES  |     | NULL    |       |
| COLUNA3 | varchar(30) | YES  |     | NULL    |       |
| COLUNA  | varchar(30) | YES  |     | NULL    |       |
+---------+-------------+------+-----+---------+-------+

ALTER TABLE TABELA
ADD COLUNA4 VARCHAR(30) NOT NULL UNIQUE
AFTER COLUNA3;
+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| COLUNA1 | varchar(30) | NO   | PRI | NULL    |       |
| COLUNA2 | varchar(30) | YES  |     | NULL    |       |
| COLUNA3 | varchar(30) | YES  |     | NULL    |       |
| COLUNA4 | varchar(30) | NO   | UNI | NULL    |       |
| COLUNA  | varchar(30) | YES  |     | NULL    |       |
+---------+-------------+------+-----+---------+-------+


/*MODIFICANDO O TIPO DE UMA COLUNA NA TABELA:*/

ALTER TABLE TABELA MODIFY COLUNA2 DATE NOT NULL;

+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| COLUNA1 | varchar(30) | NO   | PRI | NULL    |       |
| COLUNA2 | date        | NO   |     | NULL    |       |
| COLUNA3 | varchar(30) | YES  |     | NULL    |       |
| COLUNA4 | varchar(30) | NO   | UNI | NULL    |       |
| COLUNA  | varchar(30) | YES  |     | NULL    |       |
+---------+-------------+------+-----+---------+-------+


/*RENOMEANDO O NOME DA TABELA*/

ALTER TABLE TABELA
RENAME PESSOA;

+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| COLUNA1 | varchar(30) | NO   | PRI | NULL    |       |
| COLUNA2 | date        | NO   |     | NULL    |       |
| COLUNA3 | varchar(30) | YES  |     | NULL    |       |
| COLUNA4 | varchar(30) | NO   | UNI | NULL    |       |
| COLUNA  | varchar(30) | YES  |     | NULL    |       |
+---------+-------------+------+-----+---------+-------+

CREATE TABLE TIME(
	IDTIME INT PRIMARY KEY AUTO_INCREMENT,
	TIME VARCHAR(30),
	ID_PESSOA VARCHAR(30)
	);

+-----------+-------------+------+-----+---------+----------------+
| Field     | Type        | Null | Key | Default | Extra          |
+-----------+-------------+------+-----+---------+----------------+
| IDTIME    | int(11)     | NO   | PRI | NULL    | auto_increment |
| TIME      | varchar(30) | YES  |     | NULL    |                |
| ID_PESSOA | varchar(30) | YES  |     | NULL    |                |
+-----------+-------------+------+-----+---------+----------------+

/*ADICIONANDO FOREIGN KEY*/

ALTER TABLE TIME
ADD FOREIGN KEY(ID_PESSOA)
REFERENCES PESSOA(COLUNA1);

/*VERIFICANDO AS CHAVES*/

SHOW CREATE TABLE TIME;
/*------------------------------
| TIME  | CREATE TABLE `time` (
  `IDTIME` int(11) NOT NULL AUTO_INCREMENT,
  `TIME` varchar(30) DEFAULT NULL,
  `ID_PESSOA` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`IDTIME`),
  KEY `ID_PESSOA` (`ID_PESSOA`),
  CONSTRAINT `time_ibfk_1` FOREIGN KEY (`ID_PESSOA`) REFERENCES `pessoa` (`COLUNA1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 |
------------------------------*/

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

/*ORGANIZANDO CHAVES - CONSTRAINT (REGRA)*/

CREATE TABLE JOGADOR(
	IDJOGADOR INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30)
	);

+-----------+-------------+------+-----+---------+----------------+
| Field     | Type        | Null | Key | Default | Extra          |
+-----------+-------------+------+-----+---------+----------------+
| IDJOGADOR | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME      | varchar(30) | YES  |     | NULL    |                |
+-----------+-------------+------+-----+---------+----------------+

CREATE TABLE TIMES(
	IDTIME INT PRIMARY KEY AUTO_INCREMENT,
	NOMETIME VARCHAR(30),
	ID_JOGADOR INT,
	FOREIGN KEY(ID_JOGADOR)
	REFERENCES JOGADOR(IDJOGADOR)
	);

+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| IDTIME     | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOMETIME   | varchar(30) | YES  |     | NULL    |                |
| ID_JOGADOR | int(11)     | YES  | MUL | NULL    |                |
+------------+-------------+------+-----+---------+----------------+

INSERT INTO JOGADOR VALUES(NULL,'GUERREIRO');
INSERT INTO TIMES VALUES(NULL,'FLAMENGO',1);

SELECT* FROM TIMES;
+--------+----------+------------+
| IDTIME | NOMETIME | ID_JOGADOR |
+--------+----------+------------+
|      1 | FLAMENGO |          1 |
+--------+----------+------------+

SHOW CREATE TABLE JOGADOR;

| JOGADOR | CREATE TABLE `jogador` (
  `IDJOGADOR` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`IDJOGADOR`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 |

SHOW CREATE TABLE TIMES;

| TIMES | CREATE TABLE `times` (
  `IDTIME` int(11) NOT NULL AUTO_INCREMENT,
  `NOMETIME` varchar(30) DEFAULT NULL,
  `ID_JOGADOR` int(11) DEFAULT NULL,
  PRIMARY KEY (`IDTIME`),
  KEY `ID_JOGADOR` (`ID_JOGADOR`),
  CONSTRAINT `times_ibfk_1` FOREIGN KEY (`ID_JOGADOR`) REFERENCES `jogador` (`IDJOGADOR`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 |


/*APAGANDO ALGUMAS TABELAS NO DB COMÉRCIO, APENAS PARA LIMPAR*/
DROP TABLE ENDEREÇO;
DROP TABLE TELEFONE;
DROP TABLE CLIENTE;



/*RECRIANDO COM CHAVES NOMEADAS:*/

CREATE TABLE CLIENTE(
	IDCLIENTE INT,
	NOME VARCHAR(30) NOT NULL
	);

CREATE TABLE TELEFONE(
	IDTELEFONE INT,
	TIPO CHAR(3) NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_CLIENTE INT
	);

/*NOMEANDO-AS*/
ALTER TABLE CLIENTE
ADD CONSTRAINT PK_CLIENTE
PRIMARY KEY(IDCLIENTE);

ALTER TABLE TELEFONE
ADD CONSTRAINT FK_CLIENTE_TELEFONE
FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(IDCLIENTE);

SHOW CREATE TABLE TELEFONE; /*AGORA POSSUI UM NOME DESIGNADO EM CONSTRAINT*/

---------------------------+
| TELEFONE | CREATE TABLE `telefone` (
  `IDTELEFONE` int(11) DEFAULT NULL,
  `TIPO` char(3) NOT NULL,
  `NUMERO` varchar(10) NOT NULL,
  `ID_CLIENTE` int(11) DEFAULT NULL,
  KEY `FK_CLIENTE_TELEFONE` (`ID_CLIENTE`),
  CONSTRAINT `FK_CLIENTE_TELEFONE` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`IDCLIENTE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 |
---------------------------+

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

/*DICIONÁRIO DE DADOS:*/

SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
+--------------------+

USE information_schema;

SHOW TABLES;
+---------------------------------------+
| Tables_in_information_schema          |
+---------------------------------------+
| TABLE_CONSTRAINTS                     |
+---------------------------------------+

DESC TABLE_CONSTRAINTS;
+--------------------+--------------+------+-----+---------+-------+
| Field              | Type         | Null | Key | Default | Extra |
+--------------------+--------------+------+-----+---------+-------+
| CONSTRAINT_CATALOG | varchar(512) | NO   |     |         |       |
| CONSTRAINT_SCHEMA  | varchar(64)  | NO   |     |         |       |
| CONSTRAINT_NAME    | varchar(64)  | NO   |     |         |       |
| TABLE_SCHEMA       | varchar(64)  | NO   |     |         |       |
| TABLE_NAME         | varchar(64)  | NO   |     |         |       |
| CONSTRAINT_TYPE    | varchar(64)  | NO   |     |         |       |
+--------------------+--------------+------+-----+---------+-------+

SELECT 	CONSTRAINT_SCHEMA AS 'BANCO',
				TABLE_NAME AS 'TABELA',
				CONSTRAINT_NAME AS 'NOME REGRA',
				CONSTRAINT_TYPE AS 'TIPO'
				FROM TABLE_CONSTRAINTS
				WHERE CONSTRAINT_SCHEMA = 'PROJETO_2';
+-----------+------------+---------------------+-------------+
| BANCO     | TABELA     | NOME REGRA          | TIPO        |
+-----------+------------+---------------------+-------------+
| projeto_2 | cliente    | PRIMARY             | PRIMARY KEY |
| projeto_2 | cursos     | PRIMARY             | PRIMARY KEY |
| projeto_2 | jogador    | PRIMARY             | PRIMARY KEY |
| projeto_2 | pessoa     | PRIMARY             | PRIMARY KEY |
| projeto_2 | pessoa     | COLUNA4             | UNIQUE      |
| projeto_2 | telefone   | FK_CLIENTE_TELEFONE | FOREIGN KEY |
| projeto_2 | time       | PRIMARY             | PRIMARY KEY |
| projeto_2 | time       | time_ibfk_1         | FOREIGN KEY |
| projeto_2 | times      | PRIMARY             | PRIMARY KEY |
| projeto_2 | times      | times_ibfk_1        | FOREIGN KEY |
| projeto_2 | vendedores | PRIMARY             | PRIMARY KEY |
+-----------+------------+---------------------+-------------+

/*APAGANDO CONSTRAINTS*/

USE PROJETO_2;

ALTER TABLE TELEFONE 
DROP FOREIGN KEY FK_CLIENTE_TELEFONE;

/*DESABILITA-SE TEMPORARIAMENTE A FK QUANDO SE TEM UM NÚMERO MUITO GRANDE DE DADOS PARA SE
ADICIONAR, POIS AJUDA O PROCESSAMENTO DE DESTES. APÓS ISSO É SÓ RECRIÁ-LA.
SE ESTIVER TUDO CERTO, NÃO DARÁ ERRO, MAS SE DER: CHECAR O QUE NÃO TEM NA TABELA RELACIONADA E CORRIGIR*/