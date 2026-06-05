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
