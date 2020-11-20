
CREATE DATABASE hadoop;

\c hadoop;

CREATE SCHEMA lake;

CREATE TABLE lake.retail (
	idvendas int default nextval('lake.idvendas'::regclass )PRIMARY KEY,
	data varchar(10),
	idproduto integer,
	produto varchar(50),
	idsubcategoria integer,
	subcategoria varchar(50),
	idcategoria integer,
	categoria varchar(50),
	cor varchar(15),
	idcliente integer,
	estadocivil char(1),
	sexo char(1),
	idregiao integer,
	pais varchar(50),
	estado varchar(50),
	cidade varchar(30),
	idterritoriovendas integer,
	territoriovendasregiao varchar(50),
	vendasterritoriopais varchar(50),
	vendasgrupoterritorio varchar(50),
	ordemvendas varchar(20),
	custototalproduto numeric(23, 4),
	quantidadevendas numeric(23,4)

	)
;


