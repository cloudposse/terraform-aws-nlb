locals {
  listener_port         = var.tcp_enabled ? (var.udp_enabled ? var.udp_port : var.tcp_port) : var.udp_port
  listener_proto        = var.tcp_enabled ? (var.udp_enabled ? "TCP_UDP" : "TCP") : "UDP"
  tcp_port              = var.udp_enabled ? var.udp_port : var.tcp_port
  health_check_port     = coalesce(var.health_check_port, "traffic-port")
  target_group_protocol = var.tls_enabled ? "TCP" : local.listener_proto
  health_check_protocol = coalesce(var.health_check_protocol, local.target_group_protocol)
}

module "access_logs" {
  source  = "cloudposse/lb-s3-bucket/aws"
  version = "0.16.3"

  enabled = module.this.enabled && var.access_logs_enabled && var.access_logs_s3_bucket_id == null

  attributes = compact(concat(module.this.attributes, ["nlb", "access", "logs"]))

  allow_ssl_requests_only       = var.allow_ssl_requests_only
  lifecycle_configuration_rules = var.lifecycle_configuration_rules
  force_destroy                 = var.nlb_access_logs_s3_bucket_force_destroy

  ## Depricated variables --------------------------
  lifecycle_rule_enabled             = var.lifecycle_rule_enabled
  enable_glacier_transition          = var.enable_glacier_transition
  glacier_transition_days            = var.glacier_transition_days
  expiration_days                    = var.expiration_days
  noncurrent_version_expiration_days = var.noncurrent_version_expiration_days
  noncurrent_version_transition_days = var.noncurrent_version_transition_days
  standard_transition_days           = var.standard_transition_days
  ##-----------------------------------------------

  context = module.this.context
}

module "default_load_balancer_label" {
  source          = "cloudposse/label/null"
  version         = "0.25.0"
  id_length_limit = var.load_balancer_name_max_length

  context = module.this.context
}

resource "aws_lb" "default" {
  #bridgecrew:skip=BC_AWS_NETWORKING_41 - Skipping `Ensure that ALB drops HTTP headers` check. Only valid for Load Balancers of type application.
  count              = module.this.enabled ? 1 : 0
  name               = var.load_balancer_name == "" ? module.default_load_balancer_label.id : substr(var.load_balancer_name, 0, var.load_balancer_name_max_length)
  tags               = module.this.tags
  internal           = var.internal
  load_balancer_type = "network"

  subnets                          = var.subnet_ids
  enable_cross_zone_load_balancing = var.cross_zone_load_balancing_enabled
  ip_address_type                  = var.ip_address_type
  enable_deletion_protection       = var.deletion_protection_enabled

  access_logs {
    bucket  = try(element(compact([var.access_logs_s3_bucket_id, module.access_logs.bucket_id]), 0), "")
    prefix  = var.access_logs_prefix
    enabled = var.access_logs_enabled
  }
}

module "default_target_group_label" {
  source          = "cloudposse/label/null"
  version         = "0.25.0"
  attributes      = ["default"]
  id_length_limit = var.target_group_name_max_length

  context = module.this.context
}


resource "aws_lb_target_group" "default" {
  count                  = module.this.enabled ? 1 : 0
  name                   = var.target_group_name == "" ? module.default_target_group_label.id : substr(var.target_group_name, 0, var.target_group_name_max_length)
  port                   = var.target_group_port
  protocol               = local.target_group_protocol
  vpc_id                 = var.vpc_id
  target_type            = var.target_group_target_type
  deregistration_delay   = var.deregistration_delay
  connection_termination = var.connection_termination
  preserve_client_ip     = var.preserve_client_ip
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

  stickiness {
    enabled         = var.stickiness_enabled
    type            = var.stickiness_type
    cookie_duration = var.stickiness_cookie_duration
    cookie_name     = var.stickiness_cookie_name
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
  count             = module.this.enabled && var.tcp_enabled ? 1 : (module.this.enabled && var.udp_enabled ? 1 : 0)
  load_balancer_arn = join(aws_lb.default.*.arn)
  port              = local.listener_port
  protocol          = local.listener_proto

  default_action {
    target_group_arn = join(aws_lb_target_group.default.*.arn)
    type             = "forward"
  }
}

resource "aws_lb_listener" "tls" {
  count             = module.this.enabled && var.tls_enabled ? 1 : 0
  load_balancer_arn = join(aws_lb.default.*.arn)

  port            = var.tls_port
  protocol        = "TLS"
  ssl_policy      = var.tls_ssl_policy
  certificate_arn = var.certificate_arn

  default_action {
    target_group_arn = join(aws_lb_target_group.default.*.arn)
    type             = "forward"
  }
}

