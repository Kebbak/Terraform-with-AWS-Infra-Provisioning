variable "s3_bucket_name" {
  description = "Name of the S3 bucket for Lambda trigger."
  type        = string
}

variable "sns_topic_name" {
  description = "Name of the SNS topic to create."
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function."
  type        = string
}

variable "lambda_zip_path" {
  description = "Path to the Lambda deployment package (zip file)."
  type        = string
}

variable "sns_email" {
  description = "Email address to subscribe to SNS topic."
  type        = string
}

variable "vpc_subnet_ids" {
  description = "List of subnet IDs for Lambda VPC config."
  type        = list(string)
  default     = []
}

variable "security_group_id" { 
type = string
description = "The ID of the security group"
}

variable "subnet_id" {
	type        = string
	description = "The ID of the subnet to launch the EC2 instance in."
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs for Lambda VPC config."
  type        = list(string)
  default     = []
}
