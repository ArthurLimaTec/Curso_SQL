CREATE DATABASE COMERCIO;

USE COMERCIO;

SHOW DATABASES;


CREATE TABLE CLIENTE(
		IDCLIENTE INT PRIMARY KEY AUTO_INCREMENT, 
		NOME VARCHAR(30) NOT NULL, 
		SEXO ENUM('M','F') NOT NULL, 
		EMAIL VARCHAR(50) UNIQUE, 
		CPF VARCHAR(15) UNIQUE );

CREATE TABLE ENDEREÇO(
		IDENDEREÇO INT PRIMARY KEY AUTO_INCREMENT,
		RUA VARCHAR(30) NOT NULL,
		BAIRRO VARCHAR(30) NOT NULL,
		CIDADE VARCHAR(30) NOT NULL,
		ESTADO CHAR(2) NOT NULL );

CREATE TABLE TELEFONE(
		IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT,
		TIPO ENUM('RES','COM','CEL') NOT NULL,
		NUMERO VARCHAR(11) NOT NULL );
		

CREATE TABLE ENDEREÇO(
		IDENDEREÇO INT PRIMARY KEY AUTO_INCREMENT,
		RUA VARCHAR(30) NOT NULL,
		BAIRRO VARCHAR(30) NOT NULL,
		CIDADE VARCHAR(30) NOT NULL,
		ESTADO CHAR(2) NOT NULL,
		ID_CLIENTE INT UNIQUE,
		FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(IDCLIENTE));
		
CREATE TABLE TELEFONE(
		IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT,
		TIPO ENUM('RES','COM','CEL') NOT NULL,
		NUMERO VARCHAR(11) NOT NULL,
		ID_CLIENTE INT UNIQUE,
		FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(IDCLIENTE));
		
 
INSERT INTO CLIENTE VALUES(NULL, 'JOAO','M','JOAO@IG.COM','76567587887');
INSERT INTO CLIENTE VALUES(NULL, 'CARLOS','M','CARLOS@IG.COM','76567587486');
INSERT INTO CLIENTE VALUES(NULL, 'ANA','F','ANA@GMAIL.COM','76999587251');
INSERT INTO CLIENTE VALUES(NULL, 'CLARA','F',NULL,'76516475887');
INSERT INTO CLIENTE VALUES(NULL, 'JORGE','M','JORGE@YAHOO.COM','89545581487');
INSERT INTO CLIENTE VALUES(NULL, 'CELIA','F','CELIA@HOTMAIL.COM.BR','99567514885');

SELECT* FROM CLIENTE;

+-----------+--------+------+----------------------+-------------+
| IDCLIENTE | NOME   | SEXO | EMAIL                | CPF         |
+-----------+--------+------+----------------------+-------------+
|         1 | JOAO   | M    | JOAO@IG.COM          | 76567587887 |
|         2 | CARLOS | M    | CARLOS@IG.COM        | 76567587486 |
|         3 | ANA    | F    | ANA@GMAIL.COM        | 76999587251 |
|         4 | CLARA  | F    | NULL                 | 76516475887 |
|         5 | JORGE  | M    | JORGE@YAHOO.COM      | 89545581487 |
|         6 | CELIA  | F    | CELIA@HOTMAIL.COM.BR | 99567514885 |
+-----------+--------+------+----------------------+-------------+

/* INSERÇÃO EM RELACIONAMENTOS (1,1), NESSE CASO ENDEREÇO PARA CLIENTE */
DESC ENDEREÇO;

+-------------+-------------+------+-----+---------+----------------+
| Field       | Type        | Null | Key | Default | Extra          |
+-------------+-------------+------+-----+---------+----------------+
| IDENDEREÇO  | int(11)     | NO   | PRI | NULL    | auto_increment |
| RUA         | varchar(30) | NO   |     | NULL    |                |
| BAIRRO      | varchar(30) | NO   |     | NULL    |                |
| CIDADE      | varchar(30) | NO   |     | NULL    |                |
| ESTADO      | char(2)     | NO   |     | NULL    |                |
| ID_CLIENTE  | int(11)     | YES  | UNI | NULL    |                |
+-------------+-------------+------+-----+---------+----------------+

INSERT INTO ENDEREÇO VALUES(NULL,'RUA ANTONIO SA','CENTRO','B. HORIZONTE','MG',4);
INSERT INTO ENDEREÇO VALUES(NULL,'RUA CAPITAO HERNES','CENTRO','RIO DE JANEIRO','RJ',1);
INSERT INTO ENDEREÇO VALUES(NULL,'RUA PRESIDENTE VARGAS','JARDINS','SAO PAULO','SP',3);
INSERT INTO ENDEREÇO VALUES(NULL,'RUA ALFANDEGA','ESTÁCIO','RIO DE JANEIRO','RJ',2);
INSERT INTO ENDEREÇO VALUES(NULL,'RUA OUVIDOR','FLAMENGO','RIO DE JANEIRO','RJ',6);
INSERT INTO ENDEREÇO VALUES(NULL,'RUA URUGUAIANA','CENTRO','VITÓRIA','ES',5);

SELECT* FROM ENDEREÇO;

