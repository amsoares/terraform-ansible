# Key pair
resource "aws_key_pair" "pc_auth" {
  key_name   = var.ec2_key_name
  public_key = file(var.ec2_public_key_path)
}