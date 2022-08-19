
terraform {
  source = "${get_parent_terragrunt_dir()}//test/test-infra-2"
}

include {
  path = find_in_parent_folders()
}


inputs = {
}

dependencies {
  paths = ["../test-infra-1","../test-infra-0"]
}