+-------------+-----------------------+----------+----------------+--------+------------+
| IDENDEREÇO  | RUA                   | BAIRRO   | CIDADE         | ESTADO | ID_CLIENTE |
+-------------+-----------------------+----------+----------------+--------+------------+
|           1 | RUA ANTONIO SA        | CENTRO   | B. HORIZONTE   | MG     |          4 |
|           2 | RUA CAPITAO HERNES    | CENTRO   | RIO DE JANEIRO | RJ     |          1 |
|           3 | RUA PRESIDENTE VARGAS | JARDINS  | SAO PAULO      | SP     |          3 |
|           4 | RUA ALFANDEGA         | ESTÁCIO  | RIO DE JANEIRO | RJ     |          2 |
|           5 | RUA OUVIDOR           | FLAMENGO | RIO DE JANEIRO | RJ     |          6 |
|           6 | RUA URUGUAIANA        | CENTRO   | VITÓRIA        | ES     |          5 |
+-------------+-----------------------+----------+----------------+--------+------------+

/* LEMBRANDO QUE, COMO NA TABELA ENDEREÇO FOI COLOCADO O ID_CLIENTE (CHAVE ESTRANGEIRA) COMO 
'UNIQUE', SE TENTAR COLOCAR MAIS DE 1 ENDEREÇO NA MESMA PESSOA (ID_CLIENTE), O BANCO NÃO ACEITARÁ,
POIS FOI DETERMINADO QUE EXISTIRIA APENAS 1 ENDEREÇO POR CLIENTE;
COISA QUE NÃO ACONTECERÁ COM O TELEFONE, POIS NÃO FOI COLOCADO 'UNIQUE' NA CHAVE ESTRANGEIRA - ID_CLIENTE.
---------------------
	EXEMPLO: 
	INSERT INTO ENDEREÇO VALUES(NULL,'RUA URUGUAIANA','CENTRO','SAO PAULO','SP',5);

	RESULTADO: ERROR 1062 (23000): Duplicate entry '5' for key 'ID_CLIENTE' (DIRÁ QUE NÃO PODE
	DAR ENTRADA DUPLICADA PARA O ID_CLIENTE, POIS JÁ POSSUI UM ENDEREÇO CADASTRADO ANTERIORMENTE)
	A MESMA COISA NÃO ACONTECERÁ COM O TELEFONE, POR NÃO TER O 'UNIQUE'
---------------------*/

DESC TELEFONE;

+------------+-------------------------+------+-----+---------+----------------+
| Field      | Type                    | Null | Key | Default | Extra          |
+------------+-------------------------+------+-----+---------+----------------+
| IDTELEFONE | int(11)                 | NO   | PRI | NULL    | auto_increment |
| TIPO       | enum('RES','COM','CEL') | NO   |     | NULL    |                |
| NUMERO     | varchar(11)             | NO   |     | NULL    |                |
| ID_CLIENTE | int(11)                 | YES  | UNI | NULL    |                |
+------------+-------------------------+------+-----+---------+----------------+

INSERT INTO TELEFONE VALUES(NULL,'CEL','84645875251',5);
INSERT INTO TELEFONE VALUES(NULL,'RES','81568499251',5);
INSERT INTO TELEFONE VALUES(NULL,'CEL','84614547854',1);
INSERT INTO TELEFONE VALUES(NULL,'COM','84654998575',1);
INSERT INTO TELEFONE VALUES(NULL,'RES','84646516214',1);
INSERT INTO TELEFONE VALUES(NULL,'CEL','84651235975',2);
INSERT INTO TELEFONE VALUES(NULL,'CEL','84147885695',3);
INSERT INTO TELEFONE VALUES(NULL,'COM','97645125485',5);
INSERT INTO TELEFONE VALUES(NULL,'RES','84645456512',5);
INSERT INTO TELEFONE VALUES(NULL,'CEL','15615648956',2);

SELECT* FROM TELEFONE;

+------------+------+-------------+------------+
| IDTELEFONE | TIPO | NUMERO      | ID_CLIENTE |
+------------+------+-------------+------------+
|          1 | CEL  | 84645875251 |          5 |
|          2 | RES  | 81568499251 |          5 |
|          3 | CEL  | 84614547854 |          1 |
|          4 | COM  | 84654998575 |          1 |
|          5 | RES  | 84646516214 |          1 |
|          6 | CEL  | 84651235975 |          2 |
|          7 | CEL  | 84147885695 |          3 |
|          8 | COM  | 97645125485 |          5 |
|          9 | RES  | 84645456512 |          5 |
|         10 | CEL  | 15615648956 |          2 |
+------------+------+-------------+------------+

/* PELA AUSÊNCIA DO 'UNIQUE', PODERÁ INSERIR VARIOS TELEFONES PARA CADA PESSOA */

    SELECT NOME,EMAIL,IDCLIENTE
    FROM CLIENTE;

+--------+----------------------+-----------+
| NOME   | EMAIL                | IDCLIENTE |
+--------+----------------------+-----------+
| JOAO   | JOAO@IG.COM          |         1 |
| CARLOS | CARLOS@IG.COM        |         2 |
| ANA    | ANA@GMAIL.COM        |         3 |
| CLARA  | NULL                 |         4 |
| JORGE  | JORGE@YAHOO.COM      |         5 |
| CELIA  | CELIA@HOTMAIL.COM.BR |         6 |
+--------+----------------------+-----------+

	SELECT ID_CLIENTE,BAIRRO,CIDADE
	FROM ENDEREÇO;

