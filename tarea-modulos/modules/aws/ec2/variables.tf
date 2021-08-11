variable "vpc_id" {
  description = "VPC Id"
  type = string
  default = "default"
}

variable "sg_name" {
  description = "Security Group Name"
  type = string
}

variable "sg_ingress_cidr" {
  description = "Security Group Ingress CIDR"
  type = map(object({
    cidr_blocks: list(string),
    port: number,
    protocol: string
  }))
  default = {}
}


variable "sg_ingress_sg" {
  description = "Security Group Ingress Source SG"
  type = map(object({
    sg_id: string,
    port: number,
    protocol: string
  }))
  default = {}
}

variable "ec2_ami" {
  description = "EC2 AMI"
  type = string
}

variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t2.micro"
}

variable "ec2_subnets_id" {
  description = "EC2 Subnets Id"
  type = set(string)
  default = []
}

variable "ec2_key_name" {
  description = "EC2 Key Name"
  type = string
}

variable "ec2_name" {
  description = "EC2 Name"
  type = string
}

variable "ec2_tags" {
  description = "EC2 Tags"
  type = map(string)
  default = {}
}

variable "sg_tags" {
  description = "Security Group Tags"
  type = map(string)
  default = {}
}

variable "ec2_user_data" {
  description = "EC2 User Data"
  default = ""
}
