FROM openjdk:21-jdk
WORKDIR /app

COPY target/*.war app.war

EXPOSE 8087
ENTRYPOINT ["java","-jar","/app/app.war"]
