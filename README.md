# 🐳 Dockerized Application Deployment Pipeline

A Docker-based CI/CD pipeline integrated with Jenkins — containerizes a Java web app, pushes to DockerHub, and deploys on AWS EC2. Reduced environment setup time by **30%**.

## 📌 Project Overview

Eliminates configuration drift across environments using Docker containers. Automates image build, versioning, registry push, and EC2 deployment via Jenkins.

## 🏗️ Architecture

```
GitHub Push → Jenkins Pipeline
                    ↓
            Docker Build & Test
                    ↓
            Push to DockerHub
                    ↓
         SSH Deploy to AWS EC2
         (docker run / compose up)
```

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| Docker | Containerization |
| Dockerfile | Image definition (multi-stage) |
| Docker Compose | Multi-container orchestration |
| Jenkins | CI/CD automation |
| DockerHub | Container registry |
| AWS EC2 | Deployment host |

## 📁 Project Structure

```
2-docker-pipeline/
├── Dockerfile               # Multi-stage Docker build
├── docker-compose.yml       # Multi-container setup (app + db + nginx)
├── Jenkinsfile              # CI/CD pipeline
├── nginx.conf               # Reverse proxy config
├── init.sql                 # DB initialization script
├── pom.xml                  # Maven build file
├── src/                     # Application source
└── README.md
```

## ⚙️ Setup Instructions

### Step 1 — Clone & Configure
```bash
git clone https://github.com/<your-username>/2-docker-pipeline.git
cd 2-docker-pipeline
```

### Step 2 — Build & Run Locally
```bash
# Build image
docker build -t myapp:latest .

# Run with Docker Compose (app + database + nginx)
docker-compose up -d

# Check running containers
docker ps

# View logs
docker-compose logs -f webapp
```

### Step 3 — Access Application
```
http://localhost:8080
```

### Step 4 — Jenkins Pipeline Setup
1. Add DockerHub credentials: `dockerhub-credentials`
2. Add EC2 SSH key: `ec2-ssh-key`
3. Update `EC2_SERVER` in Jenkinsfile
4. Create Jenkins Pipeline job pointing to this repo

## 🔧 Useful Docker Commands

```bash
# Build with build number tag
docker build -t mahammedshafi/myapp:42 .

# Push to DockerHub
docker push mahammedshafi/myapp:42

# Run with port mapping
docker run -d -p 8080:8080 --name myapp mahammedshafi/myapp:latest

# Container health check
docker inspect --format='{{.State.Health.Status}}' myapp

# Stop and remove all
docker-compose down -v
```

## 📊 Results

- ✅ 30% faster environment setup — no more "works on my machine"
- ✅ Versioned Docker images on DockerHub per build
- ✅ Zero config drift across dev/staging/production
- ✅ Multi-container orchestration with service discovery
