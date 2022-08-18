
terraform {
  source = "${get_parent_terragrunt_dir()}//test/job-resources"
}

include {
  path = find_in_parent_folders()
}


inputs = {
}


