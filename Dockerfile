# Stage 1: Build
FROM maven:3.8-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM tomcat:9-jdk11
# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy WAR file
COPY --from=build /app/target/TourGuide.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
