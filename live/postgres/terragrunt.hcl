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
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-rds.git//.?ref=v5.0.3"
  extra_arguments extra_args {
    commands = local.all_commands
    env_vars = {"k8s_dependency":false}
  }
}

inputs = {
  replace_variables = merge(local.replacements,{})

  password                  = dependency.postgres_password.outputs.password
  vpc_security_group_ids    = [dependency.postgres_sg.outputs.security_group_id]
  db_subnet_group_name      = dependency.postgres_sg.outputs.db_subnet_group_name
  

}

dependency "vpc" {
  config_path = "../vpc"
    mock_outputs = {

  } 
}

dependency "postgres_password" {
  config_path = "../postgres-password"
    mock_outputs = {
      password = "known after apply"
    } 
}

dependency "postgres_sg" {
  config_path = "../postgres-sg"
    mock_outputs = {
      security_group_id = "known after apply"
      db_subnet_group_name = "known after apply"
    } 
}
