variable "aws_region" {
  description = "The AWS region for creating the infrastructure"
  default     = "ap-south-1"
}

variable "admin_cidr_ingress" {
  description = "Ingress for CIDR"
  default     = "0.0.0.0/0"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC to use"
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet within the VPC"
}

variable "private_subnet_cidr_block" {
  description = "The CIDR block for the private subnet within the VPC"
}

variable "account_no" {
  description = "AWS Onsurity Account no. on which resources to be provisioned"
}

variable "region" {
  description = "AWS Onsurity Account Peudo region name to be provisioned"
}

variable "avail_zone" {
  description = "AWS Onsurity AZ's  on which resources to be provisioned"
}

variable "deployment_stage" {
  description = "AWS Onsurity deployment stage on which resources to be provisioned"
}

variable "client" {
  description = "AWS Onsurity Account's Client name which resources to be provisioned"
}

variable "product" {
  description = "AWS Onsurity Account's Product name on which resources to be provisioned"
}

variable "projectcode" {
  description = "AWS Onsurity Account'sn client Project code on which resources to be provisioned"
}


variable "environment" {
  description = "AWS Onsurity Account's environment name on which resources to be provisioned"
}

variable "owner" {
  description = "AWS Onsurity Account's Owner who will maintain resources"
}