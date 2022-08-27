resource "aws_route53_record" "cname" {
  zone_id = var.dns_zone_id
  name    = "postgres"
  type    = "CNAME"
  ttl     = "5"

  records = [module.db_instance.db_instance_address]
  
}

variable "dns_zone_id" {
  type = string
  description = "(optional) describe your variable"
  default = "value"
}