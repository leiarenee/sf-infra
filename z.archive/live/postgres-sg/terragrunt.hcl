
terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git//.?ref=v4.9.0"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}
inputs = {
  name        = "interview-postgress-chainlink"
  vpc_id      = dependency.vpc.outputs.vpc_id
  description = "Port 5432 for db connection within VPC"

  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL"
      cidr_blocks = dependency.vpc.outputs.vpc_cidr_block
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL"
      cidr_blocks = dependency.vpc.outputs.vpc_cidr_block
    },
  ]

}