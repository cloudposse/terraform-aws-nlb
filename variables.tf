variable "vpc_id" {
  type        = string
  description = "VPC ID to associate with NLB"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs to associate with NLB"
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "A list of additional security group IDs to allow access to NLB"
}

variable "subnet_mapping_enabled" {
  type        = bool
  default     = false
  description = "Enable generate EIP for defined subnet ids"
}

variable "eip_allocation_ids" {
  type        = list(string)
  default     = []
  description = <<-EOT
    Allocation ID for EIP for subnets.
    The length of the list must correspond to the number of defined subnents.
    If the `subnet_mapping_enabled` variable is not defined and enabled `subnet_mapping_enabled`, EIPs will be created
    EOT
}

variable "internal" {
  type        = bool
  default     = false
  description = "A boolean flag to determine whether the NLB should be internal"
}

variable "slow_start" {
  type        = number
  default     = 0
  description = "Amount time for targets to warm up before the load balancer sends them a full share of requests. The range is 30-900 seconds or 0 to disable."
}

variable "tcp_port" {
  type        = number
  default     = 80
  description = "The port for the TCP listener"
}

variable "tcp_enabled" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable TCP listener"
}

variable "load_balancer_name" {
  type        = string
  default     = ""
  description = "The name for the default load balancer, uses a module label name if left empty"
}

variable "load_balancer_name_max_length" {
  type        = number
  default     = 32
  description = "The max length of characters for the load balancer name."
}

variable "target_group_name" {
  type        = string
  default     = ""
  description = "The name for the default target group, uses a module label name if left empty"
}

variable "target_group_name_max_length" {
  type        = number
  default     = 32
  description = "The max length of characters for the target group name."
}

variable "target_group_port" {
  type        = number
  default     = 80
  description = "The port for the default target group"
}

variable "target_group_target_type" {
  type        = string
  default     = "ip"
  description = "The type (`instance`, `ip` or `lambda`) of targets that can be registered with the default target group"
}

variable "target_group_ip_address_type" {
  type        = string
  default     = "ipv4"
  description = "The type of IP addresses used by the target group. The possible values are `ipv4` and `ipv6`."
}

variable "target_group_additional_tags" {
  type        = map(string)
  default     = {}
  description = "The additional tags to apply to the default target group"
}

variable "eip_additional_tags" {
  type        = map(string)
  default     = {}
  description = "The additional tags to apply to the generated eip"
}

variable "target_group_proxy_protocol_v2" {
  type        = bool
  default     = false
  description = "A boolean flag to enable/disable proxy protocol v2 support"
}

variable "target_group_preserve_client_ip" {
  type        = bool
  default     = false
  description = "A boolean flag to enable/disable client IP preservation."
}

variable "tls_port" {
  type        = number
  default     = 443
  description = "The port for the TLS listener"
}

variable "tls_enabled" {
  type        = bool
  default     = false
  description = "A boolean flag to enable/disable TLS listener"
}

variable "udp_port" {
  type        = number
  default     = 53
  description = "The port for the UDP listener"
}

variable "udp_enabled" {
  type        = bool
  default     = false
  description = "A boolean flag to enable/disable UDP listener"
}

variable "certificate_arn" {
  type        = string
  default     = ""
  description = "The ARN of the default SSL certificate for HTTPS listener"
}

variable "additional_certs" {
  type        = list(string)
  description = "A list of additonal certs to add to the https listerner"
  default     = []
}

variable "security_group_enabled" {
  type        = bool
  description = "Enables the security group"
  default     = false
}

variable "default_listener_ingress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of CIDR blocks to allow in TLS security group"
}

variable "default_listener_ingress_prefix_list_ids" {
  type        = list(string)
  default     = []
  description = "List of prefix list IDs for allowing access to TLS ingress security group"
}

variable "tls_ingress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of CIDR blocks to allow in TLS security group"
}

variable "tls_ingress_prefix_list_ids" {
  type        = list(string)
  default     = []
  description = "List of prefix list IDs for allowing access to TLS ingress security group"
}

