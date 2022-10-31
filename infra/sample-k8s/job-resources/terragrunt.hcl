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

  vpc_id = dependency.vpc.outputs.vpc_id
  private_subnets = dependency.vpc.outputs.private_subnets
  public_subnets = dependency.vpc.outputs.public_subnets
  cluster_id = dependency.cluster.outputs.cluster_id
  cluster_endpoint = dependency.cluster.outputs.cluster_endpoint
  k8s_managed_node_security_group = dependency.k8s_sg.outputs.id
  k8s_kms_arn = dependency.kms.outputs.arn
  
}

dependency "init" {
  config_path = "../init"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "cluster" {
  config_path = "../k8s-cluster"
}

dependency "k8s_sg" {
  config_path = "../k8s-sg"
}

dependency "kms" {
  config_path = "../k8s-kms"
}
