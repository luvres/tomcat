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
-p 5432:5432 -e POSTGRES_PASSWORD=postgres -d arm32v7/postgres:alpine

docker run --name Tomcat -h tomcat \
--link PostgreSQL:postgres-host \
-e PASS="admin" \
-e HOST_POSTGRES=postgres-host \
-e PORT_POSTGRES=5432 \
-e USER_POSTGRES=postgres \
-e PASS_POSTGRES=postgres \
-e DB_POSTGRES=postgres \
-p 8080:8080 \
-d izone/tomcat:armhf
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

