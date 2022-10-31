dependency "vpc" {
  config_path = "../vpc"
    mock_outputs = {
      vpc_id = "known after apply",
      private_subnets =  ["known after apply"]
  } 
}

dependency "sg" {
  config_path = "../k8s-sg"
    mock_outputs = {
      id = "known after apply"
  } 
}

dependency "kms" {
  config_path = "../k8s-kms"
    mock_outputs = {
      arn = "known after apply"
  } 
}
