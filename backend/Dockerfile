# ---- Build stage ----
FROM gradle:8-jdk21-alpine AS build
WORKDIR /app
COPY settings.gradle.kts build.gradle.kts /app/
COPY gradle /app/gradle
COPY gradlew /app/gradlew
RUN chmod +x /app/gradlew
# Pre-download dependencies
RUN /app/gradlew --no-daemon dependencies
COPY src /app/src
RUN /app/gradlew --no-daemon bootJar

# ---- Runtime stage ----
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
RUN addgroup -S spring && adduser -S spring -G spring
USER spring
COPY --from=build /app/build/libs/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]