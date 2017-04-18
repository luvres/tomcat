## Tomcat 8
### Tomcat 8.0.43 with the main SQL connectors Java 8
-----
### Pull image latest
```
docker pull izone/tomcat
```
### Run pulled image
```
docker run --rm --name Tomcat -h tomcat \
-p 8080:8080 \
-ti izone/tomcat
```
### Enviroments for JDBC Datasource
##### MySQL
```
docker run --name MySQL -h mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=pass -d mysql

docker run --rm --name Tomcat -h tomcat \
--link MySQL:mysql-host \
-e PASS="admin" \
-e HOST_MYSQL=mysql-host \
-e PORT_MYSQL=3306 \
-e USER_MYSQL=root \
-e PASS_MYSQL=pass \
-e DB_MYSQL=mysql \
-p 8080:8080 \
-ti izone/tomcat
```
##### Oracle
```
docker run --name OracleXE -h oraclexe -p 1521:1521 -d izone/oracle

docker run --rm --name Tomcat -h tomcat \
--link OracleXE:oracle-host \
-e PASS="admin" \
-e HOST_ORACLE=oracle-host \
-e PORT_ORACLE=1521 \
-e USER_ORACLE=system \
-e PASS_ORACLE=oracle \
-e DB_ORACLE=XE \
-p 8080:8080 \
-ti izone/tomcat
```
##### MariaDB
```
docker run --name MariaDB -p 3308:3306 -e MYSQL_ROOT_PASSWORD=maria -d mariadb

docker run --rm --name Tomcat -h tomcat \
--link MariaDB:mariadb-host \
-e PASS="admin" \
-e HOST_MARIADB=mariadb-host \
-e PORT_MARIADB=3306 \
-e USER_MARIADB=root \
-e PASS_MARIADB=maria \
-e DB_MARIADB=mysql \
-p 8080:8080 \
-ti izone/tomcat
```
##### Postgres
```
docker run --name PostgreSQL -h postgres \
-p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgres:9.5.5

docker run --rm --name Tomcat -h tomcat \
--link PostgreSQL:postgres-host \
-e PASS="admin" \
-e HOST_POSTGRES=postgres-host \
-e PORT_POSTGRES=5432 \
-e USER_POSTGRES=postgres \
-e PASS_POSTGRES=postgres \
-e DB_POSTGRES=postgres \
-p 8080:8080 \
-ti izone/tomcat
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
      jdbc/JNDI-MariaDB
         Test connection
```
-----
### Auto Construction
```
git clone https://github.com/luvres/tomcat.git
cd tomcat


docker build -t izone/tomcat .
```

