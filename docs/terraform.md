## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 2.0 |
| local | ~> 1.3 |
| null | ~> 2.0 |
| template | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_logs\_enabled | A boolean flag to enable/disable access\_logs | `bool` | `true` | no |
| access\_logs\_prefix | The S3 log bucket prefix | `string` | `""` | no |
| access\_logs\_region | The region for the access\_logs S3 bucket | `string` | `"us-east-1"` | no |
| attributes | Additional attributes (\_e.g.\_ "1") | `list(string)` | `[]` | no |
| certificate\_arn | The ARN of the default SSL certificate for HTTPS listener | `string` | `""` | no |
| cross\_zone\_load\_balancing\_enabled | A boolean flag to enable/disable cross zone load balancing | `bool` | `true` | no |
| deletion\_protection\_enabled | A boolean flag to enable/disable deletion protection for NLB | `bool` | `false` | no |
| delimiter | Delimiter between `namespace`, `stage`, `name` and `attributes` | `string` | `"-"` | no |
| deregistration\_delay | The amount of time to wait in seconds before changing the state of a deregistering target to unused | `number` | `15` | no |
| enable\_glacier\_transition | Enables the transition of lb logs to AWS Glacier | `bool` | `true` | no |
| expiration\_days | Number of days after which to expunge s3 logs | `number` | `90` | no |
| glacier\_transition\_days | Number of days after which to move s3 logs to the glacier storage tier | `number` | `60` | no |
| health\_check\_enabled | A boolean flag to enable/disable the NLB health checks | `bool` | `true` | no |
| health\_check\_interval | The duration in seconds in between health checks | `number` | `15` | no |
| health\_check\_path | The destination for the health check request | `string` | `"/"` | no |
| health\_check\_port | The port to send the health check request to (defaults to `traffic-port`) | `number` | `null` | no |
| health\_check\_protocol | The protocol to use for the health check request | `string` | `null` | no |
| health\_check\_threshold | The number of consecutive health checks successes required before considering an unhealthy target healthy, or failures required before considering a health target unhealthy | `number` | `2` | no |
| internal | A boolean flag to determine whether the NLB should be internal | `bool` | `false` | no |
| ip\_address\_type | The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` and `dualstack`. | `string` | `"ipv4"` | no |
| lifecycle\_rule\_enabled | A boolean that indicates whether the s3 log bucket lifecycle rule should be enabled. | `bool` | `false` | no |
| name | Name of the application | `string` | n/a | yes |
| namespace | Namespace (e.g. `eg` or `cp`) | `string` | `""` | no |
| nlb\_access\_logs\_s3\_bucket\_force\_destroy | A boolean that indicates all objects should be deleted from the NLB access logs S3 bucket so that the bucket can be destroyed without error | `bool` | `false` | no |
| noncurrent\_version\_expiration\_days | Specifies when noncurrent s3 log versions expire | `number` | `90` | no |
| noncurrent\_version\_transition\_days | Specifies when noncurrent s3 log versions transition | `number` | `30` | no |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | `string` | `""` | no |
| standard\_transition\_days | Number of days to persist logs in standard storage tier before moving to the infrequent access tier | `number` | `30` | no |
| subnet\_ids | A list of subnet IDs to associate with NLB | `list(string)` | n/a | yes |
| tags | Additional tags (\_e.g.\_ { BusinessUnit : ABC }) | `map(string)` | `{}` | no |
| target\_group\_additional\_tags | The additional tags to apply to the default target group | `map(string)` | `{}` | no |
| target\_group\_name | The name for the default target group, uses a module label name if left empty | `string` | `""` | no |
| target\_group\_port | The port for the default target group | `number` | `80` | no |
| target\_group\_target\_type | The type (`instance`, `ip` or `lambda`) of targets that can be registered with the default target group | `string` | `"ip"` | no |
| tcp\_enabled | A boolean flag to enable/disable TCP listener | `bool` | `true` | no |
| tcp\_port | The port for the TCP listener | `number` | `80` | no |
| tls\_enabled | A boolean flag to enable/disable TLS listener | `bool` | `false` | no |
| tls\_port | The port for the TLS listener | `number` | `443` | no |
| tls\_ssl\_policy | The name of the SSL Policy for the listener | `string` | `"ELBSecurityPolicy-2016-08"` | no |
| udp\_enabled | A boolean flag to enable/disable UDP listener | `bool` | `false` | no |
| udp\_port | The port for the UDP listener | `number` | `53` | no |
| vpc\_id | VPC ID to associate with NLB | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| access\_logs\_bucket\_id | The S3 bucket ID for access logs |
| default\_listener\_arn | The ARN of the default listener |
| default\_target\_group\_arn | The default target group ARN |
| listener\_arns | A list of all the listener ARNs |
| nlb\_arn | The ARN of the NLB |
| nlb\_arn\_suffix | The ARN suffix of the NLB |
| nlb\_dns\_name | DNS name of NLB |
| nlb\_name | The ARN suffix of the NLB |
| nlb\_zone\_id | The ID of the zone which NLB is provisioned |
| tls\_listener\_arn | The ARN of the TLS listener |

