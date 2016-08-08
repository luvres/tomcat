#!/bin/sh

if [ $# -ne 13 ]; then
  echo ""
  echo "   sh tomcat_mysql.sh <password Manager Web> <user mysql> <pass mysql> <db mysql> <user mariadb> <pass mariadb> <db mariadb> <user postgres> <pass postgres> <db postgres> <user oracle> <pass oracle> <tomcat port>"
  echo ""
  exit 1
fi

### Tomcat 8 jre-8 -> MySQL, MariaDB, Oracle, Postgres
sed -i "s/ENV PASS admin/ENV PASS $1/" Dockerfile_pass_sql_8.0.36-jre8

sed -i "s/ENV USER_MYSQL root/ENV USER_MYSQL $2/" Dockerfile_pass_sql_8.0.36-jre8
sed -i "s/ENV PASS_MYSQL pass/ENV PASS_MYSQL $3/" Dockerfile_pass_sql_8.0.36-jre8
sed -i "s/ENV DB_MYSQL dbzone/ENV DB_MYSQL $4/" Dockerfile_pass_sql_8.0.36-jre8

sed -i "s/ENV USER_MARIADB root/ENV USER_MARIADB $5/" Dockerfile_pass_sql_8.0.36-jre8
sed -i "s/ENV PASS_MARIADB mariadb/ENV PASS_MARIADB $6/" Dockerfile_pass_sql_8.0.36-jre8
sed -i "s/ENV DB_MARIADB dbzone/ENV DB_MARIADB $7/" Dockerfile_pass_sql_8.0.36-jre8

sed -i "s/ENV USER_POSTGRES postgres/ENV USER_POSTGRES $8/" Dockerfile_pass_sql_8.0.36-jre8
sed -i "s/ENV PASS_POSTGRES postgres/ENV PASS_POSTGRES $9/" Dockerfile_pass_sql_8.0.36-jre8
sed -i "s/ENV DB_POSTGRES postgres/ENV DB_POSTGRES ${10}/" Dockerfile_pass_sql_8.0.36-jre8

sed -i "s/ENV USER_ORACLE system/ENV USER_ORACLE ${11}/" Dockerfile_pass_sql_8.0.36-jre8
sed -i "s/ENV PASS_ORACLE oracle/ENV PASS_ORACLE ${12}/" Dockerfile_pass_sql_8.0.36-jre8


docker build -t tomcat${13}:8jre8_datasource -f Dockerfile_pass_sql_8.0.36-jre8 .
docker run \
	--link MySQL:mysql-host \
	--link MariaDB:mariadb-host \
	--link PostgreSQL:postgres-host \
	--link OracleXE:oracle-host \
	--name Tomcat${13} -p ${13}:8080 \
	-d tomcat${13}:8jre8_datasource


cd .. && rm tomcat-8.0.36 -fR

