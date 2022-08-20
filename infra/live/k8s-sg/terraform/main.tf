resource "aws_security_group" "k8s_managed_node_group_additional" {
  name_prefix = var.nameprefix
  vpc_id      = var.vpc_id

  ingress {
    from_port = var.ingress.from_port
    to_port   = var.ingress.to_port
    protocol  = var.ingress.protocol
    cidr_blocks = var.ingress.cidr_blocks
  }

  tags = var.tags

}
