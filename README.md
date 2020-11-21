# hadoop-pipeline

A criação do framework [Hadoop](https://hadoop.apache.org/) mudou totalmente o paradigma dos modelos de armazenagem e processamento de dados. Com o artifício de utilizar computação paralela e distribuída, podemos processar uma gigantesca quantidade de dados em um tempo muito inferior em relação a outros players do mercado, poís é possível utilizar recursos de diversas máquinas (nodes) simultaneamente. O surgimento do Hadoop foi essencial para a humanidade. Com o surgimento de novas tecnologias e melhorias das já existentes, houve um pico de na quantidade de dados geradas pelos individuos, acarretando na pergunta: Como podemos guardar esse dados ? Como podemos analisá-los ? 

O framework Hadoop é composto por várias ferramentas que nos permitem armazenar, processar e analisar um conjunto elevado de dados. Podemos citar como as mais importantes o **HDFS**, **Map Reduce**, **Sqoop** e **Hive**.

O [HDFS](https://hadoop.apache.org/docs/r1.2.1/hdfs_design.htm) é a principal ferramenta de armazenamento de dados do Hadoop. O *Hadoop Distributed File System* é o sistema de arquivos distribuidos do Ecossistema Hadoop. O HDFS nos permite armazenar uma imensa quantidade de dados de forma distribuída utilizando cluster (Conjunto de vários computados) com diversos nós (uma única máquina). Na concepção do hadoop, um modelo de computação distribuída e paralela, é possível utilizar várias máquinas para diversos fins. Portanto, para que não haja um custo elevado de projeto para implantação do sistema, o Hadoop nos trouxe o conceito de Commodity Hadware, máquinas de qualidade inferior em relação a uma utilizada, por exemplo, em um banco de dados relacional, para compor o cluster. Logo, devido a utilização de hadwares mais baratos, surge a possibilidade de falhas. O HDFS, assim como as demais ferramentas do ecossistema, tem a característica de ser tolerante a falha, pois utiliza o modelo de replicação em seus dados, isto é, um arquivo ou uma parte do mesmo, pode ser armazenado em diversos nodes, garantindo a sua disponibilidade de acesso.


[Map Reduce](https://hadoop.apache.org/docs/r1.2.1/mapred_tutorial.html#Purpose) é o modelo de processo de dados apresentado pelo Hadoop. Basicamente, este método consiste em  mapear, no input dos dados, àqueles que são idênticos, ordená-los, com o intuito de organizar e separá-los, para a etapa seguinte, o Reduce, que por sua vez, reduz aqueles dados de entrada para um conjunto menor, onde, é possível ser analisado. Para a execução de aplicação de MapReduce é necessário conhecer a linguagem de programação java. 

O [sqoop](https://sqoop.apache.org/) é a ferramenta de extração e carga de dados para bancos relacionais do ecossistema. Com ela, é possível importar dados dos SGBD's para o HDFS ou do HDFS para os bancos relacionais. O Sqoop apresenta a facilidade em sua execução, pois com poucas linhas de código é possível realizar esse processo de extrair e carregar. Além disso, em execução é realizado o processamento de MapReduce, garantindo uma maior velocidade de processamento.

Por fim, o [HIVE](https://hive.apache.org/) é o data warehouse do framework. Data Warehouse é o armazém de dados utilizados para análise de dados das organizações. Com a engine do HIVE é possível analisar grandes datasets utilizando HiveQL, uma linguagem similar ao famoso SQL para os bancos de dados relacionais. O Hive nos permite executar grandes queries utilizando o método mapreduce, o que traz um aumento de produtividade para os analistas de dados. 

Baseado nessas ferramentas, criei um pequeno pipeline de dados, utilizando o PostgreSql, HDFS, Sqoop e Hive. Utilizei o [Cloudera Quickstart Vm](https://docs.cloudera.com/documentation/enterprise/5-14-x/topics/cloudera_quickstart_vm.html) com VMware que nos oferece o ambiente pronto para desenvolvimento do ecossitema hadoop.

## Data Pipeline 

O fluxo apresentado abaixo consiste em extrair dados do Banco de dados Postgresql via Sqoop, inserindo-os no HDFS e criando uma tabela no hive para serem analisados.

![Data Pipeline](https://github.com/levisouuza/hadoop-pipeline/blob/master/HadoopFiles/hadoop-pipeline.PNG)

### 1º Passo - PostgreSql

A primeira etapa do projeto foi criar uma tabela e populá-la em um banco de dados relacional. O escolhido foi o postgresql. Todo processo de criação está exibido na imagem abaixo. 

![PostgreSQL](https://github.com/levisouuza/hadoop-pipeline/blob/master/HadoopFiles/Postgresql.png)

### 2º Passo - Sqoop

Tabela criada no banco de dados relacional. Agora, precisamos carregar os dados para o HDFS, o nosso [Data Lake](https://www.redhat.com/pt-br/topics/data-storage/what-is-a-data-lake). Logo, utilizaremos o Sqoop.

Podemos verificar as tabelas existentes no Postgres via sqoop, utilizando a linha de comando abaixo. 

![SqoopListTables](https://github.com/levisouuza/hadoop-pipeline/blob/master/HadoopFiles/SqoopListTables.png)

O resultado apresentado foi:

![SqoopOutputTable](https://github.com/levisouuza/hadoop-pipeline/blob/master/HadoopFiles/SqooplistTables.jpeg)

Vamos realizar uma consulta na tabela que iremos trabalhar, a retail. 

![SqoopQuery](https://github.com/levisouuza/hadoop-pipeline/blob/master/HadoopFiles/SqoopQuery.png)

Output query sqoop:

![SqoopQueryOutput](https://github.com/levisouuza/hadoop-pipeline/blob/master/HadoopFiles/SqoopQuery.jpeg)

Iremos copiar os dados das tabelas do postgres para o HDFS. Para isso, iremos executar a linha de comando abaixo.

![Sqoopimport](https://github.com/levisouuza/hadoop-pipeline/blob/master/HadoopFiles/SqoopImport.png)

No processamento de carga para o HDFS, o sqoop utiliza o método de *MapReduce*, dito anteriormente. Em sua execução, ocorre o particionamente de registros da tabela em vários arquivos(o próprio sqoop define a quantidade de arquivos e registros contidos neles) baseado em sua chave primária, acarretando em um aumento de performance de carga. 

Os arquivos são armazenados no diretório */user/cloudera/retail/*, visto que estamos utilizando a VM cloudera quickstart.
