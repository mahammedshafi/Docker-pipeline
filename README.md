# 🚀 Docker CI/CD Pipeline (Step-by-Step Implementation)

## 📌 Project Overview

This project demonstrates a complete CI/CD pipeline where a Java application is built, containerized using Docker, pushed to DockerHub, and deployed on AWS EC2.

---

## 🔄 Pipeline Flow

GitHub → Jenkins → Docker Build → DockerHub → AWS EC2 Deployment

---

## 🛠 Tools & Technologies

* GitHub (Source Code)
* Jenkins (CI/CD Automation)
* Docker (Containerization)
* DockerHub (Image Registry)
* AWS EC2 (Deployment Server)

---

## 📁 Project Structure

Jenkinsfile → Pipeline automation
Dockerfile → Application container setup
app/ → Application source code

---

## ⚙️ Step-by-Step Implementation

### 🔹 Step 1: Setup AWS EC2 Server

* Launch EC2 instance (Ubuntu)
* Install Docker:
  sudo apt update
  sudo apt install docker.io -y
* Start Docker:
  sudo systemctl start docker
* Add user to docker group:
  sudo usermod -aG docker ubuntu

---

### 🔹 Step 2: Install Jenkins

* Install Java:
  sudo apt install openjdk-11-jdk -y
* Install Jenkins:
  sudo apt install jenkins -y
* Start Jenkins:
  sudo systemctl start jenkins

---

### 🔹 Step 3: Configure Jenkins

* Open Jenkins in browser (port 8080)
* Install suggested plugins
* Add GitHub & DockerHub credentials
* Create new pipeline job

---

### 🔹 Step 4: Setup GitHub Webhook

* Go to GitHub repo → Settings → Webhooks
* Add Jenkins URL:
  http://<your-ec2-ip>:8080/github-webhook/

---

### 🔹 Step 5: Create Dockerfile

* Define base image
* Copy application files
* Expose port
* Run application

---

### 🔹 Step 6: Write Jenkins Pipeline (Jenkinsfile)

Pipeline stages:

* Clone code from GitHub
* Build Docker image
* Tag image
* Push to DockerHub
* Deploy container on EC2

---

### 🔹 Step 7: Build & Push Docker Image

* Build image:
  docker build -t your-image-name .
* Push to DockerHub:
  docker push your-image-name

---

### 🔹 Step 8: Deploy Container

* Pull image from DockerHub:
  docker pull your-image-name
* Run container:
  docker run -d -p 8080:8080 your-image-name

---

## 📷 Proof of Execution

(Add screenshots here)

* Jenkins pipeline success
* Docker image build logs
* Running container output

---

## 🎯 Key Outcomes

* Automated Docker build & deployment
* Faster application delivery
* Consistent environment using containers

---

## 🚀 Conclusion

This project simulates a real-world DevOps pipeline where applications are containerized and deployed automatically using CI/CD tools.
