# Devops Project Concept

This repository hold the concept for the DevOps Project and the Provisioning Code for the Terraform.

# Overview
![prototype_v4](https://user-images.githubusercontent.com/57735112/146023498-3d8aa2fc-805f-4b5d-9f2f-09aec209bb2f.png)

The inspiration comes from [Multi-Cloud: managed [remote]](https://github.com/lucendio/lecture-devops-infos/blob/main/guide/examples.md) with some slight modification on the logging / monitoring.

# Description
 
1. AWS EC2 will act as the Virtual Machine which will hold the Kubernetes Cluster for the application.
2. EC2 Cluster will be provisioned using Terraform. In total two EC2 Cluster will be running, one is for production-environment and the other one is for development / test-environment.
3. The first Deployment / Provisioning is not automated using the github actions or CI / CD .
4. Once the Clusters are running, any changes will be tested and direct implemented to the Clusters.
5. Monitoring / Logging will be realized with the help of the EFK-stacks.

# Workflow
In the Github repositories two branches (develop and main) will be created to control the workflow. The production's workflow will only be run when any PR happen to the main branch.
Develop workflow:
 - Build image -> Test -> Upload image to docker-hub -> Deploy to test-env in EC2

Production workflow:
 - Build image from stable version -> Test -> Upload image to docker-hub -> Deploy to prod-env in EC2
