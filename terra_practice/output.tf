#provides ec2 ip and dns --> directly we can ssh without going to check ip from aws console
output "ec2_public_ip" {
        value = aws_instance.my_instance.public_ip
}

output "ec2_public_dns" {
        value = aws_instance.my_instance.public_dns
}

output "ec2_private_ip" {
        value = aws_instance.my_instance.private_ip
}
