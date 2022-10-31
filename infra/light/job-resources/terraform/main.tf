locals {
  job_outputs = {
    vpc_id = var.vpc_id
    private_subnets = jsondecode(var.private_subnets)
    public_subnets = jsondecode(var.public_subnets)
  }
}