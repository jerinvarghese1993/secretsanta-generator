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
                    sh 'docker push jerinvarghese1993/secret-santa' -- (OPTIONAL)
                    sh 'docker run -it -d -p 9000:8080 jerinvarghese1993/secret-santa' -- (OPTIONAL)
                }
            }
        }
        stage('Deploy to K8s') {
            steps {
                withKubeConfig(caCertificate: '', clusterName: 'eks-cluster', contextName: '', credentialsId: 'K8s-token', namespace: 'jangojerin', restrictKubeConfigAccess: false, serverUrl: 'https://37C6935AF1E50E3E0EE307405CDDA1B6.gr7.us-east-1.eks.amazonaws.com') {
                    sh 'kubectl apply -f K8-Manifest/deployment.yml -n jangojerin'
                    sh 'kubectl apply -f K8-Manifest/service.yml -n jangojerin'
                    sh 'kubectl get svc -n jangojerin'
                }
            }
        }
    }
}
