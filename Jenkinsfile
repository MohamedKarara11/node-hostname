pipeline {
    agent any

    environment {
        // Define required environment variables
        CLUSTER_NAME = 'cluster-1'      // Name of the existing cluster
        NAMESPACE = 'default'             // Namespace for deployment
        IMAGE_NAME = "mohamedkarara11/node-hostname:${env.BUILD_NUMBER}" // Image name and build number
        PROJECT_ID = 'project-1-405906'
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
	stage('Connect to K8s Cluster') {
		steps {
			withCredentials([file(credentialsId: 'Google_Cloud_2', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
				sh "gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}"
				sh "gcloud config set project ${PROJECT_ID}"		    
				sh "gcloud container clusters get-credentials ${CLUSTER_NAME} --zone us-central1-c --project ${PROJECT_ID}"
                    		sh "kubectl apply -f /home/karara_cloud_architecture/k8s/deployment.yml -n ${NAMESPACE}"
                   		sh "kubectl apply -f /home/karara_cloud_architecture/k8s/service.yml -n ${NAMESPACE}"
                    		sh "kubectl apply -f /home/karara_cloud_architecture/k8s/ingress.yml -n ${NAMESPACE}"

		 }
	     }
	}
	    
    }
}
