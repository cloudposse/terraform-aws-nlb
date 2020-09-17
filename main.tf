locals {
  listener_port         = var.tcp_enabled ? (var.udp_enabled ? var.udp_port : var.tcp_port) : var.udp_port
  listener_proto        = var.tcp_enabled ? (var.udp_enabled ? "TCP_UDP" : "TCP") : "UDP"
  tcp_port              = var.udp_enabled ? var.udp_port : var.tcp_port
  health_check_port     = coalesce(var.health_check_port, "traffic-port")
  target_group_protocol = var.tls_enabled ? "TCP" : local.listener_proto
  health_check_protocol = coalesce(var.health_check_protocol, local.target_group_protocol)
}

module "default_label" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.17.0"
  attributes  = var.attributes
  delimiter   = var.delimiter
  environment = var.environment
  name        = var.name
  namespace   = var.namespace
  stage       = var.stage
  tags        = var.tags
}

module "access_logs" {
  source                             = "git::https://github.com/cloudposse/terraform-aws-lb-s3-bucket.git?ref=tags/0.7.0"
  name                               = var.name
  environment                        = var.environment
  namespace                          = var.namespace
  stage                              = var.stage
  attributes                         = compact(concat(var.attributes, ["nlb", "access", "logs"]))
  delimiter                          = var.delimiter
  tags                               = var.tags
  region                             = var.access_logs_region
  lifecycle_rule_enabled             = var.lifecycle_rule_enabled
  enable_glacier_transition          = var.enable_glacier_transition
  expiration_days                    = var.expiration_days
  glacier_transition_days            = var.glacier_transition_days
  noncurrent_version_expiration_days = var.noncurrent_version_expiration_days
  noncurrent_version_transition_days = var.noncurrent_version_transition_days
  standard_transition_days           = var.standard_transition_days
  force_destroy                      = var.nlb_access_logs_s3_bucket_force_destroy
  enabled                            = false # Cannot apparently use encryption with S3 logs for NLB, even if using AES256. See https://github.com/cloudposse/terraform-aws-lb-s3-bucket/issues/9 for discussion.
}

resource "aws_lb" "default" {
  name               = module.default_label.id
  tags               = module.default_label.tags
  internal           = var.internal
  load_balancer_type = "network"

  subnets                          = var.subnet_ids
  enable_cross_zone_load_balancing = var.cross_zone_load_balancing_enabled
  ip_address_type                  = var.ip_address_type
  enable_deletion_protection       = var.deletion_protection_enabled

  /* TODO: re-enable when bucket encryption issue is resolved for NLBs
  access_logs {
    bucket  = module.access_logs.bucket_id
    prefix  = var.access_logs_prefix
    enabled = var.access_logs_enabled
  }
  */
}

module "default_target_group_label" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.17.0"
  attributes  = concat(var.attributes, ["default"])
  delimiter   = var.delimiter
  environment = var.environment
  name        = var.name
  namespace   = var.namespace
  stage       = var.stage
  tags        = var.tags
}

resource "aws_lb_target_group" "default" {
  name                 = var.target_group_name == "" ? module.default_target_group_label.id : var.target_group_name
  port                 = var.target_group_port
  protocol             = local.target_group_protocol
  vpc_id               = var.vpc_id
  target_type          = var.target_group_target_type
  deregistration_delay = var.deregistration_delay

  health_check {
    enabled             = var.health_check_enabled
    port                = local.health_check_port
    protocol            = local.health_check_protocol
    path                = local.health_check_protocol == "HTTP" ? var.health_check_path : null
    healthy_threshold   = var.health_check_threshold
    unhealthy_threshold = var.health_check_threshold
    interval            = var.health_check_interval
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    module.default_target_group_label.tags,
    var.target_group_additional_tags
  )

  depends_on = [
    aws_lb.default,
  ]
}

resource "aws_lb_listener" "default" {
  count             = var.tcp_enabled ? 1 : (var.udp_enabled ? 1 : 0)
  load_balancer_arn = aws_lb.default.arn
  port              = local.listener_port
  protocol          = local.listener_proto

  default_action {
    target_group_arn = aws_lb_target_group.default.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "tls" {
  count             = var.tls_enabled ? 1 : 0
  load_balancer_arn = aws_lb.default.arn

  port            = var.tls_port
  protocol        = "TLS"
  ssl_policy      = var.tls_ssl_policy
  certificate_arn = var.certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.default.arn
    type             = "forward"
  }
}
