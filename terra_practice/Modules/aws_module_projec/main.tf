module "dev-app" {
  source        = "./aws_module_projec"
  my_env        = "dev"
  buckt_name    = "infra-app-bucket
  instance_count = 1
  instance_type = "t2.micro"
  ami           = "ami-0fe18bc3cfa53a248"
  hash_key      = "studentID"
}

# prd
module "prd-app" {
  source        = "./aws_module_projec"
  my_env        = "prod"
  buckt_name    = "infra-app-bucket
  instance_count = 1
  instance_type = "t2.small"
  ami           = "ami-0fe18bc3cfa53a248"
  hash_key      = "studentname"
}

# stg
module "stg-app" {
  source        = "./aws_module_projec"
  my_env        = "stag"
  buckt_name    = "infra-app-bucket
  instance_count = 1
  instance_type = "t2.micro"
  ami           = "ami-0fe18bc3cfa53a248"
  hash_key      = "studentclass"
}
