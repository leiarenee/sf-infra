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
  source = "tfr:///terraform-aws-modules/alb/aws//.?version=v6.10.0"
  # https://github.com/terraform-aws-modules/terraform-aws-alb
  
  extra_arguments extra_args {
    commands = local.all_commands
    env_vars = {"k8s_dependency":false}
  }
}

inputs = {
  replace_variables = merge(local.replacements,{})

  vpc_id       = dependency.vpc.outputs.vpc_id
  subnets      = dependency.vpc.outputs.public_subnets
  security_groups = [dependency.alb_sg.outputs.security_group_id]
}

dependency "vpc" {
  config_path = "../vpc"
    mock_outputs = {
      vpc_id = "known after apply"
      public_subnets = ["known after apply"]
  } 
}

dependency "alb_sg" {
  config_path = "../alb-sg"
    mock_outputs = {
      security_group_id = "known after apply"
  } 
}

