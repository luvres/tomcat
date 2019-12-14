FROM tomcat:9-jdk11-openjdk-slim

# Connectors Java
ENV URL_JDBC="https://github.com/luvres/jdbc/raw/master"

ENV MYSQL_CONN_J_VERSION=8.0.18
ENV MYSQL_CONN_J mysql-connector-java-$MYSQL_CONN_J_VERSION.jar
ENV MYSQL_CONN_J_URL $URL_JDBC/$MYSQL_CONN_J

ENV MARIADB_CONN_J_VERSION 2.5.2
ENV MARIADB_CONN_J mariadb-java-client-$MARIADB_CONN_J_VERSION.jar
ENV MARIADB_CONN_J_URL $URL_JDBC/$MARIADB_CONN_J

ENV POSTGRES_CONN_J postgresql-42.2.9.jar
ENV POSTGRES_CONN_J_URL $URL_JDBC/$POSTGRES_CONN_J

ENV ORACLE_CONN_J ojdbc6.jar
ENV ORACLE_CONN_J_URL $URL_JDBC/$ORACLE_CONN_J


ENV \
  # Admin
	PASS=admin \
  \
  # Datasource
	PORT_MYSQL=3306 \
	USER_MYSQL=root \
	PASS_MYSQL=root \
	DB_MYSQL=dbzone \
	HOST_MYSQL=mysql-host \
	JNDI_MYSQL=JNDI-MySQL \
  \
	PORT_ORACLE=1521 \
	USER_ORACLE=system \
	PASS_ORACLE=oracle \
	DB_ORACLE=XE \
	HOST_ORACLE=oracle-host \
	JNDI_ORACLE=JNDI-Oracle \
  \
	PORT_MARIADB=3306 \
	USER_MARIADB=root \
	PASS_MARIADB=maria \
	DB_MARIADB=dbzone \
	HOST_MARIADB=mariadb-host \
	JNDI_MARIADB=JNDI-MariaDB \
  \
	PORT_POSTGRES=5432 \
	USER_POSTGRES=postgres \
	PASS_POSTGRES=postgres \
	DB_POSTGRES=postgres \
	HOST_POSTGRES=postgres-host \
	JNDI_POSTGRES=JNDI-PostgreSQL


RUN \
	apt-get update \
	&& apt-get install -y \
		wget \
  \
  # Change upload limit that is 50Megas in Tomcat 8
	&& sed -i 's/52428800/104857600/' /usr/local/tomcat/webapps/manager/WEB-INF/web.xml \
  \
	&& wget -c $MYSQL_CONN_J_URL -O /usr/local/tomcat/lib/$MYSQL_CONN_J \
	&& wget -c $MARIADB_CONN_J_URL -O /usr/local/tomcat/lib/$MARIADB_CONN_J \
	&& wget -c $POSTGRES_CONN_J_URL -O /usr/local/tomcat/lib/$POSTGRES_CONN_J \
	&& wget -c $ORACLE_CONN_J_URL -O /usr/local/tomcat/lib/$ORACLE_CONN_J \
	&& wget -c $URL_JDBC/probe.war -O /usr/local/tomcat/webapps/probe.war


EXPOSE 8080

ADD start.sh /etc/start.sh
CMD ["sh", "/etc/start.sh"]