variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}
variable "vpc_name" {
  type    = string
  default = "main"
}

variable "vpc_instance_tenancy" {
  type    = string
  default = "default"
}

variable "vpc_enable_dns_hostnames" {
  type    = bool
  default = false
}

variable "vpc_tags" {
  type    = map(string)
  default = {}
}

variable "vpc_pub_subnets" {
  type = list(object({
    name                    = string
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    tags                    = map(string)
  }))

  default = [
    {
      name                    = "nombre",
      cidr_block              = "10.1.0.0/24",
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = true
      tags = {
        "env" = "ac-xl-module-lab-f"
      }
    }
  ]
}

variable "vpc_pri_subnets" {
  type = list(object({
    name                    = string
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
    tags                    = map(string)
  }))

  default = [
    {
      name                    = "nombre",
      cidr_block              = "10.1.0.0/24",
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = true
      tags = {
        "env" = "ac-xl-module-lab-f"
      }
    }
  ]
}

variable "name_subnet_nat" {
  type    = string
  default = "value"
}
