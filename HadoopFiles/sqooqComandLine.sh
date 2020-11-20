

sqoop list-databases --connect jdbc:postgresql://127.0.0.1/ --username postgres --password 123456

sqoop list-tables --connect jdbc:postgresql://127.0.0.1/hadoop --username postgres --password 123456 -- --schema lake 

sqoop eval --connect jdbc:postgresql://127.0.0.1/ --username postgres --password 123456\
--query 'select * from lake.retail limit 10'

sqoop import --connect jdbc:postgresql://127.0.0.1/hadoop \
--username postgres --password 123456\
--table retail -- --schema lake\
--target-dir=user/cloudera/lake\
--as-textfile

