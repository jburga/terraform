variable "prod_region" {
  type    = string
  default = "us-east-1"
}

variable "prod_profile" {
  type    = string
  default = "profile"
}

variable "prod_name_vpc" {
  type    = string
  default = "vpc"
}

variable "prod_vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "prod_vpc_enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "prod_common_tag" {
  type    = map(string)
  default = {}
}

// vars modules ec2

variable "prod_ami_id" {
  type    = string
  default = "default"
}

variable "prod_instance_type" {
  type = string
  default = ""
}

variable "prod_key_name" {
  type    = string
  default = "default"
}

variable "prod_sg_name_bastion" {
  type = string
  default = "sg bastion"
}

variable "prod_ec2_name_bastion" {
  type = string
  default = "bastion"
}

variable "prod_ec2_name_app" {
  type = string
  default = "app"
}

variable "prod_sg_name_app" {
  type = string
  default = "sg app"
}

variable "prod_sg_name_lb" {
  type = string
  default = "alb"
}

variable "prod_lb_name" {
  type = string
  default = "lb"
}

variable "prod_tg_name" {
  type = string
  default = "tg"
}

