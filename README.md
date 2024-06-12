# Service Deployment

This repository contains the necessary code and configuration files to deploy a simple HTTP service displaying a version number using Docker, Amazon ECR, Amazon EKS, and Jenkins for CI/CD.

## Prerequisites

- AWS CLI configured with appropriate permissions.
- Docker installed locally.
- kubectl installed locally.
- Jenkins installed and configured with Docker and Kubernetes plugins.
- AWS IAM roles and policies for EKS and ECR.

## Steps to Create the Infrastructure

### 1. Create an ECR Repository

```sh
aws ecr create-repository --repository-name service

Create an EKS Cluster

aws eks create-cluster --name my-cluster --role-arn arn:aws:iam::471112595535:role/eks-role --resources-vpc-config subnetIds=<subnet-ids>,securityGroupIds=<security-group-ids>
aws eks update-kubeconfig --name my-cluster --region <your-region>

Steps to Deploy the Application
1. Build and Push Docker Image to ECR
docker build -t service .
aws ecr get-login-password --region <your-region> | docker login --username AWS --password-stdin 471112595535.dkr.ecr.<your-region>.amazonaws.com
docker tag service:latest 471112595535.dkr.ecr.<your-region>.amazonaws.com/service:latest
docker push 471112595535.dkr.ecr.<your-region>.amazonaws.com/service:latest

2. Deploy the Application to EKS
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

3. Retrieve the LoadBalancer URL
kubectl get services service

Access the service using the external URL provided.

CI/CD Pipeline with Jenkins
Create a Jenkins pipeline job.
Configure Jenkins with appropriate AWS credentials.
Use the provided Jenkinsfile for the pipeline configuration.
The Jenkins pipeline will build the Docker image, push it to ECR, and deploy it to the EKS cluster.


### Step 3: Commit and Push to GitHub

```sh
git add .
git commit -m "Initial commit with deployment and application code"
git push origin main
