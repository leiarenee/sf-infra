
terraform {
  source = "${get_parent_terragrunt_dir()}/test/main.tf"
}

include {
  path = find_in_parent_folders()
}


inputs = {
}
