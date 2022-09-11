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
  source = ".//terraform"
  extra_arguments extra_args {
    commands = local.all_commands
    env_vars = {"k8s_dependency":false}
  }
}

inputs = {
  replace_variables = merge(local.replacements,{})
  lineage = dependency.init.outputs.lineage

  client_repository_url = dependency.ecr-client.outputs.repository_url
  server_repository_url = dependency.ecr-server.outputs.repository_url
  
}

dependency "init" {
  config_path = "../init"
}

dependency "ecr-client" {
  config_path = "../ecr-client"
}

dependency "ecr-server" {
  config_path = "../ecr-server"
}

