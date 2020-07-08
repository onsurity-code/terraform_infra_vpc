output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_zone_identifier" {
  value = "${module.vpc.vpc_zone_identifier}"
}

output "instance_sg_id" {
  value = "${module.vpc.instance_sg_id}"
}

output "public_subnet_ids" {
  value = "${module.vpc.public_subnet_ids}"
}

output "private_subnet_ids" {
  value = "${module.vpc.private_subnet_ids}"
}

output "security_groups" {
  value = "${module.vpc.security_groups}"
}

output "private_subnet_group_name" {
  value = "${module.vpc.private_subnet_group_name}"
}


output "private_route_table_id" {
  value = "${module.vpc.private_route_table_name}"
}

output "public_route_table_id" {
  value = "${module.vpc.public_route_table_name}"
}