variable "pre_region" {
  type    = string
  default = "us-east-1"
}

variable "pre_profile" {
  type    = string
  default = "profile"
}

variable "pre_name_vpc" {
  type    = string
  default = "vpc"
}

variable "pre_vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "pre_vpc_enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "pre_common_tag" {
  type    = map(string)
  default = {}
}

// vars modules ec2

variable "pre_ami_id" {
  type    = string
  default = "default"
}

variable "pre_instance_type" {
  type = string
  default = ""
}

variable "pre_key_name" {
  type    = string
  default = "default"
}

variable "pre_sg_name_bastion" {
  type = string
  default = "sg bastion"
}

variable "pre_ec2_name_bastion" {
  type = string
  default = "bastion"
}

variable "pre_ec2_name_app" {
  type = string
  default = "app"
}

variable "pre_sg_name_app" {
  type = string
  default = "sg app"
}

variable "pre_sg_name_lb" {
  type = string
  default = "alb"
}

variable "pre_lb_name" {
  type = string
  default = "lb"
}

variable "pre_tg_name" {
  type = string
  default = "tg"
}

