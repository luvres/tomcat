# Tomcat 8
## Tomcat 8.0.39 with the main SQL connectors Java 8 in container Docker
### Pull image latest
```
docker pull izone/tomcat
```
### Run pulled image
```
docker run --rm --name Tomcat -h tomcat \
-p 8080:8080 \
-e PASS="aamu02" \
-ti izone/tomcat
```
### Enviroments for JDBC Datasource
##### MySQL
```
-e PORT_MYSQL=3306
-e USER_MYSQL=root
-e PASS_MYSQL=pass
-e DB_MYSQL=dbzone
-e HOST_MYSQL=mysql-host
```
##### Oracle
```
-e PORT_ORACLE=1521
-e USER_ORACLE=system
-e PASS_ORACLE=oracle
-e DB_ORACLE=XE
-e HOST_ORACLE=oracle-host
```
##### MariaDB
```
-e PORT_MARIADB=3306
-e USER_MARIADB=root
-e PASS_MARIADB=maria
-e DB_MARIADB=dbzone
-e HOST_MARIADB=mariadb-host
```
##### Postgres
```
-e PORT_POSTGRES=5432
-e USER_POSTGRES=postgres
-e PASS_POSTGRES=postgres
-e DB_POSTGRES=postgres
-e HOST_POSTGRES=postgres-host
```

### Auto Construction
```
git clone https://github.com/luvres/tomcat.git
cd tomcat


docker build -t izone/tomcat .
```

For construction of the container run the following command with with the necessary parameters:

	sh tomcat_mysql.sh <pass Manager Web> <user mysql> <pass mysql> <db mysql> <user mariadb> <pass mariadb> <db mariadb> <user postgres> <pass postgres> <db postgres> <schema oracle> <pass oracle> <tomcat port>

Example:

	sh tomcat_8.0.36_sql.sh P4sSwd userMySQL P4sSdb dbysql userMariaDB P4sSdb dbmariadb userPostgres P4sSdb dbpostgres dboracle P4sSdb 8880

Browser access:

	http://localhost:8880/

Administration access:

	User Name: admin
	Password: P4sSwd

