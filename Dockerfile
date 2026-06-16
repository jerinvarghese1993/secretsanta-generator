# Stage 1 - Build the JAR using Maven
FROM maven:3.8.5-openjdk-8 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2 - Run the JAR
FROM openjdk:8u151-jdk-alpine3.7
EXPOSE 8080
ENV APP_HOME /usr/src/app
COPY --from=build /app/target/secretsanta-0.0.1-SNAPSHOT.jar $APP_HOME/app.jar
WORKDIR $APP_HOME
ENTRYPOINT ["java", "-jar", "app.jar"]
