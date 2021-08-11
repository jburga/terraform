variable "vpc_tags" {
  description = "VPC Tags"
  type = map(string)
  default = {}
}

variable "vpc_subnet_tags" {
  description = "VPC Subnet Tags"
  type = map(string)
}

variable "vpc_nat_gw_tags" {
  description = "VPC Nat Gateway Tags"
  type = map(string)
}

variable "vpc_igw_tags" {
  description = "VPC Internet Gateway Tags"
  type = map(string)
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type = string
}

variable "vpc_name" {
  description = "VPC Name"
  type = string
}

variable "vpc_instance_tenancy" {
  description = "VPC Instance Tenancy"
  type = string
  default = "default"
}

variable "vpc_enable_dns_hostnames" {
  description = "VPC Enable DNS Hostnames"
  type = bool
  default = false
}

variable "vpc_subnets_public" {
  description = "VPC Subnets Public"
  default = {
    one = {
      cidr_block = "10.1.0.0/24",
      availability_zone = "us-east-1a"
      map_public_ip_on_launch = true
    }
  }
}

variable "vpc_subnets_private" {
  description = "VPC Subnets Private"

  default = {
    one = {
      cidr_block = "10.1.0.0/24",
      availability_zone = "us-east-1a"
      map_public_ip_on_launch = true
    }
  }
}

