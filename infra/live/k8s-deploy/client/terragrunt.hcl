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
  lineage = dependency.init.outputs.lineage
  module_enabled = true
  replace_variables             = merge(local.replacements,{
    IMAGE_URL= dependency.build-client.outputs.image_repository_url
    }
  )
}

dependency "k8s-cluster" {
  config_path = "../../k8s-cluster"
  skip_outputs = true
}

dependency "namespace" {
  config_path = "../namespace"
  skip_outputs = true
}

dependency "autoscaler" {
  config_path = "../auto-scaler"
  skip_outputs = true
}

dependency "build-client" {
  config_path = "../../build-client"
}

dependency "init" {
  config_path = "../../init"
}