# Stage 1: Build the application using Maven
FROM maven:3.8.4-openjdk-11-slim AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the application in Tomcat
FROM tomcat:10-jdk11
WORKDIR /usr/local/tomcat

# Remove default webapps
RUN rm -rf webapps/*

# Copy the WAR file from the build stage
COPY --from=build /app/target/PayPulse.war webapps/ROOT.war

# Expose the default Tomcat port
EXPOSE 8080

# The application uses .env or System Environment variables.
# For cloud deployment, you will set DB_URL, DB_USER, and DB_PASSWORD as Environment Variables.

CMD ["catalina.sh", "run"]
