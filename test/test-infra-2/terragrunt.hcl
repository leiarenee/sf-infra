
terraform {
  source = "${get_parent_terragrunt_dir()}//test/test-infra-2"
}

include {
  path = find_in_parent_folders()
}


inputs = {
}

dependency "test1" {
  config_path = "../test-infra-1"
}