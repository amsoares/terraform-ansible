# ----- ASG -----
resource "aws_autoscaling_group" "pc_asg" {
  name                      = "asg-${aws_launch_configuration.pc_lc.id}"
  max_size                  = var.asg_max
  min_size                  = var.asg_min
  health_check_grace_period = var.asg_grace
  health_check_type         = var.asg_hct
  desired_capacity          = var.asg_cap
  force_delete              = true
  load_balancers            = [aws_elb.pc_elb.id]

  vpc_zone_identifier = [
    aws_subnet.pc_public1.id,
    aws_subnet.pc_public2.id
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
}