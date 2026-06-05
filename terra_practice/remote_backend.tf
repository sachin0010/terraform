S3.tf--------.........................
resource "aws_s3_bucket" "remote_s3" {
  bucket = "state_bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

dynamodb.tf.................................................    through AWS console also we can create
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "skt_table"
  billing_mode   = "PAY_PER+REQUEST"
  hash_key       = "LockId"

  attribute {
    name = "LockID"
    type = "String"                #or S
  }
  tags = {
    Name        = "skt_table"
    Environment = "Dev"                 #or remove
  }
}

.....................................'
terraform init
terraform validate
terraform plan
terraform apply -autu-approve
terraform state list
terraform refresh

q. if .tfstate deleted then it will restore it from backup and if backeup also deleted

aws s3api list-object-versions --bucket my-tf-state-bucket
sol. Option 1: Import Resources Again
terraform import aws_instance.web i-1234567890abcdef

Option 2: Terraform 1.5+ Import Blocks
import {
  to = aws_instance.web
  id = "i-1234567890abcdef"
}
then:
terraform plan
Option 3: Reconstruct State
