# ---------------------------------------------
# Stage 1 – Build the application using Maven
# ---------------------------------------------
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory inside container
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the application (skip tests if needed)
RUN mvn clean package -DskipTests

# ---------------------------------------------
# Stage 2 – Create lightweight runtime image
# ---------------------------------------------
FROM eclipse-temurin:17-jdk-jammy

# Set working directory
WORKDIR /app

# Copy only the generated jar from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose application port (adjust if different)
EXPOSE 8080

# Set default command
ENTRYPOINT ["java", "-jar", "app.jar"]


