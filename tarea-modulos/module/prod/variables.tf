variable "prod_region" {
  type    = string
  default = "us-east-1"
}

variable "prod_name_vpc" {
  type    = string
  default = "prod_main"
}

variable "prod_profile" {
  type    = string
  default = "default"
}

variable "prod_vpc_cidr_block" {
  type    = string
  default = "10.100.0.0/16"
}

variable "prod_vpc_enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "prod_vpc_tags" {
  type    = map(string)
  default = {}
}

variable "prod_vpc_pub_subnets" {
  type = list(object({
    name                    = string
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    tags                    = map(string)
  }))
  default = []
}

variable "prod_vpc_pri_subnets" {
  type = list(object({
    name                    = string
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    tags                    = map(string)
  }))
  default = []
}

// vars module ec2

variable "prod_ami_id" {
  type    = string
  default = "default"
}

variable "prod_key_name" {
  type    = string
  default = "default"
}

variable "prod_ec2_name_default" {
  type    = string
  default = "default"
}
