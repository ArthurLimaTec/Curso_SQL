CREATE DATABASE CURSORES;

USE CURSORES;

CREATE TABLE VENDEDORES(
	IDVENDEDOR INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	JAN INT,
	FEV INT,
	MAR INT 
	);

INSERT INTO VENDEDORES VALUES(NULL,'MAFRA',4516,4562,5257852);
INSERT INTO VENDEDORES VALUES(NULL,'CLARA',4746,4548,5784512);
INSERT INTO VENDEDORES VALUES(NULL,'JOÃO',47849,44741,525522);
INSERT INTO VENDEDORES VALUES(NULL,'LILIAN',44157,454574,5898742);
INSERT INTO VENDEDORES VALUES(NULL,'ANTONIO',4884,4215,5254847);
INSERT INTO VENDEDORES VALUES(NULL,'GLORIA',4999,47154,527484);

SELECT* FROM VENDEDORES;
+------------+---------+-------+--------+---------+
| IDVENDEDOR | NOME    | JAN   | FEV    | MAR     |
+------------+---------+-------+--------+---------+
|          1 | MAFRA   |  4516 |   4562 | 5257852 |
|          2 | CLARA   |  4746 |   4548 | 5784512 |
|          3 | JOÃO    | 47849 |  44741 |  525522 |
|          4 | LILIAN  | 44157 | 454574 | 5898742 |
|          5 | ANTONIO |  4884 |   4215 | 5254847 |
|          6 | GLORIA  |  4999 |  47154 |  527484 |
+------------+---------+-------+--------+---------+

SELECT NOME,(JAN+FEV+MAR) AS TOTAL FROM VENDEDORES;
+---------+---------+
| NOME    | TOTAL   |
+---------+---------+
| MAFRA   | 5266930 |
| CLARA   | 5793806 |
| JOÃO    |  618112 |
| LILIAN  | 6397473 |
| ANTONIO | 5263946 |
| GLORIA  |  579637 |
+---------+---------+

SELECT NOME,(JAN+FEV+MAR) AS TOTAL, (JAN+FEV+MAR)/3 AS MÉDIA FROM VENDEDORES;
+---------+---------+--------------+
| NOME    | TOTAL   | MÉDIA        |
+---------+---------+--------------+
| MAFRA   | 5266930 | 1755643.3333 |
| CLARA   | 5793806 | 1931268.6667 |
| JOÃO    |  618112 |  206037.3333 |
| LILIAN  | 6397473 | 2132491.0000 |
| ANTONIO | 5263946 | 1754648.6667 |
| GLORIA  |  579637 |  193212.3333 |
+---------+---------+--------------+

/*CRIANDO CURSOR: */

CREATE TABLE VEND_TOTAL(
	NOME VARCHAR(30),
	JAN INT,
	FEV INT,
	MAR INT,
	TOTAL INT,
	MEDIA INT 
	);

DELIMITER $


CREATE PROCEDURE INSEREDADOS()
BEGIN
		DECLARE FIM INT DEFAULT 0;
		DECLARE VAR1,VAR2,VAR3,VTOTAL,VMEDIA INT;		/*VARIÁVEIS*/
		DECLARE VNOME VARCHAR(30);

		DECLARE REG CURSOR FOR(								/*VETOR*/
			SELECT NOME,JAN,FEV,MAR FROM VENDEDORES
		);

		DECLARE CONTINUE HANDLER FOR NOT FOUND SET FIM = 1;	/*ISSO NUNCA MUDA, ISTO É O QUE VAI FAZER O LOOP DE OPERAÇÕES PARAR*/

		OPEN REG;											/*ISTO FAZ COM QUE O RESULTADO SEJA JOGADO PARA A MEMÓRIA RAM PARA 
															PODER SER MANIPULADO*/
		REPEAT
			FETCH REG INTO VNOME,VAR1,VAR2,VAR3;
			IF NOT FIM THEN
						SET VTOTAL = VAR1+VAR2+VAR3;								/*ESTE É O CURSOR*/
						SET VMEDIA = VTOTAL/3;

				INSERT INTO VEND_TOTAL VALUES(VNOME,VAR1,VAR2,VAR3,VTOTAL,VMEDIA);
			END IF;

		UNTIL FIM END REPEAT;

		CLOSE REG;
		
END$

DELIMITER ;

SELECT* FROM VENDEDORES;
+------------+---------+-------+--------+---------+
| IDVENDEDOR | NOME    | JAN   | FEV    | MAR     |
+------------+---------+-------+--------+---------+
|          1 | MAFRA   |  4516 |   4562 | 5257852 |
|          2 | CLARA   |  4746 |   4548 | 5784512 |
|          3 | JOÃO    | 47849 |  44741 |  525522 |
|          4 | LILIAN  | 44157 | 454574 | 5898742 |
|          5 | ANTONIO |  4884 |   4215 | 5254847 |
|          6 | GLORIA  |  4999 |  47154 |  527484 |
+------------+---------+-------+--------+---------+

SELECT* FROM VEND_TOTAL;
Empty set (0.01 sec)

/*AGORA VAMOS RODAR O CURSOR:*/

CALL INSEREDADOS();
Query OK, 0 rows affected (0.17 sec)

SELECT* FROM VEND_TOTAL;
+---------+-------+--------+---------+---------+---------+
| NOME    | JAN   | FEV    | MAR     | TOTAL   | MEDIA   |
+---------+-------+--------+---------+---------+---------+
| MAFRA   |  4516 |   4562 | 5257852 | 5266930 | 1755643 |
| CLARA   |  4746 |   4548 | 5784512 | 5793806 | 1931269 |
| JOÃO    | 47849 |  44741 |  525522 |  618112 |  206037 |
| LILIAN  | 44157 | 454574 | 5898742 | 6397473 | 2132491 |
| ANTONIO |  4884 |   4215 | 5254847 | 5263946 | 1754649 |
| GLORIA  |  4999 |  47154 |  527484 |  579637 |  193212 |
+---------+-------+--------+---------+---------+---------+

/*AGORA, O CURSOR CALCULARÁ AUTOMATICAMENTE COMO FOI PROGRAMADO*/