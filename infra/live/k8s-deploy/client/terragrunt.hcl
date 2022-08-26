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
    env_vars = {"k8s_dependency":true}
  }
}

inputs = {
  module_enabled = true
  replace_variables             = merge(local.replacements,{
    IMAGE_URL="${dependency.build-client.outputs.repository_url}:${local.local_replacements.IMAGE_TAG}"
    }
  )
}

dependency "k8s-cluster" {
  config_path = "../../k8s-cluster"
}

dependency "namespace" {
  config_path = "../namespace"
}

dependency "build-client" {
  config_path = "../../build-client"
}