
terraform {
  source = "git::https://github.com/cloudposse/terraform-aws-elasticache-redis.git//.?ref=0.42.0"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  availability_zones         = dependency.vpc.outputs.azs
  namespace                  = "redis"
  stage                      = "prod"
  name                       = "interview"
  vpc_id                     = dependency.vpc.outputs.vpc_id
  allowed_security_groups    = [dependency.vpc.outputs.default_security_group_id]
  subnets                    = dependency.vpc.outputs.private_subnets
  cluster_size               = 1
  instance_type              = "cache.t2.micro"
  apply_immediately          = true
  engine_version             = "4.0.10"
  family                     = "redis4.0"
  at_rest_encryption_enabled = false
  transit_encryption_enabled = true
}
