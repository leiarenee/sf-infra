# To suppress warning
variable "ingress_with_cidr_blocks_pass" {
  default = []
  type = list
}

variable "egress_with_cidr_blocks_pass" {
  default = []
  type = list
}

variable "subnet_ids" {
  type = list
  default = []
}


resource "aws_db_subnet_group" "rds_public" {
  name        = "db_subnet_group"
  description = "DB Subnet group for RDS instance"
  subnet_ids  = var.subnet_ids
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.rds_public.id
}
