# ----- ASG -----
module "asg"  {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"

  name = "pc_asg"

  # Launch configuration
  lc_name = "pc_example-lc"

  image_id        = var.ec2_ami
  instance_type   = var.ec2_instance_type
  security_groups = [aws_security_group.pc_public_sg.id]
  key_name        = aws_key_pair.pc_auth.id
  user_data       = data.template_file.installnginx.rendered

  # Auto scaling group
  asg_name                  = "pc_example-asg"
  vpc_zone_identifier       = [aws_subnet.pc_public1.id, aws_subnet.pc_public2.id]
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
  ]

  tags_as_map = {
    extra_tag1 = "extra_value1"
    extra_tag2 = "extra_value2"
  }

}

data "template_file" "installnginx" {
template = file("${path.module}/installnginx.tpl")
}

data "aws_instance" "aaa" {
  depends_on = [module.asg]
  filter {
    name   = "vpc-id"
    values = [aws_vpc.pc_vpc.id]
  }
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = module.alb.target_group_arns[0]
  target_id        = data.aws_instance.aaa.id
  port             = 80
}

/*resource "aws_autoscaling_group" "pc_asg" {
  name                      = "asg-${aws_launch_configuration.pc_lc.id}"
  max_size                  = var.asg_max
  min_size                  = var.asg_min
  health_check_grace_period = var.asg_grace
  health_check_type         = var.asg_hct
  desired_capacity          = var.asg_cap
  force_delete              = true
  load_balancers            = [module.alb.this_lb_id]

  vpc_zone_identifier = [
    aws_subnet.pc_public1.id,
    aws_subnet.pc_public2.id
  ]

  termination_policies = [
    "OldestInstance",
    "OldestLaunchConfiguration",
  ]

  launch_configuration = aws_launch_configuration.pc_lc.name

  tag {
    key                 = "Name"
    value               = "pc_asg-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}*/