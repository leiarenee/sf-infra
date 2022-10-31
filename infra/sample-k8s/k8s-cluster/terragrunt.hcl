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
  source = "tfr:///terraform-aws-modules/eks/aws//.?version=18.28.0"
  # https://github.com/terraform-aws-modules/terraform-aws-eks
  
  extra_arguments extra_args {
    commands = local.all_commands
    env_vars = {"k8s_dependency":false}
  }
  after_hook "after_hook_1" {
    commands     = ["apply"]
    execute      = ["bash","-c","aws --profile ${get_env("TARGET_AWS_PROFILE","default")} eks update-kubeconfig --name ${get_env("CLUSTER","")}"]
   }
}

inputs = {
  replace_variables = merge(local.replacements,{})
  lineage = dependency.init.outputs.lineage
  
  # VPC
  vpc_id     = dependency.vpc.outputs.vpc_id,
  subnet_ids = dependency.vpc.outputs.private_subnets,

  # KMS
  cluster_encryption_config = [{
    provider_key_arn = dependency.kms.outputs.arn,
    resources        : ["secrets"]
  }]

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = merge(local.inputs.eks_managed_node_group_defaults,
    {vpc_security_group_ids                = [dependency.sg.outputs.id]})

}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "sg" {
  config_path = "../k8s-sg"
}

dependency "kms" {
  config_path = "../k8s-kms"
}

dependency "init" {
  config_path = "../init"
}