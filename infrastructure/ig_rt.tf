# Internet gateway
resource "aws_internet_gateway" "pc_internet_gateway" {
  vpc_id = aws_vpc.pc_vpc.id

  tags = {
    Name = "pc_igw"
  }
}

# Route Tables
resource "aws_route_table" "pc_public" {
  vpc_id = aws_vpc.pc_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pc_internet_gateway.id
  }

  tags = {
    Name = "pc_public"
  }
}