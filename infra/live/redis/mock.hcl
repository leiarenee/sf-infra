dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    azs = ["known after apply"],
    vpc_id = "known after apply",
    default_security_group_id = "known after apply",
    private_subnets =  ["known after apply"]
  } 
}