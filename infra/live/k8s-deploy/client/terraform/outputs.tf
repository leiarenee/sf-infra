# Input Data
output "input_data" {
  value = var.module_enabled && var.raw_outputs ? module.deploy.input_data : null
}

# Deployment
output "output_data" {
  value = var.module_enabled && var.raw_outputs ? module.deploy.output_data : null
}

# Internal Service
output "internal_service_cluster_ip" {
  value = var.module_enabled ? local.internal_service_output.spec.clusterIp : null
}

output "internal_service_target_port" {
  value = var.module_enabled ? local.internal_service_output.spec_port.targetPort : null
}

output "internal_service_service_name" {
  value = var.module_enabled ? local.internal_service_output.metadata.name : null
}

# External Service

output "expose_external" {
  value = var.module_enabled ? ( var.expose_external ? var.expose_external : null ) : null
}

output "loadBalancerIngress" {
  value = var.module_enabled ? ( var.expose_external ? local.external_service_output.status.0.load_balancer.0.ingress.0.hostname : null) : null
}

output "node_port" {
  value = var.module_enabled ? ( var.expose_external ? local.external_service_output.spec_port.nodePort : null ) : null
}

output "cname" {
  value = var.module_enabled ? ( var.expose_external && var.assign_cname ? join("",aws_route53_record.cname[*].name) : null ) : null
}




