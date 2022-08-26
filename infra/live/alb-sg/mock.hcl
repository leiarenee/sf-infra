dependency "vpc" {
  config_path = "../vpc"
    mock_outputs = {
      vpc_id = "known after apply"
  } 
}