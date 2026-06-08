resource aws_s3_bucket my_bucket {
        bucket = "${var.my_env}-skt-bucket"

        tags = {
          Name = "skt-bucket"
          Environment = var.env
}
