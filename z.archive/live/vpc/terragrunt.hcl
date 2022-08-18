terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-vpc.git//.?ref=v3.14.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "interview-chainlink"

  cidr = "10.99.0.0/18"

  azs              = ["us-west-2a", "us-west-2b", "us-west-2c"]
  public_subnets   = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
  private_subnets  = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]
  database_subnets = ["10.99.7.0/24", "10.99.8.0/24", "10.99.9.0/24"]

  create_database_subnet_group       = true
  create_database_subnet_route_table = true

  enable_dns_support   = true
  enable_dns_hostnames = true

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    "environment" = "interview-chainlink"
  }

  private_subnet_tags = {
    "scope" = "private"
  }

  public_subnet_tags = {
    "scope" = "public"
  }
}