resource "aws_dynamodb_table" "basic_dynamodb_table" {

  name         = "${var.my_env}-tws-demo-app-table"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = var.hash_key

  attribute {
    name = var.hash_key
    type = "S"
  }

  tags = {
    Name = "${var.my_env}-tws-demo-app-table"
    Environment = var.env
  }
}



