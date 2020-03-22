# ----- VPC -----
resource "aws_vpc" "pc_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "pc_vpc"
  }
}