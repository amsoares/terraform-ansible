# ----- Load Balancer -----
/*resource "aws_lb" "pc_lb" {
  name = "${var.domain_name}-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups = [aws_security_group.pc_public_sg.id]
  subnets = [
    aws_subnet.pc_public1.id,
    aws_subnet.pc_public2.id
  ]

  enable_cross_zone_load_balancing = true
  idle_timeout                = 400

  tags = {
    Name = "pc_${var.domain_name}-alb"
  }
}*/

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name = "my-alb"

  load_balancer_type = "application"

  vpc_id             = aws_vpc.pc_vpc.id
  subnets            = [aws_subnet.pc_public1.id, aws_subnet.pc_public2.id]
  security_groups    = [aws_security_group.pc_public_sg.id]

  target_groups = [
    {
      name_prefix      = "default"
      backend_protocol = "HTTP"
      backend_port     = 80
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

  tags = {
    Environment = "Test"
  }
}