+------------+----------+----------------+
| ID_CLIENTE | BAIRRO   | CIDADE         |
+------------+----------+----------------+
|          4 | CENTRO   | B. HORIZONTE   |
|          1 | CENTRO   | RIO DE JANEIRO |
|          3 | JARDINS  | SAO PAULO      |
|          2 | ESTÁCIO  | RIO DE JANEIRO |
|          6 | FLAMENGO | RIO DE JANEIRO |
|          5 | CENTRO   | VITÓRIA        |
+------------+----------+----------------+

/*EXEMPLO 1: (1,1)*/

	SELECT NOME,SEXO,BAIRRO,CIDADE
	FROM CLIENTE
	INNER JOIN ENDEREÇO
	ON IDCLIENTE = ID_CLIENTE;

+--------+------+----------+----------------+
| NOME   | SEXO | BAIRRO   | CIDADE         |
+--------+------+----------+----------------+
| JOAO   | M    | CENTRO   | RIO DE JANEIRO |
| CARLOS | M    | ESTÁCIO  | RIO DE JANEIRO |
| ANA    | F    | JARDINS  | SAO PAULO      |
| CLARA  | F    | CENTRO   | B. HORIZONTE   |
| JORGE  | M    | CENTRO   | VITÓRIA        |
| CELIA  | F    | FLAMENGO | RIO DE JANEIRO |
+--------+------+----------+----------------+

	SELECT NOME,SEXO,BAIRRO,CIDADE 	/*PROJEÇÃO*/
	FROM CLIENTE					/*ORIGEM*/
	INNER JOIN IDENDEREÇO			/*JUNÇÃO*/
	ON IDCLIENTE = ID_CLIENTE
	WHERE SEXO = 'F';				/*SELEÇÃO*/

+-------+------+----------+----------------+
| NOME  | SEXO | BAIRRO   | CIDADE         |
+-------+------+----------+----------------+
| ANA   | F    | JARDINS  | SAO PAULO      |
| CLARA | F    | CENTRO   | B. HORIZONTE   |
| CELIA | F    | FLAMENGO | RIO DE JANEIRO |
+-------+------+----------+----------------+

/*EXEMPLO 2: (1,n)*/

	SELECT NOME,SEXO,EMAIL,TIPO,NUMERO
	FROM CLIENTE
	INNER JOIN TELEFONE
	ON IDCLIENTE = ID_CLIENTE;

+--------+------+-----------------+------+-------------+
| NOME   | SEXO | EMAIL           | TIPO | NUMERO      |
+--------+------+-----------------+------+-------------+
| JOAO   | M    | JOAO@IG.COM     | CEL  | 84614547854 |
| JOAO   | M    | JOAO@IG.COM     | COM  | 84654998575 |
| JOAO   | M    | JOAO@IG.COM     | RES  | 84646516214 |
| CARLOS | M    | CARLOS@IG.COM   | CEL  | 84651235975 |
| CARLOS | M    | CARLOS@IG.COM   | CEL  | 15615648956 |
| ANA    | F    | ANA@GMAIL.COM   | CEL  | 84147885695 |
| JORGE  | M    | JORGE@YAHOO.COM | CEL  | 84645875251 |
| JORGE  | M    | JORGE@YAHOO.COM | RES  | 81568499251 |
| JORGE  | M    | JORGE@YAHOO.COM | COM  | 97645125485 |
| JORGE  | M    | JORGE@YAHOO.COM | RES  | 84645456512 |
+--------+------+-----------------+------+-------------+

/*EXEMPLO 3: MAIS DE 2 TABELAS:*/

	SELECT CLIENTE.NOME,CLIENTE.SEXO,ENDEREÇO.BAIRRO,ENDEREÇO.CIDADE,TELEFONE.TIPO,TELEFONE.NUMERO
	FROM CLIENTE
	INNER JOIN ENDEREÇO
	ON CLIENTE.IDCLIENTE = ENDEREÇO.ID_CLIENTE
	INNER JOIN TELEFONE
	ON CLIENTE.IDCLIENTE = TELEFONE.ID_CLIENTE;

			/*OU, PODE-SE APELIDAR AS TABELAS, COMO ABAIXO:*/

	SELECT C.NOME,C.SEXO,E.BAIRRO,E.CIDADE,T.TIPO,T.NUMERO
	FROM CLIENTE C
	INNER JOIN ENDEREÇO E
	ON C.IDCLIENTE = E.ID_CLIENTE
	INNER JOIN TELEFONE T
	ON C.IDCLIENTE = T.ID_CLIENTE;

+--------+------+----------+----------------+------+-------------+
| NOME   | SEXO | BAIRRO   | CIDADE         | TIPO | NUMERO      |
+--------+------+----------+----------------+------+-------------+
| JOAO   | M    | CENTRO   | RIO DE JANEIRO | CEL  | 84614547854 |
| JOAO   | M    | CENTRO   | RIO DE JANEIRO | COM  | 84654998575 |
| JOAO   | M    | CENTRO   | RIO DE JANEIRO | RES  | 84646516214 |
| CARLOS | M    | ESTÁCIO  | RIO DE JANEIRO | CEL  | 84651235975 |
| CARLOS | M    | ESTÁCIO  | RIO DE JANEIRO | CEL  | 15615648956 |
| ANA    | F    | JARDINS  | SAO PAULO      | CEL  | 84147885695 |
| JORGE  | M    | CENTRO   | VITÓRIA        | CEL  | 84645875251 |
| JORGE  | M    | CENTRO   | VITÓRIA        | RES  | 81568499251 |
| JORGE  | M    | CENTRO   | VITÓRIA        | COM  | 97645125485 |
| JORGE  | M    | CENTRO   | VITÓRIA        | RES  | 84645456512 |
+--------+------+----------+----------------+------+-------------+


