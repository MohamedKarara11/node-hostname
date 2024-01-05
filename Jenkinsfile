pipeline {
    agent any

    stages {
        stage('Checkout from GitHub') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/MohamedKarara11/node-hostname.git'
            }
        }
        stage('Build Container Image') {
            steps {
                script {
                    dockerImage = docker.build("mohamedkarara11/node-hostname:${env.BUILD_NUMBER}")
                }
            }
        }
	stage('Deploy to Kubernetes') {
            steps {
                withKubeConfig([credentialsId: 'kubernetes-config']) {
                    sh "kubectl apply -f deployment.yml"
                    sh "kubectl apply -f service.yml"
                    sh "kubectl apply -f ingress.yml"
                }
            }
        }
    }
}
