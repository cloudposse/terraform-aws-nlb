output "nlb_name" {
  description = "The ARN suffix of the NLB"
  value       = join("", aws_lb.default[*].name)
}

output "nlb_arn" {
  description = "The ARN of the NLB"
  value       = join("", aws_lb.default[*].arn)
}

output "nlb_arn_suffix" {
  description = "The ARN suffix of the NLB"
  value       = join("", aws_lb.default[*].arn_suffix)
}

output "nlb_dns_name" {
  description = "DNS name of NLB"
  value       = join("", aws_lb.default[*].dns_name)
}

output "nlb_zone_id" {
  description = "The ID of the zone which NLB is provisioned"
  value       = join("", aws_lb.default[*].zone_id)
}

output "default_target_group_arn" {
  description = "The default target group ARN"
  value       = join("", aws_lb_target_group.default[*].arn)
}

output "default_listener_arn" {
  description = "The ARN of the default listener"
  value       = join("", aws_lb_listener.default[*].arn)
}

output "tls_listener_arn" {
  description = "The ARN of the TLS listener"
  value       = join("", aws_lb_listener.tls[*].arn)
}

output "listener_arns" {
  description = "A list of all the listener ARNs"
  value = compact(
    concat(aws_lb_listener.default[*].arn, aws_lb_listener.tls[*].arn)
  )
}

output "access_logs_bucket_id" {
  description = "The S3 bucket ID for access logs"
  value       = module.access_logs.bucket_id
}
