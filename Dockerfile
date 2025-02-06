# Step 1: Use an official OpenJDK base image
FROM openjdk:17-jdk-slim as build

# Step 2: Set the working directory
WORKDIR /app

# Step 3: Copy the pom.xml and the source code
COPY pom.xml ./
COPY src ./src

# Step 4: Build the application using Maven
RUN ./mvnw clean package -DskipTests

# Step 5: Use a new base image for runtime
FROM openjdk:17-jdk-slim

# Step 6: Copy the jar file from the build stage
COPY --from=build /app/target/helloworld-0.0.1-SNAPSHOT.jar /app/helloworld.jar

# Step 7: Expose the port the app will run on
EXPOSE 8081

# Step 8: Run the jar file
ENTRYPOINT ["java", "-jar", "/app/helloworld.jar"]

