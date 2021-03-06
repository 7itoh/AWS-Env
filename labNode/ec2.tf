data "aws_ami" "wordpress" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-wordpress-5.4.1-0-linux-ubuntu-16.04*"]
  }

  owners = ["679593333241"]
}

resource "aws_instance" "wordpress" {
  ami           = data.aws_ami.wordpress.id
  key_name      = "aws-beNode_sub"
  instance_type = "t3.small"

  subnet_id              = aws_subnet.public-a.id
  vpc_security_group_ids = ["${aws_security_group.allow.id}"]
}

output "ec2_public_ip" {
  value = aws_instance.wordpress.public_ip
}