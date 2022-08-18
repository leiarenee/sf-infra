locals {
  global_replacements = jsondecode(file(find_in_parent_folders("replace.json")))
  local_replacements = jsondecode(file("replace.json"))
  replacements = merge(local.global_replacements, local.local_replacements)
}

include {
 path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-vpc.git//.?ref=v3.14.0"
  extra_arguments extra_args {
    commands = get_terraform_commands_that_need_locking()
    env_vars = {"k8s_dependency":false}
  }
}

inputs = {
  replace_variables = merge(local.replacements,{})
}
