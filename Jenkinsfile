pipeline {
    agent any
    environment {
        ECR_REPOSITORY_URI = '471112595535.dkr.ecr.<your-region>.amazonaws.com/service'
        CLUSTER_NAME = 'my-cluster'
        AWS_REGION = '<your-region>'
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("service")
                }
            }
        }
        stage('Push to ECR') {
            steps {
                script {
                    docker.withRegistry("https://${env.ECR_REPOSITORY_URI}", 'ecr:us-west-2:aws-credentials-id') {
                        dockerImage.push("latest")
                    }
                }
            }
        }
        stage('Deploy to EKS') {
            steps {
                script {
                    sh """
                        aws eks update-kubeconfig --name ${env.CLUSTER_NAME} --region ${env.AWS_REGION}
                        kubectl set image deployment/service service=${env.ECR_REPOSITORY_URI}:latest
                    """
                }
            }
        }
    }
}
