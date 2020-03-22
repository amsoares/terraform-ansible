#------ IAM -----

#S3_Access --- this is going to access the IAM Role Policy
/*resource "aws_iam_instance_profile" "pc_s3_access_profile" {
  name = "pc_s3_access"
  role = aws_iam_role.pc_s3_access_role.name
}

resource "aws_iam_role_policy" "pc_s3_access_policy" {
  name = "pc_s3_access_policy"
  role = aws_iam_role.pc_s3_access_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
EOF
}*/

/*#VCP Endpoint for S3 Bucket
resource "aws_vpc_endpoint" "pc_private-s3_endpoint" {
  vpc_id       = aws_vpc.pc_vpc.id
  service_name = "com.amazonaws.${var.region}.s3"

  route_table_ids = [
    aws_vpc.pc_vpc.main_route_table_id,
    aws_route_table.pc_public.id
  ]

  policy = <<POLICY
{
    "Statement": [
      {
        "Action": "*",
        "Effect": "Allow",
        "Resource": "*",
        "Principal": "*"
      }
    ]
}
POLICY
}*/

/*# ----- S3 code bucket -----
resource "random_id" "pc_code_bucket" {
  byte_length = 2
}

resource "aws_s3_bucket" "code" {
  bucket        = "${var.domain_name}-${random_id.pc_code_bucket.dec}"
  acl           = "private"
  force_destroy = true

  tags = {
    Name = "code bucket"
  }
}

resource "aws_iam_role" "pc_s3_access_role" {
  name = "pc_s3_access_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Sid": "",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
EOF
}*/

/*resource "aws_instance" "pc_instance" {
  instance_type = var.ec2_instance_type
  ami           = var.ec2_ami

  tags = {
    Name = "pc_dev"
  }

  key_name               = aws_key_pair.pc_auth.id
  vpc_security_group_ids = [aws_security_group.pc_public_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.pc_s3_access_profile.id
  subnet_id              = aws_subnet.pc_public1.id

  provisioner "local-exec" {
    command = <<EOD
cat <<EOF > aws_hosts
[dev]
${aws_instance.pc_instance.public_ip}
[dev:vars]
s3code=${aws_s3_bucket.code.bucket}
domain=${var.domain_name}
EOF
EOD
  }

  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.pc_instance.id} --profile gd-aws  && ansible-playbook -i aws_hosts ansible/webserver.yml"
  }
}*/
