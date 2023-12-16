FROM maven:3.9.5-jdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean install

FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/demoapp.jar /apps/
EXPOSE 8080
CMD [ "java", "-jar", "/apps/demoapp.jar" ]