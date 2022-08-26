locals {
  module_output = module.deploy.output_data

  deployment_output = var.module_enabled ? local.module_output["${var.application_name}:folders.${var.source_folder}:${var.source_folder}/deployment.yml:00"].deployment : null 
  internal_service_output = var.module_enabled ? local.module_output["${var.application_name}:folders.${var.source_folder}:${var.source_folder}/deployment.yml:01"].service : null 
  external_service_output = var.module_enabled ? local.module_output["${var.application_name}:folders.${var.source_folder}:${var.source_folder}/deployment.yml:02"].service : null 
}

module "deploy" {
  source = "./deploy-yaml"
  namespace = var.namespace
  application_name = var.application_name
  source_folder = var.source_folder
  module_enabled = var.module_enabled

}

resource "null_resource" "health_check" {
  count = var.health_check_enabled ? 1 : 0
  triggers = {
    value = timestamp()
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command = "scripts/health-check.sh ${var.host} ${var.port} ${var.health_check_timeout}"
  }
}

resource "aws_route53_record" "cname" {
  count   = var.expose_external && var.assign_cname && var.module_enabled ? 1 : 0
  zone_id = var.dns_zone_id
  name    = var.cname
  type    = "CNAME"
  ttl     = "5"

  records = [local.external_service_output.status.0.load_balancer.0.ingress.0.hostname]
  
}