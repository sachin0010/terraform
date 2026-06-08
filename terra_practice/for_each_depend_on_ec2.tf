#generally output.tf not working with this, but we can use by using for loop to iterate like below--- in output.tf
syntax -  for key, resource in aws_instance.my_instance : ...

output "ec2_public_ips" {
  value = {
    for name, instance in aws_instance.my_instance :
    name => instance.public_ip
  }
}
output "website_urls" {
  value = {
    for name, instance in aws_instance.my_instance :
    name => "http://${instance.public_ip}"
  }
}

##for one instance 
output "junoon_public_ip" {
  value = aws_instance.my_instance["skt_junoon"].public_ip
}

---------------------------------------------------------------
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
  for_each = tomap( {
    skt_junoon = "t3.micro"
    skt_agra = "t3.micro"
  })
  depends_on = [aws_security_group.my_sg , aws_key_pair.my_key]
  ami                    = var.ec2_ami_id
  instance_type          = each.value
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  user_data = file("nginx.sh")

  root_block_device {
    volume_size = 15
    volume_type = "gp3"

  }

  tags = {
    Name = "${each.key}"                       #key=skt_junoon ,  value=t2.micro   used in for_each only
  }
}
