variable "profile" {
  description = "profile"
  type = string
  default = "default"
}

variable "region" {
  description = "region"
  type = string
  default = "us-east-1"
}

variable "ami-id-ec2-aws" {
    type = string
    default = "ami-0dc2d3e4c0f9ebd18"
}

variable "instance-type" {
  type = string
  default = "t2.micro"
}

variable "key-name-ssh" {
  type = string
  default = "default"
}

variable "peer-owner-id" {
  type = string
}
