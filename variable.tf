variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_count" {
  type = number
}

variable "aws_region" {
  type = string
}