/*FUNÇÃO 'IFNULL()', E CONSERTANDO O NOME DA COLUNA*/

SELECT C.NOME,C.EMAIL,E.ESTADO,T.NUMERO
FROM CLIENTE C
INNER JOIN ENDEREÇO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+---------+-------------------+--------+-------------+
| NOME    | EMAIL             | ESTADO | NUMERO      |
+---------+-------------------+--------+-------------+
| JORGE   | JORGE@YAHOO.COM   | ES     | 84645875251 |
| JORGE   | JORGE@YAHOO.COM   | ES     | 81568499251 |
| JOAO    | JOAO@IG.COM       | RJ     | 84614547854 |
| JOAO    | JOAO@IG.COM       | RJ     | 84654998575 |
| JOAO    | JOAO@IG.COM       | RJ     | 84646516214 |
| CARLOS  | CARLOS@IG.COM     | RJ     | 84651235975 |
| ANA     | ANA@GMAIL.COM     | SP     | 84147885695 |
| JORGE   | JORGE@YAHOO.COM   | ES     | 97645125485 |
| JORGE   | JORGE@YAHOO.COM   | ES     | 84645456512 |
| CARLOS  | CARLOS@IG.COM     | RJ     | 15615648956 |
| ANDRE   | ANDRE@GLOBO.COM   | MG     | 68976565    |
| ANDRE   | ANDRE@GLOBO.COM   | MG     | 99656675    |
| KARLA   | KARLA@GMAIL.COM   | RJ     | 33567765    |
| KARLA   | KARLA@GMAIL.COM   | RJ     | 88668786    |
| KARLA   | KARLA@GMAIL.COM   | RJ     | 55689654    |
| DANIELE | DANIELE@GMAIL.COM | RJ     | 88687979    |
| LORENA  | NULL              | ES     | 88965676    |
| ANTONIO | ANTONIO@IG.COM    | PR     | 89966809    |
| ANTONIO | ANTONIO@UOL.COM   | SP     | 88679978    |
| ELAINE  | ELAINE@GLOBO.COM  | PR     | 99655768    |
| CARMEM  | CARMEM@IG.COM     | SP     | 89955665    |
| ADRIANA | ADRIANA@GMAIL.COM | RJ     | 77455786    |
| ADRIANA | ADRIANA@GMAIL.COM | RJ     | 89766554    |
| JOICE   | JOICE@GMAIL.COM   | RJ     | 77755785    |
| JOICE   | JOICE@GMAIL.COM   | RJ     | 44522578    |
+---------+-------------------+--------+-------------+

SELECT 	C.NOME,
		IFNULL(C.EMAIL,'NÃO TEM EMAIL'),
		E.ESTADO,
		T.NUMERO
FROM CLIENTE C
INNER JOIN ENDEREÇO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+---------+----------------------------------+--------+-------------+
| NOME    | IFNULL(C.EMAIL,'NÃO TEM EMAIL')  | ESTADO | NUMERO      |
+---------+----------------------------------+--------+-------------+
| JORGE   | JORGE@YAHOO.COM                  | ES     | 84645875251 |
| JORGE   | JORGE@YAHOO.COM                  | ES     | 81568499251 |
| JOAO    | JOAO@IG.COM                      | RJ     | 84614547854 |
| JOAO    | JOAO@IG.COM                      | RJ     | 84654998575 |
| JOAO    | JOAO@IG.COM                      | RJ     | 84646516214 |
| CARLOS  | CARLOS@IG.COM                    | RJ     | 84651235975 |
| ANA     | ANA@GMAIL.COM                    | SP     | 84147885695 |
| JORGE   | JORGE@YAHOO.COM                  | ES     | 97645125485 |
| JORGE   | JORGE@YAHOO.COM                  | ES     | 84645456512 |
| CARLOS  | CARLOS@IG.COM                    | RJ     | 15615648956 |
| ANDRE   | ANDRE@GLOBO.COM                  | MG     | 68976565    |
| ANDRE   | ANDRE@GLOBO.COM                  | MG     | 99656675    |
| KARLA   | KARLA@GMAIL.COM                  | RJ     | 33567765    |
| KARLA   | KARLA@GMAIL.COM                  | RJ     | 88668786    |
| KARLA   | KARLA@GMAIL.COM                  | RJ     | 55689654    |
| DANIELE | DANIELE@GMAIL.COM                | RJ     | 88687979    |
| LORENA  | NÃO TEM EMAIL                    | ES     | 88965676    |
| ANTONIO | ANTONIO@IG.COM                   | PR     | 89966809    |
| ANTONIO | ANTONIO@UOL.COM                  | SP     | 88679978    |
| ELAINE  | ELAINE@GLOBO.COM                 | PR     | 99655768    |
| CARMEM  | CARMEM@IG.COM                    | SP     | 89955665    |
| ADRIANA | ADRIANA@GMAIL.COM                | RJ     | 77455786    |
| ADRIANA | ADRIANA@GMAIL.COM                | RJ     | 89766554    |
| JOICE   | JOICE@GMAIL.COM                  | RJ     | 77755785    |
| JOICE   | JOICE@GMAIL.COM                  | RJ     | 44522578    |
+---------+----------------------------------+--------+-------------+

