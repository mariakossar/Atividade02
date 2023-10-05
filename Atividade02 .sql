DROP USER IF EXISTS 'funcionario'@'localhost';
  
DROP USER IF EXISTS 'gerente'@'localhost';

DROP DATABASE if  EXISTS atividade02;
CREATE SCHEMA atividade02;

USE atividade02;

#DROP TABLE IF EXISTS departamento;

CREATE TABLE departamento(
		cod_departamento  INT(12) NOT NULL AUTO_INCREMENT, 
		nome_departamento VARCHAR (90) NOT NULL, 
		CONSTRAINT pk_departamento
			PRIMARY KEY(cod_departamento)		
);

CREATE TABLE funcionario(
	cod_funcionario INT(12) NOT NULL AUTO_INCREMENT,
	cod_departamento INT(12) NOT NULL,
	nome_funcionario VARCHAR(90) NOT NULL, 
	qde_funcionario INT(12) NOT NULL,
	salario FLOAT(7,2) NOT NULL, 
	cargo VARCHAR (90) NOT NULL,
	CONSTRAINT pk_funcionario
	    PRIMARY KEY(cod_funcionario),
	CONSTRAINT fk_departamento
		FOREIGN KEY (cod_departamento)
	REFERENCES departamento(cod_departamento),
	CONSTRAINT funcionario_por_departamento
		UNIQUE (cod_funcionario, cod_departamento)		 
);

INSERT INTO departamento (cod_departamento, nome_departamento ) VALUES ( 1, 'Diretoria Geral' );
INSERT INTO departamento (cod_departamento, nome_departamento ) VALUES ( 2, 'Recursos Humanos' );
INSERT INTO departamento (cod_departamento, nome_departamento ) VALUES ( 3, 'Finanças' );
INSERT INTO departamento (cod_departamento, nome_departamento ) VALUES ( 4, 'Vendas'); 


INSERT INTO funcionario ( cod_funcionario, cod_departamento, nome_funcionario, qde_funcionario, salario, cargo )
     VALUES( 1, 1, 'Maria', 0, 10000.00, 'Diretor Geral' );
INSERT INTO funcionario ( cod_funcionario, cod_departamento, nome_funcionario, qde_funcionario, salario, cargo )
     VALUES( 2, 1, 'Felipe', 1, 3500.00, 'Assitente' );
INSERT INTO funcionario ( cod_funcionario, cod_departamento, nome_funcionario, qde_funcionario, salario, cargo )
     VALUES( 3, 2, 'Ana', 2, 4000.00, 'Recrutadora' );   
INSERT INTO funcionario ( cod_funcionario, cod_departamento, nome_funcionario, qde_funcionario, salario, cargo )
     VALUES( 4, 2, 'Amanda', 2, 2000.00, 'Auxiliar Administrativo');	    
INSERT INTO funcionario ( cod_funcionario, cod_departamento, nome_funcionario, qde_funcionario, salario, cargo )
     VALUES( 5, 3, 'João', 3, 5000.00, 'Tesoureiro' );
INSERT INTO funcionario ( cod_funcionario, cod_departamento, nome_funcionario, qde_funcionario, salario, cargo )
     VALUES( 6, 3, 'Carlos', 3, 3500.00, 'Assitente' );	 
INSERT INTO funcionario ( cod_funcionario, cod_departamento, nome_funcionario, qde_funcionario, salario, cargo )
     VALUES( 7, 3, 'Leticia', 3, 2500.00, 'Tecnico' );
INSERT INTO funcionario ( cod_funcionario, cod_departamento, nome_funcionario, qde_funcionario, salario, cargo )
     VALUES( 8, 4, 'Luiza', 4, 7000.00, 'Gerente de Negócios' );
INSERT INTO funcionario ( cod_funcionario, cod_departamento, nome_funcionario, qde_funcionario, salario, cargo )
     VALUES( 9, 4, 'Pedro', 4, 3000.00, 'Vendedor' );	  	  	
