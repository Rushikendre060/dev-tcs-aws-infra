variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_id" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "aws_region" {
  type = string
}