pipeline {
    agent any
    
    tools {
        maven 'maven3'
        dockerTool 'Docker'
    }
    
    environment {
        DOCKER_HUB_USER = credentials('docker-user') 
        DOCKER_HUB_PASS = credentials('docker-pass') 
    }

    stages {
        stage('Git Checkout') {
            steps {
                git credentialsId: 'github', url: 'https://github.com/sanciajerin/secretsanta-generator.git'
            }
        }
        stage('Build Project') {
            steps {
                sh 'mvn package'
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                script {
                    sh 'docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_PASS}'
                    sh 'docker build -t secret-santa -f Dockerfile .'
                    sh 'docker tag secret-santa jerinvarghese1993/secret-santa
                    sh 'docker push jerinvarghese1993/secret-santa
                    sh 'docker run -it -d -p 9000:8080 jerinvarghese1993/secret-santa'
                }
            }
        }
    }
}
