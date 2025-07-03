
# AWS ECS Deployment with Terraform and Azure DevOps Pipeline

This project demonstrates deploying a simple Node.js web application to AWS using ECS Fargate. The entire infrastructure is provisioned with Terraform following best practices with a modular structure. The application is containerized with Docker and deployed automatically via a CI/CD pipeline using Azure DevOps (ADO). Set Up CloudWatch alarm for monitoring.




## Prerequisites
- AWS Account
- Terraform
- Azure DevOps
- Docker
- AWS CLI installed and configured

## Creating the Workflow
Below are the step-by-step instructions to set up and deploy the project.
##
## Root Project Folder Structure 
   








**app/:**  
- index.js – server code

- package.json – lists dependencies
- Dockerfile - for Docker image

**terraform/:** Infrastructure as Code (IaC)

- main.tf, variables.tf, outputs.tf – orchestrate module calls

- modules/ – each AWS resource in its own submodule
    
    vpc/ – network setup
    
    iam/ – roles/policies

    ecr/ – container registry

    ecs/ – ECS cluster, task definition, service













## AWS Configure for Terraform

Before deploying infrastructure, authenticate Terraform to AWS.

```bash
  aws configure

```
Enter:
- AWS Access KeyID
- AWS Secret Access Key 


    
##  Initialize, Plan, and Apply Terraform
Inside your /terraform folder:

 Initialize providers and modules:

```bash
 terraform init

```
This downloads AWS provider and prepares your modules.

Plan your deployment:

```bash
terraform plan
```
 Check that it shows what will be created.


Apply the infrastructure:
```bash
terraform apply

```
 Confirm with “yes” when prompted.


Result :
- VPC with subnet and IGW
- ECR repository for container images
- ECS Fargate cluster and service (with task definition)
- IAM roles for ECS tasks
- CloudWatch log group for container logs


AWS infrastructure is now fully provisioned and ready to deploy containers.




## Azure DevOps(ADO) pipeline for  CI/CD


- Create an AWS service connection in Azure DevOps to securely connect ADO with AWS.



     Project Settings → Service connections →   New → AWS → Add Access Key/Secret → Verify & Save 

- Create a variable group for AWS keys to store AWS credentials securely.


    Pipelines → Library → Variable Group → Add AWS_ACCESS_KEY_ID  and  AWS_SECRET_ACCESS_KEY

- Create Azure DevOps YAML Pipeline.

    In your root folder, add: aws-pipelines.yml

- Create Pipeline in ADO Using YAML.

    ADO → Pipelines → New Pipeline → Select repo → Choose YAML → Link service connection → Add variable group → Save (sets up your CI/CD pipeline)

- Run the Pipeline.

    Click Run pipeline → Executes Build → Push → Deploy stages → ECS updates with new image (completes automated deployment to AWS)

- Node.js app is now running in AWS ECS Fargate via a fully automated Azure DevOps pipeline.
    





## Access The Application

- Access via ECS Task Public IP:

    Go to ECS Console → Cluster → Tasks → Details → Public IP

- Open in browser:

```bash
  http://TASK_PUBLIC_IP:3000/


```



## Outcome


![App Screenshot](https://i.postimg.cc/FFZYDxhr/cluster.png)


![App Screenshot](https://i.postimg.cc/zGY4vTRh/service.png)

![App Screenshot](https://i.postimg.cc/Jz3vktb2/task.png)

![App Screenshot](https://i.postimg.cc/NfHWQdLY/pub-ip-ecs.png)

![App Screenshot](https://i.postimg.cc/G3JXK6B4/ECS-output.png)



