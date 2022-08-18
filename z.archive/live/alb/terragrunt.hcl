
terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-alb.git//.?ref=v6.10.0"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "alb_sg" {
  config_path = "../alb-sg"
}

inputs = {
  name = "interview-chainlink"
  
  load_balancer_type = "application"

  vpc_id       = dependency.vpc.outputs.vpc_id
  subnets      = dependency.vpc.outputs.public_subnets
  idle_timeout = 300

  security_groups = [dependency.alb_sg.outputs.security_group_id]

  target_groups = [
    {
      name_prefix      = "iw"
      backend_protocol = "HTTP"
      backend_port     = 8080
      target_type      = "instance"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}
