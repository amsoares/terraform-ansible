#Subnets
#CIDR - Classless Inter-Domain Routing

resource "aws_subnet" "pc_public1" {
  vpc_id                  = aws_vpc.pc_vpc.id
  cidr_block              = var.cidrs["public1"]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "pc_public1"
  }
}

resource "aws_subnet" "pc_public2" {
  vpc_id                  = aws_vpc.pc_vpc.id
  cidr_block              = var.cidrs["public2"]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "pc_public2"
  }
}

#Subnet Associations

resource "aws_route_table_association" "pc_public1_assoc" {
  subnet_id      = aws_subnet.pc_public1.id
  route_table_id = aws_route_table.pc_public.id
}

resource "aws_route_table_association" "pc_public2_assoc" {
  subnet_id      = aws_subnet.pc_public2.id
  route_table_id = aws_route_table.pc_public.id
}