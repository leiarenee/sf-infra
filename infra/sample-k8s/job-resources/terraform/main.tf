locals {
  job_outputs = {
    vpc_id = var.vpc_id
    private_subnets = jsondecode(var.private_subnets)
    public_subnets = jsondecode(var.public_subnets)
    cluster_id = var.cluster_id
    cluster_endpoint = var.cluster_endpoint
    k8s_managed_node_security_group = var.k8s_managed_node_security_group
    k8s_kms_arn = var.k8s_kms_arn
  }
}