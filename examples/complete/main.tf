provider "aws" {
  region = var.region
}

module "vpc" {
  source     = "git::https://github.com/cloudposse/terraform-aws-vpc.git?ref=tags/0.14.0"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  delimiter  = var.delimiter
  attributes = var.attributes
  cidr_block = var.vpc_cidr_block
  tags       = var.tags
}

module "subnets" {
  source               = "git::https://github.com/cloudposse/terraform-aws-dynamic-subnets.git?ref=tags/0.19.0"
  availability_zones   = var.availability_zones
  namespace            = var.namespace
  stage                = var.stage
  name                 = var.name
  attributes           = var.attributes
  delimiter            = var.delimiter
  vpc_id               = module.vpc.vpc_id
  igw_id               = module.vpc.igw_id
  cidr_block           = module.vpc.vpc_cidr_block
  nat_gateway_enabled  = false
  nat_instance_enabled = false
  tags                 = var.tags
}

module "nlb" {
  source                                  = "../.."
  namespace                               = var.namespace
  stage                                   = var.stage
  name                                    = var.name
  attributes                              = var.attributes
  delimiter                               = var.delimiter
  vpc_id                                  = module.vpc.vpc_id
  subnet_ids                              = module.subnets.public_subnet_ids
  internal                                = var.internal
  tcp_enabled                             = var.tcp_enabled
  access_logs_enabled                     = var.access_logs_enabled
  nlb_access_logs_s3_bucket_force_destroy = var.nlb_access_logs_s3_bucket_force_destroy
  access_logs_region                      = var.access_logs_region
  cross_zone_load_balancing_enabled       = var.cross_zone_load_balancing_enabled
  ip_address_type                         = var.ip_address_type
  deletion_protection_enabled             = var.deletion_protection_enabled
  deregistration_delay                    = var.deregistration_delay
  health_check_threshold                  = var.health_check_threshold
  health_check_interval                   = var.health_check_interval
  target_group_port                       = var.target_group_port
  target_group_target_type                = var.target_group_target_type
  tags                                    = var.tags
}
