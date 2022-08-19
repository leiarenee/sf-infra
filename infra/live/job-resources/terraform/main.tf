locals {
  job_outputs = {
    vpc_id = var.vpc_id
    private_subnets = var.private_subnets
    public_subnets = var.public_subnets
    cluster_id = var.cluster_id
    cluster_endpoint = var.cluster_endpoint
    redis_enpoint = var.redis_enpoint
    postgres_endpoint = var.postgres_endpoint
    alb_dns_name = var.alb_dns_name
    postgres_security_group = var.postgres_security_group
    k8s_managed_node_security_group = var.k8s_managed_node_security_group
    alb_security_group = var.alb_security_group
    k8s_kms_arn = var.k8s_kms_arn
  }
}