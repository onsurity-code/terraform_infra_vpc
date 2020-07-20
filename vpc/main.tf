locals {
  account_no = "${var.account_no}"
  region = "${var.region}"
  avail_zone = "${var.avail_zone}"
  deployment_stage = "${var.deployment_stage}"
  client = "${var.client}"
  product = "${var.client}"
  projectname = "OnsuirtyInfra"
  projectcode = "${var.projectcode}"
  environment = "${var.environment}"
  owner       = "${var.owner}"
  
}


data "aws_availability_zones" "available" {}

resource "aws_vpc" "primary_vpc" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = true

  tags = {
    Name =  "aws-${local.account_no}-${local.region}-${local.avail_zone}-${local.deployment_stage}-vpc-${local.client}-${local.product}-${local.environment}vpc01"
    Environment = "${local.environment}"
    Owner = "${local.owner}"
    Projectcode = "${local.projectcode}"
    Projectname = "${local.projectname}"
  }
}

resource "aws_subnet" "public" {
  count             = "${var.az_count}"
  cidr_block        = "${cidrsubnet(aws_vpc.primary_vpc.cidr_block, 8, count.index)}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  vpc_id            = "${aws_vpc.primary_vpc.id}"
  tags = {
    Name = "aws-${local.account_no}-${local.region}-${local.avail_zone}-${local.deployment_stage}-sub-${local.client}-${local.product}-publicsub"
    Environment = "${local.environment}"
    Owner = "${local.owner}"
    Projectcode = "${local.projectcode}"
    Projectname = "${local.projectname}"
  }
}

# Create var.az_count private subnets, each in a different AZ
resource "aws_subnet" "private" {
  count             = "${var.az_count}"
  cidr_block        = cidrsubnet(aws_vpc.primary_vpc.cidr_block, 8, var.az_count + count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = "${aws_vpc.primary_vpc.id}"
  tags = {
    Name = "aws-${local.account_no}-${local.region}-${local.avail_zone}-${local.deployment_stage}-sub-${local.client}-${local.product}-privatesub"
    Environment = "${local.environment}"
    Owner = "${local.owner}"
    Projectcode = "${local.projectcode}"
    Projectname = "${local.projectname}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.primary_vpc.id}"
  tags = {
    Name = "aws-a0001-aps1-1a-d-igw-onsy-infra-igw01"
    Environment = "${local.environment}"
    Owner = "${local.owner}"
    Projectcode = "${local.projectcode}"
    Projectname = "${local.projectname}"
  }
}

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.primary_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags = {
    Name = "aws-${local.account_no}-${local.region}-${local.avail_zone}-${local.deployment_stage}-rtb-${local.client}-${local.product}-pub_rtb"
    Environment = "${local.environment}"
    Owner = "${local.owner}"
    Projectcode = "${local.projectcode}"
    Projectname = "${local.projectname}"
  }
}

resource "aws_route_table_association" "main" {
  count          = "${var.availability_zone_count}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.main.id}"

  }


resource "aws_route_table" "private_table" {
  vpc_id = "${aws_vpc.primary_vpc.id}"

  tags = {
    Name = "aws-${local.account_no}-${local.region}-${local.avail_zone}-${local.deployment_stage}-rtb-${local.client}-${local.product}-priv_rtb"
    Environment = "${local.environment}"
    Owner = "${local.owner}"
    Projectcode = "${local.projectcode}"
    Projectname = "${local.projectname}"
  }
}


resource "aws_route_table_association" "private" {
  count          = "${var.availability_zone_count}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private_table.id}"

}

resource "aws_security_group" "alb_sg" {
  description = "The security group used to grant access to the ALB"

  vpc_id = "${aws_vpc.primary_vpc.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  tags = {
    Name = "aws-${local.account_no}-${local.region}-${local.avail_zone}-${local.deployment_stage}-seg-${local.client}-${local.product}-seg_alb"
    Environment = "${local.environment}"
    Owner = "${local.owner}"
    Projectcode = "${local.projectcode}"
    Projectname = "${local.projectname}"
  }
}

resource "aws_security_group" "instance_sg" {
  description = "The security group allowing SSH administrative access to the instances"
  vpc_id      = "${aws_vpc.primary_vpc.id}"

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22

    cidr_blocks = [
      "${var.admin_cidr_ingress}",
    ]
  }

  ingress {
    protocol  = "tcp"
    from_port = 32768
    to_port   = 61000

    security_groups = [
      "${aws_security_group.alb_sg.id}",
    ]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = "${aws_subnet.private.*.cidr_block}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws-${local.account_no}-${local.region}-${local.avail_zone}-${local.deployment_stage}-seg-${local.client}-${local.product}-instance_seg"
    Environment = "${local.environment}"
    Owner = "${local.owner}"
    Projectcode = "${local.projectcode}"
    Projectname = "${local.projectname}"
  }
}

