S3.tf--------.........................
resource "aws_s3_bucket" "remote_s3" {
  bucket = "skt-state-bucket-2026"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

dynamodb.tf.................................................    through AWS console also we can create
resource "aws_dynamodb_table" "basic_dynamodb_table" {

  name         = "skt_table"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "skt_table"
    Environment = "prod"
  }
}

..................................... after initiate the s3 and dynamo then only ater add s3 backend in terr.tf
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
terraform state list
terraform refresh                   

terraform.tf....................................
terraform {
  backend "s3" {
    bucket         = "skt-state-bucket-2026"
    key            = "prod/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "skt_table"
    encrypt        = true
  }
}
..............................................
terraform init

aws s3 ls s3://skt-state-bucket-2026/prod/
2026-06-05 12:02:43      22368 terraform.tfstate

rm terraform.tfstate
rm terraform.tfstate.backup

terraform state list    ->  still it will be there using remote backend from s3
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
