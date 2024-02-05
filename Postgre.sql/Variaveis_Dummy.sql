/*VARIÁVEIS DUMMY PARA MACHINE LEARNING: BINÁRIO

Dummy é aquela que toma o valor de "zero"(NÃO) ou "um"(SIM) indicando a ausência ou presença de qualidades ou atributos

UTILIZANDO O CASE: isso criará outra coluna classificando cada linha de acordo com o CASE*/

SELECT NOME, SEXO FROM FUNCIONARIOS;

SELECT NOME, CARGO,
	CASE

		WHEN CARGO = 'Financial Advisor' THEN 'CONDIÇÃO 01'
		WHEN CARGO = 'Structural Engineer' THEN 'CONDIÇÃO 02'
		WHEN CARGO = 'Executive Secretary' THEN 'CONDIÇÃO 03'
		WHEN CARGO = 'Sales Associative' THEN 'CONDIÇÃO 04'
		ELSE 'OUTRAS CONDIÇÕES'

	END AS "CONDIÇÕES"
FROM FUNCIONARIOS;

/*CASE 2:*/
SELECT NOME,
	CASE

		WHEN SEXO = 'Masculino' THEN 'M'
		ELSE 'F'

	END AS "SEXO"
FROM FUNCIONARIOS;


/*UTILIZANDO VALORES BOOLEANOS (TRUE ou FALSE - 0 ou 1):*/

SELECT NOME, CARGO, (SEXO = 'Masculino') AS Masculino, (SEXO = 'Feminino') AS Feminino
FROM FUNCIONARIOS;

SELECT NOME, CARGO,
	CASE

		WHEN (SEXO = 'Masculino') = TRUE THEN 1
		ELSE 0 

	END AS "MASCULINO",
	CASE

		WHEN (SEXO = 'Feminino') = TRUE THEN 1
		ELSE 0

	END AS "FEMININO"
FROM FUNCIONARIOS;

