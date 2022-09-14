output "job_resources" {
  value = jsonencode({
    job_outputs = local.job_outputs
  })
}
