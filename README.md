# Tomcat 8.0.36 with the main SQL connectors Java 8 in container Docker

The script can be run anywhere after downloading:

	git clone https://github.com/luvres/tomcat-8.0.36.git
	cd tomcat-8.0.36

For construction of the container run the following command with with the necessary parameters:

	sh tomcat_mysql.sh <password Manager Web> <user mysql> <pass user mysql> <db mysql> <user mariadb> <pass user mariadb> <db mariadb> <user postgres> <pass user postgres> <db postgres> <pass user oracle> <pass schema oracle> <tomcat port>

Example:

	sh tomcat_mysql.sh p4asSwd root PasSroot mysql root PasSroot mysql postgres postgres dbpostgres system oracle 8880

Browser access:

	http://localhost:8880/

Administration access:

	User Name: admin
	Password: p4asSwd