SELECT 	C.NOME,
		IFNULL(C.EMAIL,'NÃO TEM EMAIL') AS 'EMAIL',
		E.ESTADO,
		T.NUMERO
FROM CLIENTE C
INNER JOIN ENDEREÇO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+---------+-------------------+--------+-------------+
| NOME    | EMAIL             | ESTADO | NUMERO      |
+---------+-------------------+--------+-------------+
| JORGE   | JORGE@YAHOO.COM   | ES     | 84645875251 |
| JORGE   | JORGE@YAHOO.COM   | ES     | 81568499251 |
| JOAO    | JOAO@IG.COM       | RJ     | 84614547854 |
| JOAO    | JOAO@IG.COM       | RJ     | 84654998575 |
| JOAO    | JOAO@IG.COM       | RJ     | 84646516214 |
| CARLOS  | CARLOS@IG.COM     | RJ     | 84651235975 |
| ANA     | ANA@GMAIL.COM     | SP     | 84147885695 |
| JORGE   | JORGE@YAHOO.COM   | ES     | 97645125485 |
| JORGE   | JORGE@YAHOO.COM   | ES     | 84645456512 |
| CARLOS  | CARLOS@IG.COM     | RJ     | 15615648956 |
| ANDRE   | ANDRE@GLOBO.COM   | MG     | 68976565    |
| ANDRE   | ANDRE@GLOBO.COM   | MG     | 99656675    |
| KARLA   | KARLA@GMAIL.COM   | RJ     | 33567765    |
| KARLA   | KARLA@GMAIL.COM   | RJ     | 88668786    |
| KARLA   | KARLA@GMAIL.COM   | RJ     | 55689654    |
| DANIELE | DANIELE@GMAIL.COM | RJ     | 88687979    |
| LORENA  | NÃO TEM EMAIL     | ES     | 88965676    |
| ANTONIO | ANTONIO@IG.COM    | PR     | 89966809    |
| ANTONIO | ANTONIO@UOL.COM   | SP     | 88679978    |
| ELAINE  | ELAINE@GLOBO.COM  | PR     | 99655768    |
| CARMEM  | CARMEM@IG.COM     | SP     | 89955665    |
| ADRIANA | ADRIANA@GMAIL.COM | RJ     | 77455786    |
| ADRIANA | ADRIANA@GMAIL.COM | RJ     | 89766554    |
| JOICE   | JOICE@GMAIL.COM   | RJ     | 77755785    |
| JOICE   | JOICE@GMAIL.COM   | RJ     | 44522578    |
+---------+-------------------+--------+-------------+


/* CRIANDO VIEWS: */

CREATE VIEW RELATÓRIO AS
SELECT 	C.NOME,
		C.SEXO,
		C.EMAIL,
		T.TIPO,
		T.NUMERO,
		E.BAIRRO,
		E.CIDADE,
		E.ESTADO 
FROM CLIENTE C
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDEREÇO E
ON C.IDCLIENTE = E.ID_CLIENTE;

SELECT * FROM RELATÓRIO;

+---------+------+-------------------+------+-------------+------------+----------------+--------+
| NOME    | SEXO | EMAIL             | TIPO | NUMERO      | BAIRRO     | CIDADE         | ESTADO |
+---------+------+-------------------+------+-------------+------------+----------------+--------+
| JORGE   | M    | JORGE@YAHOO.COM   | CEL  | 84645875251 | CENTRO     | VITÓRIA        | ES     |
| JORGE   | M    | JORGE@YAHOO.COM   | RES  | 81568499251 | CENTRO     | VITÓRIA        | ES     |
| JOAO    | M    | JOAO@IG.COM       | CEL  | 84614547854 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@IG.COM       | COM  | 84654998575 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@IG.COM       | RES  | 84646516214 | CENTRO     | RIO DE JANEIRO | RJ     |
| CARLOS  | M    | CARLOS@IG.COM     | CEL  | 84651235975 | ESTÁCIO    | RIO DE JANEIRO | RJ     |
| ANA     | F    | ANA@GMAIL.COM     | CEL  | 84147885695 | JARDINS    | SAO PAULO      | SP     |
| JORGE   | M    | JORGE@YAHOO.COM   | COM  | 97645125485 | CENTRO     | VITÓRIA        | ES     |
| JORGE   | M    | JORGE@YAHOO.COM   | RES  | 84645456512 | CENTRO     | VITÓRIA        | ES     |
| CARLOS  | M    | CARLOS@IG.COM     | CEL  | 15615648956 | ESTÁCIO    | RIO DE JANEIRO | RJ     |
| ANDRE   | M    | ANDRE@GLOBO.COM   | RES  | 68976565    | CASCADURA  | B. HORIZONTE   | MG     |
| ANDRE   | M    | ANDRE@GLOBO.COM   | CEL  | 99656675    | CASCADURA  | B. HORIZONTE   | MG     |
| KARLA   | F    | KARLA@GMAIL.COM   | CEL  | 33567765    | CENTRO     | RIO DE JANEIRO | RJ     |
| KARLA   | F    | KARLA@GMAIL.COM   | CEL  | 88668786    | CENTRO     | RIO DE JANEIRO | RJ     |
| KARLA   | F    | KARLA@GMAIL.COM   | COM  | 55689654    | CENTRO     | RIO DE JANEIRO | RJ     |
| DANIELE | F    | DANIELE@GMAIL.COM | COM  | 88687979    | COPACABANA | RIO DE JANEIRO | RJ     |
| LORENA  | F    | NULL              | COM  | 88965676    | CENTRO     | VITORIA        | ES     |
| ANTONIO | M    | ANTONIO@IG.COM    | CEL  | 89966809    | CENTRO     | CURITIBA       | PR     |
| ANTONIO | M    | ANTONIO@UOL.COM   | COM  | 88679978    | JARDINS    | SAO PAULO      | SP     |
| ELAINE  | F    | ELAINE@GLOBO.COM  | CEL  | 99655768    | BOM RETIRO | CURITIBA       | PR     |
| CARMEM  | F    | CARMEM@IG.COM     | RES  | 89955665    | LAPA       | SAO PAULO      | SP     |
| ADRIANA | F    | ADRIANA@GMAIL.COM | RES  | 77455786    | CENTRO     | RIO DE JANEIRO | RJ     |
| ADRIANA | F    | ADRIANA@GMAIL.COM | RES  | 89766554    | CENTRO     | RIO DE JANEIRO | RJ     |
| JOICE   | F    | JOICE@GMAIL.COM   | RES  | 77755785    | CENTRO     | RIO DE JANEIRO | RJ     |
| JOICE   | F    | JOICE@GMAIL.COM   | COM  | 44522578    | CENTRO     | RIO DE JANEIRO | RJ     |
+---------+------+-------------------+------+-------------+------------+----------------+--------+


