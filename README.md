# Tomcat 8.0.36 with the main SQL connectors Java 8 in container Docker

The script can be run anywhere after downloading:

	git clone https://github.com/luvres/tomcat-8.0.36.git
	cd tomcat-8.0.36

For construction of the container run the following command with with the necessary parameters:

	sh tomcat_mysql.sh <pass Manager Web> <user mysql> <pass mysql> <db mysql> <user mariadb> <pass mariadb> <db mariadb> <user postgres> <pass postgres> <db postgres> <schema oracle> <pass oracle> <tomcat port>

Example:

	sh tomcat_8.0.36_sql.sh P4sSwd userMySQL P4sSwd dbysql userMariaDB P4sSwd dbmariadb userPostgres P4sSwd dbpostgres dboracle P4sSwd 8880

Browser access:

	http://localhost:8880/

Administration access:

	User Name: admin
	Password: p4asSwd

