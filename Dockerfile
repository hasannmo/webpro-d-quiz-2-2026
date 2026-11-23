# Build stage: compile and package ROOT.war using Maven on JDK 17
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the WAR file without running tests
RUN mvn clean package -DskipTests

# Run stage: deploy ROOT.war on Apache Tomcat 10.1 (Jakarta EE 10 / JRE 17)
FROM tomcat:10.1-jdk17-temurin

# Clear default Tomcat apps to avoid conflicts
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy packaged ROOT.war into Tomcat's webapps directory as ROOT.war
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose standard Tomcat HTTP port
EXPOSE 8080

# Launch Tomcat
CMD ["catalina.sh", "run"]