SHOW TABLES;

+--------------------+
| Tables_in_comercio |
+--------------------+
| cliente            |
| endereço           |
| relatório          |
| telefone           |
+--------------------+

/* APAGANDO VIEW */

DROP VIEW RELATÓRIO;

/* RECRIANDO COM PREFIXO 'V_...', PARA PADRONIZAÇÃO: */

CREATE VIEW V_RELATÓRIO AS
SELECT 	C.NOME,
		C.SEXO,
		IFNULL(C.EMAIL, 'CLIENTE SEM EMAIL') AS 'E-MAIL',
		T.TIPO,
		T.NUMERO,
		E.BAIRRO,
		E.CIDADE,
		E.ESTADO 
FROM CLIENTE C
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDEREÇO E
ON C.IDCLIENTE = E.ID_CLIENTE;

SHOW TABLES;

+--------------------+
| Tables_in_comercio |
+--------------------+
| cliente            |
| endereço           |
| telefone           |
| v_relatório        |
+--------------------+

SELECT NOME,NUMERO,ESTADO
FROM V_RELATÓRIO;

+---------+-------------+--------+
| NOME    | NUMERO      | ESTADO |
+---------+-------------+--------+
| JORGE   | 84645875251 | ES     |
| JORGE   | 81568499251 | ES     |
| JOAO    | 84614547854 | RJ     |
| JOAO    | 84654998575 | RJ     |
| JOAO    | 84646516214 | RJ     |
| CARLOS  | 84651235975 | RJ     |
| ANA     | 84147885695 | SP     |
| JORGE   | 97645125485 | ES     |
| JORGE   | 84645456512 | ES     |
| CARLOS  | 15615648956 | RJ     |
| ANDRE   | 68976565    | MG     |
| ANDRE   | 99656675    | MG     |
| KARLA   | 33567765    | RJ     |
| KARLA   | 88668786    | RJ     |
| KARLA   | 55689654    | RJ     |
| DANIELE | 88687979    | RJ     |
| LORENA  | 88965676    | ES     |
| ANTONIO | 89966809    | PR     |
| ANTONIO | 88679978    | SP     |
| ELAINE  | 99655768    | PR     |
| CARMEM  | 89955665    | SP     |
| ADRIANA | 77455786    | RJ     |
| ADRIANA | 89766554    | RJ     |
| JOICE   | 77755785    | RJ     |
| JOICE   | 44522578    | RJ     |
+---------+-------------+--------+


UPDATE V_RELATÓRIO SET NOME = 'JOSE' WHERE NOME = 'JORGE';
Query OK, 1 row affected (0.08 sec)


