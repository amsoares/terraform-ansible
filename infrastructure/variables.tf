variable "region" {}
variable "profile" {}
data "aws_availability_zones" "available" {}
variable "blacklisted_ips" {}
variable "domain_name" {}
variable "vpc_cidr" {}
variable "cidrs" {
  type = map
}
variable "alb_healthy_threshold" {}
variable "alb_unhealthy_threshold" {}
variable "alb_timeout" {}
variable "alb_interval" {}
variable "ec2_instance_type" {}
variable "ec2_ami" {}
variable "ec2_public_key_path" {}
variable "ec2_key_name" {}
variable "asg_max" {}
variable "asg_min" {}
variable "asg_grace" {}
variable "asg_hct" {}
variable "asg_cap" {}
variable "localip" {}
