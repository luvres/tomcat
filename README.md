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
-e PASS="paSSadm" \
-ti izone/tomcat
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

