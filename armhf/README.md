## Tomcat 9
### Tomcat 9.0.30 with the main SQL connectors Java 
-----
### Pull image latest
```
docker pull izone/tomcat:armhf
```
### Run pulled image
```
docker run --rm --name Tomcat -h tomcat \
-p 8080:8080 \
-ti izone/tomcat:armhf
```
### Enviroments for JDBC Datasource
##### Postgres
```
docker run --name PostgreSQL -h postgres \
--restart=always \
--publish=5432:5432 \
--env POSTGRES_PASSWORD=postgres \
--detach arm32v7/postgres:alpine

docker run --name Tomcat -h tomcat \
--restart=always \
--publish=8080:8080 \
--link PostgreSQL:postgres-host \
--env PASS="admin" \
--env HOST_POSTGRES=postgres-host \
--env PORT_POSTGRES=5432 \
--env USER_POSTGRES=postgres \
--env PASS_POSTGRES=postgres \
--env DB_POSTGRES=postgres \
--detach izone/tomcat:armhf
```
##### Add MariaDB
```
--link MariaDB:mariadb-host \
--env HOST_MARIADB=mariadb-host \
--env PORT_MARIADB=3306 \
--env USER_MARIADB=root \
--env PASS_MARIADB=maria \
--env DB_MARIADB=mysql \
```
##### Add MySQL
```
--link MySQL:mysql-host \
--env HOST_MYSQL=mysql-host \
--env PORT_MYSQL=3306 \
--env USER_MYSQL=root \
--env PASS_MYSQL=pass \
--env DB_MYSQL=mysql \
```
##### Add Oracle 11g
```
--link Oracle:oracle-host
--env HOST_ORACLE=oracle-host \
--env PORT_ORACLE=1521 \
--env USER_ORACLE=system \
--env PASS_ORACLE=oracle \
--env DB_ORACLE=XE \
```
##### Add Oracle 12c
```
--link Oracle:oracle-host
--env HOST_ORACLE=oracle-host \
--env PORT_ORACLE=1521 \
--env USER_ORACLE=system \
--env PASS_ORACLE=oracle \
--env DB_ORACLE=ORCLCDB \
```
-----
### Browser access:
```
http://localhost:8080/
```
##### Administration access:
```
http://localhost:8080/manager/html

User Name: admin
Password: admin

http://localhost:8080/probe/
   Data Sources
      jdbc/JNDI-PostgreSQL
         Test connection
```
-----
### Auto Construction
```
git clone https://github.com/luvres/tomcat.git
cd tomcat


docker build -t izone/tomcat:armhf ./armhf/
```

