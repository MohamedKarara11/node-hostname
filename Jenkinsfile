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

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId:'Dockerhub', passwordVariable:'DOCKER_PASSWORD', usernameVariable:'DOCKER_USERNAME')]) {
                    sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                }
            }
        }
    }
}
