dependency "vpc" {
  config_path = "../vpc"
    mock_outputs = {

  } 
}

dependency "postgres_password" {
  config_path = "../postgres-password"
    mock_outputs = {
      password = "known after apply"
    } 
}

dependency "postgres_sg" {
  config_path = "../postgres-sg"
    mock_outputs = {
      security_group_id = "known after apply"
      db_subnet_group_name = "known after apply"
    } 
}
