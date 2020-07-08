variable "availability_zone_count" {
  description = "The number of availability zones to be leveraged within the VPC"
  default     = "2"
}


variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}


variable "private_subnet_cidr_block" {
  description = "The CIDR block for the private subnet within the VPC"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet within the VPC"
}

variable "admin_cidr_ingress" {
    description = "The CIDR block for the public subnet within the VPC"
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