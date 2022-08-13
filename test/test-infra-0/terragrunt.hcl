
terraform {
  source = "${get_parent_terragrunt_dir()}//test/test-infra-0"
}

include {
  path = find_in_parent_folders()
}


inputs = {
}