variable "tls_ssl_policy" {
  type        = string
  description = "The name of the SSL Policy for the listener"
  default     = "ELBSecurityPolicy-2016-08"
}

variable "access_logs_prefix" {
  type        = string
  default     = ""
  description = "The S3 log bucket prefix"
}

variable "access_logs_enabled" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable access_logs"
}

variable "allow_ssl_requests_only" {
  type        = bool
  default     = false
  description = "Set to true to require requests to use Secure Socket Layer (HTTPS/SSL) on the access logs S3 bucket. This will explicitly deny access to HTTP requests"
}

variable "access_logs_s3_bucket_id" {
  type        = string
  default     = null
  description = "An external S3 Bucket name to store access logs in. If specified, no logging bucket will be created."
}

variable "cross_zone_load_balancing_enabled" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable cross zone load balancing"
}

variable "ip_address_type" {
  type        = string
  default     = "ipv4"
  description = "The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` and `dualstack`."
}

variable "deletion_protection_enabled" {
  type        = bool
  default     = false
  description = "A boolean flag to enable/disable deletion protection for NLB"
}

variable "deregistration_delay" {
  type        = number
  default     = 15
  description = "The amount of time to wait in seconds before changing the state of a deregistering target to unused"
}

variable "connection_termination_enabled" {
  type        = bool
  default     = false
  description = "Whether to terminate connections at the end of the deregistration timeout"
}

variable "health_check_enabled" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable the NLB health checks"
}

variable "health_check_port" {
  type        = number
  default     = null
  description = "The port to send the health check request to (defaults to `traffic-port`)"
}

variable "health_check_protocol" {
  type        = string
  default     = null
  description = "The protocol to use for the health check request"
}

variable "health_check_path" {
  type        = string
  default     = "/"
  description = "The destination for the health check request"
}

variable "health_check_threshold" {
  type        = number
  default     = 2
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy."
}

variable "health_check_unhealthy_threshold" {
  type        = number
  default     = null
  description = "The number of consecutive health check failures required before considering the target unhealthy. If not set using value from `health_check_threshold`"
}

variable "health_check_interval" {
  type        = number
  default     = 10
  description = "The duration in seconds in between health checks"
}

variable "health_check_timeout" {
  type        = number
  default     = null
  description = "The amount of time, in seconds, during which no response means a failed health check"
}

variable "health_check_matcher" {
  type        = string
  default     = null
  description = "The HTTP or gRPC codes to use when checking for a successful response from a target, values can be comma-separated individual values or a range of values"
}

variable "stickiness_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable sticky sessions"
}

variable "nlb_access_logs_s3_bucket_force_destroy" {
  type        = bool
  default     = false
  description = "A boolean that indicates all objects should be deleted from the NLB access logs S3 bucket so that the bucket can be destroyed without error"
}

variable "lifecycle_configuration_rules" {
  type = list(object({
    enabled = bool
    id      = string

    abort_incomplete_multipart_upload_days = number

    # `filter_and` is the `and` configuration block inside the `filter` configuration.
    # This is the only place you should specify a prefix.
    filter_and = any
    expiration = any
    transition = list(any)

    noncurrent_version_expiration = any
    noncurrent_version_transition = list(any)
  }))
  default     = []
  description = <<-EOT
    A list of S3 bucket v2 lifecycle rules, as specified in [terraform-aws-s3-bucket](https://github.com/cloudposse/terraform-aws-s3-bucket)"
    These rules are not affected by the deprecated `lifecycle_rule_enabled` flag.
    **NOTE:** Unless you also set `lifecycle_rule_enabled = false` you will also get the default deprecated rules set on your bucket.
    EOT
}

variable "target_group_enabled" {
  type        = bool
  default     = true
  description = "Whether or not to create the default target group and listener"
}

variable "enforce_security_group_inbound_rules_on_private_link_traffic" {
  type        = string
  default     = null
  description = "Indicates whether inbound security group rules are enforced for traffic originating from a PrivateLink. Only valid for Load Balancers of type network. The possible values are on and off."
}
