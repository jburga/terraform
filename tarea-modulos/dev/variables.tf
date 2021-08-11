variable "dev_region" {
  type    = string
  default = "us-east-1"
}

variable "dev_profile" {
  type    = string
  default = "profile"
}

variable "dev_name_vpc" {
  type    = string
  default = "vpc"
}

variable "dev_vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "dev_vpc_enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "dev_common_tag" {
  type    = map(string)
  default = {}
}

// vars modules ec2

variable "dev_ami_id" {
  type    = string
  default = "default"
}

variable "dev_instance_type" {
  type = string
  default = ""
}

variable "dev_key_name" {
  type    = string
  default = "default"
}

variable "dev_sg_name_bastion" {
  type = string
  default = "sg bastion"
}

variable "dev_ec2_name_bastion" {
  type = string
  default = "bastion"
}

variable "dev_ec2_name_app" {
  type = string
  default = "app"
}

variable "dev_sg_name_app" {
  type = string
  default = "sg app"
}

variable "dev_sg_name_lb" {
  type = string
  default = "alb"
}

variable "dev_lb_name" {
  type = string
  default = "lb"
}

variable "dev_tg_name" {
  type = string
  default = "tg"
}

