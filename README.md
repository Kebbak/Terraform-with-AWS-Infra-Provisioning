
# DevOps Infra Provisioning with Terraform & AWS SDK

## Overview

This project automates AWS infrastructure provisioning using Terraform modules and Python SDK scripts. It includes reusable modules for VPC, EC2, ALB, S3, Security Groups, EKS, and RDS, plus Python scripts for additional AWS resource management.

## Directory Structure

```
├── backend.tf
├── local.tf
├── main.tf
├── output.tf
├── providers.tf
├── terraform.tfvars
├── variables.tf
├── modules/
│   ├── alb/
│   ├── db/
│   ├── ec2/
│   ├── eks/
│   ├── s3/
│   ├── sg/
│   └── vpc/
├── SDK/
│   ├── app.py
│   ├── aws_create_resources.py
│   ├── ec2_instance_wrapper.py
│   ├── ec2-instance-start.py
│   ├── lambda_function.py
│   ├── requirements.txt
│   └── typing_extensions.py
```

## Requirements

- Terraform >= 1.0
- AWS CLI configured with credentials
- Python >= 3.8
- boto3 (install via `pip install -r SDK/requirements.txt`)

## Setup & Usage

### 1. Terraform Infrastructure

1. Initialize Terraform:
	```
	terraform init
	```
2. Review and update `terraform.tfvars` and module variables as needed.
3. Apply the infrastructure:
	```
	terraform apply
	```

### 2. Python SDK Scripts

1. Navigate to the SDK directory:
	```
	cd SDK
	```
2. Install dependencies:
	```
	pip install -r requirements.txt
	```
3. Run scripts as needed, e.g.:
	```
	python aws_create_resources.py
	python ec2-instance-start.py
	```

## Module Descriptions

- **vpc/**: VPC and subnets
- **ec2/**: EC2 instance provisioning
- **sg/**: Security groups
- **alb/**: Application Load Balancer
- **db/**: RDS database
- **eks/**: Kubernetes cluster
- **s3/**: S3 bucket

## Example: EC2 Module

The EC2 module provisions an instance with user data, security group, and IAM role. See `modules/ec2/main.tf` for details.

## Example: Security Group Module

The SG module creates a security group with SSH, HTTP, and custom port access. See `modules/sg/main.tf`.

## Authors

Kebba 
