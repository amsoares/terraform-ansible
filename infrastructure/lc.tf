# ----- Launch Configuration -----

resource "aws_launch_configuration" "pc_lc" {
  name_prefix          = "wp_lc-"
  image_id             = var.ec2_ami
  instance_type        = var.ec2_instance_type
  security_groups      = [aws_security_group.pc_public_sg.id]
  key_name             = aws_key_pair.pc_auth.id
  user_data            = data.template_file.installnginx.rendered

  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "installnginx" {
  template = file("${path.module}/installnginx.tpl")
}