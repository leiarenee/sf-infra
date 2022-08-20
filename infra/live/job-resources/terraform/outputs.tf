output "job_resources" {
  value = jsonencode({
    job_outputs = local.job_outputs
  })
}

output "vpc_id" {value=local.job_outputs.vpc_id}
output "private_subnets" {value=local.job_outputs.private_subnets}
output "public_subnets" {value=local.job_outputs.public_subnets}
output "cluster_id" {value=local.job_outputs.cluster_id}
output "cluster_endpoint" {value=local.job_outputs.cluster_endpoint}
output "redis_enpoint" {value=local.job_outputs.redis_enpoint}
output "postgres_endpoint" {value=local.job_outputs.postgres_endpoint}
output "alb_dns_name" {value=local.job_outputs.alb_dns_name}
output "postgres_security_group" {value=local.job_outputs.postgres_security_group}
output "k8s_managed_node_security_group" {value=local.job_outputs.k8s_managed_node_security_group}
output "alb_security_group" {value=local.job_outputs.alb_security_group}
output "k8s_kms_arn" {value=local.job_outputs.k8s_kms_arn}