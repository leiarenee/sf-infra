locals {
  global_replacements = jsondecode(file(find_in_parent_folders("replace.json")))
  local_replacements = jsondecode(file("replace.json"))
  replacements = merge(local.global_replacements, local.local_replacements)
  inputs =  jsondecode(file("inputs.tfvars.json"))
  all_commands = ["apply", "plan","destroy","apply-all","plan-all","destroy-all","init","init-all"]
}

terraform {
  source = "${get_parent_terragrunt_dir()}//test/job-resources"
  extra_arguments extra_args {
    commands = local.all_commands
    env_vars = {"k8s_dependency":false}
  }
}

include {
  path = find_in_parent_folders()
}


inputs = {
}

dependency "test2" {
  config_path = "../test-infra-2"
  skip_outputs=true
}
