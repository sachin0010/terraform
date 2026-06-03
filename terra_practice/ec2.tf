resource "aws_key_pair" "my_key" {
  key_name   = "terra-key"
  public_key = file("terra-key-ec2.pub")           #function to get terra key via ssh-keygen
}

#vpc
resource "aws_default_vpc" "my_vpc" {
}

#sg
resource "aws_security_group" "my_sg" {
  name   = "automate-sg"
  vpc_id = aws_default_vpc.my_vpc.id          #interpolation

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
    protocol    = "-1"              #all traffic
    cidr_blocks = ["0.0.0.0/0"]
    description = "all access open outbound"
  }
}

#ec2
resource "aws_instance" "my_instance" {
  ami                    = "ami-0fe18bc3cfa53a248"          #us-east-2 ami_id of ubuntu
  instance_type          = "t3.small"
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  root_block_device {
    volume_size = 15
    volume_type = "gp3"
  }

  tags = {
    Name = "skt_automate"
  }
}
