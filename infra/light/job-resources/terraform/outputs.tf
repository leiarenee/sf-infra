output "job_resources" {
  value = jsonencode({
    job_outputs = local.job_outputs
  })
}

output "vpc_id" {value=local.job_outputs.vpc_id}
output "private_subnets" {value=local.job_outputs.private_subnets}
output "public_subnets" {value=local.job_outputs.public_subnets}
