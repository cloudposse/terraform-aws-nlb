provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "0.18.1"

  cidr_block = var.vpc_cidr_block

  context = module.this.context
}

module "subnets" {
  source               = "cloudposse/dynamic-subnets/aws"
  version              = "0.33.0"
  availability_zones   = var.availability_zones
  vpc_id               = module.vpc.vpc_id
  igw_id               = module.vpc.igw_id
  cidr_block           = module.vpc.vpc_cidr_block
  nat_gateway_enabled  = false
  nat_instance_enabled = false

  context = module.this.context
}

module "nlb" {
  source = "../.."

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

  context = module.this.context
}
