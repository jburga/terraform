variable "vpc_main" {
  description = "vpc id main"
  type = string
  default = "default"
}

variable "region_lab" {
  description = "region"
  type = string
  default = "ggggg"
}

variable "profile-lab" {
  description = "profile"
  type = string
  default = "default"
}

variable "cirdr_sub_1" {
  type = string
  default = "10.0.2.0/24"
}

variable "ingress-ac-xl-sg-tmp" {
    type = list
    default = []
}
variable "ami-id-ec2-aws" {
    type = string
    default = "ami-0dc2d3e4c0f9ebd18"
}

variable "key-name-ssh" {
    type = string
    default = "default"
}