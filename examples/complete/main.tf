provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "2.1.0"

  ipv4_primary_cidr_block = var.vpc_cidr_block

  context = module.this.context
}

module "subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "2.4.1"

  availability_zones   = var.availability_zones
  vpc_id               = module.vpc.vpc_id
  igw_id               = [module.vpc.igw_id]
  ipv4_cidr_block      = [module.vpc.vpc_cidr_block]
  nat_gateway_enabled  = false
  nat_instance_enabled = false

  context = module.this.context
}

module "nlb" {
  source = "../.."

  vpc_id                                  = module.vpc.vpc_id
  subnet_ids                              = module.subnets.public_subnet_ids
  security_group_enabled                  = var.security_group_enabled
  internal                                = var.internal
  tcp_enabled                             = var.tcp_enabled
  access_logs_enabled                     = var.access_logs_enabled
  nlb_access_logs_s3_bucket_force_destroy = var.nlb_access_logs_s3_bucket_force_destroy
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
