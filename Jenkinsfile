pipeline {
    agent any

    environment {
        DOCKER_IMAGE     = 'mahammedshafi/myapp'
        DOCKER_TAG       = "${BUILD_NUMBER}"
        DOCKERHUB_CREDS  = 'dockerhub-credentials'
        EC2_SERVER       = '<EC2-INSTANCE-IP>'
        EC2_USER         = 'ubuntu'
    }

    stages {

        stage('Checkout') {
            steps {
                echo '📥 Checking out code...'
                git branch: 'main', url: 'https://github.com/<your-username>/2-docker-pipeline.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest"
            }
        }

        stage('Test Container') {
            steps {
                echo '🧪 Running container health test...'
                sh """
                    docker run -d --name test-container -p 9090:8080 ${DOCKER_IMAGE}:${DOCKER_TAG}
                    sleep 20
                    curl -f http://localhost:9090/ && echo 'Container test passed!'
                    docker stop test-container && docker rm test-container
                """
            }
        }

        stage('Push to DockerHub') {
            steps {
                echo '📤 Pushing image to DockerHub...'
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKERHUB_CREDS}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh """
                        echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin
                        docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                        docker push ${DOCKER_IMAGE}:latest
                    """
                }
            }
        }

        stage('Deploy on EC2') {
            steps {
                echo '🚀 Deploying container on AWS EC2...'
                sshagent(['ec2-ssh-key']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_SERVER} '
                            docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}
                            docker stop myapp-web || true
                            docker rm myapp-web || true
                            docker run -d \
                                --name myapp-web \
                                -p 8080:8080 \
                                --restart unless-stopped \
                                ${DOCKER_IMAGE}:${DOCKER_TAG}
                        '
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build ${BUILD_NUMBER} deployed successfully!"
        }
        failure {
            echo '❌ Build failed!'
            sh 'docker stop test-container || true && docker rm test-container || true'
        }
        always {
            sh 'docker image prune -f'
        }
    }
}
