# Use a base image with Java and Maven installed
FROM maven:3.8.4-openjdk-17-slim AS build

# Set the working directory
WORKDIR /app

# Copy the project's pom.xml and build dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code
COPY src ./src

# Build the application
RUN mvn package -DskipTests

# Use a base image with Java installed
FROM openjdk:17-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/<your-application-name>.jar .

# Expose the port your application is listening on (default is 8080)
EXPOSE 8080

# Set the entry point command to run your application
CMD ["java", "-jar", "<your-application-name>.jar"]