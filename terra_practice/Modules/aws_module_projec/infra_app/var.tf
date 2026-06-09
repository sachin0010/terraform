variable "my_env" {
  description = "The environment for the app (dev, stg, prd)"
  type        = string
}

variable "bucket_name" {
  description = "This is bucket name"
  type        = string
}

variable "ec2_ami_id" {
  type = string

}

variable "instance_count" {
  description = "this is the no of ec2 instance"
  type = number

}

variable "instance_type" {
  description = "this is the inst type"
  type = string

}

variable "hash_key" {
  description = "this is hash key for dynamo_db"
  type = string

}