+---------+------+-------------------+------+-------------+------------+----------------+--------+
| NOME    | SEXO | E-MAIL            | TIPO | NUMERO      | BAIRRO     | CIDADE         | ESTADO |
+---------+------+-------------------+------+-------------+------------+----------------+--------+
| JOSE    | M    | JORGE@YAHOO.COM   | CEL  | 84645875251 | CENTRO     | VITÓRIA        | ES     |
| JOSE    | M    | JORGE@YAHOO.COM   | RES  | 81568499251 | CENTRO     | VITÓRIA        | ES     |
| JOAO    | M    | JOAO@IG.COM       | CEL  | 84614547854 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@IG.COM       | COM  | 84654998575 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@IG.COM       | RES  | 84646516214 | CENTRO     | RIO DE JANEIRO | RJ     |
| CARLOS  | M    | CARLOS@IG.COM     | CEL  | 84651235975 | ESTÁCIO    | RIO DE JANEIRO | RJ     |
| ANA     | F    | ANA@GMAIL.COM     | CEL  | 84147885695 | JARDINS    | SAO PAULO      | SP     |
| JOSE    | M    | JORGE@YAHOO.COM   | COM  | 97645125485 | CENTRO     | VITÓRIA        | ES     |
| JOSE    | M    | JORGE@YAHOO.COM   | RES  | 84645456512 | CENTRO     | VITÓRIA        | ES     |
| CARLOS  | M    | CARLOS@IG.COM     | CEL  | 15615648956 | ESTÁCIO    | RIO DE JANEIRO | RJ     |
| ANDRE   | M    | ANDRE@GLOBO.COM   | RES  | 68976565    | CASCADURA  | B. HORIZONTE   | MG     |
| ANDRE   | M    | ANDRE@GLOBO.COM   | CEL  | 99656675    | CASCADURA  | B. HORIZONTE   | MG     |
| KARLA   | F    | KARLA@GMAIL.COM   | CEL  | 33567765    | CENTRO     | RIO DE JANEIRO | RJ     |
| KARLA   | F    | KARLA@GMAIL.COM   | CEL  | 88668786    | CENTRO     | RIO DE JANEIRO | RJ     |
| KARLA   | F    | KARLA@GMAIL.COM   | COM  | 55689654    | CENTRO     | RIO DE JANEIRO | RJ     |
| DANIELE | F    | DANIELE@GMAIL.COM | COM  | 88687979    | COPACABANA | RIO DE JANEIRO | RJ     |
| LORENA  | F    | CLIENTE SEM EMAIL | COM  | 88965676    | CENTRO     | VITORIA        | ES     |
| ANTONIO | M    | ANTONIO@IG.COM    | CEL  | 89966809    | CENTRO     | CURITIBA       | PR     |
| ANTONIO | M    | ANTONIO@UOL.COM   | COM  | 88679978    | JARDINS    | SAO PAULO      | SP     |
| ELAINE  | F    | ELAINE@GLOBO.COM  | CEL  | 99655768    | BOM RETIRO | CURITIBA       | PR     |
| CARMEM  | F    | CARMEM@IG.COM     | RES  | 89955665    | LAPA       | SAO PAULO      | SP     |
| ADRIANA | F    | ADRIANA@GMAIL.COM | RES  | 77455786    | CENTRO     | RIO DE JANEIRO | RJ     |
| ADRIANA | F    | ADRIANA@GMAIL.COM | RES  | 89766554    | CENTRO     | RIO DE JANEIRO | RJ     |
| JOICE   | F    | JOICE@GMAIL.COM   | RES  | 77755785    | CENTRO     | RIO DE JANEIRO | RJ     |
| JOICE   | F    | JOICE@GMAIL.COM   | COM  | 44522578    | CENTRO     | RIO DE JANEIRO | RJ     |
+---------+------+-------------------+------+-------------+------------+----------------+--------+

------------------------------------------------------------------------------------------------------------------

CREATE TABLE ALUNOS(
		NUMERO INT,
		NOME VARCHAR(30)
		);

INSERT INTO ALUNOS VALUES(1,'JOAO');
INSERT INTO ALUNOS VALUES(1,'MARIA');
INSERT INTO ALUNOS VALUES(2,'ZOE');
INSERT INTO ALUNOS VALUES(2,'ANDRE');
INSERT INTO ALUNOS VALUES(3,'CLARA');
INSERT INTO ALUNOS VALUES(1,'CLARA');
INSERT INTO ALUNOS VALUES(4,'MAFRA');
INSERT INTO ALUNOS VALUES(5,'JANAINA');
INSERT INTO ALUNOS VALUES(1,'JANAINA');
INSERT INTO ALUNOS VALUES(3,'MARCELO');
INSERT INTO ALUNOS VALUES(4,'GIOVANI');
INSERT INTO ALUNOS VALUES(5,'ANTONIO');
INSERT INTO ALUNOS VALUES(6,'ANA');
INSERT INTO ALUNOS VALUES(6,'VIVIANE');

+--------+---------+							+--------+---------+
| NUMERO | NOME    |							| NUMERO | NOME    |
+--------+---------+							+--------+---------+
|      1 | JOAO    |							|      1 | JOAO    |
|      1 | MARIA   |							|      1 | MARIA   |
|      2 | ZOE     |							|      1 | CLARA   |
|      2 | ANDRE   |	SELECT* FROM ALUNOS		|      1 | JANAINA |
|      3 | CLARA   |	ORDER BY 1;				|      2 | ZOE     |
|      1 | CLARA   |							|      2 | ANDRE   |
|      4 | MAFRA   |	/*-------------->*/		|      3 | CLARA   |
|      5 | JANAINA |							|      3 | MARCELO |
|      1 | JANAINA |							|      4 | MAFRA   |
|      3 | MARCELO |							|      4 | GIOVANI |
|      4 | GIOVANI |							|      5 | JANAINA |
|      5 | ANTONIO |							|      5 | ANTONIO |
|      6 | ANA     |							|      6 | ANA     |
|      6 | VIVIANE |							|      6 | VIVIANE |
+--------+---------+							+--------+---------+

