# ============================================================
# Dockerfile — Multi-stage build for Java Web Application
# ============================================================

# Stage 1: Build
FROM maven:3.8.6-openjdk-11 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ ./src/
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM tomcat:9.0-jdk11-openjdk-slim
LABEL maintainer="Pinjari Mahammed Shafi <mahammedshafi8058@gmail.com>"
LABEL project="dockerized-cicd-pipeline"
LABEL version="1.0"

# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR from builder stage
COPY --from=builder /app/target/myapp.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

# Start Tomcat
CMD ["catalina.sh", "run"]
