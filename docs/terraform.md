## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access_logs_enabled | A boolean flag to enable/disable access_logs | bool | `true` | no |
| access_logs_prefix | The S3 log bucket prefix | string | `` | no |
| access_logs_region | The region for the access_logs S3 bucket | string | `us-east-1` | no |
| attributes | Additional attributes (_e.g._ "1") | list(string) | `<list>` | no |
| certificate_arn | The ARN of the default SSL certificate for HTTPS listener | string | `` | no |
| cross_zone_load_balancing_enabled | A boolean flag to enable/disable cross zone load balancing | bool | `true` | no |
| deletion_protection_enabled | A boolean flag to enable/disable deletion protection for NLB | bool | `false` | no |
| delimiter | Delimiter between `namespace`, `stage`, `name` and `attributes` | string | `-` | no |
| deregistration_delay | The amount of time to wait in seconds before changing the state of a deregistering target to unused | number | `15` | no |
| health_check_enabled | A boolean flag to enable/disable the NLB health checks | bool | `true` | no |
| health_check_interval | The duration in seconds in between health checks | number | `15` | no |
| health_check_path | The destination for the health check request | string | `/` | no |
| health_check_port | The port to send the health check request to (defaults to `traffic-port`) | number | `null` | no |
| health_check_protocol | The protocol to use for the health check request | string | `null` | no |
| health_check_threshold | The number of consecutive health checks successes required before considering an unhealthy target healthy, or failures required before considering a health target unhealthy | number | `2` | no |
| internal | A boolean flag to determine whether the NLB should be internal | bool | `false` | no |
| ip_address_type | The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` and `dualstack`. | string | `ipv4` | no |
| name | Name of the application | string | - | yes |
| namespace | Namespace (e.g. `eg` or `cp`) | string | `` | no |
| nlb_access_logs_s3_bucket_force_destroy | A boolean that indicates all objects should be deleted from the NLB access logs S3 bucket so that the bucket can be destroyed without error | bool | `false` | no |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | `` | no |
| subnet_ids | A list of subnet IDs to associate with NLB | list(string) | - | yes |
| tags | Additional tags (_e.g._ { BusinessUnit : ABC }) | map(string) | `<map>` | no |
| target_group_additional_tags | The additional tags to apply to the default target group | map(string) | `<map>` | no |
| target_group_name | The name for the default target group, uses a module label name if left empty | string | `` | no |
| target_group_port | The port for the default target group | number | `80` | no |
| target_group_target_type | The type (`instance`, `ip` or `lambda`) of targets that can be registered with the default target group | string | `ip` | no |
| tcp_enabled | A boolean flag to enable/disable TCP listener | bool | `true` | no |
| tcp_port | The port for the TCP listener | number | `80` | no |
| tls_enabled | A boolean flag to enable/disable TLS listener | bool | `false` | no |
| tls_port | The port for the TLS listener | number | `443` | no |
| tls_ssl_policy | The name of the SSL Policy for the listener | string | `ELBSecurityPolicy-2016-08` | no |
| udp_enabled | A boolean flag to enable/disable UDP listener | bool | `false` | no |
| udp_port | The port for the UDP listener | number | `53` | no |
| vpc_id | VPC ID to associate with NLB | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| access_logs_bucket_id | The S3 bucket ID for access logs |
| default_listener_arn | The ARN of the default listener |
| default_target_group_arn | The default target group ARN |
| listener_arns | A list of all the listener ARNs |
| nlb_arn | The ARN of the NLB |
| nlb_arn_suffix | The ARN suffix of the NLB |
| nlb_dns_name | DNS name of NLB |
| nlb_name | The ARN suffix of the NLB |
| nlb_zone_id | The ID of the zone which NLB is provisioned |
| tls_listener_arn | The ARN of the TLS listener |

