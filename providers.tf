terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  #   confluent = {
  #     source  = "confluentinc/confluent"
  #     version = "2.59.0"
  #   }
  #   kafka = {
  #     source  = "confluentinc/kafka"
  #     version = ">= 1.0.0"
  #   }
  }
}

provider "aws" {
  region = var.aws_region
}
