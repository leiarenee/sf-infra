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
  source = "tfr:///cloudposse/elasticache-redis/aws//.?version=0.42.0"
  # https://github.com/cloudposse/terraform-aws-elasticache-redis
  
  extra_arguments extra_args {
    commands = local.all_commands
    env_vars = {"k8s_dependency":false}
  }
}

inputs = {
  lineage = dependency.init.outputs.lineage
  replace_variables = merge(local.replacements,{})

  availability_zones         = dependency.vpc.outputs.azs
  vpc_id                     = dependency.vpc.outputs.vpc_id
  allowed_security_groups    = [dependency.vpc.outputs.default_security_group_id]
  subnets                    = dependency.vpc.outputs.private_subnets
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "init" {
  config_path = "../init"
}