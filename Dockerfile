FROM openjdk:20-jdk
EXPOSE 8080
ADD target/demo-app.jar demo-app.jar
ENTRYPOINT ["java","-jar","/demo-app.jar"]