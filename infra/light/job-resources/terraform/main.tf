locals {
  job_outputs = {
    vpc_id = var.vpc_id
    private_subnets = var.private_subnets
    public_subnets = var.public_subnets
  }
}