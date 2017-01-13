FROM tomcat:8.0.39-jre8

MAINTAINER Leonardo Loures <luvres@hotmail.com>

ENV PASS admin

ENV URL_JDBC="https://github.com/luvres/jdbc/raw/master/"

ENV MYSQL_CONN_J_VERSION 5.1.39
ENV MYSQL_CONN_J mysql-connector-java-$MYSQL_CONN_J_VERSION-bin.jar
ENV MYSQL_CONN_J_URL $URL_JDBC/$MYSQL_CONN_J

ENV MARIADB_CONN_J_VERSION 1.4.6
ENV MARIADB_CONN_J mariadb-java-client-$MARIADB_CONN_J_VERSION.jar
ENV MARIADB_CONN_J_URL $URL_JDBC/$MARIADB_CONN_J

ENV POSTGRES_CONN_J postgresql-9.4.1209.jar
ENV POSTGRES_CONN_J_URL $URL_JDBC/$POSTGRES_CONN_J

ENV ORACLE_CONN_J ojdbc6.jar
ENV ORACLE_CONN_J_URL $URL_JDBC/$ORACLE_CONN_J


RUN sed -i 's/resourceName="UserDatabase"/resourceName="UserDatabase" digest="sha1"/' /usr/local/tomcat/conf/server.xml

RUN sed -i 's/<\/tomcat-users>/ /' /usr/local/tomcat/conf/tomcat-users.xml
RUN echo '  <role rolename="manager-gui"/>' >>/usr/local/tomcat/conf/tomcat-users.xml
RUN echo '  <role rolename="admin-gui"/>' >>/usr/local/tomcat/conf/tomcat-users.xml
RUN echo "  <user username=\"admin\" password=\"`/usr/local/tomcat/bin/digest.sh -a sha1 \$PASS | awk -F ":" '{print \$2}'`\" roles=\"manager-gui,admin-gui\"/>" >>/usr/local/tomcat/conf/tomcat-users.xml
RUN echo '</tomcat-users>' >>/usr/local/tomcat/conf/tomcat-users.xml

### Alterar limit de upload que é de 50Megas no Tomcat 8
RUN sed -i 's/52428800/104857600/' /usr/local/tomcat/webapps/manager/WEB-INF/web.xml


### Datasource
ENV USER_MYSQL root
ENV PASS_MYSQL pass
ENV DB_MYSQL dbzone
ENV MYSQLHOST mysql-host
ENV JNDI_MYSQL JNDI-MySQL

ENV USER_MARIADB root
ENV PASS_MARIADB mariadb
ENV DB_MARIADB dbzone
ENV MARIADBHOST mariadb-host
ENV JNDI_MARIADB JNDI-MariaDB

ENV USER_POSTGRES postgres
ENV PASS_POSTGRES postgres
ENV DB_POSTGRES postgres
ENV POSTGRESHOST postgres-host
ENV JNDI_POSTGRES JNDI-PostgreSQL

ENV USER_ORACLE system
ENV PASS_ORACLE oracle
ENV ORACLEHOST oracle-host
ENV JNDI_ORACLE JNDI-Oracle


RUN wget -c $MYSQL_CONN_J_URL -O /usr/local/tomcat/lib/$MYSQL_CONN_J
RUN wget -c $MARIADB_CONN_J_URL -O /usr/local/tomcat/lib/$MARIADB_CONN_J
RUN wget -c $POSTGRES_CONN_J_URL -O /usr/local/tomcat/lib/$POSTGRES_CONN_J
RUN wget -c $ORACLE_CONN_J_URL -O /usr/local/tomcat/lib/$ORACLE_CONN_J

RUN wget -c $URL_JDBC/probe.war -O /usr/local/tomcat/webapps/probe.war


# context.xml
RUN sed -i 's/<\/Context>//' /usr/local/tomcat/conf/context.xml
RUN echo "<Resource name=\"jdbc/$JNDI_MYSQL\" auth=\"Container\"" >>/usr/local/tomcat/conf/context.xml
RUN echo '        type="javax.sql.DataSource"' >>/usr/local/tomcat/conf/context.xml
RUN echo "        username=\"$USER_MYSQL\" password=\"$PASS_MYSQL\"" >>/usr/local/tomcat/conf/context.xml
RUN echo '        driverClassName="com.mysql.jdbc.Driver"' >>/usr/local/tomcat/conf/context.xml
RUN echo "        url=\"jdbc:mysql://$MYSQLHOST:3306/$DB_MYSQL\"/>" >>/usr/local/tomcat/conf/context.xml

RUN echo "<Resource name=\"jdbc/$JNDI_ORACLE\" auth=\"Container\"" >>/usr/local/tomcat/conf/context.xml
RUN echo '        type="javax.sql.DataSource"' >>/usr/local/tomcat/conf/context.xml
RUN echo "        username=\"$USER_ORACLE\" password=\"$PASS_ORACLE\"" >>/usr/local/tomcat/conf/context.xml
RUN echo '        driverClassName="oracle.jdbc.OracleDriver"' >>/usr/local/tomcat/conf/context.xml
RUN echo "        url=\"jdbc:oracle:thin:@$ORACLEHOST:1521:XE\"/>" >>/usr/local/tomcat/conf/context.xml

RUN echo "<Resource name=\"jdbc/$JNDI_MARIADB\" auth=\"Container\"" >>/usr/local/tomcat/conf/context.xml
RUN echo '        type="javax.sql.DataSource"' >>/usr/local/tomcat/conf/context.xml
RUN echo "        username=\"$USER_MARIADB\" password=\"$PASS_MARIADB\"" >>/usr/local/tomcat/conf/context.xml
RUN echo '        driverClassName="org.mariadb.jdbc.Driver"' >>/usr/local/tomcat/conf/context.xml
RUN echo "        url=\"jdbc:mysql://$MARIADBHOST:3306/$DB_MARIADB\"/>" >>/usr/local/tomcat/conf/context.xml

RUN echo "<Resource name=\"jdbc/$JNDI_POSTGRES\" auth=\"Container\"" >>/usr/local/tomcat/conf/context.xml
RUN echo '        type="javax.sql.DataSource"' >>/usr/local/tomcat/conf/context.xml
RUN echo "        username=\"$USER_POSTGRES\" password=\"$PASS_POSTGRES\"" >>/usr/local/tomcat/conf/context.xml
RUN echo '        driverClassName="org.postgresql.Driver"' >>/usr/local/tomcat/conf/context.xml
RUN echo "        url=\"jdbc:postgresql://$POSTGRESHOST:5432/$DB_POSTGRES\"/>" >>/usr/local/tomcat/conf/context.xml
RUN echo '</Context>' >>/usr/local/tomcat/conf/context.xml
