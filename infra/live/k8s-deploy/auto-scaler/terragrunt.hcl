
locals {
  all_commands=["apply", "plan","destroy","apply-all","plan-all","destroy-all"]
}

terraform {
  source = ".//terraform"
  # Bug fix for https://github.com/cookielab/terraform-kubernetes-cluster-autoscaler-aws/issues/10
  # before_hook "before_hook_custom" {
  #   commands     = local.all_commands
  #   execute      = ["cp", "-R", "${get_parent_terragrunt_dir()}/modules/.outsource/registry/cookielab/cluster-autoscaler-aws/main.tf", ".terraform/modules/cluster_autoscaler"]
  #  }
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
 cluster_id = dependency.cluster.outputs.cluster_id
#  kubernetes_resources_labels = dependency.cluster.outputs.tags
worker_iam_role_name = dependency.cluster.outputs.eks_managed_node_groups.green.iam_role_name
}


dependency "cluster" {
  config_path = "../../k8s-cluster"

}