dependency "vpc" {
  config_path = "../vpc"
    mock_outputs = {
      vpc_id = "known after apply"
      public_subnets = ["known after apply"]
  } 
}

dependency "alb_sg" {
  config_path = "../alb-sg"
    mock_outputs = {
      security_group_id = "known after apply"
  } 
}