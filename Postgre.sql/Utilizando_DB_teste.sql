/*FUNÇÕES DE AGREGAÇÃO: COUNT, MAX, MIN, SUM...*/
SELECT COUNT (*) FROM funcionarios;
SELECT COUNT (*) FROM departamento;
SELECT COUNT (*) FROM localizacao;

/*AGRUPANDO POR SEXO DOS FUNCIONÁRIOS:*/
SELECT COUNT(*) FROM funcionarios
GROUP BY SEXO;

/*COLOCANDO O NOME DA COLUNA*/
SELECT SEXO COUNT(*) AS 'QUANTIDADE' FROM funcionarios
GROUP BY SEXO;

/*MOSTRANDO O NUMERO DE FUNCIONARIOS EM CADA DEPARTAMENTO*/
select departamento, count(*) from funcionarios
group by departamento;

/* EXIBINDO O MÁXIMO DE SALÁRIOS - 149929 */
select max(salario) as "SALARIO MAXIMO" from funcionarios;

/* EXIBINDO O MINIMO DE SALÁRIOS - 40138 */
select min(salario) as "SALARIO MENOR" from funcionarios;

/* Exibindo o máximo e o mínimo juntos */
select min(salario) as "SALARIO MINIMO", max(salario) as "SALARIO MAXIMO"
from funcionarios;

/* Exibindo o máximo e o mínimo de cada departamento */
select departamento, min(salario), max(salario)
from funcionarios
group by departamento;

/* Exibindo o máximo e o mínimo por sexo */
select sexo, min(salario), max(salario)
from funcionarios
group by sexo;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*ESTATÍSTICAS*/

/* Mostrando uma quantidade limitada de linhas */
select * from funcionarios
limit 10;


/* Qual o gasto total de salario pago pela empresa? */
select sum(salario) from funcionarios;


/* Qual o montante total que cada departamento recebe de salario? */
select departamento, sum(salario)
from funcionarios
group by departamento;


/* Por departamento, qual o total e a média paga para os funcionarios? */

select sum(salario), avg(salario)
from funcionarios;

select departamento, sum(salario), avg(salario)
from funcionarios
group by departamento;

/*ordenando pela média*/
select departamento, sum(salario), avg(salario)
from funcionarios
group by departamento
order by 3;

select departamento, sum(salario), avg(salario)
from funcionarios
group by departamento
order by 3 ASC;

select departamento, sum(salario), avg(salario)
from funcionarios
group by departamento
order by 3 DESC;