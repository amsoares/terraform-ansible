region = "us-east-1"
profile = "gd-aws"
blacklisted_ips = [
  {
    value = "165.225.206.180/32"
    type = "IPV4"
  }
]
domain_name = "pricus"
vpc_cidr    = "10.0.0.0/16"
cidrs = {
  public1  = "10.0.1.0/24"
  public2 = "10.0.2.0/24"
}
elb_healthy_threshold   = "2"
elb_unhealthy_threshold = "2"
elb_timeout             = "3"
elb_interval            = "30"
ec2_instance_type       = "t3.micro"
ec2_ami                 = "ami-0e2ff28bfb72a4e45"
ec2_public_key_path     = "~/.ssh/keypair-gd-aws.pub"
ec2_key_name            = "keypair-gd-aws"
asg_max                 = "2"
asg_min                 = "1"
asg_grace               = "300"
asg_hct                 = "EC2"
asg_cap                 = "2"
localip                 = "165.225.206.180/32"