SELECT NOME FROM ALUNOS
ORDER BY NUMERO, NOME;

+---------+
| NOME    |
+---------+
| CLARA   |
| JANAINA |
| JOAO    |
| MARIA   |
| ANDRE   |
| ZOE     |
| CLARA   |
| MARCELO |
| GIOVANI |
| MAFRA   |
| ANTONIO |
| JANAINA |
| ANA     |
| VIVIANE |
+---------+


SELECT * FROM ALUNOS
ORDER BY 1 DESC, 2 DESC;

+--------+---------+
| NUMERO | NOME    |
+--------+---------+
|      6 | VIVIANE |
|      6 | ANA     |
|      5 | JANAINA |
|      5 | ANTONIO |
|      4 | MAFRA   |
|      4 | GIOVANI |
|      3 | MARCELO |
|      3 | CLARA   |
|      2 | ZOE     |
|      2 | ANDRE   |
|      1 | MARIA   |
|      1 | JOAO    |
|      1 | JANAINA |
|      1 | CLARA   |
+--------+---------+



/*ORDER BY COM JOIN NAS VIEWS:*/

SELECT 	C.NOME,
		C.SEXO,
		IFNULL(C.EMAIL,'CLIENTE SEM EMAIL') AS 'E-MAIL',
		T.TIPO,
		T.NUMERO,
		E.BAIRRO,
		E.CIDADE,
		E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDEREÇO E
ON C.IDCLIENTE = E.ID_CLIENTE;
---------------------------------------


SELECT * FROM V_RELATÓRIO
ORDER BY 1;

+---------+------+-------------------+------+-------------+------------+----------------+--------+
| NOME    | SEXO | E-MAIL            | TIPO | NUMERO      | BAIRRO     | CIDADE         | ESTADO |
+---------+------+-------------------+------+-------------+------------+----------------+--------+
| ADRIANA | F    | ADRIANA@GMAIL.COM | RES  | 89766554    | CENTRO     | RIO DE JANEIRO | RJ     |
| ADRIANA | F    | ADRIANA@GMAIL.COM | RES  | 77455786    | CENTRO     | RIO DE JANEIRO | RJ     |
| ANA     | F    | ANA@GMAIL.COM     | CEL  | 84147885695 | JARDINS    | SAO PAULO      | SP     |
| ANDRE   | M    | ANDRE@GLOBO.COM   | CEL  | 99656675    | CASCADURA  | B. HORIZONTE   | MG     |
| ANDRE   | M    | ANDRE@GLOBO.COM   | RES  | 68976565    | CASCADURA  | B. HORIZONTE   | MG     |
| ANTONIO | M    | ANTONIO@UOL.COM   | COM  | 88679978    | JARDINS    | SAO PAULO      | SP     |
| ANTONIO | M    | ANTONIO@IG.COM    | CEL  | 89966809    | CENTRO     | CURITIBA       | PR     |
| CARLOS  | M    | CARLOS@IG.COM     | CEL  | 84651235975 | ESTÁCIO    | RIO DE JANEIRO | RJ     |
| CARLOS  | M    | CARLOS@IG.COM     | CEL  | 15615648956 | ESTÁCIO    | RIO DE JANEIRO | RJ     |
| CARMEM  | F    | CARMEM@IG.COM     | RES  | 89955665    | LAPA       | SAO PAULO      | SP     |
| DANIELE | F    | DANIELE@GMAIL.COM | COM  | 88687979    | COPACABANA | RIO DE JANEIRO | RJ     |
| ELAINE  | F    | ELAINE@GLOBO.COM  | CEL  | 99655768    | BOM RETIRO | CURITIBA       | PR     |
| JOAO    | M    | JOAO@IG.COM       | CEL  | 84614547854 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@IG.COM       | RES  | 84646516214 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@IG.COM       | COM  | 84654998575 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOICE   | F    | JOICE@GMAIL.COM   | COM  | 44522578    | CENTRO     | RIO DE JANEIRO | RJ     |
| JOICE   | F    | JOICE@GMAIL.COM   | RES  | 77755785    | CENTRO     | RIO DE JANEIRO | RJ     |
| JOSE    | M    | JORGE@YAHOO.COM   | RES  | 84645456512 | CENTRO     | VITÓRIA        | ES     |
| JOSE    | M    | JORGE@YAHOO.COM   | COM  | 97645125485 | CENTRO     | VITÓRIA        | ES     |
| JOSE    | M    | JORGE@YAHOO.COM   | RES  | 81568499251 | CENTRO     | VITÓRIA        | ES     |
| JOSE    | M    | JORGE@YAHOO.COM   | CEL  | 84645875251 | CENTRO     | VITÓRIA        | ES     |
| KARLA   | F    | KARLA@GMAIL.COM   | CEL  | 88668786    | CENTRO     | RIO DE JANEIRO | RJ     |
| KARLA   | F    | KARLA@GMAIL.COM   | CEL  | 33567765    | CENTRO     | RIO DE JANEIRO | RJ     |
| KARLA   | F    | KARLA@GMAIL.COM   | COM  | 55689654    | CENTRO     | RIO DE JANEIRO | RJ     |
| LORENA  | F    | CLIENTE SEM EMAIL | COM  | 88965676    | CENTRO     | VITORIA        | ES     |
+---------+------+-------------------+------+-------------+------------+----------------+--------+
