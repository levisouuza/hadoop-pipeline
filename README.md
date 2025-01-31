# hadoop-pipeline

O framework Hadoop é composto por várias ferramentas em seu ecossistema. Nesse projeto, iremos utilizar o **HDFS**, **Map Reduce**, **Sqoop** e **Hive**.
 
O [HDFS](https://hadoop.apache.org/docs/r1.2.1/hdfs_design.htm), *Hadoop Distributed File System*, é o sistema de arquivos distribuidos do Ecossistema. Ele nos permite armazenar dados utilizando clusters (Conjunto de vários computadores). Assim como as demais ferramentas do ecossistema, possui o aspecto de ser tolerante a falha, com a replicação de dados em blocos nos diversos nós do cluster, garantindo a sua disponibilidade de acesso.

[Map Reduce](https://hadoop.apache.org/docs/r1.2.1/mapred_tutorial.html#Purpose) é o modelo de processamento de dados do Hadoop. Consiste em  mapear (*Map*) os dados, ordená-los, com o intuito de organizar e separá-los, e reduzi-los (*Reduce*), para um conjunto menor, mais apto à análises.

O [Sqoop](https://sqoop.apache.org/) é a ferramenta de extração e carga de dados para bancos relacionais do ecossistema. O Sqoop exporta dados dos SGBD's para o HDFS ou vice-versa. Com poucas linhas de código é possível realizar o processo de extração e carga. Além disso, em execução, é realizado o processamento de MapReduce, garantindo uma maior performance.

O [Apache Hive](https://hive.apache.org/) é o Data Warehouse do framework. Um Data Warehouse é o armazém de dados utilizados para análise das organizações. Com a engine do HIVE é possível analisar grandes datasets utilizando queries na linguagem HiveQL, similar SQL, e MapReduce.

Baseado nessas ferramentas, criei um pequeno pipeline de dados. Utilizei o [Cloudera Quickstart Vm](https://docs.cloudera.com/documentation/enterprise/5-14-x/topics/cloudera_quickstart_vm.html) com VMware que nos oferece o ambiente com Ecossistema Hadoop instalado para estudo.

## Data Pipeline 

O fluxo apresentado abaixo consiste em extrair dados do Postgresql via Sqoop, inserindo-os no HDFS e analisá-los via Hive.

![Data Pipeline](https://github.com/levisouuza/hadoop-pipeline/blob/master/HadoopFiles/hadoop-pipeline.PNG)

### 1º Passo - PostgreSql

A primeira etapa do projeto foi criar uma tabela e populá-la no PostgreSql. Todo processo de criação está exibido na imagem abaixo. 

![PostgreSQL](https://github.com/levisouuza/hadoop-pipeline/blob/master/HadoopFiles/Postgresql.png)

### 2º Passo - Sqoop

Agora, precisamos carregar os dados para o HDFS, o nosso [Data Lake](https://www.redhat.com/pt-br/topics/data-storage/what-is-a-data-lake).

Antes, iremos verificar as tabelas existentes no PostgreSql via sqoop, utilizando a linha de comando abaixo. 

![SqoopListTables](https://github.com/levisouuza/hadoop-pipeline/blob/master/HadoopFiles/SqoopListTables.png)

O resultado apresentado foi:

![SqoopOutputTable](https://github.com/levisouuza/hadoop-pipeline/blob/master/HadoopFiles/SqooplistTables.jpeg)

Vamos realizar uma consulta na tabela que iremos trabalhar, a retail. 

![SqoopQuery](https://github.com/levisouuza/hadoop-pipeline/blob/master/HadoopFiles/SqoopQuery.png)

Output query sqoop:

![SqoopQueryOutput](https://github.com/levisouuza/hadoop-pipeline/blob/master/HadoopFiles/SqoopQuery.jpeg)

Iremos copiar os dados das tabelas do postgres para o HDFS. Para isso, iremos executar a linha de comando abaixo.

![Sqoopimport](https://github.com/levisouuza/hadoop-pipeline/blob/master/HadoopFiles/SqoopImport.png)

No processamento de carga para o HDFS, o sqoop utiliza o método de *MapReduce*, dito anteriormente. Em sua execução, ocorre o particionamento de registros da tabela em vários arquivos (O próprio Sqoop define a quantidade de arquivos e registros contidos em cada partição) baseado na chave primária da tabela, acarretando em uma maior performance.

Os arquivos são armazenados no diretório */user/cloudera/lake/retail/*.

Agora que os dados estão em nosso **Data Lake**, o HDFS, será necessário levá-los para o nosso **Data Warehouse**. 

Existem algumas metodologias modelagem de dados de um DW, conforme podemos visualizar nesse [link](https://www.astera.com/pt/type/blog/data-warehouse-concepts/).

Nesse projeto, o intuito é mostrar como funciona, de maneira bem prática, algumas ferramentas do ecossistema Hadoop. Portanto, iremos apenas realizar a carga direta na tabela no Hive, não criando as **tabelas fato e dimensão**. Porém, nesse [projeto](https://github.com/levisouuza/Brazilian-E-commerce-Project) podemos visualizar esse tipo de modelagem e todo o processo de execução.

### 3º Passo - Hive

Podemos visualizar as etapas de criação do banco de dados e tabela no Hive na imagem abaixo:

![HiveQL](https://github.com/levisouuza/hadoop-pipeline/blob/master/HadoopFiles/HiveQL.png)

**Pontos importantes:**

* O Hive possui o mecanismo de particionamento de arquivos de suas tabelas. Esse método permite que os dados sejam divididos entre arquivos baseados em um ou mais atributos. Logo, quando uma query é executada com determinado filtro (*where*), a engine irá procurar em arquivos específicos. É necessário escolher bem o atributo da partição, visto que, atributos com alta cardinalidade irão gerar um número elevado de arquivos no diretório.

* No exemplo, foi criada uma tabela externa, isso significa que caso a tabela seja *"dropada"*, os dados ainda estaram no HDFS para serem utilizados, diferente das tabelas criadas e populadas diretamente no Hive, onde tudo seria deletado.
