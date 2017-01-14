FROM tomcat:8.0.39-jre8

MAINTAINER Leonardo Loures <luvres@hotmail.com>

ENV PASS admin

ENV URL_JDBC="https://github.com/luvres/jdbc/raw/master/"

ENV MYSQL_CONN_J_VERSION 5.1.40
ENV MYSQL_CONN_J mysql-connector-java-$MYSQL_CONN_J_VERSION-bin.jar
ENV MYSQL_CONN_J_URL $URL_JDBC/$MYSQL_CONN_J

ENV MARIADB_CONN_J_VERSION 1.4.6
ENV MARIADB_CONN_J mariadb-java-client-$MARIADB_CONN_J_VERSION.jar
ENV MARIADB_CONN_J_URL $URL_JDBC/$MARIADB_CONN_J

ENV POSTGRES_CONN_J postgresql-9.4.1212.jar
ENV POSTGRES_CONN_J_URL $URL_JDBC/$POSTGRES_CONN_J

ENV ORACLE_CONN_J ojdbc6.jar
ENV ORACLE_CONN_J_URL $URL_JDBC/$ORACLE_CONN_J

# Alterar limit de upload que é de 50Megas no Tomcat 8
RUN sed -i 's/52428800/104857600/' /usr/local/tomcat/webapps/manager/WEB-INF/web.xml

RUN sed -i 's/resourceName="UserDatabase"/resourceName="UserDatabase" digest="sha1"/' /usr/local/tomcat/conf/server.xml \
    && mv /usr/local/tomcat/conf/tomcat-users.xml{,.orig}


##RUN sed -i 's/<\/tomcat-users>/ /' /usr/local/tomcat/conf/tomcat-users.xml
##RUN echo '  <role rolename="manager-gui"/>' >>/usr/local/tomcat/conf/tomcat-users.xml
##RUN echo '  <role rolename="admin-gui"/>' >>/usr/local/tomcat/conf/tomcat-users.xml
##RUN echo "  <user username=\"admin\" password=\"`/usr/local/tomcat/bin/digest.sh -a sha1 \$PASS | awk -F ":" '{print \$2}'`\" roles=\"manager-gui,admin-gui\"/>" >>/usr/local/tomcat/conf/tomcat-users.xml
##RUN echo '</tomcat-users>' >>/usr/local/tomcat/conf/tomcat-users.xml


# Datasource
ENV PORT_MYSQL 3306
ENV USER_MYSQL root
ENV PASS_MYSQL root
ENV DB_MYSQL dbzone
ENV HOST_MYSQL mysql-host
ENV JNDI_MYSQL JNDI-MySQL

ENV PORT_ORACLE 1521
ENV USER_ORACLE system
ENV PASS_ORACLE oracle
ENV DB_ORACLE XE
ENV HOST_ORACLE oracle-host
ENV JNDI_ORACLE JNDI-Oracle

ENV PORT_MARIADB 3306
ENV USER_MARIADB root
ENV PASS_MARIADB maria
ENV DB_MARIADB dbzone
ENV HOST_MARIADB mariadb-host
ENV JNDI_MARIADB JNDI-MariaDB

ENV PORT_POSTGRES 5432
ENV USER_POSTGRES postgres
ENV PASS_POSTGRES postgres
ENV DB_POSTGRES postgres
ENV HOST_POSTGRES postgres-host
ENV JNDI_POSTGRES JNDI-PostgreSQL

RUN wget -c $MYSQL_CONN_J_URL -O /usr/local/tomcat/lib/$MYSQL_CONN_J \
    && wget -c $MARIADB_CONN_J_URL -O /usr/local/tomcat/lib/$MARIADB_CONN_J \
    && wget -c $POSTGRES_CONN_J_URL -O /usr/local/tomcat/lib/$POSTGRES_CONN_J \
    && wget -c $ORACLE_CONN_J_URL -O /usr/local/tomcat/lib/$ORACLE_CONN_J \
    && wget -c $URL_JDBC/probe.war -O /usr/local/tomcat/webapps/probe.war


ADD start.sh /etc/start.sh
ENTRYPOINT ["bash", "/etc/start.sh"]


# context.xml
##RUN sed -i 's/<\/Context>//' /usr/local/tomcat/conf/context.xml
##RUN echo "<Resource name=\"jdbc/$JNDI_MYSQL\" auth=\"Container\"" >>/usr/local/tomcat/conf/context.xml
##RUN echo '        type="javax.sql.DataSource"' >>/usr/local/tomcat/conf/context.xml
##RUN echo "        username=\"$USER_MYSQL\" password=\"$PASS_MYSQL\"" >>/usr/local/tomcat/conf/context.xml
##RUN echo '        driverClassName="com.mysql.jdbc.Driver"' >>/usr/local/tomcat/conf/context.xml
##RUN echo "        url=\"jdbc:mysql://$HOST_MYSQL:$PORT_MYSQL/$DB_MYSQL\"/>" >>/usr/local/tomcat/conf/context.xml

##RUN echo "<Resource name=\"jdbc/$JNDI_ORACLE\" auth=\"Container\"" >>/usr/local/tomcat/conf/context.xml
##RUN echo '        type="javax.sql.DataSource"' >>/usr/local/tomcat/conf/context.xml
##RUN echo "        username=\"$USER_ORACLE\" password=\"$PASS_ORACLE\"" >>/usr/local/tomcat/conf/context.xml
##RUN echo '        driverClassName="oracle.jdbc.OracleDriver"' >>/usr/local/tomcat/conf/context.xml
##RUN echo "        url=\"jdbc:oracle:thin:@$HOST_ORACLE:1521:$DB_ORACLE\"/>" >>/usr/local/tomcat/conf/context.xml

##RUN echo "<Resource name=\"jdbc/$JNDI_MARIADB\" auth=\"Container\"" >>/usr/local/tomcat/conf/context.xml
##RUN echo '        type="javax.sql.DataSource"' >>/usr/local/tomcat/conf/context.xml
##RUN echo "        username=\"$USER_MARIADB\" password=\"$PASS_MARIADB\"" >>/usr/local/tomcat/conf/context.xml
##RUN echo '        driverClassName="org.mariadb.jdbc.Driver"' >>/usr/local/tomcat/conf/context.xml
##RUN echo "        url=\"jdbc:mysql://$HOST_MARIADB:$PORT_MARIADB/$DB_MARIADB\"/>" >>/usr/local/tomcat/conf/context.xml

##RUN echo "<Resource name=\"jdbc/$JNDI_POSTGRES\" auth=\"Container\"" >>/usr/local/tomcat/conf/context.xml
##RUN echo '        type="javax.sql.DataSource"' >>/usr/local/tomcat/conf/context.xml
##RUN echo "        username=\"$USER_POSTGRES\" password=\"$PASS_POSTGRES\"" >>/usr/local/tomcat/conf/context.xml
##RUN echo '        driverClassName="org.postgresql.Driver"' >>/usr/local/tomcat/conf/context.xml
##RUN echo "        url=\"jdbc:postgresql://$HOST_POSTGRES:$PORT_POSTGRES/$DB_POSTGRES\"/>" >>/usr/local/tomcat/conf/context.xml
##RUN echo '</Context>' >>/usr/local/tomcat/conf/context.xml

