resource "aws_s3_bucket" "remote_s3" {
        bucket = "${var.my_env}-${var.bucket_name}"

        tags = {
          Name = "${var.my_env}-${var.bucket_name}"
          Environment = var.env
}
