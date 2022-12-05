variable "vpc_id" {
  type        = string
  description = "VPC ID to associate with NLB"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs to associate with NLB"
}

variable "internal" {
  type        = bool
  default     = false
  description = "A boolean flag to determine whether the NLB should be internal"
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

variable "target_group_name" {
  type        = string
  default     = ""
  description = "The name for the default target group, uses a module label name if left empty"
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

variable "target_group_additional_tags" {
  type        = map(string)
  default     = {}
  description = "The additional tags to apply to the default target group"
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
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy, or failures required before considering a health target unhealthy"
}

variable "health_check_interval" {
  type        = number
  default     = 10
  description = "The duration in seconds in between health checks"
}

variable "nlb_access_logs_s3_bucket_force_destroy" {
  type        = bool
  default     = false
  description = "A boolean that indicates all objects should be deleted from the NLB access logs S3 bucket so that the bucket can be destroyed without error"
}

variable "nlb_access_logs_s3_bucket_force_destroy_enabled" {
  type        = bool
  default     = false
  description = <<-EOT
    When `true`, permits `force_destroy` to be set to `true`.
    This is an extra safety precaution to reduce the chance that Terraform will destroy and recreate
    your S3 bucket, causing COMPLETE LOSS OF ALL DATA even if it was stored in Glacier.
    WARNING: Upgrading this module from a version prior to 0.27.0 to this version
      will cause Terraform to delete your existing S3 bucket CAUSING COMPLETE DATA LOSS
      unless you follow the upgrade instructions on the Wiki [here](https://github.com/cloudposse/terraform-aws-s3-log-storage/wiki/Upgrading-to-v0.27.0-(POTENTIAL-DATA-LOSS)).
      See additional instructions for upgrading from v0.27.0 to v0.28.0 [here](https://github.com/cloudposse/terraform-aws-s3-log-storage/wiki/Upgrading-to-v0.28.0-and-AWS-provider-v4-(POTENTIAL-DATA-LOSS)).
    EOT
}

variable "lifecycle_rule_enabled" {
  type        = bool
  description = "A boolean that indicates whether the s3 log bucket lifecycle rule should be enabled."
  default     = false
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

variable "enable_glacier_transition" {
  type        = bool
  description = "Enables the transition of lb logs to AWS Glacier"
  default     = true
}

variable "glacier_transition_days" {
  type        = number
  description = "Number of days after which to move s3 logs to the glacier storage tier"
  default     = 60
}

variable "expiration_days" {
  type        = number
  description = "Number of days after which to expunge s3 logs"
  default     = 90
}

variable "noncurrent_version_expiration_days" {
  type        = number
  description = "Specifies when noncurrent s3 log versions expire"
  default     = 90
}

variable "noncurrent_version_transition_days" {
  type        = number
  description = "Specifies when noncurrent s3 log versions transition"
  default     = 30
}

variable "standard_transition_days" {
  type        = number
  description = "Number of days to persist logs in standard storage tier before moving to the infrequent access tier"
  default     = 30
}
