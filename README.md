# DevOps Platform Implementation

This repository contains the configuration files and pipeline for a DevOps platform deployment using AWS EKS, Terraform, GitHub Actions, SonarCloud, JFrog Artifactory, and Ansible.

## Prerequisites

- AWS account
- Terraform installed
- kubectl installed
- GitHub Actions secrets for SonarCloud and JFrog Artifactory

## Steps

1. **Set up AWS EKS with Terraform**:
   - Run the following commands in the root of the repo:
     ```bash
     terraform init
     terraform apply
     ```

2. **CI/CD Pipeline**:
   - Push changes to the `main` branch to trigger the GitHub Actions pipeline.
   - The pipeline will:
     - Run SonarCloud for code quality.
     - Build a Docker image and push to JFrog Artifactory.
     - Deploy the application to the EKS cluster.

3. **Ansible Deployment**:
   - Use Ansible to deploy another application on the same EKS cluster:
     ```bash
     ansible-playbook ansible/deploy-app.yml
     ```

## Configuration

- Ensure your GitHub secrets are configured for:
  - `SONAR_TOKEN`
  - `JFROG_USERNAME`
  - `JFROG_PASSWORD`
