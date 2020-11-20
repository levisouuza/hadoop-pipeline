
#Acessando Hive
beeline -u jdbc:hive2://

#Criando banco de dados
CREATE DATABASE dwareahouse;

#Acessando banco de dados criado
USE dwareahouse;

#habilitando particionamento dinamico
set hive.exec.dynamic.partition.mode=nonstrict

#Dropando tabela caso exista
DROP TABLE IF EXISTS RETAIL;

#Criando tabela hive com partição em relação ao atributo vendasgrupoterritorio.

CREATE EXTERNAL TABLE RETAIL 
				(idvendas int comment "id sequencial de venda",
				 data string comment "data da venda",
				 idproduto integer comment "id produto",
				 produto string comment "descrição produto",
				 idsubcategoria integer comment "id subcategoria",
				 subcategoria string comment "descrição subcategoria",
				 idcategoria integer comment "id categoria",
				 categoria string comment "descrição categoria",
				 cor string comment "descrição cor", 
				 idcliente integer comment "id cliente",
				 estadocivil string comment "estado civil cliente",
				 sexo string comment "sexo cliente",
				 idregiao integer comment "id região venda",
				 pais string comment "descrição país",
				 estado string comment "descrição estado",
				 cidade string comment "descrição cidade",
				 idterritoriovendas integer comment "id territorio da venda realizada" ,
				 territoriovendasregiao string comment "descrição territorio da região em que a venda foi realizada",
				 vendasterritoriopais string comment "descrição da região do país em que a venda foi realizada",
				 vendasgrupoterritorio string comment "descrição grupo do territorio em que a venda foi realizada",
				 ordemvendas string comment "código da ordem de venda",
				 custototalproduto decimal(23, 4) comment "custo total do produto",
				 quantidadevendas decimal(23,4) comment "quantidade de vendas")

				PARTITIONED BY (vendasgrupoterritorio STRING)
				ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
				STORED AS TEXTFILE;
