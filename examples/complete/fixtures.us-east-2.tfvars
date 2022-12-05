region = "us-east-2"

availability_zones = ["us-east-2a", "us-east-2b"]

namespace = "eg"

stage = "test"

name = "nlb"

vpc_cidr_block = "172.16.0.0/16"

internal = false

tcp_enabled = true

access_logs_enabled = true

nlb_access_logs_s3_bucket_force_destroy_enabled = true

cross_zone_load_balancing_enabled = false

ip_address_type = "ipv4"

deletion_protection_enabled = false

deregistration_delay = 15

health_check_threshold = 2

health_check_interval = 10

health_check_protocol = "HTTP"

target_group_port = 80

target_group_target_type = "ip"
