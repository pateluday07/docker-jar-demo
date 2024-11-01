# Stage 1: Build
FROM maven:3.9.9-amazoncorretto-21-alpine AS build
WORKDIR /home/app/
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package

# Stage 2: Run
FROM amazoncorretto:21.0.5-alpine3.20 AS run
WORKDIR /home/app
COPY --from=build /home/app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
