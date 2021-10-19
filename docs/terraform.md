<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 1.3 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_access_logs"></a> [access\_logs](#module\_access\_logs) | cloudposse/lb-s3-bucket/aws | 0.12.0 |
| <a name="module_default_target_group_label"></a> [default\_target\_group\_label](#module\_default\_target\_group\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.24.1 |

## Resources

| Name | Type |
|------|------|
| [aws_lb.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.tls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs_enabled"></a> [access\_logs\_enabled](#input\_access\_logs\_enabled) | A boolean flag to enable/disable access\_logs | `bool` | `true` | no |
| <a name="input_access_logs_prefix"></a> [access\_logs\_prefix](#input\_access\_logs\_prefix) | The S3 log bucket prefix | `string` | `""` | no |
| <a name="input_access_logs_s3_bucket_id"></a> [access\_logs\_s3\_bucket\_id](#input\_access\_logs\_s3\_bucket\_id) | An external S3 Bucket name to store access logs in. If specified, no logging bucket will be created. | `string` | `null` | no |
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional tags for appending to tags\_as\_list\_of\_maps. Not added to `tags`. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | The ARN of the default SSL certificate for HTTPS listener | `string` | `""` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_cross_zone_load_balancing_enabled"></a> [cross\_zone\_load\_balancing\_enabled](#input\_cross\_zone\_load\_balancing\_enabled) | A boolean flag to enable/disable cross zone load balancing | `bool` | `true` | no |
| <a name="input_deletion_protection_enabled"></a> [deletion\_protection\_enabled](#input\_deletion\_protection\_enabled) | A boolean flag to enable/disable deletion protection for NLB | `bool` | `false` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_deregistration_delay"></a> [deregistration\_delay](#input\_deregistration\_delay) | The amount of time to wait in seconds before changing the state of a deregistering target to unused | `number` | `15` | no |
| <a name="input_enable_glacier_transition"></a> [enable\_glacier\_transition](#input\_enable\_glacier\_transition) | Enables the transition of lb logs to AWS Glacier | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_expiration_days"></a> [expiration\_days](#input\_expiration\_days) | Number of days after which to expunge s3 logs | `number` | `90` | no |
| <a name="input_glacier_transition_days"></a> [glacier\_transition\_days](#input\_glacier\_transition\_days) | Number of days after which to move s3 logs to the glacier storage tier | `number` | `60` | no |
| <a name="input_health_check_enabled"></a> [health\_check\_enabled](#input\_health\_check\_enabled) | A boolean flag to enable/disable the NLB health checks | `bool` | `true` | no |
| <a name="input_health_check_interval"></a> [health\_check\_interval](#input\_health\_check\_interval) | The duration in seconds in between health checks | `number` | `10` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | The destination for the health check request | `string` | `"/"` | no |
| <a name="input_health_check_port"></a> [health\_check\_port](#input\_health\_check\_port) | The port to send the health check request to (defaults to `traffic-port`) | `number` | `null` | no |
| <a name="input_health_check_protocol"></a> [health\_check\_protocol](#input\_health\_check\_protocol) | The protocol to use for the health check request | `string` | `null` | no |
| <a name="input_health_check_threshold"></a> [health\_check\_threshold](#input\_health\_check\_threshold) | The number of consecutive health checks successes required before considering an unhealthy target healthy, or failures required before considering a health target unhealthy | `number` | `2` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | A boolean flag to determine whether the NLB should be internal | `bool` | `false` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` and `dualstack`. | `string` | `"ipv4"` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | The letter case of label keys (`tag` names) (i.e. `name`, `namespace`, `environment`, `stage`, `attributes`) to use in `tags`.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The naming order of the id output and Name tag.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | The letter case of output label values (also used in `tags` and `id`).<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_lifecycle_rule_enabled"></a> [lifecycle\_rule\_enabled](#input\_lifecycle\_rule\_enabled) | A boolean that indicates whether the s3 log bucket lifecycle rule should be enabled. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Solution name, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| <a name="input_nlb_access_logs_s3_bucket_force_destroy"></a> [nlb\_access\_logs\_s3\_bucket\_force\_destroy](#input\_nlb\_access\_logs\_s3\_bucket\_force\_destroy) | A boolean that indicates all objects should be deleted from the NLB access logs S3 bucket so that the bucket can be destroyed without error | `bool` | `false` | no |
| <a name="input_noncurrent_version_expiration_days"></a> [noncurrent\_version\_expiration\_days](#input\_noncurrent\_version\_expiration\_days) | Specifies when noncurrent s3 log versions expire | `number` | `90` | no |
| <a name="input_noncurrent_version_transition_days"></a> [noncurrent\_version\_transition\_days](#input\_noncurrent\_version\_transition\_days) | Specifies when noncurrent s3 log versions transition | `number` | `30` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_standard_transition_days"></a> [standard\_transition\_days](#input\_standard\_transition\_days) | Number of days to persist logs in standard storage tier before moving to the infrequent access tier | `number` | `30` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs to associate with NLB | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| <a name="input_target_group_additional_tags"></a> [target\_group\_additional\_tags](#input\_target\_group\_additional\_tags) | The additional tags to apply to the default target group | `map(string)` | `{}` | no |
| <a name="input_target_group_name"></a> [target\_group\_name](#input\_target\_group\_name) | The name for the default target group, uses a module label name if left empty | `string` | `""` | no |
| <a name="input_target_group_port"></a> [target\_group\_port](#input\_target\_group\_port) | The port for the default target group | `number` | `80` | no |
| <a name="input_target_group_target_type"></a> [target\_group\_target\_type](#input\_target\_group\_target\_type) | The type (`instance`, `ip` or `lambda`) of targets that can be registered with the default target group | `string` | `"ip"` | no |
| <a name="input_tcp_enabled"></a> [tcp\_enabled](#input\_tcp\_enabled) | A boolean flag to enable/disable TCP listener | `bool` | `true` | no |
| <a name="input_tcp_port"></a> [tcp\_port](#input\_tcp\_port) | The port for the TCP listener | `number` | `80` | no |
| <a name="input_tls_enabled"></a> [tls\_enabled](#input\_tls\_enabled) | A boolean flag to enable/disable TLS listener | `bool` | `false` | no |
| <a name="input_tls_port"></a> [tls\_port](#input\_tls\_port) | The port for the TLS listener | `number` | `443` | no |
| <a name="input_tls_ssl_policy"></a> [tls\_ssl\_policy](#input\_tls\_ssl\_policy) | The name of the SSL Policy for the listener | `string` | `"ELBSecurityPolicy-2016-08"` | no |
| <a name="input_udp_enabled"></a> [udp\_enabled](#input\_udp\_enabled) | A boolean flag to enable/disable UDP listener | `bool` | `false` | no |
| <a name="input_udp_port"></a> [udp\_port](#input\_udp\_port) | The port for the UDP listener | `number` | `53` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID to associate with NLB | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_logs_bucket_id"></a> [access\_logs\_bucket\_id](#output\_access\_logs\_bucket\_id) | The S3 bucket ID for access logs |
| <a name="output_default_listener_arn"></a> [default\_listener\_arn](#output\_default\_listener\_arn) | The ARN of the default listener |
| <a name="output_default_target_group_arn"></a> [default\_target\_group\_arn](#output\_default\_target\_group\_arn) | The default target group ARN |
| <a name="output_listener_arns"></a> [listener\_arns](#output\_listener\_arns) | A list of all the listener ARNs |
| <a name="output_nlb_arn"></a> [nlb\_arn](#output\_nlb\_arn) | The ARN of the NLB |
| <a name="output_nlb_arn_suffix"></a> [nlb\_arn\_suffix](#output\_nlb\_arn\_suffix) | The ARN suffix of the NLB |
| <a name="output_nlb_dns_name"></a> [nlb\_dns\_name](#output\_nlb\_dns\_name) | DNS name of NLB |
| <a name="output_nlb_name"></a> [nlb\_name](#output\_nlb\_name) | The ARN suffix of the NLB |
| <a name="output_nlb_zone_id"></a> [nlb\_zone\_id](#output\_nlb\_zone\_id) | The ID of the zone which NLB is provisioned |
| <a name="output_tls_listener_arn"></a> [tls\_listener\_arn](#output\_tls\_listener\_arn) | The ARN of the TLS listener |
<!-- markdownlint-restore -->
