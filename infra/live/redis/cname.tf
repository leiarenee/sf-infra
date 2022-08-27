resource "aws_route53_record" "cname" {
  zone_id = var.dns_zone_id
  name    = "redis"
  type    = "CNAME"
  ttl     = "5"

  records = [var.cluster_mode_enabled ? join("", aws_elasticache_replication_group.default.*.configuration_endpoint_address) : join("", aws_elasticache_replication_group.default.*.primary_endpoint_address)]
  
}

variable "dns_zone_id" {
  type = string
  description = "(optional) describe your variable"
  default = "value"
}