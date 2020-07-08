# Provider - AWS 
provider "aws" {
  region = "${var.aws_region}"
}

# Backend - S3
terraform {
  required_version = "~> 0.12"
  backend "s3" {
    encrypt = true
  }
}

# Module to provision VPC
module "vpc" {
  source = "./vpc"

  admin_cidr_ingress        = "${var.admin_cidr_ingress}"
  vpc_cidr_block            = "${var.vpc_cidr_block}"
  public_subnet_cidr_block  = "${var.public_subnet_cidr_block}"
  private_subnet_cidr_block = "${var.private_subnet_cidr_block}"
  deployment_stage          = "${var.deployment_stage}"
  account_no                = "${var.account_no}"
  region                    = "${var.region}"
  avail_zone                = "${var.avail_zone}"
  client                    = "${var.client}"
  product                   = "${var.product}"
  projectcode               = "${var.projectcode}"
  environment               = "${var.environment}"
  owner                     = "${var.owner}"
}