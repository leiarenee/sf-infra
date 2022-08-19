locals {
  global_replacements = jsondecode(file(find_in_parent_folders("replace.json")))
  local_replacements = jsondecode(file("replace.json"))
  replacements = merge(local.global_replacements, local.local_replacements)
  inputs =  jsondecode(file("inputs.tfvars.json"))
  all_commands = ["apply", "plan","destroy","apply-all","plan-all","destroy-all","init","init-all"]
}

include {
 path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git//.?ref=v4.9.0"
  extra_arguments extra_args {
    commands = local.all_commands
    env_vars = {"k8s_dependency":false}

  }
}

inputs = {
  replace_variables = merge(local.replacements,{})

  vpc_id      = dependency.vpc.outputs.vpc_id
  
  ingress_with_cidr_blocks = [merge(local.inputs.ingress_with_cidr_blocks_pass[0],{
    cidr_blocks = dependency.vpc.outputs.vpc_cidr_block
  })]

  egress_with_cidr_blocks = [merge(local.inputs.egress_with_cidr_blocks_pass[0],{
    cidr_blocks = dependency.vpc.outputs.vpc_cidr_block
  })]

  subnet_ids                = dependency.vpc.outputs.public_subnets
}

dependency "vpc" {
  config_path = "../vpc"
}

