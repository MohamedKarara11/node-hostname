pipeline {
    agent any

    environment {
        // Define required environment variables
        GCP_CREDENTIALS_ID = 'Google_Cloud'  // ID of your GCP service account credentials
        CLUSTER_NAME = 'cluster-1'      // Name of the existing cluster
        NAMESPACE = 'default'             // Namespace for deployment
        IMAGE_NAME = "mohamedkarara11/node-hostname:${env.BUILD_NUMBER}" // Image name and build number
    }
	
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
	stage('Deploy to Existing Cluster') {
            steps {
                withKubeConfig([credentialsId: 'Kubernetes']) {
                    sh "kubectl apply -f /home/karara_cloud_architecture/k8s/deployment.yml -n ${NAMESPACE}"
                    sh "kubectl apply -f /home/karara_cloud_architecture/k8s/service.yml -n ${NAMESPACE}"
                    sh "kubectl apply -f /home/karara_cloud_architecture/k8s/ingress.yml -n ${NAMESPACE}"
                }
            }
        }
    }
}