INSERT INTO funcionario ( cod_funcionario, cod_departamento, nome_funcionario, qde_funcionario, salario, cargo )
     VALUES( 10, 4, 'Carolina', 4, 3000.00, 'Vendedor' );	
INSERT INTO funcionario ( cod_funcionario, cod_departamento, nome_funcionario, qde_funcionario, salario, cargo )
     VALUES( 11, 4, 'Marcelo', 4, 3000.00, 'Vendedor' );     
     
atividade02
#Questão 04 - letra a
CREATE OR REPLACE 
	VIEW QuestaoA
		AS 
 			SELECT departamento.nome_departamento AS nome, 
 				COUNT(funcionario.cod_funcionario) AS quantidade 
		 FROM funcionario
 INNER JOIN departamento ON departamento.cod_departamento = funcionario.cod_departamento
GROUP BY departamento.nome_departamento
HAVING COUNT(funcionario.cod_funcionario) = (
	SELECT MAX(contagem) FROM 	(
		SELECT COUNT(funcionario.cod_funcionario) AS contagem
		FROM funcionario
		GROUP BY funcionario.cod_departamento
	) AS subquery
);
	SELECT * FROM QuestaoA;
 	
#Questao 04 - Letra b
CREATE OR REPLACE 
	VIEW QuestaoB
		AS 
			SELECT departamento.nome_departamento AS nome, 
				COUNT(funcionario.cod_funcionario) AS quantidade
			FROM funcionario 
INNER JOIN departamento ON departamento.cod_departamento = funcionario.cod_departamento
	WHERE funcionario.qde_funcionario = 0	
GROUP BY departamento.nome_departamento
	HAVING COUNT(funcionario.cod_funcionario) = (
		SELECT MIN(contagem) FROM (
		SELECT COUNT(funcionario.cod_funcionario) AS contagem 
		FROM funcionario
		WHERE funcionario.qde_funcionario = 0
		GROUP BY funcionario.cod_departamento
	) AS subquery
);

	SELECT * FROM questaob;
	
#Questao 04 - Letra c
CREATE OR REPLACE 
	VIEW QuestaoC
		AS 
			SELECT departamento.nome_departamento	AS nome,
			funcionario.nome_funcionario
			FROM funcionario 
INNER JOIN departamento ON departamento.cod_departamento = funcionario.cod_departamento
	WHERE departamento.nome_departamento LIKE 'Dir%';		
	
	SELECT * FROM QuestaoC;
	
CREATE OR REPLACE VIEW QuestaoD AS
SELECT departamento.nome_departamento,  
       funcionario.nome_funcionario,
       MAX(funcionario.salario) AS maior_salario
FROM funcionario
INNER JOIN departamento ON departamento.cod_departamento = funcionario.cod_departamento
GROUP BY departamento.nome_departamento, funcionario.cod_departamento
HAVING MAX(funcionario.salario) = (
  SELECT MAX(salario) FROM funcionario
);

SELECT * FROM QuestaoD;

	
#Questao 04 - Letra e	
CREATE OR REPLACE 
	VIEW QuestaoE
		AS 
			SELECT departamento.nome_departamento, 
		 funcionario.nome_funcionario
			FROM funcionario
INNER JOIN departamento ON departamento.cod_departamento = funcionario.cod_departamento
	WHERE funcionario.cargo LIKE  'Gerente%';		 	
	
	SELECT * FROM QuestaoE;

# Questao 05	  
CREATE USER 'funcionario'@'localhost' IDENTIFIED BY 'abcd123';
CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'abcd123';

# Questao 5 - Letra a 
GRANT CREATE, SELECT ON *. * TO 'funcionario'@'localhost';
FLUSH PRIVILEGES;

#Questao 5 - Letra b 
GRANT ALL PRIVILEGES ON * . * TO 'gerente'@'localhost';	     
FLUSH PRIVILEGES;       
