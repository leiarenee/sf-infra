
dependency "vpc" {
  config_path = "../vpc"
    mock_outputs = {
      vpc_id = "known after apply",
      private_subnets =  ["known after apply"],
      public_subnets =  ["known after apply"]
    } 
}

dependency "cluster" {
  config_path = "../k8s-cluster"
    mock_outputs = {
      cluster_id = "known after apply",
      cluster_endpoint =  ["known after apply"]
    } 
}

dependency "alb" {
  config_path = "../alb"
    mock_outputs = {
      lb_dns_name = "known after apply"
    } 
}

dependency "db" {
  config_path = "../postgres"
    mock_outputs = {
      db_instance_endpoint = "known after apply"
    } 
}

dependency "db_sg" {
  config_path = "../postgres-sg"
    mock_outputs = {
      security_group_id = "known after apply"
    }
}

dependency "k8s_sg" {
  config_path = "../k8s-sg"
    mock_outputs = {
      id = "known after apply"
    }
}

dependency "alb_sg" {
  config_path = "../alb-sg"
    mock_outputs = {
      security_group_id = "known after apply"
    }
}

dependency "kms" {
  config_path = "../k8s-kms"
    mock_outputs = {
      arn = "known after apply"
    }
}

dependency "redis" {
  config_path = "../redis"
    mock_outputs = {
      endpoint = "known after apply"
    }
}
