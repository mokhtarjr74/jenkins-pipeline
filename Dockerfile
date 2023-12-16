FROM maven:3.9.6-eclipse-temurin-17-alpine AS build
WORKDIR /app
COPY . .
RUN mvn clean install

FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=build /app/target/demoapp.jar /app/
EXPOSE 8080
CMD [ "java", "-jar", "/apps/demoapp.jar" ]