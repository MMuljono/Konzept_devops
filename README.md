# Devops Project Concept

This repo hold the concept for the DevOps Project and the Provisioning Code for the Terraform.

# Overview
![Prototype_v2](https://user-images.githubusercontent.com/57735112/146003269-4eef3395-e916-4f26-a057-ce555b1814b8.png)

The inspiration comes from [Multi-Cloud: managed [remote]](https://github.com/lucendio/lecture-devops-infos/blob/main/guide/examples.md) with some slight modification on the logging / monitoring.

# Description
 
1. AWS EC2 will act as the Virtual Machine which will hold the Kubernetes Cluster for the application.
2. EC2 Cluster will be provisioned using Terraform. In total two EC2 Cluster will be running, one is for production-environment and the other one is for development / test-environment.
3. The first Deployment / Provisioning is not automated using the github actions or CI / CD .
4. Once the Clusters are running, any changes will be tested and direct implemented to the Clusters.
5. Monitoring / Logging will be realized with the help of the EFK-stacks.
