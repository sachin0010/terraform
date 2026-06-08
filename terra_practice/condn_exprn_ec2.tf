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
    volume_size = var.env == "prod" ? 20 : var.ec2_default_root_storage_size           #condn expr
    volume_type = "gp3"

  }

  tags = {
    Name = "${each.key}"  
    Environment = var.env                        #take env from var.tf-> dev,prod etc
  }
} 
