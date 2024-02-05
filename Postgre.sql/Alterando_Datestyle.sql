/*CONSERTANDO DATESTYLE*/

insert into funcionarios values (2,'Armstrong','sarmstrong1@infoseek.co.jp','Masculino','Esporte','3/31/2008',71869,'Financial Advisor',2);

ERROR:  date/time field value out of range: "3/31/2008"
LINE 2: ...sarmstrong1@infoseek.co.jp','Masculino','Esporte','3/31/2008...
                                                             ^
HINT:  Perhaps you need a different "datestyle" setting.
SQL state: 22008
Character: 239

/*PARA ALTERAR A DATESTYLE PRECISA-SE IR:

1 - DISCO LOCAL -> WINDOWS -> ARQUIVOS DE PROGRAMAS -> POSTGRESQL -> 10 -> DATA -> POSTGRESQL.CONF
2 - ABRIR NO NOTEPAD++
3 - PROCURE COM O SÍMBOLO DO BINÓCULO O QUE SE QUER ALTERAR, NESSE CASO 'DATESTYLE'
4 - COPIE E COLE A QUERY, COLOCANDO '#' ANTES, PARA DEIXAR REGISTRADO APENAS COMO UM COMENTÁRIO PARA FUTURAS INSPEÇÕES
5 - ALTERE, SALVE E REINICIE O POSTGRES DESSA FORMA:

			NO INICIAR DO WINDOWS, PESQUISE: 'SERVIÇOS'
			ACHE O 'POSTGRESQL'
			REINICIE O SERVIÇO*/

