resource "aws_key_pair" "my_key" {
  key_name   = "terra-key"
  public_key = file("terra-key-ec2.pub")
}

resource "aws_default_vpc" "my_vpc" {
}

resource "aws_security_group" "my_sg" {
  name   = "automate-sg"
  vpc_id = aws_default_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http open"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all access open outbound"
  }
}

resource "aws_instance" "my_instance" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_instance_type
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  user_data = file("nginx.sh")

  root_block_device {
    volume_size = 15
    volume_type = "gp3"
  }

  tags = {
    Name = "skt_automate"
  }
}
output "instance_public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "website_url" {
  value = "http://${aws_instance.my_instance.public_ip}"
}
