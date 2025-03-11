pipeline {
    agent {
        label 'win' # label name of the slave mechine
    }
    tools {
        maven 'maven3'
    }
    
    environment {
        registry = '202533525867.dkr.ecr.us-east-1.amazonaws.com/prokopto-ecr' # ECR registry url
    }

    stages {
        stage('Git checkout') {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/jerinvarghese1993/springboot_cicd.git'
            }
        }
        stage('Build the jar') {
            steps {
                sh'mvn clean package'
            }
        }
        stage('Build the image') {
            steps {
                script {
                    dockerImage = docker.build "${registry}:latest" 
                }
            }
        }
        stage('Push to ECR') {
            steps {
                script {
                    sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 202533525867.dkr.ecr.us-east-1.amazonaws.com    # We will get this command from the ECR registry in AWS
                    sh "docker tag ${registry}:latest ${registry}:latest"
                    sh "docker push ${registry}:latest"
                }
            }
        }
    }
}
