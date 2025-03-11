pipeline {
    agent {
        label 'win'
    }
    tools {
        maven 'maven3'
    }
    environment{
        registry ='202533525867.dkr.ecr.us-east-1.amazonaws.com/prokopto-ecr' # Repository url we get it from the AWS ECR
    }

    stages {
        stage('Checkout from git') {
            steps {
                git credentialsId: 'github', url: 'https://github.com/jerinvarghese1993/secretsanta-generator.git'
            }
        }
        stage('Build the jar') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Build the Image') {
            steps {
                script {
                    dockerImage = docker.build "${registry}:latest"
                }    
            }
        }
        stage('Push to ECR') {
            steps {
                script {
                    sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 202533525867.dkr.ecr.us-east-1.amazonaws.com'  # We will get it from the ECR repositoy view push commands option
                    sh 'docker tag ${registry}:latest ${registry}:latest'
                    sh 'docker push ${registry}:latest'
                }
            }
        }
    }
}

