/*BLOCO DE EXECUÇÃO*/
BEGIN 
	
	PRINT 'PRIMEIRO BLOCO'

END 
GO 


/*BLOCOS DE ATRIBUIÇÃO DE VARIÁVEIS*/
DECLARE 

	@CONTADOR INT 

BEGIN 

	SET @CONTADOR = 5
	PRINT @CONTADOR

END
GO 


/*NO SQL SERVER, CADA COLUNA, VARIÁVEL LOCAL, EXPRESSÃO E PARÂMETRO TEM UM TIPO.*/

DECLARE 

	@V_NUMERO NUMERIC(10,2) = 100.52,
	@V_DATA DATETIME = '20170207'

BEGIN 

	PRINT 'VALOR NUMÉRICO: ' + CAST (@V_NUMERO AS VARCHAR)
	PRINT 'VALOR NUMÉRICO: ' + CONVERT(VARCHAR, @V_NUMERO)
	PRINT 'VALOR DE DATA: ' + CAST(@V_DATA AS VARCHAR)
	PRINT 'VALOR DE DATA: ' + CONVERT (VARCHAR, @V_DATA,121)	-
	PRINT 'VALOR DE DATA: ' + CONVERT (VARCHAR, @V_DATA,120)	- 121,120,105 = SÃO OS TIPOS DE LINGUAGEM
	PRINT 'VALOR DE DATA: ' + CONVERT (VARCHAR, @V_DATA,105)	-				NESTE CASO, FORMATO DE DATA

END
GO 

---------------------------------------
VALOR NUMÉRICO: 100.52
VALOR NUMÉRICO: 100.52
VALOR DE DATA: Fev  7 2017 12:00AM
VALOR DE DATA: 2017-02-07 00:00:00.000
VALOR DE DATA: 2017-02-07 00:00:00
VALOR DE DATA: 07-02-2017
---------------------------------------


/*ATRIBUINDO RESULTADO ÀS VARIÁVEIS:*/

CREATE TABLE CARROS(
	CARRO VARCHAR(20),
	FABRICANTE VARCHAR(30)
)
GO

INSERT INTO CARROS VALUES('KA','FORD')
INSERT INTO CARROS VALUES('FIESTA','FORD')
INSERT INTO CARROS VALUES('PRISMA','FORD')
INSERT INTO CARROS VALUES('CLIO','RENAULT')
INSERT INTO CARROS VALUES('SANDERO','RENAULT')
INSERT INTO CARROS VALUES('CHEVETE','CHEVROLET')
INSERT INTO CARROS VALUES('OMEGA','CHEVROLET')
INSERT INTO CARROS VALUES('PALIO','FIAT')
INSERT INTO CARROS VALUES('DOBLO','FIAT')
INSERT INTO CARROS VALUES('UNO','FIAT')
INSERT INTO CARROS VALUES('GOL','VOLKSWAGEN')
GO


DECLARE 
		@V_CONT_FORD INT,
		@V_CONT_FIAT INT
BEGIN
		
		SET @V_CONT_FORD = (SELECT COUNT(*) FROM CARROS							--METODO 1 - O SELECT PRECISA RETORNAR UMA SIMPLES COLUNA
		WHERE FABRICANTE = 'FORD')												--E UM SO RESULTADO
		
		PRINT 'QUANTIDADE FORD: ' + CAST(@V_CONT_FORD AS VARCHAR)

																				--METODO 2
		SELECT @V_CONT_FIAT = COUNT(*) FROM CARROS WHERE FABRICANTE = 'FIAT'

		PRINT 'QUANTIDADE FIAT: ' + CONVERT(VARCHAR, @V_CONT_FIAT)

END
GO
-------------------
RESULTADO:
-------------------
QUANTIDADE FORD: 3
QUANTIDADE FIAT: 3
-------------------

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

/*BLOCOS IF E ELSE:*/

DECLARE
	
	@NUMERO INT = 5

BEGIN 

	IF @NUMERO = 5
		PRINT 'VALOR É VERDADEIRO'

	ELSE
		PRINT 'VALOR É FALSO'
END
GO 

------------------
RESULTADO:
------------------
VALOR É VERDADEIRO


-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

/*BLOCO CASE:*/

DECLARE
	
	@CONTADOR INT

BEGIN

	SELECT
	CASE
		WHEN FABRICANTE = 'FIAT' THEN 'FAIXA 1'
		WHEN FABRICANTE = 'CHEVROLET' THEN 'FAIXA 2'
		ELSE 'OUTRAS FAIXAS'
	END AS 'INFORMAÇÕES',
	*
	FROM CARROS

END
GO 

-------------------------------------
INFORMAÇÕES		CARRO 	FABRICANTE
-------------------------------------
OUTRAS FAIXAS	KA			FORD
OUTRAS FAIXAS	FIESTA		FORD
OUTRAS FAIXAS	PRISMA		FORD
OUTRAS FAIXAS	CLIO		RENAULT
OUTRAS FAIXAS	SANDERO		RENAULT
FAIXA 		2	CHEVETE		CHEVROLET
FAIXA 		2	OMEGA		CHEVROLET
FAIXA 		1	PALIO		FIAT
FAIXA 		1	DOBLO		FIAT
FAIXA 		1	UNO			FIAT
OUTRAS FAIXAS	GOL			VOLKSWAGEN
-------------------------------------

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

/*LOOPS COM WHILE: ELE RODARÁ EM LOOP ATÉ O DETERMINADO PARA PARAR*/

DECLARE

	@I INT = 1

BEGIN

	WHILE (@I < 15)
	BEGIN

		PRINT 'VALOR DE @I = ' + CAST(@I AS VARCHAR)
		SET @I = @I+1

	END

END 
GO

-----------------
VALOR DE @I = 1
VALOR DE @I = 2
VALOR DE @I = 3
VALOR DE @I = 4
VALOR DE @I = 5
VALOR DE @I = 6
VALOR DE @I = 7
VALOR DE @I = 8
VALOR DE @I = 9
VALOR DE @I = 10
VALOR DE @I = 11
VALOR DE @I = 12
VALOR DE @I = 13
VALOR DE @I = 14
-----------------